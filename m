Return-Path: <tdwan@MIT.EDU>
Message-ID: <1082563268.40869ac41cfc3@webmail.mit.edu>
Date: Wed, 21 Apr 2004 12:01:08 -0400
From: Tehyih D Wan <tdwan@MIT.EDU>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] installing bluez-hciemu-1.0 on Debian--GLib not	found
References: <1081889721.407c53b90c5d4@webmail.mit.edu> <1082161011.4489.30.camel@pegasus>
In-Reply-To: <1082161011.4489.30.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

I looked in hciemu.c and the only reference I found to Glib was the #include
<glib.h> line.  Should I change this to say glib-2.0?  Or is there another
source file I should look at?

I did get the emulator installed (at least, I no longer get configuration
errors) by installing the glib1.2-dev library.  However, I'm not able to
emulate any devices.  Typing "hciemu localhost:11" gives no errors, but when I
try "hciconfig hci11 up" I get a message that there is no such device.  I run
/etc/init.d/bluetooth start before everything but that does not seem to make a
difference.  Suggestions on what log files or messages I can look for to see
what is wrong?

Thanks,
Debbie

Quoting Marcel Holtmann <marcel@holtmann.org>:

> Hi Debbie,
> 
> > I'm trying to install bluez-hciemu on Debian, and getting the error
> "checking
> > for glib-config...not found" when I run the ./configure script.
> > 
> > I've installed libglib2.0, libglib2.0-dev, libglib2.0-data, and
> libglib2.0-dbg,
> > but I still get the same error when running the ./configure script.
> > 
> > There was a thread about this same problem back in 2003 but the only
> suggestion
> > seemed to be to try installing the -dev packages for Glib.  Any ideas on
> what
> > else I might try?
> 
> change the source of hciemu to use Glib 2.x (and send us a patch) or
> install the development packages of Glib 1.4.
> 
> Regards
> 
> Marcel
> 
> 
> 
