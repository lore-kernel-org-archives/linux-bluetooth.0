Return-Path: <SRS0+1e64d80a8a8dcd07f28e+518+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106480346.9269.2.camel@pegasus>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
	 <1106232343.8190.187.camel@pegasus>
	 <1106233175.26551.597.camel@hades.cambridge.redhat.com>
	 <1106480346.9269.2.camel@pegasus>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 12:29:53 +0000
Message-Id: <1106483393.6480.11.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 2005-01-23 at 12:39 +0100, Marcel Holtmann wrote:
> your patch results in a lot of "initialization from incompatible
> pointer type" errors in the utils and hcidump. Basically in
> conjunction with functions like ntohs() etc. How do we fix this?

Mea culpa... forgot to cast when we deliberately use an integer pointer
as a pointer to our packed structure containing the same type of int. 
We might as well also switch sdp_internal.h to use the same macros while
we're at it.

Index: include/bluetooth.h
===================================================================
RCS file: /cvsroot/bluez/libs/include/bluetooth.h,v
retrieving revision 1.18
diff -u -r1.18 bluetooth.h
--- include/bluetooth.h	20 Jan 2005 18:14:19 -0000	1.18
+++ include/bluetooth.h	23 Jan 2005 12:26:50 -0000
@@ -92,7 +92,7 @@
 ({						\
 	struct __attribute__((packed)) {	\
 		typeof(*(ptr)) __v;		\
-	} *__p = (ptr);				\
+	}  *__p = (void *)(ptr);		\
 	__p->__v;				\
 })
 
@@ -100,7 +100,7 @@
 do {						\
 	struct __attribute__((packed)) {	\
 		typeof(*(ptr)) __v;		\
-	} *__p = (ptr);				\
+	}  *__p = (void *)(ptr);		\
 	__p->__v = (val);			\
 } while(0)
 
Index: include/sdp_internal.h
===================================================================
RCS file: /cvsroot/bluez/libs/include/sdp_internal.h,v
retrieving revision 1.3
diff -u -r1.3 sdp_internal.h
--- include/sdp_internal.h	3 Apr 2004 09:21:06 -0000	1.3
+++ include/sdp_internal.h	23 Jan 2005 12:26:50 -0000
@@ -55,102 +55,8 @@
 #define SDP_UUID_SEQ_SIZE 256
 #define SDP_MAX_ATTR_LEN 65535
 
-/* 
- * SDP unaligned access. 
- * based on linux/asm-<arch>/unaligned.h
- */
-#if defined(__i386__)
-
-#define sdp_get_unaligned(ptr) (*(ptr))
-#define sdp_put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
-
-#else
-
-struct __una_u64 { uint64_t x; } __attribute__((packed));
-struct __una_u32 { uint32_t x; } __attribute__((packed));
-struct __una_u16 { uint16_t x; } __attribute__((packed));
-
-static inline unsigned long long __uldq(const unsigned long *r11)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) r11;
-	return ptr->x;
-}
-
-static inline unsigned long __uldl(const unsigned int * r11)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) r11;
-	return ptr->x;
-}
-
-static inline unsigned long __uldw(const unsigned short * r11)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) r11;
-	return ptr->x;
-}
-
-static inline void __ustq(unsigned long r5, unsigned long * r11)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) r11;
-	ptr->x = r5;
-}
-
-static inline void __ustl(unsigned long r5, unsigned int * r11)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) r11;
-	ptr->x = r5;
-}
-
-static inline void __ustw(unsigned long r5, unsigned short * r11)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) r11;
-	ptr->x = r5;
-}
-
-static inline unsigned long long __sdp_get_unaligned(const void *ptr, size_t size)
-{
-	unsigned long long val = 0;
-	switch (size) {
-	case 1:
-		val = *(const unsigned char *)ptr;
-		break;
-	case 2:
-		val = __uldw((const unsigned short *)ptr);
-		break;
-	case 4:
-		val = __uldl((const unsigned int *)ptr);
-		break;
-	case 8:
-		val = __uldq((const unsigned long *)ptr);
-		break;
-	}
-	return val;
-}
-
-static inline void __sdp_put_unaligned(unsigned long val, void *ptr, size_t size)
-{
-	switch (size) {
-	case 1:
-		*(unsigned char *)ptr = (val);
-		break;
-	case 2:
-		__ustw(val, (unsigned short *)ptr);
-		break;
-	case 4:
-		__ustl(val, (unsigned int *)ptr);
-		break;
-	case 8:
-		__ustq(val, (unsigned long *)ptr);
-		break;
-	}
-}
-
-#define sdp_get_unaligned(ptr) \
-	((__typeof__(*(ptr)))__sdp_get_unaligned((ptr), sizeof(*(ptr))))
-
-#define sdp_put_unaligned(x,ptr) \
-	__sdp_put_unaligned((unsigned long)(x), (ptr), sizeof(*(ptr)))
-
-#endif 
+#define sdp_get_unaligned bt_get_unaligned
+#define sdp_put_unaligned bt_put_unaligned
 
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define ntoh64(x) x



-- 
dwmw2
