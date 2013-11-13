Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/3] audio/A2DP: Set profile .local_uuid properly
Date: Wed, 13 Nov 2013 10:53:32 +0200
Message-Id: <1384332813-7891-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With the changes to the core now it does a strict match of adapter
profiles with .local_uuid to prevent connecting to profiles not
enabled in SDP.
---
 profiles/audio/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6b3d6b2..0a347e5 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2008,6 +2008,7 @@ static struct btd_profile a2dp_source_profile = {
 	.name		= "a2dp-source",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 
+	.local_uuid	= A2DP_SINK_UUID,
 	.remote_uuid	= A2DP_SOURCE_UUID,
 	.device_probe	= a2dp_source_probe,
 	.device_remove	= a2dp_source_remove,
@@ -2024,6 +2025,7 @@ static struct btd_profile a2dp_sink_profile = {
 	.name		= "a2dp-sink",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 
+	.local_uuid	= A2DP_SOURCE_UUID,
 	.remote_uuid	= A2DP_SINK_UUID,
 	.device_probe	= a2dp_sink_probe,
 	.device_remove	= a2dp_sink_remove,
-- 
1.8.3.1

