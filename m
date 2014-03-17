Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/17] unit/test-avrcp: Use avrcp_get_player_attribute_text_rsp
Date: Mon, 17 Mar 2014 15:07:53 +0200
Message-Id: <1395061683-17206-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes list_attributes callback to use
avrcp_get_player_attribute_text_rsp.
---
 unit/test-avrcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 204d190..4bca7b4 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -319,7 +319,10 @@ static int get_attribute_text(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
-	return 1;
+	avrcp_get_player_attribute_text_rsp(session, transaction, 0, NULL,
+									NULL);
+
+	return -EAGAIN;
 }
 
 static int list_values(struct avrcp *session, uint8_t transaction,
-- 
1.8.5.3

