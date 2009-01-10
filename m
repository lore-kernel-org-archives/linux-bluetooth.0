Return-Path: <cyrus@holtmann.org>
Date: Sat, 10 Jan 2009 13:50:01 +0000 (GMT)
To: linux-bluetooth@vger.kernel.org
Subject: "packet types" wrong in libbluetooth
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1231595402.312160.19752.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The HCI packet type functions ptypetostr() and strtoptype() in lib/hci.c
don't work correctly. This is because the HCI spec is messed up wrt the 2
and 3 Mbps packet types, which are indicated by inverted bit logic (see
"Create Connection Command" in core spec document)

I think (you might like to verify that) that the patch below will calm
this hienous situation before anybody needs to call the cops.

regards,
iain

--- lib/hci.c.orig	2009-01-09 20:11:59.000000000 +0000
+++ lib/hci.c	2009-01-09 20:12:02.000000000 +0000
@@ -232,12 +232,18 @@

 char *hci_ptypetostr(unsigned int ptype)
 {
+	ptype ^= (HCI_2DH1|HCI_2DH3|HCI_2DH5|HCI_3DH1|HCI_3DH3|HCI_3DH5);
 	return hci_bit2str(pkt_type_map, ptype);
 }

 int hci_strtoptype(char *str, unsigned int *val)
 {
-	return hci_str2bit(pkt_type_map, str, val);
+
+	if (hci_str2bit(pkt_type_map, str, val) == 0)
+		return 0;
+
+	*val ^= (HCI_2DH1|HCI_2DH3|HCI_2DH5|HCI_3DH1|HCI_3DH3|HCI_3DH5);
+	return 1;
 }

 char *hci_scoptypetostr(unsigned int ptype)
