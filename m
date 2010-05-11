Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273589222.840882.854.nullmailer@galant.ukfsn.org>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <4BE270EE.5080306@greffrath.com>
	 <u2z793f89501005060256g3eb32a09ncff16e8e454bdcc@mail.gmail.com>
	 <1273589222.840882.854.nullmailer@galant.ukfsn.org>
Date: Tue, 11 May 2010 19:40:11 +0300
Message-ID: <AANLkTilEsIYKxwdD4ZLbYaIExMlHfEmpuOnj8BKeI4XP@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/5/11 Iain Hibbert:
>
> Serhiy, from your message on the ubuntu bug report
>
>> Maybe the reason is that this dongle doesn't support reading/writing of
>> 'Default Link Policy Settings' ?
>
> and this command was introduced in spec version 1.2, and your device
> reports
>
>>        HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver: 0x800
>
> so yes, that is likely the problem as it is too old.
>
> That bluez has no handling for the possibility that the command may not be
> supported is possibly a bug or possibly an indication that older devices
> are no longer to be supported, I can't really say which.
>
Yeah, i see that this device is a little buggy, but it worked in
previous version of bluez, so maybe it is possible to make it work
again for current version?
