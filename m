Return-Path: <cyrus@holtmann.org>
Message-ID: <4A42056D.90600@wowway.com>
Date: Wed, 24 Jun 2009 05:52:29 -0500
From: "John R." <johnr@wowway.com>
MIME-Version: 1.0
To: John Frankish <j-frankish@slb.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Mixed Results Playing mp3
References: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John Frankish wrote:

[snip]

> I get the following results:
> 
> 1. mplayer-gtk1 (svn 29308): plays without problems
> 
> 2. xmms-1.2.11: no error messages, but produces "noise" and "clicks" (the bluez wiki mentions "issues" with xmms).
> 
> 3. aplay-1.0.20: Is it possible to play mp3 with aplay, if so, what command is required?

aplay will not play mp3 encoded files.

> 4. mpg123-1.8.1: "mpg123 -v -a plug:bluetooth file.mp3", "mpg123 -v -a bluetooth file.mp3", no error messages, but produces "noise" and "clicks"
> 
> I don't see why xmms and mpg123 wouldn't work and there are no error messages or pointers from "bluetoothd -dn" - does anybody have any ideas?
> 
> -----------
> pcm.rawbluetooth {
>    type bluetooth
>    device 00:12:EE:A6:1D:F4
> }
> 
> pcm.bluetooth {
>    type plug
>    slave {
>       pcm {
>          type bluetooth
>          device 00:12:EE:A6:1D:F4
>       }
>    }
> }


Please refer to here:

http://wiki.bluez.org/wiki/HOWTO/AudioDevices

Your asoundrc differs from the example.

Does your mpg123 support alsa?

John

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

