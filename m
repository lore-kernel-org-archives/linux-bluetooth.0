Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 24 Feb 2014 08:38:30 -0800
Message-ID: <CAOVeLGQe8FF0eGf0M0N2T34KsOK=HvPDDc5j+0TqSjToAdN4vQ@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix bluetooth.h for inclusion in clang projects
From: Donald Carr <sirspudd@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From b12351dacb8e7fc44668ab4011db1d1b2b83e883 Mon Sep 17 00:00:00 2001
From: Donald Carr <sirspudd@gmail.com>
Date: Mon, 24 Feb 2014 08:34:46 -0800
Subject: [PATCH] Move from typeof gcc intrinsic to __typeof__

Change-Id: Ic3aa6ec1446876bfabdcc5e120ec327e177ffc74
---
 lib/bluetooth.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 61c1f9a..bc9b35e 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -158,16 +158,16 @@ enum {
 #define bt_get_unaligned(ptr)                  \
 ({                                             \
        struct __attribute__((packed)) {        \
-               typeof(*(ptr)) __v;             \
-       } *__p = (typeof(__p)) (ptr);           \
+               __typeof__(*(ptr)) __v;         \
+       } *__p = (__typeof__(__p)) (ptr);               \
        __p->__v;                               \
 })

 #define bt_put_unaligned(val, ptr)             \
 do {                                           \
        struct __attribute__((packed)) {        \
-               typeof(*(ptr)) __v;             \
-       } *__p = (typeof(__p)) (ptr);           \
+               __typeof__(*(ptr)) __v;         \
+       } *__p = (__typeof__(__p)) (ptr);               \
        __p->__v = (val);                       \
 } while(0)

--
1.9.0

-- 
-------------------------------
 °v°  Donald Carr
/(_)\ Vaguely Professional Penguin lover
 ^ ^

Cave canem, te necet lingendo
