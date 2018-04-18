Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ankit Navik <ankit.p.navik@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] src/profile: Updates HFP version to 1.7
Date: Wed, 18 Apr 2018 15:29:21 +0530
Message-Id: <1524045561-14167-1-git-send-email-ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add changes to update HFP version to 0x0107 for HFP_HS_UUID and
HFP_AG_UUID.
---
 src/profile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 7c5318c..1e9c585 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1971,7 +1971,7 @@ static struct default_settings {
 		.authorize	= true,
 		.auto_connect	= true,
 		.get_record	= get_hfp_hf_record,
-		.version	= 0x0105,
+		.version	= 0x0107,
 	}, {
 		.uuid		= HFP_AG_UUID,
 		.name		= "Hands-Free Voice gateway",
@@ -1981,7 +1981,7 @@ static struct default_settings {
 		.authorize	= true,
 		.auto_connect	= true,
 		.get_record	= get_hfp_ag_record,
-		.version	= 0x0105,
+		.version	= 0x0107,
 	}, {
 		.uuid		= HSP_AG_UUID,
 		.name		= "Headset Voice gateway",
-- 
2.7.4

