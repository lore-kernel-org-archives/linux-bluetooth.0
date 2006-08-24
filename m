Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <A984CC9EDAD168478B41BCBFA06E8D4D023565A5@xmb-rtp-203.amer.cisco.com>
References: <A984CC9EDAD168478B41BCBFA06E8D4D023565A5@xmb-rtp-203.amer.cisco.com>
Date: Thu, 24 Aug 2006 23:27:35 +0200
Message-Id: <1156454855.4133.110.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't get 'hciattach' to work with Broadcom USB	BT
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

Hi Larry,

> I'm using the 2.6 Kernel on RedHat Desktop 4 (2.6.9-42)  
> BT adapter is Kensington USB 2.0 (Broadcom chipset)  
> BlueZ tools seem to mostly work.  All commands like "lsusb", "hciconfig", "hcitool", "l2ping" work fine.  
> 
> But "hciattach" does not work for me.  It yields this:  
> [root@localhost init.d]# lsusb                                                   
> Bus 001 Device 002: ID 047d:105e Kensington     

if you use a USB Bluetooth dongle, then you don't need hciattach. It is
only needed for UART/serial based adapters.

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
