Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4DD75480.3030509@ethicstech.in>
References: <4DD675D5.1030601@ethicstech.in>
	<BANLkTimFfLJxwyTM2MNcVeEMC2n+r2MsHA@mail.gmail.com>
	<4DD75480.3030509@ethicstech.in>
Date: Sat, 21 May 2011 11:56:43 +0200
Message-ID: <BANLkTimj+_eSaPZkvbYZwjQVbydPiowswQ@mail.gmail.com>
Subject: Re: How to test ssp pairing in linux
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Siva kumar <sivakumar@ethicstech.in>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, May 21, 2011 at 7:58 AM, Siva kumar <sivakumar@ethicstech.in> wrote:
> Bartosz Szatkowski wrote:
>>
>> On Fri, May 20, 2011 at 4:08 PM, Siva kumar <sivakumar@ethicstech.in>
>> wrote:
>>
>>>
>>> Hi all,
>>>
>>>          I had an android mobile with ssp pairing ssp pairing support, i
>>> want to check ssp pairing. When i try to pair with pc it asks for pin. i
>>> don't known how to enable ssp pairing in pc, i am using ubuntu 9.10
>>>
>>> Regards
>>> sivakumar
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>> Hi,
>> what is Your BlueZ version? Also on some (older) Android devices
>> (ROMs) there is no SSP, (not sure whether agent version matters eg
>> bluetooth-applet).
>> In other cases SSP should be used by default.
>>
>>
>
> I am using bluez 4.51-Oubuntu2, i have conformed my android phone has ssp as
> i was able to connect with other android device using ssp pairing.
> When i connect with the desktop it asks for pin.
>
>
>
>

Start by upgrading BlueZ :P ... to some reasonable new version ...
4.93 is the most current one.

-- 
Pozdrowienia,
Bartosz Szatkowski
