Return-Path: <cyrus@holtmann.org>
Message-ID: <492E81B1.5020709@powercraft.nl>
Date: Thu, 27 Nov 2008 12:17:05 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: Simon Kenyon <simon@koala.ie>, linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (help requested)
References: <492E6E6A.80509@koala.ie>  <492E7D86.8030007@powercraft.nl> <1227784243.27994.1770.camel@cookie.hadess.net>
In-Reply-To: <1227784243.27994.1770.camel@cookie.hadess.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Thu, 2008-11-27 at 11:59 +0100, Jelle de Jong wrote:
> <snip>
>> I talked to Marcel about the Sony BD Remote on the CELINUX event in the
>> Netherlands. I took my Sony BD Remote with me to show some issues.
>> Marcel did some on the fly coding to get the device connected, but there
>> is missing an hid driver that maps the keys to an input event xorg can use.
>>
>> So the device is not working yet, until somebody creates a proper hid
>> driver for the device to map the keys.
> 
> Should just work with a (very) recent distro:
> https://bugs.freedesktop.org/show_bug.cgi?id=16519
> 
> This might be missing some keys in the X evdev keyboard map, although I
> believe Peter already fixed this.
> 
> And it should also just work using LIRC (which is how I got it to work
> in the first place). Use gnome-lirc-properties to set it up.
> 
> Cheers

So does it create an input event that I can use with evtest and
xbindkeys --key to add commands to the keys. I really really don't like
all those gnome apps.... to get hardware working, hardware should be
graphical destkop independent configured. A month ago the device was not
working yet.

Best regards,

Jelle
