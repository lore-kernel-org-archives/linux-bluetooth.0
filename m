Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: AVRCP example
Message-ID: <5a957e95-1768-31a9-1a0a-da6ff58f8574@gmail.com>
Date: Sun, 12 Jun 2016 13:11:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I'm running bluez 5.40 and pulseaudio 8.0 on a Debian Jessie system.
I paired and trusted a phone and I can play audio using A2DP from phone 
to the machine.

Now I want to control the audio from the machine, i.e. prev/next, show 
song title, etc...

I don't understand how to use the simple-player example.
It says:

> Available commands:
> 	PropertiesChanged(interface, properties)
> 	help(cmd)
>
> Use python syntax to pass arguments to available methods.
> E.g.: PropertiesChanged({'Metadata' : {'Title': 'My title', 'Album': 'my album' }})

but if I try exactly what it suggests:

> PropertiesChanged({'Metadata' : {'Title': 'My title', 'Album': 'my album' }})

it returns this error:

> PropertiesChanged() takes at least 3 arguments (2 given)


Please, would you help me to understand how to run this example, or at 
least how to implement a single command? i.e. how to select the next song.

Thanks!
Marco
