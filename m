Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Patch for bluez-hcidump-1.5
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Maksim Yevmenkin <Maksim.Yevmenkin@cw.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<45258A4365C6B24A9832BFE224837D552B126E@sjdcex01.int.exodus.net>
References: <45258A4365C6B24A9832BFE224837D552B126E@sjdcex01.int.exodus.net>
Message-Id: <1039276889.852.29.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 07 Dec 2002 17:01:22 +0100
Content-Type: multipart/mixed; boundary="=-GGB9Rtn7egFg+mFwlNKp"


--=-GGB9Rtn7egFg+mFwlNKp
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Maksim,

> please find attached patch for the bluez-hcidump-1.5 package.
> here is the quick summary of the changes
> 
> 1) __uXXX types replaced with uXXX_t 
> 2) minor fix for l2cap parser
> 3) minor fix for hcidump.1 man page
> 4) get_unaligned stuff fix
> 
> Note: after applying the patch you still need to move
> hcidump.8 to hcidump.1
> 
> i also re-arranged #include lines .c files and removed #include
> lines from the headers. this way it much easier to port, because
> it is clear which headers are used and what needs to be ported.
> i would appreciate if any new code in BlueZ will follow this
> simple rules. 
> 
> please review and if there are no objections commit.

please don't put all your changes in one big patch. Such big things are
hard to review. I have removed your changes to the man page and attached
the resulting diff to this email. People with non Intel architectures
please test it. BTW the best command for making diffs is "diff -urN".

What do mean with 2. Maybe I have missed it, but I don't see any fixes
to the L2CAP parser.

The man page belongs to section 8 like all other *dump programs do. See
for example irdadump, tcpdump, pppdump etc. I will look at the man page
code today. What did you have used as reference? I ask because we should
keep the same syntax for all of our man pages. Is there a "best way to
write a man page"?

I left the re-arrange of the #include lines in the patch. I don't see
why this makes it easier, but I have no big experiences on porting stuff
to other OS. Can you give us (or maybe only me) some explanations why
this is good to have.

Regards

Marcel


--=-GGB9Rtn7egFg+mFwlNKp
Content-Disposition: attachment; filename=patch-hcidump
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch-hcidump; CHARSET=ISO-8859-15

diff -urN hcidump/hcidump.c hcidump-mh/hcidump.c
--- hcidump/hcidump.c	Mon Nov 25 19:51:58 2002
+++ hcidump-mh/hcidump.c	Sat Dec  7 16:43:52 2002
@@ -23,21 +23,21 @@
  * $Id: hcidump.c,v 1.27 2002/11/25 17:59:26 maxk Exp $
  */
=20
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <termios.h>
-#include <fcntl.h>
+#include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <sys/types.h>
 #include <sys/uio.h>
+#include <netinet/in.h>
+
 #include <errno.h>
-#include <string.h>
-#include <pwd.h>
+#include <fcntl.h>
 #include <getopt.h>
-
-#include <asm/types.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <termios.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
diff -urN hcidump/hcidump.h hcidump-mh/hcidump.h
--- hcidump/hcidump.h	Thu Feb  7 05:47:36 2002
+++ hcidump-mh/hcidump.h	Sat Dec  7 16:43:52 2002
@@ -1,4 +1,4 @@
-/*=20
+/*
 	HCIDump - HCI packet analyzer=09
 	Copyright (C) 2000-2001 Maxim Krasnyansky <maxk@qualcomm.com>
=20
@@ -31,11 +31,11 @@
 };
=20
 struct dump_hdr {
-	__u16	len;
-	__u8	in;
-	__u8	pad;
-	__u32	ts_sec;
-	__u32   ts_usec;
+	uint16_t	len;
+	uint8_t		in;
+	uint8_t		pad;
+	uint32_t	ts_sec;
+	uint32_t	ts_usec;
 } __attribute__ ((packed));
 #define DUMP_HDR_SIZE (sizeof(struct dump_hdr))
=20
diff -urN hcidump/parser/bnep.c hcidump-mh/parser/bnep.c
--- hcidump/parser/bnep.c	Sat Aug 31 05:12:18 2002
+++ hcidump-mh/parser/bnep.c	Sat Dec  7 16:43:52 2002
@@ -28,15 +28,15 @@
  * $Id: bnep.c,v 1.3 2002/08/31 03:12:18 sasai Exp $
  */
=20
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <asm/types.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -45,12 +45,6 @@
 #include "parser.h"
 #include "bnep.h"
=20
-#include <net/ethernet.h>
-#include <netinet/in.h>
-#include <netinet/ip.h>
-#include <netinet/if_ether.h>
-#include <arpa/inet.h>
-
 #define PAYLOAD_RAW_DUMP
=20
 static char *get_macaddr(struct frame *frm)
@@ -67,11 +61,11 @@
=20
 static void bnep_control(int level, struct frame *frm, int header_length)
 {
-	__u8 uuid_size;
+	uint8_t uuid_size;
 	int i, length;
 	char *s;
-	__u32 uuid =3D 0;
-	__u8 type =3D get_u8(frm);
+	uint32_t uuid =3D 0;
+	uint8_t type =3D get_u8(frm);
=20
 	p_indent(++level, frm);
 	switch (type) {
@@ -163,9 +157,9 @@
=20
 static void bnep_eval_extension(int level, struct frame *frm)
 {
-	__u8 type =3D get_u8(frm);
+	uint8_t type =3D get_u8(frm);
 	int extension =3D type & 0x80;
-	__u8 length =3D get_u8(frm);
+	uint8_t length =3D get_u8(frm);
=20
 	p_indent(level, frm);
 	switch (type & 0x7f) {
@@ -241,8 +235,8 @@
=20
 void bnep_dump(int level, struct frame *frm)
 {
-	__u8 type =3D get_u8(frm);
-	__u16 proto =3D 0x0000;
+	uint8_t type =3D get_u8(frm);
+	uint16_t proto =3D 0x0000;
 	int extension =3D type & 0x80;
=20
 	p_indent(level, frm);
diff -urN hcidump/parser/cmtp.c hcidump-mh/parser/cmtp.c
--- hcidump/parser/cmtp.c	Sat Aug 31 23:40:51 2002
+++ hcidump-mh/parser/cmtp.c	Sat Dec  7 16:43:52 2002
@@ -28,22 +28,22 @@
  * $Id: cmtp.c,v 1.1 2002/08/31 21:40:51 holtmann Exp $
  */
=20
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <netinet/in.h>
+
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <asm/types.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
=20
 #include "parser.h"
=20
=20
-char *bst2str(__u8 bst)
+char *bst2str(uint8_t bst)
 {
 	switch (bst) {
 	case 0x00:
@@ -61,14 +61,14 @@
=20
 void cmtp_dump(int level, struct frame *frm)
 {
-	__u8 hdr_size;
-	__u8 head;
-	__u8 bst, bid, nlb;
-	__u16 len;
+	uint8_t hdr_size;
+	uint8_t head;
+	uint8_t bst, bid, nlb;
+	uint16_t len;
=20
 	while (frm->len > 0) {
=20
-		head =3D *(__u8 *)frm->ptr;
+		head =3D *(uint8_t *)frm->ptr;
=20
 		bst =3D (head & 0x03);
 		bid =3D (head & 0x3c) >> 2;
@@ -83,11 +83,11 @@
 			break;
 		case 0x01:
 			hdr_size =3D 2;
-			len =3D *(__u8 *)(frm->ptr + 1);
+			len =3D *(uint8_t *)(frm->ptr + 1);
 			break;
 		case 0x02:
 			hdr_size =3D 3;
-			len =3D *(__u8 *)(frm->ptr + 1) + (*(__u8 *)(frm->ptr + 2) * 256);
+			len =3D *(uint8_t *)(frm->ptr + 1) + (*(uint8_t *)(frm->ptr + 2) * 256)=
;
 			break;
 		}
=20
diff -urN hcidump/parser/hci.c hcidump-mh/parser/hci.c
--- hcidump/parser/hci.c	Tue Mar 12 19:47:34 2002
+++ hcidump-mh/parser/hci.c	Sat Dec  7 16:43:52 2002
@@ -23,15 +23,15 @@
  * $Id: hci.c,v 1.12 2002/03/12 18:47:34 maxk Exp $
  */
=20
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <asm/types.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -223,9 +223,9 @@
 static inline void command_dump(int level, struct frame *frm)
 {
 	hci_command_hdr *hdr =3D frm->ptr;
-	__u16 opcode =3D btohs(hdr->opcode);
-	__u16 ogf =3D cmd_opcode_ogf(opcode);
-	__u16 ocf =3D cmd_opcode_ocf(opcode);
+	uint16_t opcode =3D btohs(hdr->opcode);
+	uint16_t ogf =3D cmd_opcode_ogf(opcode);
+	uint16_t ocf =3D cmd_opcode_ocf(opcode);
 	char *cmd;
=20
 	if (p_filter(FILT_HCI))
@@ -307,9 +307,9 @@
 static inline void acl_dump(int level, struct frame *frm)
 {
 	hci_acl_hdr *hdr =3D (void *) frm->ptr;
-	__u16 handle =3D btohs(hdr->handle);
-	__u16 dlen =3D btohs(hdr->dlen);
-	__u8 flags =3D acl_flags(handle);
+	uint16_t handle =3D btohs(hdr->handle);
+	uint16_t dlen =3D btohs(hdr->dlen);
+	uint8_t flags =3D acl_flags(handle);
=20
 	if (!p_filter(FILT_HCI)) {
 		p_indent(level, frm);
@@ -332,7 +332,7 @@
 static inline void sco_dump(int level, struct frame *frm)
 {
 	hci_sco_hdr *hdr =3D (void *) frm->ptr;
-	__u16 handle =3D btohs(hdr->handle);
+	uint16_t handle =3D btohs(hdr->handle);
=20
 	if (!p_filter(FILT_SCO)) {
 		p_indent(level, frm);
@@ -348,7 +348,7 @@
=20
 void hci_dump(int level, struct frame *frm)
 {
-	__u8 type =3D *(__u8 *)frm->ptr;=20
+	uint8_t type =3D *(uint8_t *)frm->ptr;=20
=20
 	frm->ptr++; frm->len--;
 =09
diff -urN hcidump/parser/l2cap.c hcidump-mh/parser/l2cap.c
--- hcidump/parser/l2cap.c	Sat Aug 31 23:40:51 2002
+++ hcidump-mh/parser/l2cap.c	Sat Dec  7 16:43:52 2002
@@ -23,15 +23,15 @@
  * $Id: l2cap.c,v 1.17 2002/08/31 21:40:51 holtmann Exp $
  */
=20
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <asm/types.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -40,7 +40,7 @@
 #include "parser.h"
=20
 typedef struct {
-	__u16 handle;
+	uint16_t handle;
 	struct frame frm;
 } handle_info;
 #define HANDLE_TABLE_SIZE 10
@@ -48,8 +48,8 @@
 static handle_info handle_table[HANDLE_TABLE_SIZE];
=20
 typedef struct {
-	__u16 cid;
-	__u16 psm;
+	uint16_t cid;
+	uint16_t psm;
 } cid_info;
 #define CID_TABLE_SIZE	20
=20
@@ -58,7 +58,7 @@
 #define SCID cid_table[0]
 #define DCID cid_table[1]
=20
-static struct frame * add_handle(__u16 handle)
+static struct frame * add_handle(uint16_t handle)
 {
 	register handle_info *t =3D handle_table;
 	register int i;
@@ -71,7 +71,7 @@
 	return NULL;
 }
=20
-static struct frame * get_frame(__u16 handle)
+static struct frame * get_frame(uint16_t handle)
 {
 	register handle_info *t =3D handle_table;
 	register int i;
@@ -83,7 +83,7 @@
 	return add_handle(handle);
 }
=20
-static void add_cid(int in, __u16 cid, __u16 psm)
+static void add_cid(int in, uint16_t cid, uint16_t psm)
 {
 	register cid_info *table =3D cid_table[in];
 	register int i;
@@ -96,10 +96,10 @@
 		}
 }
=20
-static void del_cid(int in, __u16 dcid, __u16 scid)
+static void del_cid(int in, uint16_t dcid, uint16_t scid)
 {
 	register int t, i;
-	__u16 cid[2];
+	uint16_t cid[2];
=20
 	if (!in) {
 		cid[0] =3D dcid;
@@ -118,7 +118,7 @@
 	}
 }
=20
-static __u16 get_psm(int in, __u16 cid)
+static uint16_t get_psm(int in, uint16_t cid)
 {
 	register cid_info *table =3D cid_table[in];
 	register int i;
@@ -153,7 +153,7 @@
 static inline void conn_rsp(int level, struct frame *frm)
 {
 	l2cap_conn_rsp *h =3D frm->ptr;
-	__u16 psm;
+	uint16_t psm;
=20
 	if ((psm =3D get_psm(!frm->in, btohs(h->scid))))
 		add_cid(frm->in, btohs(h->dcid), psm);
@@ -166,17 +166,17 @@
 			btohs(h->result), btohs(h->status));
 }
=20
-static __u32 conf_opt_val(__u8 *ptr, __u8 len)
+static uint32_t conf_opt_val(uint8_t *ptr, uint8_t len)
 {
 	switch (len) {
 	case 1:
 		return *ptr;
=20
         case 2:
-                return btohs(*(__u16 *)ptr);
+                return btohs(*(uint16_t *)ptr);
=20
         case 4:
-                return btohl(*(__u32 *)ptr);
+                return btohl(*(uint32_t *)ptr);
 	}
 	return 0;
 }
@@ -299,9 +299,9 @@
 static void l2cap_parse(int level, struct frame *frm)
 {
 	l2cap_hdr *hdr =3D (void *)frm->ptr;
-	__u16 dlen =3D btohs(hdr->len);
-	__u16 cid  =3D btohs(hdr->cid);
-	__u16 psm;
+	uint16_t dlen =3D btohs(hdr->len);
+	uint16_t cid  =3D btohs(hdr->cid);
+	uint16_t psm;
=20
 	frm->ptr +=3D L2CAP_HDR_SIZE;
 	frm->len -=3D L2CAP_HDR_SIZE;
@@ -372,8 +372,8 @@
 					hdr->code, hdr->ident, btohs(hdr->len));
 				raw_dump(level, frm);
 			}
-			frm->ptr +=3D hdr->len;
-			frm->len -=3D hdr->len;
+			frm->ptr +=3D btohs(hdr->len);
+			frm->len -=3D btohs(hdr->len);
 		}
 	} else if (cid =3D=3D 0x2) {
 		/* Connectionless channel */
@@ -381,7 +381,7 @@
 		if (p_filter(FILT_L2CAP))
 			return;
=20
-		psm =3D btohs(*(__u16*)frm->ptr);
+		psm =3D btohs(*(uint16_t*)frm->ptr);
 		frm->len -=3D 2;
=20
 		p_indent(level, frm);
@@ -389,7 +389,7 @@
 		raw_dump(level, frm);
 	} else {
 		/* Connection oriented channel */
-		__u16 psm =3D get_psm(!frm->in, cid);
+		uint16_t psm =3D get_psm(!frm->in, cid);
 =09
 		if (!p_filter(FILT_L2CAP)) {
 			p_indent(level, frm);
@@ -441,7 +441,7 @@
 {
 	struct frame *fr;
 	l2cap_hdr *hdr;
-	__u16 dlen;
+	uint16_t dlen;
=20
 	if (frm->flags & ACL_START) {
 		hdr  =3D frm->ptr;
diff -urN hcidump/parser/parser.c hcidump-mh/parser/parser.c
--- hcidump/parser/parser.c	Sat Aug 31 23:40:51 2002
+++ hcidump-mh/parser/parser.c	Sat Dec  7 16:43:52 2002
@@ -23,15 +23,15 @@
  * $Id: parser.c,v 1.13 2002/08/31 21:40:51 holtmann Exp $
  */
=20
+#include <sys/types.h>
+#include <netinet/in.h>
+
+#include <ctype.h>
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-#include <ctype.h>
-
-#include <sys/types.h>
-#include <asm/types.h>
+#include <unistd.h>
=20
 #include "parser.h"
=20
diff -urN hcidump/parser/parser.h hcidump-mh/parser/parser.h
--- hcidump/parser/parser.h	Mon Sep 23 15:40:42 2002
+++ hcidump-mh/parser/parser.h	Sat Dec  7 16:43:52 2002
@@ -23,14 +23,6 @@
  * $Id: parser.h,v 1.19 2002/09/23 13:40:42 jscrane Exp $
  */
=20
-#include <sys/resource.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <netinet/in.h>
-
-#include <asm/unaligned.h>
-
 struct frame {
 	void	*data;
 	int	data_len;
@@ -104,34 +96,38 @@
=20
 /* get_uXX functions do byte swaping */
=20
-static inline __u8 get_u8(struct frame *frm)
+/* use memmove to prevent gcc from using builtin memcpy */
+#define get_unaligned(p) \
+	({ __typeof__(*(p)) t; memmove(&t, (p), sizeof(t)); t; })
+
+static inline uint8_t get_u8(struct frame *frm)
 {
-	__u8 *u8_ptr =3D frm->ptr;
+	uint8_t *u8_ptr =3D frm->ptr;
 	frm->ptr +=3D 1;
 	frm->len -=3D 1;
 	return *u8_ptr;
 }
=20
-static inline __u16 get_u16(struct frame *frm)
+static inline uint16_t get_u16(struct frame *frm)
 {
-	__u16 *u16_ptr =3D frm->ptr;
+	uint16_t *u16_ptr =3D frm->ptr;
 	frm->ptr +=3D 2;
 	frm->len -=3D 2;
 	return ntohs(get_unaligned(u16_ptr));
 }
=20
-static inline __u32 get_u32(struct frame *frm)
+static inline uint32_t get_u32(struct frame *frm)
 {
-	__u32 *u32_ptr =3D frm->ptr;
+	uint32_t *u32_ptr =3D frm->ptr;
 	frm->ptr +=3D 4;
 	frm->len -=3D 4;
 	return ntohl(get_unaligned(u32_ptr));
 }
=20
-static inline __u64 get_u64(struct frame *frm)
+static inline uint64_t get_u64(struct frame *frm)
 {
-	__u64 *u64_ptr =3D frm->ptr;
-	__u64 u64 =3D get_unaligned(u64_ptr), tmp;
+	uint64_t *u64_ptr =3D frm->ptr;
+	uint64_t u64 =3D get_unaligned(u64_ptr), tmp;
 	frm->ptr +=3D 8;
 	frm->len -=3D 8;
 	tmp =3D ntohl(u64 & 0xffffffff);
@@ -139,7 +135,7 @@
 	return u64;
 }
=20
-static inline void get_u128(struct frame *frm, __u64 *l, __u64 *h)
+static inline void get_u128(struct frame *frm, uint64_t *l, uint64_t *h)
 {
 	*h =3D get_u64(frm);
 	*l =3D get_u64(frm);
diff -urN hcidump/parser/rfcomm.c hcidump-mh/parser/rfcomm.c
--- hcidump/parser/rfcomm.c	Sat Oct 12 20:07:10 2002
+++ hcidump-mh/parser/rfcomm.c	Sat Dec  7 16:43:52 2002
@@ -28,15 +28,16 @@
  * $Id: rfcomm.c,v 1.5 2002/10/12 18:07:10 holtmann Exp $
  */
=20
+#include <asm/byteorder.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <asm/types.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
=20
@@ -51,12 +52,12 @@
 #define CR_STR(mcc_head) cr_str[mcc_head->type.cr]
 #define GET_DLCI(addr) ((addr.server_chn << 1) | (addr.d & 1))
=20
-void print_rfcomm_hdr(long_frame_head* head, __u8 *ptr, int len)
+void print_rfcomm_hdr(long_frame_head* head, uint8_t *ptr, int len)
 {
 	address_field  addr  =3D head->addr;
-	__u8           ctr   =3D head->control;
-	__u16          ilen  =3D head->length.bits.len;
-	__u8           ctr_type,pf,dlci,fcs;
+	uint8_t           ctr   =3D head->control;
+	uint16_t          ilen  =3D head->length.bits.len;
+	uint8_t           ctr_type,pf,dlci,fcs;
=20
 	dlci     =3D GET_DLCI(addr);
 	pf       =3D GET_PF(ctr);
@@ -71,7 +72,7 @@
 	printf("mcc_len %d\n", mcc_head->length.bits.len);
 }
=20
-static inline void mcc_test(int level, __u8 *ptr, int len,=20
+static inline void mcc_test(int level, uint8_t *ptr, int len,=20
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -79,7 +80,7 @@
 	print_rfcomm_hdr(head, ptr, len);
 	print_mcc(mcc_head);
 }
-static inline void mcc_fcon(int level, __u8 *ptr, int len,=20
+static inline void mcc_fcon(int level, uint8_t *ptr, int len,=20
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -88,7 +89,7 @@
 	print_mcc(mcc_head);
 }
=20
-static inline void mcc_fcoff(int level, __u8 *ptr, int len,=20
+static inline void mcc_fcoff(int level, uint8_t *ptr, int len,=20
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -97,7 +98,7 @@
 	print_mcc(mcc_head);
 }
=20
-static inline void mcc_msc(int level, __u8 *ptr, int len,=20
+static inline void mcc_msc(int level, uint8_t *ptr, int len,=20
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -124,7 +125,7 @@
 		printf("\n");
 }
=20
-static inline void mcc_rpn(int level, __u8 *ptr, int len,
+static inline void mcc_rpn(int level, uint8_t *ptr, int len,
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -152,10 +153,10 @@
 		rpn->rpn_val.rtr_input, rpn->rpn_val.rtr_output,
 		rpn->rpn_val.rtc_input, rpn->rpn_val.rtc_output,
 		rpn->rpn_val.xon, rpn->rpn_val.xoff,
-		btohs(*(__u16 *)&(rpn->rpn_val.pm)));
+		btohs(*(uint16_t *)&(rpn->rpn_val.pm)));
 }
=20
-static inline void mcc_rls(int level, __u8 *ptr, int len,
+static inline void mcc_rls(int level, uint8_t *ptr, int len,
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -167,7 +168,7 @@
 	printf("dlci %d error: %d", GET_DLCI(rls->dlci), rls->error);
 }
=20
-static inline void mcc_pn(int level, __u8 *ptr, int len,
+static inline void mcc_pn(int level, uint8_t *ptr, int len,
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -185,7 +186,7 @@
 		pn->credits);
 }
=20
-static inline void mcc_nsc(int level, __u8 *ptr, int len,
+static inline void mcc_nsc(int level, uint8_t *ptr, int len,
 				long_frame_head *head,=20
 				mcc_long_frame_head *mcc_head)
 {
@@ -205,7 +206,7 @@
 {
         mcc_short_frame_head *mcc_short_head_p =3D frm->ptr;
         mcc_long_frame_head mcc_head;
-        __u8 hdr_size;
+        uint8_t hdr_size;
=20
         if ( mcc_short_head_p->length.ea =3D=3D EA ) {
                 mcc_head.type       =3D mcc_short_head_p->type;
@@ -276,7 +277,7 @@
=20
 void rfcomm_dump(int level, struct frame *frm)
 {
-	__u8 hdr_size, ctr_type;
+	uint8_t hdr_size, ctr_type;
 	short_frame_head *short_head_p =3D (void *) frm->ptr;
 	long_frame_head head;
=20
diff -urN hcidump/parser/rfcomm.h hcidump-mh/parser/rfcomm.h
--- hcidump/parser/rfcomm.h	Mon Apr 22 23:47:07 2002
+++ hcidump-mh/parser/rfcomm.h	Sat Dec  7 16:43:52 2002
@@ -28,8 +28,6 @@
  * $Id: rfcomm.h,v 1.2 2002/04/22 21:47:07 maxk Exp $
  */
=20
-#include <asm/byteorder.h>
-
 #define RFCOMM_PSM 	3
=20
 #define TRUE	1
@@ -118,83 +116,83 @@
 #ifdef __LITTLE_ENDIAN_BITFIELD
=20
 typedef struct parameter_mask{
-	__u8 bit_rate:1;
-	__u8 data_bits:1;
-	__u8 stop_bit:1;
-	__u8 parity:1;
-	__u8 parity_type:1;
-	__u8 xon:1;
-	__u8 xoff:1;
-	__u8 res1:1;
-	__u8 xon_input:1;
-	__u8 xon_output:1;
-	__u8 rtr_input:1;
-	__u8 rtr_output:1;
-	__u8 rtc_input:1;
-	__u8 rtc_output:1;
-	__u8 res2:2;
+	uint8_t bit_rate:1;
+	uint8_t data_bits:1;
+	uint8_t stop_bit:1;
+	uint8_t parity:1;
+	uint8_t parity_type:1;
+	uint8_t xon:1;
+	uint8_t xoff:1;
+	uint8_t res1:1;
+	uint8_t xon_input:1;
+	uint8_t xon_output:1;
+	uint8_t rtr_input:1;
+	uint8_t rtr_output:1;
+	uint8_t rtc_input:1;
+	uint8_t rtc_output:1;
+	uint8_t res2:2;
 } __attribute__ ((packed)) parameter_mask;
=20
 typedef struct rpn_values{
-	__u8 bit_rate;
-	__u8 data_bits:2;
-	__u8 stop_bit:1;
-	__u8 parity:1;
-	__u8 parity_type:2;
-	__u8 res1:2;
-	__u8 xon_input:1;
-	__u8 xon_output:1;
-	__u8 rtr_input:1;
-	__u8 rtr_output:1;
-	__u8 rtc_input:1;
-	__u8 rtc_output:1;
-	__u8 res2:2;
-	__u8 xon;
-	__u8 xoff;
+	uint8_t bit_rate;
+	uint8_t data_bits:2;
+	uint8_t stop_bit:1;
+	uint8_t parity:1;
+	uint8_t parity_type:2;
+	uint8_t res1:2;
+	uint8_t xon_input:1;
+	uint8_t xon_output:1;
+	uint8_t rtr_input:1;
+	uint8_t rtr_output:1;
+	uint8_t rtc_input:1;
+	uint8_t rtc_output:1;
+	uint8_t res2:2;
+	uint8_t xon;
+	uint8_t xoff;
 	parameter_mask pm;
 } __attribute__ ((packed)) rpn_values;
=20
 #elif defined(__BIG_ENDIAN_BITFIELD)
=20
 typedef struct parameter_mask{=20
-	__u8 res1:1;
-	__u8 xoff:1;
-	__u8 xon:1;
-	__u8 parity_type:1;
-	__u8 parity:1;
-	__u8 stop_bit:1;
-	__u8 data_bits:1;
-	__u8 bit_rate:1;
-
-	__u8 res2:2;
-	__u8 rtc_output:1;
-	__u8 rtc_input:1;
-	__u8 rtr_output:1;
-	__u8 rtr_input:1;
-	__u8 xon_output:1;
-	__u8 xon_input:1;
+	uint8_t res1:1;
+	uint8_t xoff:1;
+	uint8_t xon:1;
+	uint8_t parity_type:1;
+	uint8_t parity:1;
+	uint8_t stop_bit:1;
+	uint8_t data_bits:1;
+	uint8_t bit_rate:1;
+
+	uint8_t res2:2;
+	uint8_t rtc_output:1;
+	uint8_t rtc_input:1;
+	uint8_t rtr_output:1;
+	uint8_t rtr_input:1;
+	uint8_t xon_output:1;
+	uint8_t xon_input:1;
=20
 } __attribute__ ((packed)) parameter_mask;
=20
 typedef struct rpn_values{=20
-	__u8 bit_rate;
+	uint8_t bit_rate;
=20
-	__u8 res1:2;
-	__u8 parity_type:2;
-	__u8 parity:1;
-	__u8 stop_bit:1;
-	__u8 data_bits:2;
-
-	__u8 res2:2;
-	__u8 rtc_output:1;
-	__u8 rtc_input:1;
-	__u8 rtr_output:1;
-	__u8 rtr_input:1;
-	__u8 xon_output:1;
-	__u8 xon_input:1;
+	uint8_t res1:2;
+	uint8_t parity_type:2;
+	uint8_t parity:1;
+	uint8_t stop_bit:1;
+	uint8_t data_bits:2;
+
+	uint8_t res2:2;
+	uint8_t rtc_output:1;
+	uint8_t rtc_input:1;
+	uint8_t rtr_output:1;
+	uint8_t rtr_input:1;
+	uint8_t xon_output:1;
+	uint8_t xon_input:1;
=20
-	__u8 xon;
-	__u8 xoff;
+	uint8_t xon;
+	uint8_t xoff;
 	parameter_mask pm;
 } __attribute__ ((packed)) rpn_values;
=20
@@ -213,94 +211,94 @@
 #ifdef __LITTLE_ENDIAN_BITFIELD
=20
 typedef struct address_field {
-	__u8 ea:1;
-	__u8 cr:1;
-	__u8 d:1;
-	__u8 server_chn:5;
+	uint8_t ea:1;
+	uint8_t cr:1;
+	uint8_t d:1;
+	uint8_t server_chn:5;
 } __attribute__ ((packed)) address_field;
=20
 typedef struct short_length {
-	__u8 ea:1;
-	__u8 len:7;
+	uint8_t ea:1;
+	uint8_t len:7;
 } __attribute__ ((packed)) short_length;
=20
 typedef union long_length {
 	struct bits {
-		__u8 ea:1;
+		uint8_t ea:1;
 		unsigned short len:15;
 	} __attribute__ ((packed)) bits ;
-	__u16 val ;
+	uint16_t val ;
 } __attribute__ ((packed)) long_length;
=20
 typedef struct short_frame_head {
 	address_field addr;
-	__u8 control;
+	uint8_t control;
 	short_length length;
 } __attribute__ ((packed)) short_frame_head;
=20
 typedef struct short_frame {
 	short_frame_head h;
-	__u8 data[0];=20
+	uint8_t data[0];=20
 } __attribute__ ((packed)) short_frame;
=20
 typedef struct long_frame_head {
 	address_field addr;
-	__u8 control;
+	uint8_t control;
 	long_length length;
-	__u8 data[0];
+	uint8_t data[0];
 } __attribute__ ((packed)) long_frame_head;
=20
 typedef struct long_frame {
 	long_frame_head h;
-	__u8 data[0];
+	uint8_t data[0];
 } __attribute__ ((packed)) long_frame;
=20
 /* Typedefinitions for structures used for the multiplexer commands */
 typedef struct mcc_type {
-	__u8 ea:1;
-	__u8 cr:1;
-	__u8 type:6;
+	uint8_t ea:1;
+	uint8_t cr:1;
+	uint8_t type:6;
 } __attribute__ ((packed)) mcc_type;
=20
 typedef struct mcc_short_frame_head {
 	mcc_type type;
 	short_length length;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_short_frame_head;
=20
 typedef struct mcc_short_frame {
 	mcc_short_frame_head h;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_short_frame;
=20
 typedef struct mcc_long_frame_head {
 	mcc_type type;
 	long_length length;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_long_frame_head;
=20
 typedef struct mcc_long_frame {
 	mcc_long_frame_head h;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_long_frame;
=20
 /* MSC-command */
 typedef struct v24_signals {
-	__u8 ea:1;
-	__u8 fc:1;
-	__u8 rtc:1;
-	__u8 rtr:1;
-	__u8 reserved:2;
-	__u8 ic:1;
-	__u8 dv:1;
+	uint8_t ea:1;
+	uint8_t fc:1;
+	uint8_t rtc:1;
+	uint8_t rtr:1;
+	uint8_t reserved:2;
+	uint8_t ic:1;
+	uint8_t dv:1;
 } __attribute__ ((packed)) v24_signals;
=20
 typedef struct break_signals {
-	__u8 ea:1;
-	__u8 b1:1;
-	__u8 b2:1;
-	__u8 b3:1;
-	__u8 len:4;
+	uint8_t ea:1;
+	uint8_t b1:1;
+	uint8_t b2:1;
+	uint8_t b3:1;
+	uint8_t len:4;
 } __attribute__ ((packed)) break_signals;
=20
 typedef struct msc_msg {
@@ -309,7 +307,7 @@
 	address_field dlci;
 	v24_signals v24_sigs;
 	//break_signals break_sigs;
-	__u8 fcs;
+	uint8_t fcs;
 } __attribute__ ((packed)) msc_msg;
=20
 typedef struct rpn_msg {
@@ -317,7 +315,7 @@
 	mcc_short_frame_head mcc_s_head;
 	address_field dlci;
 	rpn_values rpn_val;
-	__u8 fcs;
+	uint8_t fcs;
 } __attribute__ ((packed)) rpn_msg;
=20
 /* RLS-command */ =20
@@ -325,9 +323,9 @@
 	short_frame_head s_head;
 	mcc_short_frame_head mcc_s_head;
 	address_field dlci;
-	__u8 error:4;
-	__u8 res:4;
-	__u8 fcs;
+	uint8_t error:4;
+	uint8_t res:4;
+	uint8_t fcs;
 } __attribute__ ((packed)) rls_msg;
=20
 /* PN-command */
@@ -335,17 +333,17 @@
 	short_frame_head s_head;
 	mcc_short_frame_head mcc_s_head;
 /* The res1, res2 and res3 values have to be set to 0 by the sender */
-	__u8 dlci:6;
-	__u8 res1:2;
-	__u8 frame_type:4;
-	__u8 credit_flow:4;
-	__u8 prior:6;
-	__u8 res2:2;
-	__u8 ack_timer;
-	__u16 frame_size:16;
-	__u8 max_nbrof_retrans;
-	__u8 credits;
-	__u8 fcs;
+	uint8_t dlci:6;
+	uint8_t res1:2;
+	uint8_t frame_type:4;
+	uint8_t credit_flow:4;
+	uint8_t prior:6;
+	uint8_t res2:2;
+	uint8_t ack_timer;
+	uint16_t frame_size:16;
+	uint8_t max_nbrof_retrans;
+	uint8_t credits;
+	uint8_t fcs;
 } __attribute__ ((packed)) pn_msg;
=20
 /* NSC-command */
@@ -353,98 +351,98 @@
 	short_frame_head s_head;
 	mcc_short_frame_head mcc_s_head;
 	mcc_type command_type;
-	__u8 fcs;
+	uint8_t fcs;
 } __attribute__ ((packed)) nsc_msg;
=20
 #elif defined(__BIG_ENDIAN_BITFIELD)
=20
 typedef struct address_field {
-	__u8 server_chn:5;
-	__u8 d:1;
-	__u8 cr:1;
-	__u8 ea:1;
+	uint8_t server_chn:5;
+	uint8_t d:1;
+	uint8_t cr:1;
+	uint8_t ea:1;
 } __attribute__ ((packed)) address_field;
=20
 typedef struct short_length {
-	__u8 len:7;
-	__u8 ea:1;
+	uint8_t len:7;
+	uint8_t ea:1;
 } __attribute__ ((packed)) short_length;
=20
 typedef union long_length {
 	struct bits {
 		unsigned short len:15;
-		__u8 ea:1;
+		uint8_t ea:1;
 	} __attribute__ ((packed)) bits;
-	__u16 val;
+	uint16_t val;
 } __attribute__ ((packed)) long_length;
=20
 typedef struct short_frame_head {=20
 	address_field addr;
-	__u8 control;
+	uint8_t control;
 	short_length length;
 } __attribute__ ((packed)) short_frame_head;
=20
 typedef struct short_frame {
 	short_frame_head h;
-	__u8 data[0];
+	uint8_t data[0];
 } __attribute__ ((packed)) short_frame;
=20
 typedef struct long_frame_head {=20
 	address_field addr;
-	__u8 control;
+	uint8_t control;
 	long_length length;
-	__u8 data[0];
+	uint8_t data[0];
 } __attribute__ ((packed)) long_frame_head;
=20
 typedef struct long_frame {=20
 	long_frame_head h;
-	__u8 data[0];
+	uint8_t data[0];
 } __attribute__ ((packed)) long_frame;
=20
 typedef struct mcc_type {=20
-	__u8 type:6;
-	__u8 cr:1;
-	__u8 ea:1;
+	uint8_t type:6;
+	uint8_t cr:1;
+	uint8_t ea:1;
 } __attribute__ ((packed)) mcc_type;
=20
 typedef struct mcc_short_frame_head {=20
 	mcc_type type;
 	short_length length;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_short_frame_head;
=20
 typedef struct mcc_short_frame {=20
 	mcc_short_frame_head h;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_short_frame;
=20
 typedef struct mcc_long_frame_head {=20
 	mcc_type type;
 	long_length length;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_long_frame_head;
=20
 typedef struct mcc_long_frame {=20
 	mcc_long_frame_head h;
-	__u8 value[0];
+	uint8_t value[0];
 } __attribute__ ((packed)) mcc_long_frame;
=20
 typedef struct v24_signals {=20
-	__u8 dv:1;
-	__u8 ic:1;
-	__u8 reserved:2;
-	__u8 rtr:1;
-	__u8 rtc:1;
-	__u8 fc:1;
-	__u8 ea:1;
+	uint8_t dv:1;
+	uint8_t ic:1;
+	uint8_t reserved:2;
+	uint8_t rtr:1;
+	uint8_t rtc:1;
+	uint8_t fc:1;
+	uint8_t ea:1;
 } __attribute__ ((packed)) v24_signals;
=20
 typedef struct break_signals {=20
-	__u8 len:4;
-	__u8 b3:1;
-	__u8 b2:1;
-	__u8 b1:1;
-	__u8 ea:1;
+	uint8_t len:4;
+	uint8_t b3:1;
+	uint8_t b2:1;
+	uint8_t b1:1;
+	uint8_t ea:1;
 } __attribute__ ((packed)) break_signals;
=20
 typedef struct msc_msg {=20
@@ -453,7 +451,7 @@
 	address_field dlci;
 	v24_signals v24_sigs;
 	//break_signals break_sigs;
-	__u8 fcs;
+	uint8_t fcs;
 } __attribute__ ((packed)) msc_msg;
=20
 typedef struct rpn_msg {=20
@@ -461,39 +459,39 @@
 	mcc_short_frame_head mcc_s_head;
 	address_field dlci;
 	rpn_values rpn_val;
-	__u8 fcs;
+	uint8_t fcs;
 } __attribute__ ((packed)) rpn_msg;
=20
 typedef struct rls_msg {=20
 	short_frame_head s_head;
 	mcc_short_frame_head mcc_s_head;
 	address_field dlci;
-	__u8 res:4;
-	__u8 error:4;
-	__u8 fcs;
+	uint8_t res:4;
+	uint8_t error:4;
+	uint8_t fcs;
 } __attribute__ ((packed)) rls_msg;
=20
 typedef struct pn_msg {=20
 	short_frame_head s_head;
 	mcc_short_frame_head mcc_s_head;
-	__u8 res1:2;
-	__u8 dlci:6;
-	__u8 credit_flow:4;
-	__u8 frame_type:4;
-	__u8 res2:2;
-	__u8 prior:6;
-	__u8 ack_timer;
-	__u16 frame_size:16;
-	__u8 max_nbrof_retrans;
-	__u8 credits;
-	__u8 fcs;
+	uint8_t res1:2;
+	uint8_t dlci:6;
+	uint8_t credit_flow:4;
+	uint8_t frame_type:4;
+	uint8_t res2:2;
+	uint8_t prior:6;
+	uint8_t ack_timer;
+	uint16_t frame_size:16;
+	uint8_t max_nbrof_retrans;
+	uint8_t credits;
+	uint8_t fcs;
 } __attribute__ ((packed)) pn_msg;
=20
 typedef struct nsc_msg {=20
 	short_frame_head s_head;
 	mcc_short_frame_head mcc_s_head;
 	mcc_type command_type;
-	__u8 fcs;
+	uint8_t fcs;
 } __attribute__ ((packed)) nsc_msg;
=20
 #else /* __XXX_ENDIAN */
diff -urN hcidump/parser/sdp.c hcidump-mh/parser/sdp.c
--- hcidump/parser/sdp.c	Thu Nov  7 00:13:16 2002
+++ hcidump-mh/parser/sdp.c	Sat Dec  7 16:43:52 2002
@@ -28,16 +28,15 @@
  * $Id: sdp.c,v 1.14 2002/11/06 23:10:55 holtmann Exp $
  */
=20
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include <string.h>
-
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <asm/types.h>=20
-#include <netinet/in.h>
+#include <unistd.h>
=20
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -150,11 +149,11 @@
 	return 0;
 }
=20
-static inline __u8 parse_de_hdr(struct frame *frm, int* n)
+static inline uint8_t parse_de_hdr(struct frame *frm, int* n)
 {
-	__u8	de_hdr =3D get_u8(frm);
-	__u8	de_type =3D de_hdr >> 3;
-	__u8	siz_idx =3D de_hdr & 0x07;
+	uint8_t	de_hdr =3D get_u8(frm);
+	uint8_t	de_type =3D de_hdr >> 3;
+	uint8_t	siz_idx =3D de_hdr & 0x07;
=20
 	/* Get the number of bytes */
 	if (sdp_siz_idx_lookup_table[siz_idx].addl_bits) {
@@ -175,9 +174,9 @@
 	return de_type;
 }
=20
-static inline void print_int(__u8 de_type, int level, int n, struct frame =
*frm)
+static inline void print_int(uint8_t de_type, int level, int n, struct fra=
me *frm)
 {
-	__u64 val, val2;
+	uint64_t val, val2;
=20
 	switch(de_type) {
 	case SDP_DE_UINT:
@@ -223,7 +222,7 @@
=20
 static inline void print_uuid(int n, struct frame *frm)
 {
-	__u32 uuid =3D 0;
+	uint32_t uuid =3D 0;
 	char* s;
=20
 	switch(n) {
@@ -270,7 +269,7 @@
 	frm->len -=3D n;
 }
=20
-static inline void print_des(__u8 de_type, int level, int n, struct frame =
*frm, int *split)
+static inline void print_des(uint8_t de_type, int level, int n, struct fra=
me *frm, int *split)
 {
 	int len =3D frm->len;
 	while (len - frm->len < n )
@@ -280,7 +279,7 @@
 static inline void print_de(int level, struct frame *frm, int *split)
 {
 	int  n;
-	__u8 de_type =3D parse_de_hdr(frm, &n);
+	uint8_t de_type =3D parse_de_hdr(frm, &n);
=20
 	switch(de_type) {
 	case SDP_DE_NULL:
@@ -342,8 +341,8 @@
=20
 static inline void print_attr_id_list(int level, struct frame *frm)
 {
-	__u16 attr_id;
-	__u32 attr_id_range;
+	uint16_t attr_id;
+	uint32_t attr_id_range;
 	int len =3D frm->len;
 	int n1, n2;
=20
@@ -380,7 +379,7 @@
=20
 static inline void print_attr_list(int level, struct frame *frm)
 {
-	__u16 attr_id;
+	uint16_t attr_id;
 	int   n1, n2, split;
 	int   len =3D frm->len;
=20
@@ -439,7 +438,7 @@
 }
=20
=20
-static inline void err_rsp(int level, __u16 tid, __u16 len, struct frame *=
frm)
+static inline void err_rsp(int level, uint16_t tid, uint16_t len, struct f=
rame *frm)
 {
 	printf("SDP Error Rsp: tid 0x%x len 0x%x\n", tid, len);
=20
@@ -453,7 +452,7 @@
 }
=20
=20
-static inline void ss_req(int level, __u16 tid, __u16 len, struct frame *f=
rm)
+static inline void ss_req(int level, uint16_t tid, uint16_t len, struct fr=
ame *frm)
 {
 	printf("SDP SS Req: tid 0x%x len 0x%x\n", tid, len);
=20
@@ -465,11 +464,11 @@
 	printf("max 0x%x\n", get_u16(frm));
 }
=20
-static inline void ss_rsp(int level, __u16 tid, __u16 len, struct frame *f=
rm)
+static inline void ss_rsp(int level, uint16_t tid, uint16_t len, struct fr=
ame *frm)
 {
 	register int i;
-	__u16 cur_srv_rec_cnt =3D get_u16(frm); /* Parse CurrentServiceRecordCoun=
t */
-	__u16 tot_srv_rec_cnt =3D get_u16(frm); /* Parse TotalServiceRecordCount =
*/
+	uint16_t cur_srv_rec_cnt =3D get_u16(frm); /* Parse CurrentServiceRecordC=
ount */
+	uint16_t tot_srv_rec_cnt =3D get_u16(frm); /* Parse TotalServiceRecordCou=
nt */
=20
 	printf("SDP SS Rsp: tid 0x%x len 0x%x\n", tid, len);
=20
@@ -486,7 +485,7 @@
 	printf("\n");
 }
=20
-static inline void sa_req(int level, __u16 tid, __u16 len, struct frame *f=
rm)
+static inline void sa_req(int level, uint16_t tid, uint16_t len, struct fr=
ame *frm)
 {
 	printf("SDP SA Req: tid 0x%x len 0x%x\n", tid, len);
=20
@@ -502,7 +501,7 @@
 	print_attr_id_list(level, frm);
 }
=20
-static inline void sa_rsp(int level, __u16 tid, __u16 len, struct frame *f=
rm)
+static inline void sa_rsp(int level, uint16_t tid, uint16_t len, struct fr=
ame *frm)
 {
 	printf("SDP SA Rsp: tid 0x%x len 0x%x\n", tid, len);
=20
@@ -514,7 +513,7 @@
 	print_attr_list(level, frm);
 }
=20
-static inline void ssa_req(int level, __u16 tid, __u16 len, struct frame *=
frm)
+static inline void ssa_req(int level, uint16_t tid, uint16_t len, struct f=
rame *frm)
 {
 	printf("SDP SSA Req: tid 0x%x len 0x%x\n", tid, len);
=20
@@ -529,7 +528,7 @@
 	print_attr_id_list(level, frm);
 }
=20
-static inline void ssa_rsp(int level, __u16 tid, __u16 len, struct frame *=
frm)
+static inline void ssa_rsp(int level, uint16_t tid, uint16_t len, struct f=
rame *frm)
 {
 	int cnt;
 	printf("SDP SSA Rsp: tid 0x%x len 0x%x\n", tid, len);
@@ -546,8 +545,8 @@
 void sdp_dump(int level, struct frame *frm)
 {
 	sdp_pdu_hdr *hdr =3D frm->ptr;
- 	__u16 tid =3D ntohs(hdr->tid);
-	__u16 len =3D ntohs(hdr->len);
+ 	uint16_t tid =3D ntohs(hdr->tid);
+	uint16_t len =3D ntohs(hdr->len);
=20
 	frm->ptr +=3D SDP_PDU_HDR_SIZE;
 	frm->len -=3D SDP_PDU_HDR_SIZE;
diff -urN hcidump/parser/sdp.h hcidump-mh/parser/sdp.h
--- hcidump/parser/sdp.h	Thu Nov  7 00:02:14 2002
+++ hcidump-mh/parser/sdp.h	Sat Dec  7 16:43:52 2002
@@ -135,9 +135,9 @@
 /* SDP structures */
=20
 typedef struct {
-	__u8  pid;
-	__u16 tid;
-	__u16 len;
+	uint8_t  pid;
+	uint16_t tid;
+	uint16_t len;
 } __attribute__ ((packed)) sdp_pdu_hdr;
 #define SDP_PDU_HDR_SIZE	5
=20

--=-GGB9Rtn7egFg+mFwlNKp--
