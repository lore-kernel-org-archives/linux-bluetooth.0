Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] bluetooth services and profiles
From: Marcel Holtmann <marcel@holtmann.org>
To: Jun Sun <jsun@docomolabs-usa.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7FB17951357F434FA9C14522522BA59B447F63@dcl-ex.dcml.docomolabs-usa.com>
References: 
	 <7FB17951357F434FA9C14522522BA59B447F63@dcl-ex.dcml.docomolabs-usa.com>
Content-Type: text/plain
Message-Id: <1098830304.6611.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 27 Oct 2004 00:38:23 +0200

Hi Jun,

> Thanks for the explanation on profiles.  It helps quite a bit.
> 
> Do you know how we can supply those phone services with bluez?
> 
> For example, the web page http://mobile.linux.pt/p800/ listed the
> following services for P800:
> 
> earth:~# sdptool browse 00:0A:D9:17:7F:51
> Browsing 00:0A:D9:17:7F:51 ...
> Service Name: Voice gateway
> Service Description: Voice gateway
> Service Provider: Sony Ericsson
> Service RecHandle: 0x10000
> Service Class ID List:
>   "Headset Audio Gateway" (0x1112)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 8
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Headset" (0x1108)
>     Version: 0x0100
> 
> Service Name: Dial-up Networking
> Service Description: Dial-up Networking
> Service Provider: Sony Ericsson
> Service RecHandle: 0x10002
> Service Class ID List:
>   "Dialup Networking" (0x1103)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 2
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Dialup Networking" (0x1103)
>     Version: 0x0100
> 
> Service Name: OBEX Object Push
> Service RecHandle: 0x10003
> Service Class ID List:
>   "OBEX Object Push" (0x1105)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 3
>   "OBEX" (0x0008)
> Profile Descriptor List:
>   "OBEX Object Push" (0x1105)
>     Version: 0x0100
> 
> Service Name: Bluetooth Serial Port
> Service Description: Bluetooth Serial Port
> Service Provider: Symbian Ltd.
> Service RecHandle: 0x10005
> Service Class ID List:
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> 
> 
> Which part of bluetooth spec covers such service discovery?  Can I
> implement similar services on top of bluez stack?  (Imagine the scenario
> if I put Linux/bluez into a phone ...)

this services are all RFCOMM based and so you need to write a RFCOMM
server application for each of them. It must listen on the specific
channel and register an SDP record. And from that point it is only
socket programming. It think the pand source code is the easiest to
understand how this works.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
