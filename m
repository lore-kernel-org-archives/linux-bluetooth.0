Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris Spencer <chrisspen@gmail.com>
In-Reply-To: <450D7E04.6080107@gmail.com>
References: <beb7688e0609150702x738ad4d8re64815d12f457a76@mail.gmail.com>
	<1158329592.5233.32.camel@localhost>  <450B3B01.2060801@gmail.com>
	<1158397207.6839.1.camel@localhost>  <450D7E04.6080107@gmail.com>
Date: Mon, 18 Sep 2006 08:38:01 +0200
Message-Id: <1158561481.30486.30.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Celluon Laserkey Bluetooth Keyboard
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

Hi Chris,

> >> Please let me know if you need any other information, or if there's 
> >> anything I can do to help get this working.
> > 
> > this looks like the third of these. Please also run "hcitool inq" and
> > "hcitool info ..." (as root) for this.
>
> What do mean by the "third of these"? Is it going to be difficult to 
> make a driver?

run "hcidump -X -V" and then connect to RFCOMM channel 1 with the rfcomm
tool and then start pressing keys and see what hcidump shows you. Maybe
it is a simple key mapping. Check the Smart Keyboard support for an
example on how to add support for this keyboard.

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
