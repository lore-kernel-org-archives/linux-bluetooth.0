Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/7] shared/gatt: Fix incorrect data read
Date: Fri, 31 Oct 2014 09:52:00 +0100
Message-Id: <1414745523-31699-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data set in Find By Type Value response contains 4 octets,
2 for start handle and two for end group handle. Reading data
with offset 6 from end of pdu can cause illegal access.
---
 src/shared/gatt-helpers.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index d751d5a..6e19066 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -686,7 +686,13 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		op->result_tail = cur_result;
 	}
 
-	last_end = get_le16(pdu + length - 6);
+	/*
+	 * Each data set contains:
+	 * 2 octets with start handle
+	 * 2 octets with end handle
+	 * last_end is end handle of last data set
+	 */
+	last_end = get_le16(pdu + length - 2);
 	if (last_end < op->end_handle) {
 		uint8_t pdu[6 + get_uuid_len(&op->uuid)];
 
-- 
1.9.3

