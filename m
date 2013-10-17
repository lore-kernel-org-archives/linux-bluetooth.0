Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 8/9] android: Fix build error when compiling with autotools
Date: Thu, 17 Oct 2013 11:55:27 +0300
Message-Id: <1382000128-23762-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

android/hal_bt_sock.c:82:21: error: no previous declaration for 'bt_get_sock_interface' [-Werror=missing-declarations]
 btsock_interface_t *bt_get_sock_interface(void)
---
 android/hal_bt_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
index 318c9c9..2a59e7e 100644
--- a/android/hal_bt_sock.c
+++ b/android/hal_bt_sock.c
@@ -23,6 +23,8 @@
 #define LOG_TAG "BlueZ"
 #include <cutils/log.h>
 
+#include "hal.h"
+
 static bt_status_t btsock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
-- 
1.8.3.1

