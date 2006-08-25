Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1999a7e40608250248h4fe44645g2d46008f5a8f874c@mail.gmail.com>
References: <1999a7e40608250248h4fe44645g2d46008f5a8f874c@mail.gmail.com>
Date: Fri, 25 Aug 2006 15:05:20 +0200
Message-Id: <1156511120.4133.121.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HCI host
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

Hi Dalmo,

>     Hi, i am in a group that is developing a bluetooth firmware (in C
> language). We are developing the hci host, baseband, lmp.

is this an open project? What hardware are you using for the radio and
the baseband?

>    I would like to test the hci host with bluez, to see if the packets
> that i am expecting are right. How can i use bluez to do this?

If you have USB or UART as transport then you don't need anything
special. If you only have the raw HCI packets, then you might wanna look
at the hci_vhci kernel module which allows you to write a virtual
Bluetooth adapter. The hciemu program for example is using it to emulate
a HCI device.

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
