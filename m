Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060706100912.95773.qmail@web25107.mail.ukl.yahoo.com>
References: <20060706100912.95773.qmail@web25107.mail.ukl.yahoo.com>
Date: Tue, 11 Jul 2006 13:18:58 +0200
Message-Id: <1152616738.15028.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcidump of an ok sco connection with a hs?
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

Hi Salvatore,

> i 'm trying to establish a connection with a headset from a usb/dongle
> using a my custom usb driver: the acl connection is created, the sco
> one's is refused. 
> 1) I'm looking for an output of hcidump related to the creation from
> scratch of a sco connection, eventually whit sco data,
> 2) is necessary l2cap packet to start sco transfer?

in general not, but it might be in specific implementations.

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
