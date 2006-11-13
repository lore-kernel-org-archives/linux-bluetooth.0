Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061108210057.7c40adaa@nim.leo>
References: <20061108210057.7c40adaa@nim.leo>
Date: Mon, 13 Nov 2006 09:14:54 +0100
Message-Id: <1163405694.26272.36.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] "Connect" button on Logitech bluetooth receiver
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Paul,

> I've got a Logitech bluetooth keyboard/mouse combo that comes with a
> charging base for the mouse, which server also as the BT receiver. On it
> is a button marked "connect".
> 
> When the receiver is working in "I'll do the bluetooth bit and just
> pretend to be a USB keyboard and mouse", this is used to connect it to
> the keyboard or mouse in question. When it is running as a real Bluetooth
> receiver with the HID being done by Linux, this button appears to have no
> effect.
> 
> I was wondering whether it might be possible to watch for this button
> being pressed, and if so, trigger a
> 
>   hidd --search
> 
> command.

I personally don't think that this button event is reported through HID
in any way. So we can't react on it.

> I ask because sometimes lately I've noticed the keyboard and/or mouse
> will become disconnected, requiring the above command to be run
> simultaneously to pressing the "connect" button on the keyboard/mouse.
> When the mouse has done that, not too difficult. But if the keyboard
> goes, it's obviously more difficult to recover :)

A Bluetooth mouse and keyboard re-connects to you after the initial
connect. Make sure "hidd --server" is running to accept these connects.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
