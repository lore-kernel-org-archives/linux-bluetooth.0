Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] racing condition in accepting incoming RFCOMM
	connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitri Khokhlov <dkhokhlov@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY8-DAV8lzzOjPtlBB000035dd@hotmail.com>
References: <BAY8-DAV8lzzOjPtlBB000035dd@hotmail.com>
Content-Type: text/plain
Message-Id: <1075947988.2783.119.camel@pegasus>
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
Date: Thu, 05 Feb 2004 03:26:28 +0100

Hi Dmitri,

> It looks like there is a racing condition in accepting incoming RFCOMM
> connection. It happens to me in 90% cases when a headset originates
> connection to a voice gateway. If RFCOMM SAMB command frame comes in L2CAP
> data packet right after L2CAP Configuration Request packet and there is no
> active RFCOMM sessions yet then the kernel RFCOMM thread wakes up only one
> time and creates new session but does not process SAMB frame from second
> L2CAP data packet waiting in queue. Connection setup hangs. Headset is
> waiting for UA frame response but the kernel RFCOMM thread keeps sleeping.
> The kernel log for bad case is attached. I use the following environment:
> Kernel: Linux 2.4.21 + patch-2.4.21-mh6, PowerPC.
> Headsets: Motorola Model 98405H, BlueTrek-G2.
> Voice gateway: Murata BlueModule, CSR BlueCore: BC02 (Hardware ID 8a)
> firmware version 526
> A possible solution could be to force additional thread wakeup right after
> successful creation of new session in rfcomm_accept_connection(). The patch
> is attached.

sounds reasonable to me. Anyone else noticed this behaviour?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
