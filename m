Return-Path: <cyrus@holtmann.org>
Date: Sat, 10 Jan 2009 16:01:36 +0000 (GMT)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: "packet types" wrong in libbluetooth
In-Reply-To: <1231597284.5229.2.camel@californication>
References: <1231595402.312160.19752.nullmailer@galant.ukfsn.org>
 <1231597284.5229.2.camel@californication>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1231603296.653256.942.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 10 Jan 2009, Marcel Holtmann wrote:

> Hi Iain,
>
> > The HCI packet type functions ptypetostr() and strtoptype() in lib/hci.c
> > don't work correctly. This is because the HCI spec is messed up wrt the 2
> > and 3 Mbps packet types, which are indicated by inverted bit logic (see
> > "Create Connection Command" in core spec document)
>
> current situation is perfectly fine. It follows the spec. closely and
> this means for EDR the types are inverted.

since the spec is somewhat twisty I don't see how it follows it at all :)

> Trying to make them looks nice doesn't help. You should not mess with
> packet types at all. It is the link managers' job to get this right.

I am not messing with packet types at all. I apologise because I don't use
Linux or the BlueZ tools in general but it seems that hcidump displays
"Create Connection" packets (at least) incorrectly because of this. For
instance

	hci_ptypetostr(HCI_DH1)

will return

	"DH1 "

which seems normal. But, when this is part of a HCI packet (eg Create
Connection command), that result should actually be:

	"DH1 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5 "

Should it be handled in hcidump instead, as below?

regards,
iain

--- parser/hci.c.orig	2009-01-10 15:51:51.000000000 +0000
+++ parser/hci.c	2009-01-10 15:51:53.000000000 +0000
@@ -718,6 +718,7 @@
 		addr, ptype, cp->role_switch,
 		clkoffset & 0x7fff, clkoffset & 0x8000 ? " (valid)" : "");

+	ptype ^= (HCI_2DH1|HCI_2DH3|HCI_2DH5|HCI_3DH1|HCI_3DH3|HCI_3DH5);
 	str = hci_ptypetostr(ptype);
 	if (str) {
 		p_indent(level, frm);
@@ -746,6 +747,7 @@
 	p_indent(level, frm);
 	printf("handle %d ptype 0x%4.4x\n", btohs(cp->handle), ptype);

+	ptype ^= (HCI_2DH1|HCI_2DH3|HCI_2DH5|HCI_3DH1|HCI_3DH3|HCI_3DH5);
 	str = hci_ptypetostr(ptype);
 	if (str) {
 		p_indent(level, frm);
@@ -2761,6 +2763,7 @@
 		p_indent(level, frm);
 		printf("Error: %s\n", status2str(evt->status));
 	} else {
+		ptype ^= (HCI_2DH1|HCI_2DH3|HCI_2DH5|HCI_3DH1|HCI_3DH3|HCI_3DH5);
 		str = hci_ptypetostr(ptype);
 		if (str) {
 			p_indent(level, frm);
