Return-Path: <wolfgang.walter@studentenwerk.mhn.de>
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
To: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: patch: problem with sco
Date: Thu, 12 Jan 2006 01:38:31 +0100
Cc: marcel@holtmann.org, maxk@qualcomm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
List-ID: <bluez-devel.lists.sourceforge.net>

A friend and I encountered a problem with sco transfers to a headset using
linux (vanilla 2.6.15). While all sco packets sent by the headset were
received there was no outgoing traffic.

After switching debugging output on we found that actually sco_cnt was always
zero in hci_sched_sco.

hciconfig hci0 shows sco_mtu to be 64:0. Changing that to 64:8 did not help.

This was because in hci_cc_info_param hdev->sco_pkts is set to zero. When we
changed this line so that hdev->sco_pkts is set to 8 if bs->sco_max_pkt is 0
sco transfer to the headset started to work just fine.


Here the patch:

--- linux-2.6.15/net/bluetooth/hci_event.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-dbg/net/bluetooth/hci_event.c	2006-01-12 00:35:48.000000000 +0100
@@ -322,7 +322,7 @@
 		hdev->acl_mtu  = __le16_to_cpu(bs->acl_mtu);
 		hdev->sco_mtu  = bs->sco_mtu ? bs->sco_mtu : 64;
 		hdev->acl_pkts = hdev->acl_cnt = __le16_to_cpu(bs->acl_max_pkt);
-		hdev->sco_pkts = hdev->sco_cnt = __le16_to_cpu(bs->sco_max_pkt);
+		hdev->sco_pkts = hdev->sco_cnt = (bs->sco_max_pkt ? __le16_to_cpu(bs->sco_max_pkt) : 8);
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);


-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
Leiter EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196-276
Fax: +49 89 38196-144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
