Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061020084015.40100.qmail@web52012.mail.yahoo.com>
References: <20061020084015.40100.qmail@web52012.mail.yahoo.com>
Date: Fri, 20 Oct 2006 10:51:16 +0200
Message-Id: <1161334276.27585.42.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Cant get dongle up
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

Hi,

> I am new to Linux and blueZ, so may be my question may be  silly.
> 
> My USB BT dongle has ISSC chipset (the ebay seller claimed that it
> will be a Bilionton dongle but it turned out to be a cheap EEPROM less
> dongle with 11:11.. BD address ) . It works fine in windows with
> blusoleil. But  I could not get it working in Linux - Kernerl 2.6.11 ,
> Fedora core 3 redhat 12.0. 

does it change the address when using it with BlueSoleil? If it doesn't
then you might wanna return this dongle and buy a good one.

You kernel is quite ancient. You can try to load the hci_usb driver with
the isoc=0 switch, but it might be a better idea to upgrade to Fedora
Core 6 on Tuesday.

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
