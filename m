Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Fabrice =?iso-8859-1?q?M=E9nard?= <menard.fabrice@orange.fr>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 8 Dec 2007 11:25:03 +0100
References: <1196009038.14897.6.camel@pico>
	<a8e1da0711291706h68d1d19ajc3819f8836cf51e8@mail.gmail.com>
	<20071208004239.234a0406@neutrino.cosmos.net>
In-Reply-To: <20071208004239.234a0406@neutrino.cosmos.net>
MIME-Version: 1.0
Message-Id: <200712081125.03678.>
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Saturday 08 December 2007 00:42:39 Didier Link wrote:
> Hi all,
>
> Just for add something on this bug report, I've the same hardware
> (Logitech dinovo keyboard+mouse), connected with bluetooth
> hcid/bluetoothd-service-input
>
> First of all, this work very well at first run and all the time I
> interact with keyboard and mouse, very good job of the bluez stack
> developpers !
>
> But, like Brad, after an amount of inactivity (about 20 minutes
> I think ...) the devices go to sleep mode and never reconnect. I need to
> restart the bluetooth service at all, with another usb keyboard. My
> kernel log contain the same warnings as Brad each time the service is
> restarted.

I had a similar problem, see my post for a possible solution (it works for =

me):
http://article.gmane.org/gmane.linux.bluez.user/12988/match=3Ddinovo

Regards,

Fabrice M=E9nard




-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
