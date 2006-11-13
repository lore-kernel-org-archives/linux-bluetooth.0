Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200611131907.13234.Kilian.Lackhove@web.de>
References: <mailman.19693.1163411759.8777.bluez-users@lists.sourceforge.net>
	<200611131907.13234.Kilian.Lackhove@web.de>
Date: Mon, 13 Nov 2006 19:29:07 +0100
Message-Id: <1163442547.26272.66.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Ubuntu edgy + Keyboard + dbus + security mode 3
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

Hi Kilian,

> I added the --encrypt option to my /etc/defaults/bluetooth and restarted the 
> deamon while running "bluez-pun --dbus". After a few seconds my keyboard 
> worked again and hcitool con showed 
> 
> ACL XX:XX:XX:XX:XX:XX handle 42 state 1 lm MASTER AUTH ENCRYPT
> 
> But even though everything seemed to have worked fine, I wasnt asked for a 
> pin... So my Question: Is everything really alright (and secure) now?

yes it is. However you might wanna consider call "hcitool key ..." to
establish a new link key if you don't know where the old one came from.

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
