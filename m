Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/17] unit/test-avrcp: Use avrcp_list_player_values_rsp
Date: Mon, 17 Mar 2014 15:07:55 +0200
Message-Id: <1395061683-17206-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes list_values callback to use avrcp_list_player_values_rsp.
---
 unit/test-avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 4bca7b4..4bf9e47 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -330,7 +330,9 @@ static int list_values(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
-	return 1;
+	avrcp_list_player_values_rsp(session, transaction, 0, NULL);
+
+	return -EINVAL;
 }
 
 static int get_value_text(struct avrcp *session, uint8_t transaction,
-- 
1.8.5.3

