Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Keith Pemberton <kbpember@cox.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1079350703.4317.7.camel@linuxcomp.gatep5.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Writing a bluetooth mouse driver...
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
Date: Mon, 15 Mar 2004 05:38:23 -0600

I'm going to write a bluetooth mouse driver for my MS bluetooth mouse
just to see if I can do it. (yes, I do know that there is one out there
already, but I don't like the way that that driver is doing things).  My
hang up in understanding is in the communication between the mouse and
the wireless transceiver.  I am guessing that the functions providing
communication to the transceiver are defined in hci.c (or hci.h).  Does
anyone have a good document that describes how the Bluez stack
communicates with different hardware?  Any other documents that you can
suggest would be much appreciated!  Thanks in advance.  

Keith



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
