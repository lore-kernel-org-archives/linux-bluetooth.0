Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Jun 2009 15:07:47 +0200
Subject: RE: Mixed Results Playing mp3
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06B181C5@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com>
	<4A42056D.90600@wowway.com>
 <6AC5A55546F64545AE996F8200E3AC4E06B1802D@NL0105EXC01V01.eur.slb.com>
 <4A421E89.3080300@gdatech.co.in>
In-Reply-To: <4A421E89.3080300@gdatech.co.in>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: Benjamin Vasanthakumar J [mailto:j.benjamin@gdatech.co.in]
Sent: 24 June, 2009 16:40
To: John Frankish
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Mixed Results Playing mp3

Dear John Frankish,
>
>> I get the following results:
>>
>> 1. mplayer-gtk1 (svn 29308): plays without problems
>>
>> 2. xmms-1.2.11: no error messages, but produces "noise" and "clicks" (the bluez wiki mentions "issues" with xmms).
>>
>> 3. aplay-1.0.20: Is it possible to play mp3 with aplay, if so, what command is required?
>>
>
> aplay will not play mp3 encoded files.
>
>
>> 4. mpg123-1.8.1: "mpg123 -v -a plug:bluetooth file.mp3", "mpg123 -v -a bluetooth file.mp3", no error messages, but produces "noise" and "clicks"
>>
>> I don't see why xmms and mpg123 wouldn't work and there are no error messages or pointers from "bluetoothd -dn" - does anybody have any ideas?
>>
>> -----------
>> pcm.rawbluetooth {
>>    type bluetooth
>>    device 00:12:EE:A6:1D:F4
>> }
>>
>> pcm.bluetooth {
>>    type plug
>>    slave {
>>       pcm {
>>          type bluetooth
>>          device 00:12:EE:A6:1D:F4
>>       }
>>    }
>> }
>>
>
>
> Please refer to here:
>
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>
>
>> I did (and I tried this also with the same results), the .asoundrc I used is as per the example /etc/alsa/Bluetooth.conf provided in the bluez-4.41 tarball
>>
>
> Your asoundrc differs from the example.
>
> Does your mpg123 support alsa?
>
>
>> yes, it plays mp3 without problems via the machine's sound card
>>
>
> John
>
>
>> --
>>
> Thanks for the reply

Whether .wav file play through 'aplay' is working fine for you?

[snip]

Yes, I didn't mention it, but aplay is working fine with a wav file
