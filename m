Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] android/README: Update required kernel options
Date: Mon, 26 May 2014 17:03:45 +0200
Message-Id: <1401116627-28767-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
References: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CRYPTO support is required by gatt.
---
 android/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/README b/android/README
index 0895b71..91fc545 100644
--- a/android/README
+++ b/android/README
@@ -102,6 +102,10 @@ CONFIG_BT_BNEP_MC_FILTER
 CONFIG_BT_BNEP_PROTO_FILTER
 CONFIG_BRIDGE
 CONFIG_UHID
+CONFIG_CRYPTO_CMAC
+CONFIG_CRYPTO_USER_API
+CONFIG_CRYPTO_USER_API_HASH
+CONFIG_CRYPTO_USER_API_SKCIPHER
 
 Also BT chip driver needs to be enabled e.g:
 CONFIG_BT_HCIBTUSB
-- 
1.9.1

