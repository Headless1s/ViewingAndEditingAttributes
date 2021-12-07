﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Ссылка.УстановитьДействие("ПриИзменении", "СсылкаПриИзменении");
	ВариантФормыВыбора = ВариантыФормыВыбора("Генерируемая");
	
	УстановитьУсловноеОформление();
	УстановитьВидимостьИДоступностьЭлементов();
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	ОбновитьПоследниеИспользованные();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Записать(Команда)
	
	ЗаписатьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПровестиНеоперативно(Команда)
	
	ЗаписатьНаСервере("Неоперативно");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьВРежимеЗагрузки(Команда)
	
	ЗаписатьНаСервере( , Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПоследнийИспользованный(Команда)
	
	ИмяЗначение = СтрЗаменить(Команда.Имя, "Команда_", "");
	
	ЭлементСписка = ПоследниеИспользованные.НайтиПоЗначению(ИмяЗначение);
	
	ОткрытьФормуВыбораСсылки(ЭлементСписка.Представление);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиСсылкуПоИдентификатору(Команда)
	
	ОповещениеПослеВводаСтроки = Новый ОписаниеОповещения("ПослеВводаСсылки", ЭтотОбъект);
	
	ПоказатьВводСтроки(ОповещениеПослеВводаСтроки, "", "Введите идентификатор", 36, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиПоНавигационнойСсылке(Команда)
	
	ОповещениеПослеВводаСтроки = Новый ОписаниеОповещения("ПослеВводаНавигационнойСсылки", ЭтотОбъект);
	
	ПоказатьВводСтроки(ОповещениеПослеВводаСтроки, "", "Введите навигационную ссылку", 100, Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СсылкаОчистка(Элемент, СтандартнаяОбработка)
	
	ИмяВыбранногоОбъекта = "";
	ЗаполнитьРеквизитыОбъекта( , Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаПриИзменении(Элемент)
	
	ЗаполнитьРеквизитыОбъекта(Истина);
	УстановитьВидимостьИДоступностьЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура РеквизитыЗначениеПриИзменении(Элемент)
	
	ТекущаяСтрока = Элемент.Родитель.ТекущиеДанные;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока.Изменен_ТЧ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура РеквизитыЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущаяСтрока = Элементы.Реквизиты.ТекущиеДанные;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущаяСтрока.ОписаниеТипа.СодержитТип(Тип("Строка")) И ТекущаяСтрока.ОписаниеТипа.Типы().Количество() = 1 Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВыбораСтрокиРеквизита", ЭтотОбъект, ТекущаяСтрока);
		ПоказатьВводСтроки(ОписаниеОповещения,
			ТекущаяСтрока.Значение,
			"Редактирование строки", ,
			Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РеквизитыЗначениеОткрытие(Элемент, СтандартнаяОбработка)
	
	ТекущаяСтрока = Элемент.Родитель.ТекущиеДанные;
	
	ИмяПоля = СтрЗаменить(Элемент.Имя, Элемент.Родитель.Имя, "");
	
	Если ТипЗнч(ТекущаяСтрока[ИмяПоля]) = Тип("ХранилищеЗначения") Тогда
		Инструкции = Новый Структура();
		ОбработатьОткрытиеХранилищаЗначения(ТекущаяСтрока[ИмяПоля], Инструкции);
		Если Инструкции.Свойство("ВызватьМетодПоказать") Тогда
			Инструкции.Значение.Показать();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ПустаяСтрока(ИмяВыбранногоОбъекта) Тогда
				
		ОткрытьФорму("ВнешняяОбработка.ПросмотрИРедактированиеРеквизитов.Форма.НоваяФормаВыбораОбъектовМетаданных",, ЭтотОбъект,,,,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	Иначе
		
		ОткрытьФормуВыбораСсылки(ИмяВыбранногоОбъекта);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьАльтернативноеПредставлениеПриИзменении(Элемент)
	Элементы.РеквизитыАльтернативноеПредставление.Видимость = ПоказыватьАльтернативноеПредставление;
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьТипПриИзменении(Элемент)
	Элементы.РеквизитыГруппаТип.Видимость = ПоказыватьТип;
КонецПроцедуры

&НаКлиенте
Процедура СсылкаАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	Если ЭтоУникальныйИдентификатор(Текст) Тогда
		
		НайденнаяСсылка = СсылкаПоУИД(ИмяВыбранногоОбъекта, Текст);
		
		Если НайденнаяСсылка <> Неопределено Тогда
			
			СтандартнаяОбработка = Ложь;
			
			Если ДанныеВыбора = Неопределено Тогда
				ДанныеВыбора = Новый СписокЗначений;
			КонецЕсли;
			
			ДанныеВыбора.Добавить(НайденнаяСсылка);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ВыборОбъектовМетаданных" Тогда		
		
		ОткрытьФормуВыбораСсылки(Параметр);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуВыбораСсылки(ИмяОбъекта)
	
	ПослеВыбора = Новый ОписаниеОповещения("ВыборСсылкиЗавершение", ЭтотОбъект, ИмяОбъекта);
	
	Если ВариантФормыВыбора = ВариантыФормыВыбора("Генерируемая") Тогда
		
		ПараметрыФормы = Новый Структура("ИмяОбъекта, ТекущаяСсылка", ИмяОбъекта, Ссылка);
		
		ОткрытьФорму("ВнешняяОбработка.ПросмотрИРедактированиеРеквизитов.Форма.ГенерируемаяФормаВыбораСсылки",
			ПараметрыФормы,
			ЭтотОбъект, , , ,
			ПослеВыбора,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	Иначе
		
		ИмяФормыВыбора = ИмяОбъекта + ".ФормаВыбора";
		
		ОткрытьФорму(ИмяФормыВыбора, ,
			ЭтотОбъект, , , ,
			ПослеВыбора,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборСсылкиЗавершение(Результат, Имя) Экспорт
	
	Если Результат <> Неопределено Тогда
		
		ОбработатьВыборСсылки(Результат, Имя);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВыборСсылки(ВыбраннаяСсылка, ИмяОбъекта)
	
	ИмяВыбранногоОбъекта = ИмяОбъекта;
	Ссылка = ВыбраннаяСсылка;
	
	ЗаполнитьРеквизитыОбъекта();
	УстановитьВидимостьИДоступностьЭлементов();
	
	ИмяБезТочки = СтрЗаменить(ИмяВыбранногоОбъекта, ".", "");
	
	Если ПоследниеИспользованные.НайтиПоЗначению(ИмяБезТочки) = Неопределено Тогда
		
		Если ПоследниеИспользованные.Количество() < 5 Тогда
			ПоследниеИспользованные.Добавить(ИмяБезТочки, ИмяВыбранногоОбъекта);
		Иначе
			ПоследниеИспользованные[0].Значение = ИмяБезТочки;
			ПоследниеИспользованные[0].Представление = ИмяВыбранногоОбъекта;
		КонецЕсли;
		
		ОбновитьПоследниеИспользованные();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьПоследниеИспользованные()
	
	УдаляемыеЭлементы = Новый Массив;
	УдаляемыеКоманды = Новый Массив;
	
	Для каждого ЭлементСписка Из ПоследниеИспользованные Цикл
		
		ЗначениеЭлемента = СтрЗаменить(ЭлементСписка.Значение, ".", "");
		
		ЭлементКнопка = Элементы.Найти("Кнопка_" + ЗначениеЭлемента);
		
		Если ЭлементКнопка <> Неопределено Тогда
			УдаляемыеЭлементы.Добавить(ЭлементКнопка);
		КонецЕсли;
		
		Команда = Команды.Найти("Команда_" + ЗначениеЭлемента);
		
		Если Команда <> Неопределено Тогда
			УдаляемыеКоманды.Добавить(Команда);
		КонецЕсли;
		
	КонецЦикла;
	
	Для каждого Элемент Из УдаляемыеЭлементы Цикл
		Элементы.Удалить(Элемент);
	КонецЦикла;
	
	Для каждого Команда Из УдаляемыеКоманды Цикл
		Команды.Удалить(Команда);
	КонецЦикла;
	
	Для каждого ЭлементСписка Из ПоследниеИспользованные Цикл
		
		ЗначениеЭлемента = СтрЗаменить(ЭлементСписка.Значение, ".", "");
		
		ИмяКоманды = "Команда_" + ЗначениеЭлемента;
		НоваяКоманда = Команды.Добавить(ИмяКоманды);
		НоваяКоманда.Действие = "Подключаемый_ПоследнийИспользованный";
		
		ИмяКнопки = "Кнопка_" + ЗначениеЭлемента;
		НоваяКнопка = Элементы.Добавить(ИмяКнопки, Тип("КнопкаФормы"), Элементы.ГруппаПоследниеИспользованные);
		НоваяКнопка.Заголовок = ЭлементСписка.Представление;
		НоваяКнопка.ИмяКоманды = НоваяКоманда.Имя;
		НоваяКнопка.ОтображениеФигуры = ОтображениеФигурыКнопки.Нет;
		Попытка
			НоваяКнопка.Картинка = БиблиотекаКартинок.История;
		Исключение
			НоваяКнопка.Картинка = БиблиотекаКартинок.ХранилищеНастроек;
		КонецПопытки;
		
		НоваяКнопка.Отображение = ОтображениеКнопки.КартинкаИТекст;
		
	КонецЦикла;
	
	Если ПоследниеИспользованные.Количество() > 0 Тогда
		Элементы.ПодсказкаПоследние.Видимость = Истина;
	Иначе
		Элементы.ПодсказкаПоследние.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#Область ЗаполнениеРеквизитов

&НаСервере
Процедура ЗаполнитьРеквизитыОбъекта(ОбъектПрежний = Ложь, Очистка = Ложь)
	
	Реквизиты.Очистить();
	
	Если Не ЗначениеЗаполнено(Ссылка) Тогда
		Возврат;
	КонецЕсли;
	
	Если Очистка Тогда
		УдалитьЭлементыРеквизитыТабличныхЧастейРегистров(ОбъектПрежний);
		ОбновитьЭлементыФормы();
		Возврат;
	КонецЕсли;
	
	МетаданныеОбъекта = Ссылка.Метаданные();
	
	ИмяТаблицы = МетаданныеОбъекта.ПолноеИмя();
	
	Запрос = Новый Запрос(
			"ВЫБРАТЬ 
			|	* 
			|ИЗ 
			|	%ИмяТаблицы% КАК ТаблицаОбъекта 
			|ГДЕ 
			|	ТаблицаОбъекта.Ссылка = &Ссылка");
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ИмяТаблицы%", ИмяТаблицы);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	
	УдалитьЭлементыРеквизитыТабличныхЧастейРегистров(ОбъектПрежний);
	
	Кэш = Новый Структура("Картинки", Новый Соответствие);
	
	ЗаполнитьСтандартныеРеквизиты(Выборка, МетаданныеОбъекта, Кэш);
	ЗаполнитьОбычныеРеквизиты(Выборка, МетаданныеОбъекта, Кэш);
	ЗаполнитьТабличныеЧасти(Выборка, МетаданныеОбъекта, ОбъектПрежний);
	ЗаполнитьОбщиеРеквизиты(Выборка, МетаданныеОбъекта, Кэш);
	//ЗаполнитьНаборыЗаписей(Выборка, МетаданныеОбъекта, ОбъектПрежний);
	ОбновитьЭлементыФормы();
	
	Реквизиты.Сортировать("Стандартный УБЫВ, Синоним");
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОбычныеРеквизиты(Выборка, МетаданныеОбъекта, Кэш)
	
	Для каждого Реквизит Из МетаданныеОбъекта.Реквизиты Цикл
		
		НовСтрока = Реквизиты.Добавить();
		ЗаполнитьОбщиеСвойстваСтрокиРеквизита(НовСтрока, Реквизит, Выборка, Кэш);
		НовСтрока.КартинкаСтрок = 1;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтандартныеРеквизиты(Выборка, МетаданныеОбъекта, Кэш)
	
	Для каждого Реквизит Из МетаданныеОбъекта.СтандартныеРеквизиты Цикл
		
		НовСтрока = Реквизиты.Добавить();
		
		НовСтрока.Имя = Реквизит.Имя;
		НовСтрока.Синоним = Реквизит.Синоним;
		НовСтрока.СтароеЗначение = Выборка[Реквизит.Имя];
		
		НовСтрока.Стандартный = Истина;
		
		Если Реквизит.Имя = "Ссылка" Тогда
			НовСтрока.ОписаниеТипа = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(36, ДопустимаяДлина.Переменная));
			НовСтрока.Значение = Выборка.Ссылка.УникальныйИдентификатор();
		Иначе
			НовСтрока.Значение = Выборка[Реквизит.Имя];
			НовСтрока.ОписаниеТипа = Реквизит.Тип;
		КонецЕсли;
		
		НедоступныеРеквизиты = Новый Массив;
		НедоступныеРеквизиты.Добавить("Проведен");
		НедоступныеРеквизиты.Добавить("Предопределенный");
		НедоступныеРеквизиты.Добавить("Ссылка");
		НедоступныеРеквизиты.Добавить("ЭтоГруппа");
		
		Если НедоступныеРеквизиты.Найти(Реквизит.Имя) <> Неопределено Тогда
			НовСтрока.Недоступен = Истина;
		КонецЕсли;
		
		НовСтрока.Тип = Строка(Реквизит.Тип);
		НовСтрока.ТипКартинка = КартинкаРеквизита(Реквизит, Кэш);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТабличныеЧасти(Выборка, МетаданныеОбъекта, ОбъектПрежний)
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Для каждого ТабличнаяЧасть Из МетаданныеОбъекта.ТабличныеЧасти Цикл
		
		ИмяТабличнойЧасти = ТабличнаяЧасть.Имя + "_ТЧ";
		
		Если Не ОбъектПрежний Тогда
			
			МассивРеквизитов = Новый Массив;
			ПараметрыВыбора = Новый Структура;
			
			ТабличныеЧасти.Добавить(ИмяТабличнойЧасти);
			
			МассивРеквизитов.Добавить(ОбработкаОбъект.РеквизитТаблицаЗначений(ИмяТабличнойЧасти));
			
			Для каждого Реквизит Из ТабличнаяЧасть.СтандартныеРеквизиты Цикл
				
				Если Реквизит.Имя = "НомерСтроки" Тогда
					Синоним = "№";
				Иначе
					Синоним = Реквизит.Синоним;
				КонецЕсли;
				
				МассивРеквизитов.Добавить(Новый РеквизитФормы(Реквизит.Имя, Реквизит.Тип, ИмяТабличнойЧасти, Синоним));
				
			КонецЦикла;
			
			Для каждого Реквизит Из ТабличнаяЧасть.Реквизиты Цикл
				
				Если Реквизит.Тип.СодержитТип(Тип("ХранилищеЗначения")) Тогда
					МассивРеквизитов.Добавить(Новый РеквизитФормы(Реквизит.Имя, Новый ОписаниеТипов(), ИмяТабличнойЧасти, Реквизит.Синоним));
				Иначе
					МассивРеквизитов.Добавить(Новый РеквизитФормы(Реквизит.Имя, Реквизит.Тип, ИмяТабличнойЧасти, Реквизит.Синоним));
				КонецЕсли;
				
				Если Реквизит.ПараметрыВыбора.Количество() <> 0 Тогда
					ПараметрыВыбора.Вставить(Реквизит.Имя, Реквизит.ПараметрыВыбора);
				КонецЕсли;
				
			КонецЦикла;
			
			МассивРеквизитов.Добавить(Новый РеквизитФормы("Изменен_ТЧ", Новый ОписаниеТипов("Булево"), ИмяТабличнойЧасти));
			
			ЭлементСтраница = Элементы.Добавить("Страница" + ИмяТабличнойЧасти, Тип("ГруппаФормы"), Элементы.ГруппаТабличныеЧасти);
			ЭлементСтраница.Вид = ВидГруппыФормы.Страница;
			ЭлементСтраница.Заголовок = ТабличнаяЧасть.Синоним + " (" + ТабличнаяЧасть.Имя + ")";
			ЭлементСтраница.Подсказка = ЭлементСтраница.Заголовок;
			ЭлементСтраница.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
			
			ИзменитьРеквизиты(МассивРеквизитов);
			
			Для каждого Реквизит Из МассивРеквизитов Цикл
				
				Если Реквизит.ТипЗначения.Типы().Количество() > 0 И Реквизит.ТипЗначения.Типы()[0] = Тип("ТаблицаЗначений") Тогда
					
					ЭлементТаблица = Элементы.Добавить(Реквизит.Имя, Тип("ТаблицаФормы"), ЭлементСтраница);
					ЭлементТаблица.ПутьКДанным = Реквизит.Имя;
					ЭлементТаблица.ИзменятьСоставСтрок = Истина;
					ЭлементТаблица.ИзменятьПорядокСтрок = Истина;
					ЭлементТаблица.Подвал = Ложь;
					ЭлементТаблица.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
					
				ИначеЕсли Реквизит.Имя <> "Изменен_ТЧ" Тогда
					
					ЭлементПоле = Элементы.Добавить(ИмяТабличнойЧасти + Реквизит.Имя, Тип("ПолеФормы"), Элементы[ИмяТабличнойЧасти]);
					ЭлементПоле.ПутьКДанным = ИмяТабличнойЧасти + "." + Реквизит.Имя;
					ЭлементПоле.Заголовок = Реквизит.Заголовок;
					Если Реквизит.ТипЗначения <> Тип("Булево") Тогда
						ЭлементПоле.Вид = ВидПоляФормы.ПолеВвода;
					Иначе
						ЭлементПоле.Вид = ВидПоляФормы.ПолеФлажка;
					КонецЕсли;
					Если Реквизит.ТипЗначения.Типы().Количество() = 0 Тогда
						ЭлементПоле.КнопкаВыбора = Ложь;
						ЭлементПоле.КнопкаОткрытия = Истина;
						ЭлементПоле.УстановитьДействие("Открытие", "РеквизитыЗначениеОткрытие");
					КонецЕсли;
					Если ПараметрыВыбора.Свойство(Реквизит.Имя) Тогда
						ЭлементПоле.ПараметрыВыбора = ПараметрыВыбора[Реквизит.Имя];
					КонецЕсли;
					ЭлементПоле.УстановитьДействие("ПриИзменении", "РеквизитыЗначениеПриИзменении");
					
					
					Если Реквизит.Имя = "НомерСтроки" Тогда
						ЭлементПоле.ТолькоПросмотр = Истина;
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
		ЭтотОбъект[ИмяТабличнойЧасти].Очистить();
		
		ВыборкаТЧ = Выборка[ТабличнаяЧасть.Имя].Выбрать();
		
		Пока ВыборкаТЧ.Следующий() Цикл
			
			НовСтрока = ЭтотОбъект[ИмяТабличнойЧасти].Добавить();
			ЗаполнитьЗначенияСвойств(НовСтрока, ВыборкаТЧ);
			
		КонецЦикла;
		
	КонецЦикла;
	
	МаксимальноеКоличествоВкладок = 10;
	
	Если ТабличныеЧасти.Количество() > МаксимальноеКоличествоВкладок Тогда
		Элементы.ГруппаТабличныеЧасти.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСлеваГоризонтально;
	Иначе
		Элементы.ГруппаТабличныеЧасти.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСверху;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОбщиеРеквизиты(Выборка, МетаданныеОбъекта, Кэш)
	
	Для каждого Реквизит Из Метаданные.ОбщиеРеквизиты Цикл
		
		СоставРеквизита = Реквизит.Состав;
		
		Если СоставРеквизита.Содержит(МетаданныеОбъекта)
			И СоставРеквизита.Найти(МетаданныеОбъекта).Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Использовать Тогда
			
			НовСтрока = Реквизиты.Добавить();
			ЗаполнитьОбщиеСвойстваСтрокиРеквизита(НовСтрока, Реквизит, Выборка, Кэш);
			НовСтрока.КартинкаСтрок = 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаборыЗаписей(Выборка, МетаданныеОбъекта, ОбъектПрежний)
	
	Если Не Метаданные.Документы.Содержит(Ссылка.Метаданные()) Тогда
		Возврат;
	КонецЕсли;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Для каждого ПриемникДвижений Из МетаданныеОбъекта.Движения Цикл
		
		Если Метаданные.РегистрыБухгалтерии.Содержит(ПриемникДвижений) Тогда
			МенеджерРегистра = РегистрыБухгалтерии[ПриемникДвижений.Имя];
		ИначеЕсли Метаданные.РегистрыСведений.Содержит(ПриемникДвижений) Тогда
			МенеджерРегистра = РегистрыСведений[ПриемникДвижений.Имя];
		ИначеЕсли Метаданные.РегистрыНакопления.Содержит(ПриемникДвижений) Тогда
			МенеджерРегистра = РегистрыНакопления[ПриемникДвижений.Имя];
		КонецЕсли;
		
		НаборЗаписей = МенеджерРегистра.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Регистратор.Установить(Ссылка);
		НаборЗаписей.Прочитать();
		
		МассивРеквизитов = Новый Массив;
		
		Регистры.Добавить(ПриемникДвижений.Имя);
		
		МассивРеквизитов.Добавить(ОбработкаОбъект.РеквизитТаблицаЗначений(ПриемникДвижений.Имя));
		
		Для каждого Реквизит Из ПриемникДвижений.Измерения Цикл
			МассивРеквизитов.Добавить(Новый РеквизитФормы(Реквизит.Имя, Реквизит.Тип, ПриемникДвижений.Имя, Реквизит.Синоним));
		КонецЦикла;
		
		Для каждого Реквизит Из ПриемникДвижений.Ресурсы Цикл
			МассивРеквизитов.Добавить(Новый РеквизитФормы(Реквизит.Имя, Реквизит.Тип, ПриемникДвижений.Имя, Реквизит.Синоним));
		КонецЦикла;
		
		Для каждого Реквизит Из ПриемникДвижений.Реквизиты Цикл
			МассивРеквизитов.Добавить(Новый РеквизитФормы(Реквизит.Имя, Реквизит.Тип, ПриемникДвижений.Имя, Реквизит.Синоним));
		КонецЦикла;
		
		МассивРеквизитов.Добавить(Новый РеквизитФормы("Изменен_ТЧ", Новый ОписаниеТипов("Булево"), ПриемникДвижений.Имя));
		
		ЭлементСтраница = Элементы.Добавить("Страница" + ПриемникДвижений.Имя, Тип("ГруппаФормы"), Элементы.ГруппаРегистры);
		ЭлементСтраница.Вид = ВидГруппыФормы.Страница;
		ЭлементСтраница.Заголовок = ПриемникДвижений.Синоним + " (" + ПриемникДвижений.Имя + ")";
		ЭлементСтраница.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
		
		ИзменитьРеквизиты(МассивРеквизитов);
		
		Для каждого Реквизит Из МассивРеквизитов Цикл
			
			Если Реквизит.ТипЗначения.Типы()[0] = Тип("ТаблицаЗначений") Тогда
				
				ЭлементТаблица = Элементы.Добавить(Реквизит.Имя, Тип("ТаблицаФормы"), ЭлементСтраница);
				ЭлементТаблица.ПутьКДанным = Реквизит.Имя;
				ЭлементТаблица.ИзменятьСоставСтрок = Истина;
				ЭлементТаблица.ИзменятьПорядокСтрок = Истина;
				ЭлементТаблица.Подвал = Ложь;
				ЭлементТаблица.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
				
			ИначеЕсли Реквизит.Имя <> "Изменен_ТЧ" Тогда
				
				ЭлементПоле = Элементы.Добавить(ПриемникДвижений.Имя + Реквизит.Имя, Тип("ПолеФормы"), Элементы[ПриемникДвижений.Имя]);
				ЭлементПоле.ПутьКДанным = ПриемникДвижений.Имя + "." + Реквизит.Имя;
				ЭлементПоле.Заголовок = Реквизит.Заголовок;
				
				Если Реквизит.ТипЗначения <> Тип("Булево") Тогда
					ЭлементПоле.Вид = ВидПоляФормы.ПолеВвода;
				Иначе
					ЭлементПоле.Вид = ВидПоляФормы.ПолеФлажка;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
		ЭтотОбъект[ПриемникДвижений.Имя].Очистить();
		
		Для каждого ЗаписьНабора Из НаборЗаписей Цикл
			
			НовСтрока = ЭтотОбъект[ПриемникДвижений.Имя].Добавить();
			ЗаполнитьЗначенияСвойств(НовСтрока, ЗаписьНабора);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Если Регистры.Количество() > 10 Тогда
		Элементы.ГруппаРегистры.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСлеваГоризонтально;
	Иначе
		Элементы.ГруппаРегистры.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСверху;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОбщиеСвойстваСтрокиРеквизита(СтрокаРеквизита, Реквизит, ИсточникДанных, Кэш)
	
	СтрокаРеквизита.Имя = Реквизит.Имя;
	СтрокаРеквизита.Синоним = Реквизит.Синоним;
	СтрокаРеквизита.Значение = ИсточникДанных[Реквизит.Имя];
	СтрокаРеквизита.СтароеЗначение = ИсточникДанных[Реквизит.Имя];
	СтрокаРеквизита.ОписаниеТипа = Реквизит.Тип;
	
	СтрокаРеквизита.АльтернативноеПредставление = ПолучитьАльтернативноеПредставление(СтрокаРеквизита.Значение);
	СтрокаРеквизита.Тип = Строка(Реквизит.Тип);
	
	СтрокаРеквизита.ТипКартинка = КартинкаРеквизита(Реквизит, Кэш);
	
	Если Реквизит.Тип.СодержитТип(Тип("ХранилищеЗначения")) Тогда
		СтрокаРеквизита.Недоступен = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Картинка реквизита.
//
// Параметры:
//  Реквизит - ОбъектМетаданныхОбщийРеквизит, ОписаниеСтандартногоРеквизита, ОбъектМетаданныхРеквизит - Реквизит формы
//  Кэш - Структура - Кэшированные значения:
// * Картинки - Соответствие - Кэш найденных картинок для переданных ранее типов
//
// Возвращаемое значение:
//  Картинка, Неопределено, Произвольный - Картинка реквизита
&НаСервере
Функция КартинкаРеквизита(Реквизит, Кэш)
	
	Если Реквизит.Тип.Типы().Количество() = 1 Тогда
		Тип = Реквизит.Тип.Типы()[0];
		Возврат КартинкаПоТипу(Тип, Кэш);
	Иначе
		Возврат БиблиотекаКартинок.РежимПросмотраСпискаСписок;
	КонецЕсли;
	
КонецФункции

// Картинка по типу.
//
// Параметры:
//  Тип - Тип - Тип значения, для которого выполняется поиск подходящей картинки
//  Кэш - Структура - Кэшированные значения:
// * Картинки - Соответствие - Кэш найденных картинок для переданных ранее типов
//
// Возвращаемое значение:
//  Неопределено, Картинка - Картинка из библиотеки картинок
&НаСервере
Функция КартинкаПоТипу(Тип, Кэш)
	
	КартинкиКэша = Кэш.Картинки;
	
	Картинка = КартинкиКэша.Получить(Тип);
	
	Если Картинка <> Неопределено Тогда
		Возврат Картинка;
	КонецЕсли;
	
	Картинка = ОпределитьКартинкуПоТипу(Тип);
	
	// Не найдена соответствующая типу картинка, ищем по метаданным
	Если Картинка = Неопределено Тогда
		ОбъектМетаданных = Метаданные.НайтиПоТипу(Тип);
		Если ОбъектМетаданных <> Неопределено Тогда
			Если Метаданные.Справочники.Содержит(ОбъектМетаданных) Тогда
				Картинка = БиблиотекаКартинок.Справочник;
			ИначеЕсли Метаданные.Документы.Содержит(ОбъектМетаданных) Тогда
				Картинка = БиблиотекаКартинок.Документ;
			ИначеЕсли Метаданные.Перечисления.Содержит(ОбъектМетаданных) Тогда
				Картинка = БиблиотекаКартинок.Перечисление;
			ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(ОбъектМетаданных) Тогда
				Картинка = БиблиотекаКартинок.ПланВидовХарактеристик;
			ИначеЕсли Метаданные.БизнесПроцессы.Содержит(ОбъектМетаданных) Тогда
				Картинка = БиблиотекаКартинок.БизнесПроцесс;
			ИначеЕсли Метаданные.ПланыСчетов.Содержит(ОбъектМетаданных) Тогда
				Картинка = БиблиотекаКартинок.ПланСчетов;
			Иначе
				Картинка = Неопределено;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	КартинкиКэша.Вставить(Тип, Картинка);
	
	Возврат Картинка;
	
КонецФункции

&НаСервере
Функция ОпределитьКартинкуПоТипу(ТипЗначения)
	
	СоответствиеКартинок = Новый Соответствие();
	
	СоответствиеКартинок.Вставить(Тип("Строка"), БиблиотекаКартинок.ВнешнийИсточникДанныхФункция);
	СоответствиеКартинок.Вставить(Тип("Число"), БиблиотекаКартинок.Калькулятор);
	СоответствиеКартинок.Вставить(Тип("Булево"), БиблиотекаКартинок.УстановитьФлажки);
	СоответствиеКартинок.Вставить(Тип("Дата"), БиблиотекаКартинок.Сегодня);
	СоответствиеКартинок.Вставить(Тип("ХранилищеЗначения"), БиблиотекаКартинок.ХранилищеНастроек);
	
	Возврат СоответствиеКартинок.Получить(ТипЗначения);
	
КонецФункции

#КонецОбласти

#Область УправлениеЭлементамиФормы

&НаСервере
Процедура УдалитьЭлементыРеквизитыТабличныхЧастейРегистров(ОбъектПрежний)
	
	Если ОбъектПрежний Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого СтрокаТЧ Из ТабличныеЧасти Цикл
		
		ЭлементТЧ = Элементы.Найти(СтрокаТЧ.Значение);
		
		Если ЭлементТЧ <> Неопределено Тогда
			Элементы.Удалить(ЭлементТЧ);
		КонецЕсли;
		
		ЭлементСтраницаТЧ = Элементы.Найти("Страница" + СтрокаТЧ.Значение);
		
		Если ЭлементТЧ <> Неопределено Тогда
			Элементы.Удалить(ЭлементСтраницаТЧ);
		КонецЕсли;
		
	КонецЦикла;
	
	Для каждого СтрокаТЧ Из Регистры Цикл
		
		ЭлементТЧ = Элементы.Найти(СтрокаТЧ.Значение);
		
		Если ЭлементТЧ <> Неопределено Тогда
			Элементы.Удалить(ЭлементТЧ);
		КонецЕсли;
		
		ЭлементСтраницаТЧ = Элементы.Найти("Страница" + СтрокаТЧ.Значение);
		
		Если ЭлементТЧ <> Неопределено Тогда
			Элементы.Удалить(ЭлементСтраницаТЧ);
		КонецЕсли;
		
	КонецЦикла;
	
	МассивУдалить = ТабличныеЧасти.ВыгрузитьЗначения();
	ДополнитьМассив(МассивУдалить, Регистры.ВыгрузитьЗначения(), Истина);
	
	Если МассивУдалить.Количество() > 0 Тогда
		ИзменитьРеквизиты( , МассивУдалить);
	КонецЕсли;
	
	Регистры.Очистить();
	ТабличныеЧасти.Очистить();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьИДоступностьЭлементов()
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		
		Элементы.Записать.Доступность = Истина;
		Элементы.ЗаписатьВРежимеЗагрузки.Доступность = Истина;
		
		Если Метаданные.Документы.Содержит(Ссылка.Метаданные()) Тогда
			Элементы.ПровестиНеоперативно.Доступность = Истина;
		КонецЕсли;
		
	Иначе
		
		Элементы.ПровестиНеоперативно.Доступность = Ложь;
		Элементы.Записать.Доступность = Ложь;
		Элементы.ЗаписатьВРежимеЗагрузки.Доступность = Ложь;
		
	КонецЕсли;
	
	Элементы.РеквизитыАльтернативноеПредставление.Видимость = ПоказыватьАльтернативноеПредставление;
	Элементы.РеквизитыГруппаТип.Видимость = ПоказыватьТип;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыФормы()
	
	Элементы.СтраницаРеквизиты.Заголовок = СтрШаблон("Реквизиты (%1)", Реквизиты.Количество());
	Элементы.СтраницаТабличныеЧасти.Заголовок = СтрШаблон("Табличные части (%1)", ТабличныеЧасти.Количество());
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ЗаписатьНаСервере(Режим = Неопределено, РежимЗагрузка = Ложь)
	
	Если Не ЗначениеЗаполнено(Ссылка) Тогда
		Возврат;
	КонецЕсли;
	
	ОбъектСсылка = Ссылка.ПолучитьОбъект();
	
	ОбъектСсылка.ОбменДанными.Загрузка = РежимЗагрузка;
	
	Для каждого СтрокаРеквизит Из Реквизиты Цикл
		Если СтрокаРеквизит.Изменен_ТЧ Тогда
			ОбъектСсылка[СтрокаРеквизит.Имя] = СтрокаРеквизит.Значение;
		КонецЕсли;
	КонецЦикла;
	
	Для каждого ТЧ Из ТабличныеЧасти Цикл
		Сч = 0;
		Для каждого СтрТЧ Из ЭтотОбъект[ТЧ.Значение] Цикл
			Если СтрТЧ.Изменен_ТЧ Тогда
				ИмяТЧ = СтрЗаменить(ТЧ.Значение, "_ТЧ", "");
				Если ОбъектСсылка[ИмяТЧ].Количество() < Сч + 1 Тогда
					// Это новая строка
					СтрокаОбъекта = ОбъектСсылка[ИмяТЧ].Добавить();
				Иначе
					СтрокаОбъекта = ОбъектСсылка[ИмяТЧ][Сч];
				КонецЕсли;
				ЗаполнитьЗначенияСвойств(СтрокаОбъекта, СтрТЧ);
			КонецЕсли;
			Сч = Сч + 1;
		КонецЦикла;
	КонецЦикла;
	
	Если Метаданные.Документы.Содержит(ОбъектСсылка.Метаданные()) Тогда
		Если Не ЗначениеЗаполнено(Режим) Тогда
			ОбъектСсылка.Записать(РежимЗаписиДокумента.Запись);
		ИначеЕсли Режим = "Неоперативно" Тогда
			ОбъектСсылка.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
		КонецЕсли;
	Иначе
		ОбъектСсылка.Записать();
	КонецЕсли;
	
	ЗаполнитьРеквизитыОбъекта(Истина);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	МассивПолейТаблицы = ОбработкаОбъект.ПолучитьМассивПолейТаблицы(Элементы.Реквизиты);
	
	ОбработкаОбъект.ДобавитьЭлементУсловногоОформления(ЭтотОбъект, "Реквизиты.Изменен_ТЧ",
		ВидСравненияКомпоновкиДанных.Равно,
		Истина,
		МассивПолейТаблицы,
		"ЦветФона",
		WebЦвета.БледноЗеленый);
	
	ОбработкаОбъект.ДобавитьЭлементУсловногоОформления(ЭтотОбъект, "Реквизиты.Недоступен",
		ВидСравненияКомпоновкиДанных.Равно,
		Истина,
		МассивПолейТаблицы,
		"ТолькоПросмотр",
		Истина);
	
	ОбработкаОбъект.ДобавитьЭлементУсловногоОформления(ЭтотОбъект, "Реквизиты.Недоступен",
		ВидСравненияКомпоновкиДанных.Равно,
		Истина,
		МассивПолейТаблицы,
		"ЦветТекста",
		WebЦвета.Серый);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораСтрокиРеквизита(Результат, ТекущаяСтрока) Экспорт
	
	Если Результат <> Неопределено Тогда
		ТекущаяСтрока.Значение = Результат;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьОткрытиеХранилищаЗначения(Хранилище, Инструкции)
	
	Значение = Хранилище.Получить();
	
	Если ТипЗнч(Значение) = Тип("ГрафическаяСхема") Или ТипЗнч(Значение) = Тип("ТабличныйДокумент") Тогда
		Инструкции.Вставить("Значение", Значение);
		Инструкции.Вставить("ВызватьМетодПоказать");
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьАльтернативноеПредставление(Значение)
	
	АльтернативноеПредставление = "";
	
	Если ЭтоСсылка(ТипЗнч(Значение)) Тогда
		Попытка
			ИмяПредопределенного = ПолучитьИмяПредопределенныхДанных(Значение);
			Если ПустаяСтрока(ИмяПредопределенного) Тогда
				Возврат Строка(Значение.УникальныйИдентификатор());
			Иначе
				Возврат ИмяПредопределенного;
			КонецЕсли;
		Исключение
			Возврат Строка(Значение.УникальныйИдентификатор());
		КонецПопытки;
	ИначеЕсли ЭтоПеречисление(ТипЗнч(Значение)) Тогда
		Для каждого ЗначениеПеречисления Из Значение.Метаданные().ЗначенияПеречисления Цикл
			Если ЗначениеПеречисления.Синоним = Строка(Значение) Тогда
				Возврат Значение.Метаданные().ПолноеИмя() + "." + ЗначениеПеречисления.Имя;
			КонецЕсли;
		КонецЦикла;
	Иначе
		Возврат "";
	КонецЕсли;
	
	Возврат АльтернативноеПредставление;
	
КонецФункции

&НаСервереБезКонтекста
Функция ЭтоПеречисление(ПроверяемыйТип)
	
	ТипПеречисления = Новый ОписаниеТипов(Перечисления.ТипВсеСсылки());
	
	Возврат ПроверяемыйТип <> Тип("Неопределено") И ТипПеречисления.СодержитТип(ПроверяемыйТип);
	
КонецФункции

&НаСервереБезКонтекста
Функция ЭтоСсылка(ПроверяемыйТип)
	
	Возврат ПроверяемыйТип <> Тип("Неопределено") И ОписаниеТипаВсеСсылки().СодержитТип(ПроверяемыйТип);
	
КонецФункции

&НаСервереБезКонтекста
Функция ОписаниеТипаВсеСсылки() Экспорт
	// BSLLS:NestedFunctionInParameters-off
	Возврат Новый ОписаниеТипов(Новый ОписаниеТипов(Новый ОписаниеТипов(Новый ОписаниеТипов(Новый ОписаниеТипов(
						Новый ОписаниеТипов(Новый ОписаниеТипов(Новый ОписаниеТипов(
									Справочники.ТипВсеСсылки(),
									Документы.ТипВсеСсылки().Типы()),
								ПланыОбмена.ТипВсеСсылки().Типы()),
							ПланыВидовХарактеристик.ТипВсеСсылки().Типы()),
						ПланыСчетов.ТипВсеСсылки().Типы()),
					ПланыВидовРасчета.ТипВсеСсылки().Типы()),
				БизнесПроцессы.ТипВсеСсылки().Типы()),
			БизнесПроцессы.ТипВсеСсылкиТочекМаршрутаБизнесПроцессов().Типы()),
		Задачи.ТипВсеСсылки().Типы());
	// BSLLS:NestedFunctionInParameters-on
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьИмяПредопределенныхДанных(Ссылка)
	
	Запрос = Новый Запрос(
			"ВЫБРАТЬ 
			|	Таблица.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных 
			|ИЗ 
			|	%ОбъектМетаданных% КАК Таблица 
			|ГДЕ 
			|	Таблица.Ссылка = &Ссылка"
		);
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ОбъектМетаданных%", Ссылка.Метаданные().ПолноеИмя());
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		Возврат "";
	Иначе
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.ИмяПредопределенныхДанных;
	КонецЕсли;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ИменаОбъектовМетаданных()
	
	Имена = Новый СписокЗначений;
	
	Имена.Добавить("Справочники");
	Имена.Добавить("Документы");
	Имена.Добавить("ПланыВидовХарактеристик");
	Имена.Добавить("ПланыВидовРасчета");
	Имена.Добавить("БизнесПроцессы");
	Имена.Добавить("ПланыОбмена");
	Имена.Добавить("Задачи");
	
	Возврат Имена;
	
КонецФункции

&НаКлиенте
Процедура ПослеВводаСсылки(Строка, ДопПараметры) Экспорт
	
	Если Строка = Неопределено Или ПустаяСтрока(Строка) Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоУникальныйИдентификатор(Строка) Тогда
		Сообщить("Введенная строка не является уникальным идентификатором!");
		Возврат;
	КонецЕсли;
	
	РезультатПоиска = НайтиСсылкуПоИдентификаторуНаСервере(Строка);
	
	ОбработатьРезультатПоискаСсылки(РезультатПоиска);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаНавигационнойСсылки(Строка, ДополнительныеПараметры) Экспорт
	
	Если Строка = Неопределено Или ПустаяСтрока(Строка) Тогда
		Возврат;
	КонецЕсли;
	
	РезультатПоиска = НайтиСсылкуПоНавигационнойСсылке(Строка);
	
	ОбработатьРезультатПоискаСсылки(РезультатПоиска);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НайтиСсылкуПоИдентификаторуНаСервере(СтрокаИД)
	
	УникальныйИдентификатор = Новый УникальныйИдентификатор(СтрокаИД);
	
	Имена = ИменаОбъектовМетаданных();
	СсылкаНаОбъект = Неопределено;
	
	Для каждого ЭлементСписка Из Имена Цикл
		
		// Передача значения в параметр СсылкаНаОбъект
		ПолучитьСсылкуПоМенеджеруОбъекта(Вычислить(ЭлементСписка.Значение), УникальныйИдентификатор, СсылкаНаОбъект);
		
		Если СсылкаНаОбъект <> Неопределено Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат РезультатПоискаСсылки(СсылкаНаОбъект);
	
КонецФункции

&НаКлиенте
Процедура ОбработатьРезультатПоискаСсылки(РезультатПоиска)
	
	Если РезультатПоиска.НайденнаяСсылка <> Неопределено Тогда
		ОбработатьВыборСсылки(РезультатПоиска.НайденнаяСсылка, РезультатПоиска.ИмяОбъекта);
	Иначе
		Сообщить("Ссылка не найдена");
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НайтиСсылкуПоНавигационнойСсылке(НС)
	
	ПервоеВхождение = СтрНайти(НС, "e1cib/data/");
	ВтороеВхождение = СтрНайти(НС, "?ref=");
	
	Если ПервоеВхождение = 0 Или ВтороеВхождение = 0 Тогда
		Возврат РезультатПоискаСсылки(Неопределено);
	КонецЕсли;
	
	ПредставлениеТипа = Сред(НС, ПервоеВхождение + 11, ВтороеВхождение - ПервоеВхождение - 11);
	ШаблонЗначения = ЗначениеВСтрокуВнутр(ПредопределенноеЗначение(ПредставлениеТипа + ".ПустаяСсылка"));
	ЗначениеСсылки = СтрЗаменить(ШаблонЗначения, "00000000000000000000000000000000", Сред(НС, ВтороеВхождение + 5));
	
	СсылкаНаОбъект = ЗначениеИзСтрокиВнутр(ЗначениеСсылки);
	
	Если ЭтоСсылка(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат РезультатПоискаСсылки(СсылкаНаОбъект);
	Иначе
		Возврат РезультатПоискаСсылки(Неопределено);
	КонецЕсли;
	
КонецФункции

&НаСервереБезКонтекста
Функция РезультатПоискаСсылки(СсылкаНаОбъект)
	
	Результат = Новый Структура;
	
	Результат.Вставить("НайденнаяСсылка", СсылкаНаОбъект);
	Результат.Вставить("ИмяОбъекта", ?(СсылкаНаОбъект = Неопределено, "", СсылкаНаОбъект.Метаданные().ПолноеИмя()));
	
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Процедура ПолучитьСсылкуПоМенеджеруОбъекта(ОбъектыМенеджер, УникальныйИдентификатор, СсылкаНаОбъект)
	
	Для Каждого Менеджер Из ОбъектыМенеджер Цикл
		
		СсылкаНаОбъект = Менеджер.ПолучитьСсылку(УникальныйИдентификатор);
		
		Если СсылкаНаОбъект.ПолучитьОбъект() <> Неопределено Тогда
			Возврат;
		Иначе
			СсылкаНаОбъект = Неопределено;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СсылкаПоУИД(ИмяОбъекта, УИД)
	
	НайденныеМетаданные = Метаданные.НайтиПоПолномуИмени(ИмяОбъекта);
	
	Если Метаданные.Справочники.Содержит(НайденныеМетаданные) Тогда
		ОбъектМенеджер = Вычислить("Справочники." + НайденныеМетаданные.Имя);
	ИначеЕсли Метаданные.Документы.Содержит(НайденныеМетаданные) Тогда
		ОбъектМенеджер = Вычислить("Документы." + НайденныеМетаданные.Имя);
	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(НайденныеМетаданные) Тогда
		ОбъектМенеджер = Вычислить("ПланыВидовХарактеристик." + НайденныеМетаданные.Имя);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Ссылка = ОбъектМенеджер.ПолучитьСсылку(Новый УникальныйИдентификатор(УИД));
	
	Если Не Ссылка.Пустая() Тогда
		Возврат Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ЭтоУникальныйИдентификатор(Знач Значение)
	
	Шаблон = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
	
	Если СтрДлина(Шаблон) <> СтрДлина(Значение) Тогда
		Возврат Ложь;
	КонецЕсли;
	Для Позиция = 1 По СтрДлина(Значение) Цикл
		// BSLLS:MagicNumber-off
		НевалидныйСимвол = КодСимвола(Шаблон, Позиция) = 88 // X
			И ((КодСимвола(Значение, Позиция) < 48 Или КодСимвола(Значение, Позиция) > 57) // 0..9
				И (КодСимвола(Значение, Позиция) < 97 Или КодСимвола(Значение, Позиция) > 102) // a..f
				И (КодСимвола(Значение, Позиция) < 65 Или КодСимвола(Значение, Позиция) > 70)) // A..F
			Или КодСимвола(Шаблон, Позиция) = 45 И КодСимвола(Значение, Позиция) <> 45; // -
		// BSLLS:MagicNumber-on
		Если НевалидныйСимвол Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ДополнитьМассив(МассивПриемник, МассивИсточник, ТолькоУникальныеЗначения = Ложь) Экспорт
	
	Если ТолькоУникальныеЗначения Тогда
		
		УникальныеЗначения = Новый Соответствие;
		
		Для Каждого Значение Из МассивПриемник Цикл
			УникальныеЗначения.Вставить(Значение, Истина);
		КонецЦикла;
		
		Для Каждого Значение Из МассивИсточник Цикл
			Если УникальныеЗначения[Значение] = Неопределено Тогда
				МассивПриемник.Добавить(Значение);
				УникальныеЗначения.Вставить(Значение, Истина);
			КонецЕсли;
		КонецЦикла;
		
	Иначе
		
		Для Каждого Значение Из МассивИсточник Цикл
			МассивПриемник.Добавить(Значение);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ВариантыФормыВыбора(КлючВарианта)
	
	Варианты = Новый Структура;
	Варианты.Вставить("Стандартная", 1);
	Варианты.Вставить("Генерируемая", 2);
	
	Возврат Варианты[КлючВарианта];
	
КонецФункции

#КонецОбласти