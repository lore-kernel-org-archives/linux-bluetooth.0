Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060829183511.65481.qmail@web25714.mail.ukl.yahoo.com>
References: <20060829183511.65481.qmail@web25714.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 22:52:37 +0200
Message-Id: <1156884757.4026.28.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hci0 only comes up with PSCAN (no ISCAN)
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

Hi Ray,

> i am currently using bluez 3.4 (hcid has dynamic dep
> on libbluetooth-2.2.1) so the disable iscan bug still
> exists.

I have no idea what you mean. This bug has nothing to do with the
library version you use. However if you use bluez-utils-3.4 the you
should also use bluez-libs-3.4 as stated in the ChangeLog file. A
previous library version might work, but it can also have side effects.

> i followed the instructions and put in "discovto 0;"
> to hcid.conf and restarted everything and this fixed
> the problem.  i didnt do anything else (no dbus-send
> etc)

Then the mode settings was "discoverable".

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
