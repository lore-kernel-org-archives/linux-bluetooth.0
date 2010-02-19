Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Patches for OpenObex
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1266581433.678.6028.camel@localhost.localdomain>
References: <1266581433.678.6028.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-Pq5n5Y3CyGDawqxfv/zy"
Date: Fri, 19 Feb 2010 13:49:41 +0000
Message-ID: <1266587381.678.6231.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Pq5n5Y3CyGDawqxfv/zy
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Fri, 2010-02-19 at 12:10 +0000, Bastien Nocera wrote:
> Heya,
> 
> 2 small patches for openobex.
> 
> The first patch fixes libusb1 compilation on my machine.
> 
> For the second patch, when libusb1 is used, we can set self->fd to be a
> monitoring file descriptor for incoming data.
> 
> With that patch, I could make osso-gwobex work with USB connections.
> 
> There's still some bugs to take care of, but I believe this patch to be
> correct. Are there any places in openobex where the self->fd will be
> directly when connected via USB? If so, those would need to be fixed as
> well.

Another patch to fix an invalid memory access when obex_transport_read()
has to resize its buffer.



--=-Pq5n5Y3CyGDawqxfv/zy
Content-Disposition: attachment; filename="0001-Fix-invalid-memory-access.patch"
Content-Type: text/x-patch; name="0001-Fix-invalid-memory-access.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From a3e0a7c2ed10ffab279ad3cab0c3139e651e35b7 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 19 Feb 2010 13:40:27 +0000
Subject: [PATCH] Fix invalid memory access

The hdr pointer will not be valid any more if the transport
read() does a realloc, so cache the opcode that we'll use
later in the code.

Fixes the following valgrind error:
==31644== Thread 2:
==31644== Invalid read of size 1
==31644==    at 0x4E3D787: obex_data_indication (obex_main.c:307)
==31644==    by 0x4E3F403: obex_transport_handle_input (obex_transport.c:72)
==31644==    by 0x4E3C67E: OBEX_HandleInput (obex.c:449)
==31644==    by 0x4C335BD: gw_obex_request_sync (obex-priv.c:108)
==31644==    by 0x4C34114: gw_obex_get (obex-priv.c:939)
==31644==    by 0x4C319EE: gw_obex_read_dir (gw-obex.c:198)
==31644==    by 0x408222: _retrieve_folder_listing (gvfsbackendobexftp.c:552)
==31644==    by 0x408DD1: do_enumerate (gvfsbackendobexftp.c:1549)
==31644==    by 0x411491: g_vfs_job_run (gvfsjob.c:198)
==31644==    by 0x3C758658CA: ??? (in /lib64/libglib-2.0.so.0.2303.0)
==31644==    by 0x3C75863A03: ??? (in /lib64/libglib-2.0.so.0.2303.0)
==31644==    by 0x3C74806CA9: start_thread (in /lib64/libpthread-2.11.90.so)
==31644==  Address 0x5313f50 is 0 bytes inside a block of size 71,679 free'd
==31644==    at 0x4A05255: realloc (vg_replace_malloc.c:476)
==31644==    by 0x4E41D12: buf_resize (databuffer.c:147)
==31644==    by 0x4E42063: buf_reserve_end (databuffer.c:217)
==31644==    by 0x4E3FE90: obex_transport_read (obex_transport.c:519)
==31644==    by 0x4E3D711: obex_data_indication (obex_main.c:268)
==31644==    by 0x4E3F403: obex_transport_handle_input (obex_transport.c:72)
==31644==    by 0x4E3C67E: OBEX_HandleInput (obex.c:449)
==31644==    by 0x4C335BD: gw_obex_request_sync (obex-priv.c:108)
==31644==    by 0x4C34114: gw_obex_get (obex-priv.c:939)
==31644==    by 0x4C319EE: gw_obex_read_dir (gw-obex.c:198)
==31644==    by 0x408222: _retrieve_folder_listing (gvfsbackendobexftp.c:552)
==31644==    by 0x408DD1: do_enumerate (gvfsbackendobexftp.c:1549)
==31644==
---
 lib/obex_main.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/obex_main.c b/lib/obex_main.c
index 9fb65d7..435f1a9 100644
--- a/lib/obex_main.c
+++ b/lib/obex_main.c
@@ -234,6 +234,7 @@ int obex_data_indication(obex_t *self, uint8_t *buf, int buflen)
 	int actual = 0;
 	unsigned int size;
 	int ret;
+	int opcode;
 	
 	DEBUG(4, "\n");
 
@@ -262,6 +263,9 @@ int obex_data_indication(obex_t *self, uint8_t *buf, int buflen)
 		hdr = (obex_common_hdr_t *) msg->data;
 		size = ntohs(hdr->len);
 
+		/* As hdr might not be valid anymore if the _read() does a realloc */
+		opcode = hdr->opcode;
+
 		actual = 0;
 		if(msg->data_size < (int) ntohs(hdr->len)) {
 
@@ -304,7 +308,7 @@ int obex_data_indication(obex_t *self, uint8_t *buf, int buflen)
 	DUMPBUFFER(2, "Rx", msg);
 
 	actual = msg->data_size;
-	final = hdr->opcode & OBEX_FINAL; /* Extract final bit */
+	final = opcode & OBEX_FINAL; /* Extract final bit */
 
 	/* Dispatch to the mode we are in */
 	if(self->state & MODE_SRV) {
-- 
1.6.6.1


--=-Pq5n5Y3CyGDawqxfv/zy--

