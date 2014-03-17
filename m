Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/17] unit/test-avrcp: Use avrcp_list_player_attributes_rsp
Date: Mon, 17 Mar 2014 15:07:51 +0200
Message-Id: <1395061683-17206-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes list_attributes callback to use
avrcp_list_player_attributes_rsp.
---
 unit/test-avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ed0c3fc..204d190 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -308,7 +308,9 @@ static int list_attributes(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
-	return 1;
+	avrcp_list_player_attributes_rsp(session, transaction, 0, NULL);
+
+	return -EAGAIN;
 }
 
 static int get_attribute_text(struct avrcp *session, uint8_t transaction,
-- 
1.8.5.3

