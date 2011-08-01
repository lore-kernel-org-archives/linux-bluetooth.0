Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] configuring device class
From: Bastien Nocera <hadess@hadess.net>
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 01 Aug 2011 16:08:27 +0100
In-Reply-To: <4E3400F7.4000504@poczta.fm>
References: <4E3400F7.4000504@poczta.fm>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1312211308.2522.15.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2011-07-30 at 15:02 +0200, Lukasz Stelmach wrote:
> Hi.
> 
> I am investigating ways to set the device class (computer/laptop
> etc) of a bluetooth device. There is a key in main.conf named
> Class to set the class but aparently it is overridden by the
> class field of /var/lib/bluetooth/<bdaddr>/config. Once the class
> is stored there changes in main.conf don't affect the actual class
> the device presents. IMHO it is quite obutse and it took me an hour
> or more with a debugger to find out how to change it so I'd like to
> propose the following patch. Are there any reasons that the config
> file in /var should override the value from /etc?

I'm not sure what we're trying to achieve with per-adapter classes (if
not for debugging purposes).

I would simply never write the class of the adapter to disk, and use the
DMI information, with the value in the options file as fallback if a
class could not be gathered. If the formfactor plugin isn't in use, use
the options value.

eg. your patch, plus a change in formfactor.c to not overwrite the
class, and another to never actually write the class to disk.

Cheers

