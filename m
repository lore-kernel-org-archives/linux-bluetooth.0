Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, pgynther@google.com, luiz.dentz@gmail.com,
        Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH v2 2/3] input: Add UHIDDestroy option into input.conf
Date: Tue, 28 Feb 2017 17:06:55 -0800
Message-Id: <1488330416-10463-3-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
References: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UHIDDestroy controls whether uHID device is destroyed on HID/HoG disconnect.
Defaults to false.
---
 profiles/input/input.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 3e1d65a..4a93e42 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -11,3 +11,7 @@
 # Enable HID protocol handling in userspace input profile
 # Defaults to false (HIDP handled in HIDP kernel module)
 #UserspaceHID=true
+
+# Destroy uHID device on HID/HoG disconnect
+# Defaults to false (uHID device is persistent across reconnects)
+#UHIDDestroy=true
-- 
2.7.4

