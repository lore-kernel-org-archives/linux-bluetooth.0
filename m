Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3 v2] audio: Fix not using opposite role for local servers
Date: Thu,  7 Mar 2013 11:41:23 +0200
Message-Id: <1362649284-24335-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362649284-24335-1-git-send-email-luiz.dentz@gmail.com>
References: <1362649284-24335-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Local role should be the opposite of the remote role otherwise if either
audio-source or audio-sink is disabled none will work.
---
 profiles/audio/manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 42a2b58..f7ff751 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -331,8 +331,8 @@ static struct btd_profile a2dp_source_profile = {
 	.connect	= a2dp_source_connect,
 	.disconnect	= a2dp_source_disconnect,
 
-	.adapter_probe	= a2dp_source_server_probe,
-	.adapter_remove	= a2dp_source_server_remove,
+	.adapter_probe	= a2dp_sink_server_probe,
+	.adapter_remove	= a2dp_sink_server_remove,
 };
 
 static struct btd_profile a2dp_sink_profile = {
@@ -347,8 +347,8 @@ static struct btd_profile a2dp_sink_profile = {
 	.connect	= a2dp_sink_connect,
 	.disconnect	= a2dp_sink_disconnect,
 
-	.adapter_probe	= a2dp_sink_server_probe,
-	.adapter_remove	= a2dp_sink_server_remove,
+	.adapter_probe	= a2dp_source_server_probe,
+	.adapter_remove	= a2dp_source_server_remove,
 };
 
 static struct btd_profile avrcp_profile = {
-- 
1.8.1.4

