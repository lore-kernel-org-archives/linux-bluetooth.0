Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Writing a bluetooth mouse driver...
From: Marcel Holtmann <marcel@holtmann.org>
To: Keith Pemberton <kbpember@cox.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1079350703.4317.7.camel@linuxcomp.gatep5.net>
References: <1079350703.4317.7.camel@linuxcomp.gatep5.net>
Content-Type: text/plain
Message-Id: <1079352208.3405.26.camel@pegasus>
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
Date: Mon, 15 Mar 2004 13:03:28 +0100

Hi Keith,

> I'm going to write a bluetooth mouse driver for my MS bluetooth mouse
> just to see if I can do it. (yes, I do know that there is one out there
> already, but I don't like the way that that driver is doing things).  My
> hang up in understanding is in the communication between the mouse and
> the wireless transceiver.  I am guessing that the functions providing
> communication to the transceiver are defined in hci.c (or hci.h).  Does
> anyone have a good document that describes how the Bluez stack
> communicates with different hardware?  Any other documents that you can
> suggest would be much appreciated!  Thanks in advance.  

actually you must understand how the Bluetooth stack is designed and how
the HID profile makes use of it. You will notice that HID uses two L2CAP
connections, one for control message and the other one for interrupt
messages. The transport protocol is HIDP and than you need of course a
HID parser, which is the biggest part.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
