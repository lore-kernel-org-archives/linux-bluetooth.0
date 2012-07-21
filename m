Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <654DF80AD31A344E93DBCC6280BD6DEF8598D39E@NL0230MBX08N1.DIR.slb.com>
References: <654DF80AD31A344E93DBCC6280BD6DEF8598D39E@NL0230MBX08N1.DIR.slb.com>
Date: Sat, 21 Jul 2012 09:15:28 +0200
Message-ID: <CANT-zCUvCc9EY6_MdjWg4qLUR90vzggPqER4=4vNBLoKzVsrQA@mail.gmail.com>
Subject: Re: FW: Can no longer connect to audio stream with bluez > 0.96 and pulseaudio-2
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Sat, Jul 21, 2012 at 8:57 AM, John Frankish <j-frankish@slb.com> wrote:
> Forgot bluetoothd output - added below
>
> -----Original Message-----
> From: John Frankish
> Sent: Friday, 20 July, 2012 21:19
> To: linux-bluetooth@vger.kernel.org
> Subject: Can no longer connect to audio stream with bluez > 0.96 and pulseaudio-2
>
> Using bluez-0.96 and pulseaudio-1.xx I could use bluetooth headphones without problems using blueman-1.23 to connect to an a2dp sink.
>
> With bluez-0.99/0.101 and pulseaudio-2 I can no longer connect and blueman gives the following error:
>
> Stream setup failed
>
> I see that bluez has moved to the MediaEndpoint format and that I need a /usr/local/etc/bluetooth/audio.conf for the first time, but things still don't work (details below), there are no error messages to speak of, am I doing something wrong?

I can't tell for sure but I can reproduce similar problem with a2dp
sources. I actually fails with some devices only, so chances are that
it's due to some race condition.

This seems to be a regression introduced recently, which I didn't have
time to check further.

In any case, could you provide us with the audio.conf you're using?

Cheers,
Mikel
