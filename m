Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v7 6/9] core: Disable unnecessary auto connections
Date: Tue, 25 Sep 2012 14:38:03 -0300
Message-Id: <1348594686-26221-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

BlueZ host disconnects the link when encryption fails. ECONNABORTED
error is returned by the kernel when the connection is terminated by the
local host. This scenario commonly happens when authentication fails due
PIN or Key Missing.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 5d92ff5..96d8b72 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1989,6 +1989,9 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
 	struct att_callbacks *attcb = user_data;
 	struct btd_device *device = attcb->user_data;
 
+	if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED))
+		return;
+
 	if (device->auto_connect == FALSE)
 		return;
 
-- 
1.7.11.4

