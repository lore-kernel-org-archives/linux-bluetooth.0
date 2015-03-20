Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2015 23:46:41 +0900
Message-ID: <CALhfZZrF0O2EREvYPrhC_vPYbyHX2c1qpySb+yj2ONjB1+jvgg@mail.gmail.com>
Subject: [PATCH] lib/bluetooth : Fix implicit pointer cast
From: Masaki Waga <masakiwaga@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implicit cast void* to uint8_t* is invalid in C++, so add explicit cast.

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 6ca64b6..3367315 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -345,8 +345,8 @@ typedef struct {

 static inline void bswap_128(const void *src, void *dst)
 {
- const uint8_t *s = src;
- uint8_t *d = dst;
+ const uint8_t *s = (uint8_t*) src;
+ uint8_t *d = (uint8_t*) dst;
  int i;

  for (i = 0; i < 16; i++)
