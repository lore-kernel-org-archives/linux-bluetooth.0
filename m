Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems with sdp_connect()
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051005070755.21011.qmail@community29.interfree.it>
References: <20051005070755.21011.qmail@community29.interfree.it>
Content-Type: text/plain
Message-Id: <1128511489.5102.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 05 Oct 2005 13:24:49 +0200

Hi,

> I am writing my thesis on Bluetooth programming under Linux and I would be grateful to you if you could give me hints to solve this problem. I have two bt devices on my laptop, both of them run the same program and register the same SDP service. When I register the service I call sdp_connect(&src, BDADDR_LOCAL, RETRY_IF_BUSY). It works but when I try to search the service from a device outside my laptop I discover the same service twice for each device. Resuming:
> - Bluetooth device A register a service C on my laptop --- sdp_connect(&srcA, BDADDR_LOCAL, ...) 
> - Bluetooth device B register a service C on my laptop --- sdp_connect(&srcB, BDADDR_LOCAL, ...)
> - Searching service C on device A will find it twice instead of once
> 
> I thought the problem was in BDADDR_LOCAL, which is defined as {0, 0, 0, 0xff, 0xff, 0xff} but if I try to register the service connecting with SDP server as sdp_connect(&srcA, &srcA, ...) it returns error "Host is down". I don't know where to hurt my head...

use the latest bluez-libs package and then you can register per device
services. Look at sdp_device_* functions or use the -i switch of
sdptool.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
