Return-Path: <cyrus@holtmann.org>
Message-ID: <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Patrick Ohly <patrick.ohly@intel.com>
To: Markus Rathgeb <maggu2810@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Date: Mon, 05 Mar 2012 14:12:47 +0100
In-Reply-To: <CAOcK=CNZofxZtUp4Zh5eiGMM_TYrbGOwseA3tcwAnAFDvLEFxg@mail.gmail.com>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	 <1330903638.3392.141.camel@aeonflux>
	 <1330932819.4028.59.camel@pohly-mobl1.fritz.box>
	 <CAOcK=CNZofxZtUp4Zh5eiGMM_TYrbGOwseA3tcwAnAFDvLEFxg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-ySYURrvyH52A2W0DiFqT"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ySYURrvyH52A2W0DiFqT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-05 at 09:31 +0100, Markus Rathgeb wrote:
> Before you are applying the patch, could you also have a look at:
> http://permalink.gmane.org/gmane.linux.bluez.kernel/22294

That's a second C++ problem with the header file. With typeof and -std=c
++0x I get an error, as you said.

I'm fine with using __typeof__ instead of typeof. I verified that g++
4.6.2 and clang++ 3.0 grok __typeof__, with and without -std=c++0x. I
also checked that gcc accepts it without -std, with -std=gnu89, and with
-std=c99. It rejects the header file with -std=c89 because of the inline
keyword.

Updated patch attached.

Note that Debian seems to have picked the older
http://marc.info/?l=linux-bluetooth&m=132644289619172&w=2 patch, the one
which removes __attribute__((packed)) and replaces the (void *) cast
with (struct __s *).

I think that shows that it is important that upstream includes a
solution, because otherwise distros will pick one randomly.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


--=-ySYURrvyH52A2W0DiFqT
Content-Disposition: attachment;
	filename*0=0001-bluetooth.h-fix-typecast-and-typeof-compile-issue-wh.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-bluetooth.h-fix-typecast-and-typeof-compile-issue-wh.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 8bit

>From 51f8b4d8343454b04e7ed83b7770185d718d6203 Mon Sep 17 00:00:00 2001
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Mon, 16 Jan 2012 10:58:44 +0100
Subject: [PATCH] bluetooth.h: fix typecast and typeof compile issue when used
 in C++
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The compiler error for the typecast is:
 /usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
 ...

The reason is that C++, in contrast to C, does not allow conversion of
void * to anything, and this code gets compiled as C++ when the app is
written in C++. The macro with the assignment itself is older, but only
recent Bluez starts to use it in inline functions, thus triggering the
problem.

Another issue in combination with -std=c++0x is the use of typeof,
which is not a standard C++ feature and thus gets rejected in strict
mode.

This patch keeps the "struct __attribute__((packed))" magic and merely
changes the typecast so that it works in C and C++. typeof gets replaced
with __typeof__.

g++ 4.6.2 and clang++ 3.0-5 accept the modified header file, with and
without -std=c++0x. gcc 4.6.2 accepts it without -std, with -std=gnu89,
and with -std=c99. It rejects the header file with -std=c89 because of
the inline keyword.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bluetooth.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 5bd4f03..297d52d 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -112,16 +112,16 @@ enum {
 #define bt_get_unaligned(ptr)			\
 ({						\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (void *) (ptr);		\
+		__typeof__(*(ptr)) __v;		\
+	} *__p = (__typeof__(__p)) (ptr);	\
 	__p->__v;				\
 })
 
 #define bt_put_unaligned(val, ptr)		\
 do {						\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (void *) (ptr);		\
+		__typeof__(*(ptr)) __v;		\
+	} *__p = (__typeof__(__p)) (ptr);	\
 	__p->__v = (val);			\
 } while(0)
 
-- 
1.7.9


--=-ySYURrvyH52A2W0DiFqT--
