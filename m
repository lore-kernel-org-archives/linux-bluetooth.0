Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1051277155.1989.3007.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
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
Date: Fri, 25 Apr 2003 14:25:56 +0100

Thou Shalt Not Use Private Kernel Headers In Userspace.
Thou Shalt Not Use Private Kernel Headers In Userspace.
Thou Shalt Not Use Private Kernel Headers In Userspace.
Thou Shalt Not Use Private Kernel Headers In Userspace.

--- bluez-hcidump-1.5/parser/parser.h~	Tue Oct 15 18:18:45 2002
+++ bluez-hcidump-1.5/parser/parser.h	Fri Apr 25 14:17:39 2003
@@ -29,8 +29,6 @@
 #include <sys/types.h>
 #include <netinet/in.h>
 
-#include <asm/unaligned.h>
-
 struct frame {
 	void	*data;
 	int	data_len;
@@ -102,7 +100,7 @@
 		printf("%*c", (level*2), ' ');
 }
 
-/* get_uXX functions do byte swaping */
+/* get_uXX functions do byte swapping */
 
 static inline __u8 get_u8(struct frame *frm)
 {
@@ -114,28 +112,35 @@
 
 static inline __u16 get_u16(struct frame *frm)
 {
-	__u16 *u16_ptr = frm->ptr;
+	__u8 *u8_ptr = frm->ptr;
 	frm->ptr += 2;
 	frm->len -= 2;
-	return ntohs(get_unaligned(u16_ptr));
+	return (u8_ptr[0] << 8) | u8_ptr[1];
 }
 
 static inline __u32 get_u32(struct frame *frm)
 {
-	__u32 *u32_ptr = frm->ptr;
+	__u8 *u8_ptr = frm->ptr;
 	frm->ptr += 4;
 	frm->len -= 4;
-	return ntohl(get_unaligned(u32_ptr));
+	return (u8_ptr[0] << 24) |(u8_ptr[1] << 16) | (u8_ptr[2] << 8) | u8_ptr[3];
 }
 
 static inline __u64 get_u64(struct frame *frm)
 {
-	__u64 *u64_ptr = frm->ptr;
-	__u64 u64 = get_unaligned(u64_ptr), tmp;
+	__u8 *u8_ptr = frm->ptr;
+	__u64 u64;
+
 	frm->ptr += 8;
 	frm->len -= 8;
-	tmp = ntohl(u64 & 0xffffffff);
-	u64 = (tmp << 32) | ntohl(u64 >> 32);
+	u64 = (__u64)u8_ptr[0] << 56;
+	u64 |= (__u64)u8_ptr[1] << 48;
+	u64 |= (__u64)u8_ptr[2] << 40;
+	u64 |= (__u64)u8_ptr[3] << 32;
+	u64 |= (__u64)u8_ptr[4] << 24;
+	u64 |= (__u64)u8_ptr[5] << 16;
+	u64 |= (__u64)u8_ptr[6] << 8;
+	u64 |= (__u64)u8_ptr[7];
 	return u64;
 }
 




-- 
dwmw2



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
