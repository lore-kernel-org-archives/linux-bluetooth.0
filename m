Return-Path: <kokor.hekkus@gmx.de>
From: Volker Fritzsch <kokor.hekkus@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] pairing on x86_64
Date: Sat, 21 Feb 2004 16:48:16 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402211252.15735.kokor.hekkus@gmx.de> <200402211508.47481.kokor.hekkus@gmx.de> <1077373108.2716.8.camel@pegasus>
In-Reply-To: <1077373108.2716.8.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A33NA2wlrZGsHoc"
Message-Id: <200402211648.16390.kokor.hekkus@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>


--Boundary-00=_A33NA2wlrZGsHoc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

> maybe this one helps.
neither did this :(

so I had a deeper look into it myself.
It seemed, as if the first four chars of buf get blanked after leaving 
g_io_channel_read.

have a look at my syslog below:

Feb 21 16:13:57 dionysos hcid[5088]: ** io_security_event
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[0]: 4
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[1]: 22
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[2]: 6
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[3]: 121
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[4]: -109
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[5]: 50
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[6]: -32
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[7]: 7
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[8]: 0
Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf points to: -1073745232
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[0] = 0
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[1] = 0
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[2] = 0
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[3] = 0
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[4] = -109
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[5] = 50
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[6] = -32
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[7] = 7
Feb 21 16:13:57 dionysos hcid[5088]: security * buf[8] = 0
Feb 21 16:13:57 dionysos hcid[5088]: security * buf points to -1073745232
Feb 21 16:13:57 dionysos hcid[5088]: ** type not HCI_EVENT_PKT

the appended patch does work for me - at least at this point,
because now I get the following from hcidump:

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Max Slots Change(0x1b) plen 3
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Negative Reply(0x01|0x000e) plen 6
> HCI Event: Command Complete(0x0e) plen 10

I'll have a deeper look into that issue later today.

Yours, Volker

--Boundary-00=_A33NA2wlrZGsHoc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch"

--- ../orig/bluez-utils-2.4/hcid/security.c	2003-07-24 19:34:34.000000000 +0200
+++ hcid/security.c	2004-02-21 16:22:01.278360248 +0100
@@ -354,7 +354,8 @@
 
 gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
-	char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
+	char *buf = malloc(sizeof(char) * HCI_MAX_EVENT_SIZE);
+	char *ptr = buf;
 	struct hci_dev_info *di = (void *) data;
 	int len, type, dev;
 	hci_event_hdr *eh;

--Boundary-00=_A33NA2wlrZGsHoc--
