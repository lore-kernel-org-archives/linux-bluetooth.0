Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8712867d0608190931o3f6042eyfdb6fdff805f91b@mail.gmail.com>
References: <8712867d0608190931o3f6042eyfdb6fdff805f91b@mail.gmail.com>
Date: Sun, 20 Aug 2006 03:35:32 +0200
Message-Id: <1156037732.3989.10.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] libbluetooth usage
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

Hi Jaime,

> Can someone please point me to some documentation about libbluetooth usage?
> 
> How can I use this library to establish comunication with a BT device?
> 
> I'm trying to write a program in J2ME for my Nokia 6670 that
> communicates with my Linux PC via RFCOMM. If I use the rfcomm utility
> like this:
> 
> # rfcomm bind 0 00:02:5B:00:A5:A5
> 
> All I have to do is write a program that opens the rfcomm0 serial port
> and waits for data? How can I detect when the client connects?

who is the client?

> How do I use the RFCOMM socket interface?

The programs rctest.c and attest.c give a good example on how to use the
RFCOMM socket interface.

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
