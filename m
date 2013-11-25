Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 01/13] core: Export some symbols from libbluetooth
Date: Mon, 25 Nov 2013 22:15:40 +0000
Message-Id: <1385417752-25664-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are commonly used and should be available for external plugins.
---
 src/bluetooth.ver | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bluetooth.ver b/src/bluetooth.ver
index b71c70d..214fa8a 100644
--- a/src/bluetooth.ver
+++ b/src/bluetooth.ver
@@ -5,6 +5,8 @@
 		info;
 		error;
 		debug;
+		baswap;
+		ba2str;
 	local:
 		*;
 };
-- 
1.8.4.4

