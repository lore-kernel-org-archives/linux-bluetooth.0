Return-Path: <kokor.hekkus@gmx.de>
From: Volker Fritzsch <kokor.hekkus@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] pairing on x86_64
Date: Sat, 21 Feb 2004 21:00:12 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402211252.15735.kokor.hekkus@gmx.de> <200402211648.16390.kokor.hekkus@gmx.de> <1077379873.2716.18.camel@pegasus>
In-Reply-To: <1077379873.2716.18.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Mj7NAitfRYR8VaK"
Message-Id: <200402212100.12603.kokor.hekkus@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>


--Boundary-00=_Mj7NAitfRYR8VaK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel.

> what is the sizeof(unsigned char) and sizeof(char) on x86_64?
printf says 1 (for both).

> > Feb 21 16:13:57 dionysos hcid[5088]: ** io_security_event
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[0]: 4
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[1]: 22
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[2]: 6
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[3]: 121
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[4]: -109
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[5]: 50
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[6]: -32
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[7]: 7
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[8]: 0
> > Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf points to:
> > -1073745232 Feb 21 16:13:57 dionysos hcid[5088]: security * buf[0] = 0
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[1] = 0
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[2] = 0
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[3] = 0
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[4] = -109
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[5] = 50
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[6] = -32
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[7] = 7
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf[8] = 0
> > Feb 21 16:13:57 dionysos hcid[5088]: security * buf points to -1073745232
> > Feb 21 16:13:57 dionysos hcid[5088]: ** type not HCI_EVENT_PKT
>
> I don't know why this happens.
I couldn't understand too, but with your sizeof(char) question you made me 
curious.

On x86_64, int has a size of 4 and size_t takes 8 (while on x86 both have a 
size of 4).
By passing &len to g_io_channel_read (which takes a size_t *buffer_read as 
argument), we blank out the first four bytes of buf - which sits directly 
after len in memory ('oh wonderful world...').

> This can be a problem that the call of the PIN helper program fails.
This problem is also solved with the change from int len to size_t len.

So, please trash my first patch and take this instead.

Regards
 Volker

--Boundary-00=_Mj7NAitfRYR8VaK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch"

--- ../orig/bluez-utils-2.4/hcid/security.c	2003-07-24 19:34:34.000000000 +0200
+++ hcid/security.c	2004-02-21 20:47:35.000000000 +0100
@@ -356,7 +356,8 @@
 {
 	char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
 	struct hci_dev_info *di = (void *) data;
-	int len, type, dev;
+	int type, dev;
+	size_t len;
 	hci_event_hdr *eh;
 	GIOError err;
 

--Boundary-00=_Mj7NAitfRYR8VaK--
