Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: zze-COLBUS Emmanuel RD-MAPS-GRE <emmanuel.colbus@rd.francetelecom.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1112624867.4782.27.camel@g-xw4200-6.rd.francetelecom.fr>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] /include/net/bluetooth/hci.h : modify ACL_PTYPE_MASK
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
Date: Mon, 04 Apr 2005 16:27:47 +0200

Hello,

I've noticed that ACL_PTYPE_MASK is defined as the binary negation of
SCO_PTYPE_MASK in /include/net/bluetooth/hci.h .

Although this happens to be not wrong currently, because none of the
values (0x0020, 0x0040, 0x0080) used by HV1, HV2 and HV3 have a meaning
for ACL packets, there is AFAIK no norm stating that this won't change
(these values are just marked as "Reserved for future use" in the
Bluetooth Specification version 2.0).

Furthermore, value 0x0001 is marked as "Reserved for future use" for
both ACL and SCO packets. Therefore, by forbidding their use for SCO
packets, and defining the ACL mask as the SCO mask's negation, we are
allowing it's use for ACL packets, which could have unspecified results
on any hardware using a future Bluetooth Specification version.

I suggest the following patch : 


--- old/include/net/bluetooth/hci.h       2005-03-26 04:28:36.000000000
+0100
+++ new/include/net/bluetooth/hci.h      2005-04-04 16:08:24.372117996
+0200
@@ -124,7 +124,8 @@
 #define HCI_HV3                0x0080

 #define SCO_PTYPE_MASK (HCI_HV1 | HCI_HV2 | HCI_HV3)
-#define ACL_PTYPE_MASK (~SCO_PTYPE_MASK)
+#define ACL_PTYPE_MASK (HCI_DM1 | HCI_DM3 | HCI_DM5 \
+		| HCI_DH1 | HCI_DH3 | HCI_DH5)

 /* ACL flags */
 #define ACL_CONT               0x01


Note that this patch has the side effect of blocking any flag that is
not defined in hci.h for ACL packets (like 0x0002 : "2-DH1 may not be
used"), but I assume that using such a flag somewhere would just be a
bug.

Regards,

Emmanuel

--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement telecoms

M. Emmanuel COLBUS intervenant à France Télécoms dans le cadre d'un
stage de fin d'études sous la responsabilité de M. Tahar Jarboui.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
