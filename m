Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] audio/AVRCP: Fix not setting browsing feature in CT record
Date: Mon, 29 Jul 2013 17:04:35 +0300
Message-Id: <1375106679-14645-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
References: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The record already contain the additional protocol containing the
browsing channel but the feature is not set as it is supposed to.
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b2135c5..32b9615 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -270,7 +270,8 @@ static sdp_record_t *avrcp_ct_record(void)
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4 );
+						AVRCP_FEATURE_CATEGORY_4 |
+						AVRCP_FEATURE_BROWSING);
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.8.3.1

