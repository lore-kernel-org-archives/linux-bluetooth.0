Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
From: Marcel Holtmann <marcel@holtmann.org>
To: Guy Harris <guy@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
In-Reply-To: <FBDCA88C-0A86-11D8-B1BA-000A958097E4@alum.mit.edu>
References: <1067379074.2419.24.camel@paul>
	<1067425631.24043.224.camel@pegasus>
	<D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu>
	<1067482224.18114.6.camel@pegasus>
	<FBDCA88C-0A86-11D8-B1BA-000A958097E4@alum.mit.edu>
Content-Type: multipart/mixed; boundary="=-MmyAHinsMnRHLFVstB0A"
Message-Id: <1067513580.18114.20.camel@pegasus>
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
Date: 30 Oct 2003 12:39:46 +0100


--=-MmyAHinsMnRHLFVstB0A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Guy,

> > here is my patch that adds a Wiretap module for reading files created
> > with "hcidump -w".
> 
> Checked in, with wiretap/Makefile.nmake updated to build it, with the 
> __attribute((packed))__ stuff removed (not all compilers used to build 
> Wiretap support it, and there are no fields in there that would require 
> padding), and with the byte swapping done with "g_ntohs()" and 
> "g_ntohl()" so it doesn't have to include headers not found on all 
> platforms.

sorry for the nmake stuff, but I always forget them :(

Attached is another patch against CVS, which re-introduces the byte
swapping, because the ntohs/ntohl are not working in this case. I used
the GLIB macros and so it should be portable now. I also use the macro
_U_ for __attribute((packed))__ and this should be portable, too.

Regards

Marcel


--=-MmyAHinsMnRHLFVstB0A
Content-Disposition: attachment; filename=patch-ethereal-hcidump-2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-ethereal-hcidump-2; charset=ISO-8859-15

diff -urN ethereal/wiretap/hcidump.c ethereal-mh/wiretap/hcidump.c
--- ethereal/wiretap/hcidump.c	Thu Oct 30 04:11:02 2003
+++ ethereal-mh/wiretap/hcidump.c	Thu Oct 30 12:16:17 2003
@@ -28,13 +28,27 @@
 #include "buffer.h"
 #include "hcidump.h"
=20
+#if G_BYTE_ORDER =3D=3D G_LITTLE_ENDIAN
+#define htobs(val)  (val)
+#define htobl(val)  (val)
+#define btohs(val)  (val)
+#define btohl(val)  (val)
+#elif G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
+#define htobs(val)  GUINT16_SWAP_LE_BE(val)
+#define htobl(val)  GUINT32_SWAP_LE_BE(val)
+#define btohs(val)  GUINT16_SWAP_LE_BE(val)
+#define btohl(val)  GUINT32_SWAP_LE_BE(val)
+#else
+#error unknown ENDIAN type
+#endif
+
 struct dump_hdr {
 	guint16 len;
 	guint8  in;
 	guint8  pad;
 	guint32 ts_sec;
 	guint32 ts_usec;
-};
+} _U_;
=20
 #define DUMP_HDR_SIZE (sizeof(struct dump_hdr))
=20
@@ -55,7 +69,7 @@
 	}
 	wth->data_offset +=3D DUMP_HDR_SIZE;
=20
-	packet_size =3D g_ntohs(dh.len);
+	packet_size =3D btohs(dh.len);
 	if (packet_size > WTAP_MAX_PACKET_SIZE) {
 		/*
 		 * Probably a corrupt capture file; don't blow up trying
@@ -79,8 +93,8 @@
 	}
 	wth->data_offset +=3D packet_size;
=20
-	wth->phdr.ts.tv_sec =3D g_ntohl(dh.ts_sec);
-	wth->phdr.ts.tv_usec =3D g_ntohl(dh.ts_usec);
+	wth->phdr.ts.tv_sec =3D btohl(dh.ts_sec);
+	wth->phdr.ts.tv_usec =3D btohl(dh.ts_usec);
 	wth->phdr.caplen =3D packet_size;
 	wth->phdr.len =3D packet_size;
 	wth->phdr.pkt_encap =3D WTAP_ENCAP_BLUETOOTH_H4;
@@ -131,7 +145,7 @@
 		return (*err !=3D 0) ? -1 : 0;
 	}
=20
-	if (dh.in !=3D 0 && dh.in !=3D 1 && dh.pad !=3D 0 && g_ntohs(dh.len) < 1)
+	if (dh.in !=3D 0 && dh.in !=3D 1 && dh.pad !=3D 0 && btohs(dh.len) < 1)
 		return 0;
=20
 	bytes_read =3D file_read(&type, 1, 1, wth->fh);

--=-MmyAHinsMnRHLFVstB0A--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
