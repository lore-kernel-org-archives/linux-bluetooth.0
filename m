Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "christian.gohmann@dsa-ac.de" <cg@dsa-ac.de>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <Pine.LNX.4.33.0310101545410.11639-100000@testcg.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] Stability problems with USB BT modules based on CSR chipset
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Oct 2003 16:25:41 +0200 (CEST)

Hello,

I am running a COM1 USB bluetooth module (and also tried other devices
based on the CSR chipset) and I am using kernel 2.4.19 with
patch-2.4.19-mh12.

When I do the following test:

  while :; do hciconfig hci0 name ; done

I recognize after a while (1-2 minutes), that the USB module will not
respond to USB requests anymore. I cross-checked that with an USB
bus analyzer. It is also possible to check it with hcidump, but I wanted
to get shure that there is no response from the physical layer.

When I do a

  hciconfig hci0 reset

I am able to get the USB module alive again (in most cases). Sometimes
the USB module will crash completely and you must unplug it.

It is also interesting, that a

  while :; do hciconfig hci0 class ; done

runs quite stable.

I think, that a local name request (which returns 252 bytes split into
several USB return packets) is confusing the module's firmware. Short
return packets (as with the class request) seem to be OK.

My questions are:
1. Has someone experienced similar hardware problems?
2. Are there any timing restrictions on the HCI layer (maybe the frequency
of HCI requests is too high and my test is not allowed) ?

Thank you in advance,
Christian Gohmann



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
