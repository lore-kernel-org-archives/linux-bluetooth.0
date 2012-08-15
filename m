Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 13/14] core: Disable unnecessary auto connections
Date: Wed, 15 Aug 2012 11:50:52 -0300
Message-Id: <1345042253-15053-14-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
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
index 1d40bb8..f116fd7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1956,6 +1956,9 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
 	struct att_callbacks *attcb = user_data;
 	struct btd_device *device = attcb->user_data;
 
+	if (gerr->code == ECONNABORTED)
+		return;
+
 	if (device->auto_connect == FALSE)
 		return;
 
-- 
1.7.11.2

