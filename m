Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0608211349380.27134-200000@bugs.comnets.uni-bremen.de>
References: <Pine.LNX.4.21.0608211349380.27134-200000@bugs.comnets.uni-bremen.de>
Date: Wed, 23 Aug 2006 19:35:54 +0200
Message-Id: <1156354555.4133.42.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Markus Becker <mab@comnets.uni-bremen.de>
Subject: Re: [Bluez-devel] [PATCH] bluez-libs UUID-128 support for
	Protocol	Descriptor List
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

Hi Markus,

> I've created a patch for bluez-libs/src/sdp.c to support the finding of
> UUID128 encoded protocols. So that also kdebluetooth and others can
> recognize those protocols. It changes the display of the Protocol
> Descriptor List for example from:
> 
> Service Name: ATEmulator
> Service RecHandle: 0x10010
> Service Class ID List:
>   "Error: This is UUID-128" (0x7dd6b763-99a9-4a92-87b5-bc8efe565c37)
>   "Error: This is UUID-128" (0x00001101-0000-1000-8000-00805f9b34fb)
> Protocol Descriptor List:
>   "Error: " (0x00000100-0000-1000-8000-00805f9b34fb)
>   "Error: " (0x00000003-0000-1000-8000-00805f9b34fb)
>     Channel: 25
> 
> to:
> 
> Service Name: ATEmulator
> Service RecHandle: 0x10010
> Service Class ID List:
>   UUID 128: 7dd6b763-99a9-4a92-87b5-bc8efe565c37
>   UUID 128: 00001101-0000-1000-8000-00805f9b34fb
> Protocol Descriptor List:
>   "L2CAP" (0x00000100-0000-1000-8000-00805f9b34fb)
>   "RFCOMM" (0x00000003-0000-1000-8000-00805f9b34fb)
>     Channel: 25
> 
> Please consider it for integration into mainline bluez-libs.

the patch is wrong. Before you are doing a lookup against the short
UUIDs of Bluetooth you should check if the base UUID is the Bluetooth
base UUID. Otherwise you can't do the lookup.

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
