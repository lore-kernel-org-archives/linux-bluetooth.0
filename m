Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
From: Marcel Holtmann <marcel@holtmann.org>
To: Guy Harris <guy@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
In-Reply-To: <D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu>
References: <1067379074.2419.24.camel@paul>
	<1067425631.24043.224.camel@pegasus>
	<D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu>
Content-Type: multipart/mixed; boundary="=-bk9cwHqSTkcauorYBhlF"
Message-Id: <1067482224.18114.6.camel@pegasus>
Mime-Version: 1.0
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
Date: 30 Oct 2003 03:50:17 +0100


--=-bk9cwHqSTkcauorYBhlF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Guy,

> >> 2. Make ethereal read capture files made with hcidump -w.
> >
> > This should be the way to go, because live capturing is not always what
> > you want.
> 
> Yes, but that doesn't *exclude* support for libpcap-based live 
> capturing; a Wiretap module to read "hcidump -w" files would be useful, 
> but if that's added you might still want support for libpcap-based 
> capturing.

here is my patch that adds a Wiretap module for reading files created
with "hcidump -w".

Regards

Marcel


--=-bk9cwHqSTkcauorYBhlF
Content-Disposition: attachment; filename=patch-ethereal-hcidump
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-ethereal-hcidump; charset=ISO-8859-15

diff -urN ethereal/wiretap/AUTHORS ethereal-mh/wiretap/AUTHORS
--- ethereal/wiretap/AUTHORS	Tue Aug 26 09:10:38 2003
+++ ethereal-mh/wiretap/AUTHORS	Thu Oct 30 03:46:02 2003
@@ -18,5 +18,6 @@
 Mark C. Brown		<mbrown[AT]nosila.net>
 Martin Warnes		<martin.warnes[AT]ntlworld.com>
 Thierry Martin		<thierry.martin[AT]accellent-group.com>
-Jesper Peterson		<jesper [AT] endace.com>
+Jesper Peterson		<jesper[AT]endace.com>
+Marcel Holtmann		<marcel[AT]holtmann.org>
=20
diff -urN ethereal/wiretap/Makefile.am ethereal-mh/wiretap/Makefile.am
--- ethereal/wiretap/Makefile.am	Tue Aug 26 09:10:38 2003
+++ ethereal-mh/wiretap/Makefile.am	Thu Oct 30 03:38:06 2003
@@ -54,6 +54,8 @@
 	file_access.c		\
 	file_wrappers.c		\
 	file_wrappers.h		\
+	hcidump.c		\
+	hcidump.h		\
 	i4btrace.c		\
 	i4btrace.h		\
 	i4b_trace.h		\
diff -urN ethereal/wiretap/file_access.c ethereal-mh/wiretap/file_access.c
--- ethereal/wiretap/file_access.c	Tue Oct 21 10:03:13 2003
+++ ethereal-mh/wiretap/file_access.c	Thu Oct 30 03:38:25 2003
@@ -70,6 +70,7 @@
 #include "cosine.h"
 #include "5views.h"
 #include "erf.h"
+#include "hcidump.h"
=20
 /* The open_file_* routines should return:
  *
@@ -120,6 +121,7 @@
 	dbs_etherwatch_open,
 	cosine_open,
 	erf_open,
+	hcidump_open,
 };
=20
 #define	N_FILE_TYPES	(sizeof open_routines / sizeof open_routines[0])
@@ -434,6 +436,10 @@
=20
 	/* WTAP_FILE_ERF */
 	{ "Endace DAG capture", "erf",
+	  NULL, NULL },
+
+	/* WTAP_FILE_HCIDUMP */
+	{ "Bluetooth HCI dump", "hcidump",
 	  NULL, NULL },
 };
=20
diff -urN ethereal/wiretap/hcidump.c ethereal-mh/wiretap/hcidump.c
--- ethereal/wiretap/hcidump.c	Thu Jan  1 01:00:00 1970
+++ ethereal-mh/wiretap/hcidump.c	Thu Oct 30 03:38:12 2003
@@ -0,0 +1,175 @@
+/* hcidump.c
+ *
+ * $Id: hcidump.c,v 1.24 2002/08/28 20:30:45 holtmann Exp $
+ *
+ * Copyright (c) 2003 by Marcel Holtmann <marcel@holtmann.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, =
USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "wtap-int.h"
+#include "file_wrappers.h"
+#include "buffer.h"
+#include "hcidump.h"
+
+#include <endian.h>
+#include <byteswap.h>
+
+/* Byte order conversions */
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+#define htobs(d)  (d)
+#define htobl(d)  (d)
+#define btohs(d)  (d)
+#define btohl(d)  (d)
+#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
+#define htobs(d)  bswap_16(d)
+#define htobl(d)  bswap_32(d)
+#define btohs(d)  bswap_16(d)
+#define btohl(d)  bswap_32(d)
+#else
+#error "Unknown byte order"
+#endif
+
+struct dump_hdr {
+	guint16 len;
+	guint8  in;
+	guint8  pad;
+	guint32 ts_sec;
+	guint32 ts_usec;
+} __attribute__ ((packed));
+
+#define DUMP_HDR_SIZE (sizeof(struct dump_hdr))
+
+static gboolean hcidump_read(wtap *wth, int *err, long *data_offset)
+{
+	struct dump_hdr dh;
+	guint8 *buf;
+	int bytes_read, packet_size;
+
+	*data_offset =3D wth->data_offset;
+
+	bytes_read =3D file_read(&dh, 1, DUMP_HDR_SIZE, wth->fh);
+	if (bytes_read !=3D DUMP_HDR_SIZE) {
+		*err =3D file_error(wth->fh);
+		if (*err =3D=3D 0 && bytes_read !=3D 0)
+			*err =3D WTAP_ERR_SHORT_READ;
+		return FALSE;
+	}
+	wth->data_offset +=3D DUMP_HDR_SIZE;
+
+	packet_size =3D btohs(dh.len);
+	if (packet_size > WTAP_MAX_PACKET_SIZE) {
+		/*
+		 * Probably a corrupt capture file; don't blow up trying
+		 * to allocate space for an immensely-large packet.
+		 */
+		g_message("hcidump: File has %u-byte packet, bigger than maximum of %u",
+			packet_size, WTAP_MAX_PACKET_SIZE);
+		*err =3D WTAP_ERR_BAD_RECORD;
+		return FALSE;
+	}
+
+	buffer_assure_space(wth->frame_buffer, packet_size);
+	buf =3D buffer_start_ptr(wth->frame_buffer);
+
+	bytes_read =3D file_read(buf, 1, packet_size, wth->fh);
+	if (bytes_read !=3D packet_size) {
+		*err =3D file_error(wth->fh);
+		if (*err =3D=3D 0)
+			*err =3D WTAP_ERR_SHORT_READ;
+		return FALSE;
+	}
+	wth->data_offset +=3D packet_size;
+
+	wth->phdr.ts.tv_sec =3D btohl(dh.ts_sec);
+	wth->phdr.ts.tv_usec =3D btohl(dh.ts_usec);
+	wth->phdr.caplen =3D packet_size;
+	wth->phdr.len =3D packet_size;
+	wth->phdr.pkt_encap =3D WTAP_ENCAP_BLUETOOTH_H4;
+
+	wth->pseudo_header.p2p.sent =3D (dh.in ? FALSE : TRUE);
+
+	return TRUE;
+}
+
+static gboolean hcidump_seek_read(wtap *wth, long seek_off, union wtap_pse=
udo_header *pseudo_header, guint8 *pd, int length, int *err)
+{
+	struct dump_hdr dh;
+	int bytes_read;
+
+	if (file_seek(wth->random_fh, seek_off, SEEK_SET, err) =3D=3D -1)
+		return FALSE;
+
+	bytes_read =3D file_read(&dh, 1, DUMP_HDR_SIZE, wth->random_fh);
+	if (bytes_read !=3D DUMP_HDR_SIZE) {
+		*err =3D file_error(wth->random_fh);
+		if (*err =3D=3D 0 && bytes_read !=3D 0)
+			*err =3D WTAP_ERR_SHORT_READ;
+		return FALSE;
+	}
+
+	bytes_read =3D file_read(pd, 1, length, wth->random_fh);
+	if (bytes_read !=3D length) {
+		*err =3D file_error(wth->random_fh);
+		if (*err =3D=3D 0)
+			*err =3D WTAP_ERR_SHORT_READ;
+		return FALSE;
+	}
+
+	pseudo_header->p2p.sent =3D (dh.in ? FALSE : TRUE);
+
+	return TRUE;
+}
+
+int hcidump_open(wtap *wth, int *err)
+{
+	struct dump_hdr dh;
+	guint8 type;
+	int bytes_read;
+
+	bytes_read =3D file_read(&dh, 1, DUMP_HDR_SIZE, wth->fh);
+	if (bytes_read !=3D DUMP_HDR_SIZE) {
+		*err =3D file_error(wth->fh);
+		return (*err !=3D 0) ? -1 : 0;
+	}
+
+	if (dh.in !=3D 0 && dh.in !=3D 1 && dh.pad !=3D 0 && btohs(dh.len) < 1)
+		return 0;
+
+	bytes_read =3D file_read(&type, 1, 1, wth->fh);
+	if (bytes_read !=3D 1) {
+		*err =3D file_error(wth->fh);
+		return (*err !=3D 0) ? -1 : 0;
+	}
+
+	if (type < 1 || type > 4)
+		return 0;
+
+	if (file_seek(wth->fh, 0, SEEK_SET, err) =3D=3D -1)
+		return -1;
+
+	wth->file_type =3D WTAP_FILE_HCIDUMP;
+	wth->file_encap =3D WTAP_ENCAP_BLUETOOTH_H4;
+	wth->snapshot_length =3D 0;
+
+	wth->subtype_read =3D hcidump_read;
+	wth->subtype_seek_read =3D hcidump_seek_read;
+
+	return 1;
+}
diff -urN ethereal/wiretap/hcidump.h ethereal-mh/wiretap/hcidump.h
--- ethereal/wiretap/hcidump.h	Thu Jan  1 01:00:00 1970
+++ ethereal-mh/wiretap/hcidump.h	Thu Oct 30 03:38:12 2003
@@ -0,0 +1,28 @@
+/* hcidump.h
+ *
+ * $Id: hcidump.h,v 1.3 2002/08/28 20:30:45 holtmann Exp $
+ *
+ * Copyright (c) 2003 by Marcel Holtmann <marcel@holtmann.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, =
USA.
+ *
+ */
+
+#ifndef __HCIDUMP_H__
+#define __HCIDUMP_H__
+
+int hcidump_open(wtap *wth, int *err);
+
+#endif
diff -urN ethereal/wiretap/wtap.h ethereal-mh/wiretap/wtap.h
--- ethereal/wiretap/wtap.h	Wed Oct 29 22:44:11 2003
+++ ethereal-mh/wiretap/wtap.h	Thu Oct 30 03:38:19 2003
@@ -129,9 +129,10 @@
 #define WTAP_ENCAP_ENC				37
 #define WTAP_ENCAP_PFLOG			38
 #define WTAP_ENCAP_CHDLC_WITH_PHDR		39
+#define WTAP_ENCAP_BLUETOOTH_H4			40
=20
 /* last WTAP_ENCAP_ value + 1 */
-#define WTAP_NUM_ENCAP_TYPES			40
+#define WTAP_NUM_ENCAP_TYPES			41
=20
 /* File types that can be read by wiretap.
    We support writing some many of these file types, too, so we
@@ -172,9 +173,10 @@
 #define WTAP_FILE_COSINE			33
 #define WTAP_FILE_5VIEWS			34
 #define WTAP_FILE_ERF				35
+#define WTAP_FILE_HCIDUMP			36
=20
 /* last WTAP_FILE_ value + 1 */
-#define WTAP_NUM_FILE_TYPES			36
+#define WTAP_NUM_FILE_TYPES			37
=20
 /*
  * Maximum packet size we'll support.
@@ -350,7 +352,7 @@
 struct cosine_phdr {
 	guint8 encap;		/* COSINE_ENCAP_* as defined above */
 	guint8 direction;	/* COSINE_DIR_*, as defined above */
-        char if_name[COSINE_MAX_IF_NAME_LEN];  /* Encap & Logical I/F name=
 */
+	char if_name[COSINE_MAX_IF_NAME_LEN];  /* Encap & Logical I/F name */
 	guint16 pro;		/* Protocol */
 	guint16 off;		/* Offset */
 	guint16 pri;		/* Priority */

--=-bk9cwHqSTkcauorYBhlF--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
