Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "franz keuner" <franz_keuner@gmx.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <16619.1079606404@www34.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-devel] Service Record Problem
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
Date: Thu, 18 Mar 2004 11:40:04 +0100 (MET)

hello,

thanks for your help with my last problem.

now i have a problem with service registration. i register a service using
the Java Bluetooth APIs. it creates a service record with an uuid of length
128. that seems to be predetermined.

if i search for services on the device i can't find that specific service.
but if i scan for SP services i receive the following message:
  ...
  Service Name: Service Name
Service RecHandle: 0x1000a
Service Class ID List:
  "Error: This is uuid128" (0xabcd0000-1000-8000-0080-5f9b34fb0000)
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Serial Port" (0x1101)
..

if i use a pda (pocket pc) with bluetooth support and search for services i
find the service without a problem.

so my question is: what can i do to find that service using bluez and the
"normal" sdptool search browse command?

thanks in advance and regards,

franz

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
