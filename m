Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 4/5] Bluetooth: Remove strtoba header declared but not define
Date: Thu, 12 Apr 2012 20:33:20 +0530
Message-id: <1334243001-17016-30-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 include/net/bluetooth/bluetooth.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f2c8bdf..d0e44a4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -178,7 +178,6 @@ static inline void bacpy(bdaddr_t *dst, bdaddr_t *src)
 
 void baswap(bdaddr_t *dst, bdaddr_t *src);
 char *batostr(bdaddr_t *ba);
-bdaddr_t *strtoba(char *str);
 
 /* Common socket structures and functions */
 
-- 
1.7.4.1

