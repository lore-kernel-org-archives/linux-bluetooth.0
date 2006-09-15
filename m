Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean-Jacques BRUCKER <jean-jacques.brucker@sagem.com>
In-Reply-To: <OF17F608CF.D3B6895F-ONC12571EA.00520CD6-C12571EA.0056BD61@sagem.com>
References: <OF17F608CF.D3B6895F-ONC12571EA.00520CD6-C12571EA.0056BD61@sagem.com>
Date: Fri, 15 Sep 2006 18:34:05 +0200
Message-Id: <1158338045.5233.44.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluez : new bluetooth keyboard supported by hidd.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jean-Jacques,

> I have recently bought a bluetooth "Smart Keyboard" for my Nokia 770.
> But this keyboard, doesn't have a sdp server and was not supported by
> bluez-tools.
> 
> (Here are the caracteristics of my keyboard:  
>         bd addr : 00:0A:3A:2E:7B:AC
>         name : KEYBOARD
>         CoD (Class of Device/Service) : 0x001f00
> )
> 
> So i have make some change in your source code to support him.
> Here is my patch and the patched tar.gz (with my makefiles, and i have
> verify that files wasn't modified recently on CVS).
> 
> As you will see i have created a new file devices.h and i have
> suggested an architecture to manage different peripherals.

I have put a file fakehid.txt in the CVS with the characteristics of
this keyboard and also the presenter device.

> As I work for Sagem Communication, this keyboard now will work on our
> Sagem Linux phone (in developpement).

Make sure to send me one for testing ;)

> (I Gonna make it work now on my Nokia 770, but I don't know how to do
> it yet, as it use dbus... and i am asking me if that was really
> necessary, and if hidd is used on the Nokia 770...).

The Nokia 770 has no supported HID support. However you can install an
applet that gives you keyboard support. This however runs hidd and so it
should not be a big problem to integrate it.

> I notice the hidd deamon may need some minor improvement now, like
> forking and doing a "search device" on a signal event. Or reading a
> configuration file that contains knows devices and connect them on
> other signal... (or using dbus... ?). (just thinking... trying to
> share ideas...).

The hidd needs D-Bus support and a small redesign. However at the moment
we are just finishing the D-Bus support in hcid and its sdpd integration
and so it might take some time before we start looking at hidd. However
feel free to propose something.

> PS: I don't have a "secure" mail server to suscribe myself to
> bluez-devel mail list. So could you please add one of my email to the
> bluez-devel mail list ?
> (personnal email: jjbrucker@free.fr, professionnal email:
> jean-jacques.brucker@sagem.com, should be the one in sender field of
> this email).

No idea what this means. Nobody needs a secure mail server to subscribe
to bluez-devel. Simply use the webform to subscribe.

> PS2: Any comments about my patche are welcome...

It needs a little bit nicer and cleaner integration work, but it seem a
good step forward to make this keyboard work under Linux.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
