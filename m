Return-Path: <SRS0+53c6f9e0eda5ea539b39+515+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092208405.4564.227.camel@pegasus>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-9sURTqgD2GzmsvX9bMVW"
Date: Thu, 20 Jan 2005 14:30:53 +0000
Message-Id: <1106231454.26551.582.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-9sURTqgD2GzmsvX9bMVW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-08-11 at 09:13 +0200, Marcel Holtmann wrote:
> > The attached patch should fix the problem (it does as far as I can tell).
> > The compiler probably thinks both arguments to memcpy() are aligned and so
> > makes an optimization which breaks the copy (because the destination is not
> > actually aligned). Perhaps this is a compiler bug... I'm using gcc 3.3.3.
> > After googling and reading some discussion on the topic it seems that it's
> > probably not a compiler bug. I'll leave that for someone else to decide. :)
> 
> after checking some more resources, you may be right and the compiler
> optimizes here where it should not. I found a comment about gcc and
> using its __builtin_memcpy. Try to replace the memcpy with memmove and
> see if this works.

That isn't guaranteed to work either. This is the patch I've been
testing in the Fedora RPM since August. It lets the compiler know what's
happening so it can generate optimal code.

-- 
dwmw2

--=-9sURTqgD2GzmsvX9bMVW
Content-Disposition: inline; filename=bluez-libs-2.10-align.patch
Content-Type: text/x-patch; name=bluez-libs-2.10-align.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- bluez-libs-2.10/include/bluetooth.h.align	2004-08-16 20:30:12.998705139 +0100
+++ bluez-libs-2.10/include/bluetooth.h	2004-08-16 20:33:14.933543394 +0100
@@ -88,17 +88,21 @@
 #endif
 
 /* Bluetooth unaligned access */
-#if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || defined(__s390__) || defined(__cris__)
-#define bt_get_unaligned(ptr) (*(ptr))
-#define bt_put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
-#else
-#define bt_get_unaligned(ptr) \
-	({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-#define bt_put_unaligned(val, ptr) \
-	({ __typeof__(*(ptr)) __tmp = (val); \
-	memmove((ptr), &__tmp, sizeof(*(ptr))); \
-	(void)0; })
-#endif
+#define bt_get_unaligned(ptr)                   \
+({                                              \
+        struct __attribute__((packed)) {        \
+                typeof(*(ptr)) __v;             \
+        }  *__p = (ptr);                        \
+        __p->__v;                               \
+})
+
+#define bt_put_unaligned(val, ptr)		\
+do {                                            \
+        struct __attribute__((packed)) {        \
+                typeof(*(ptr)) __v;             \
+        }  *__p = (ptr);                        \
+        __p->__v = (val);                       \
+} while(0)
 
 /* BD Address */
 typedef struct {

--=-9sURTqgD2GzmsvX9bMVW--
