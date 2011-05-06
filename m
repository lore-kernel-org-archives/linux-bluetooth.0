Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304693325.16101.34.camel@novo.hadess.net>
References: <1304620983.16101.16.camel@novo.hadess.net>
	<BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
	<1304693325.16101.34.camel@novo.hadess.net>
Date: Fri, 6 May 2011 20:43:07 +0300
Message-ID: <BANLkTim+KAu03JSJ--wkYGs0a9kD6hzC7w@mail.gmail.com>
Subject: Re: Warning fixes for GCC 4.6
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 6, 2011 at 5:48 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> @@ -250,7 +250,7 @@ static int decode_key(const char *str)
>>  static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
>>  {
>>       struct uinput_event event;
>> -     int err;
>> +     int __attribute__((__unused__)) err;
>>
>>       memset(&event, 0, sizeof(event));
>>       event.type      = type;
>>
>> Can't we just removed err here, Im afraid using
>> __attribute__((__unused__)) is not a good practice and we should try
>> to avoid using it.
>
> We either get a warning that the return value is unused, or that we
> should be checking the return value. Which one do you prefer?

I guess I would prefer checking the return properly if you don't mind.
Also like Gustavo mentioned, it would be great to have the gdbus
changes in a separate patch so we can apply to other project which
uses it.

-- 
Luiz Augusto von Dentz
Computer Engineer
