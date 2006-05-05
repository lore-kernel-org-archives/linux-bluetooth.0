Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Message-ID: <loom.20060505T213220-715@post.gmane.org>
References: <200604291601.43549.menard.fabrice@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [Bluez-users] Re: DiNovo and evdev
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 5 May 2006 19:40:18 +0000 (UTC)

Fabrice Ménard <menard.fabrice <at> wanadoo.fr> writes:
> Is there a way to make appear the mouse in /proc/bus/input/devices without 
> having to move the device ?

I suppose you should hack your hidd init script (or create an extra init script)
to aggresively connect the mouse. ie. hidd --connect 00:07:61:24:12:34

Just curious, will evdev give us the 11th mouse button and all keyboard Fn keys?

gr
Dick



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
