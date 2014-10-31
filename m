Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 7/7] monitor/rfcomm: Add rfcomm file in Android.mk
Date: Fri, 31 Oct 2014 20:38:34 +0530
Message-id: <1414768114-3775-8-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
References: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/Android.mk b/android/Android.mk
index aefe41c..eebd863 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -289,6 +289,7 @@ LOCAL_SRC_FILES := \
 	bluez/monitor/packet.c \
 	bluez/monitor/l2cap.c \
 	bluez/monitor/avctp.c \
+	bluez/monitor/rfcomm.c \
 	bluez/monitor/uuid.c \
 	bluez/monitor/sdp.c \
 	bluez/monitor/vendor.c \
-- 
1.9.1

