Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 10/13] lib: Add comment to BluetoothProfileDescriptorList parsing workaround
Date: Sun, 10 Feb 2013 17:26:34 -0400
Message-Id: <1360531597-3506-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commits 0f5a5a9580084a3c4e0644ef5cd75689aeb5ff40 and
46b3a3d2d00bf70bc57ef0c9ad5542a2271e3350 introduced this workaround.
---
 lib/sdp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index c5bc16e..a8a4010 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2091,6 +2091,11 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 		uint16_t version = 0x100;
 
 		if (SDP_IS_UUID(seq->dtd)) {
+			/* Mac OS X 10.7.3 and old Samsung phones do not comply
+			 * to the SDP specification for
+			 * BluetoothProfileDescriptorList. This workaround
+			 * allows to properly parse UUID/version from SDP
+			 * record published by these systems. */
 			sdp_data_t *next = seq->next;
 			uuid = &seq->val.uuid;
 			if (next && next->dtd == SDP_UINT16) {
-- 
1.7.9.5

