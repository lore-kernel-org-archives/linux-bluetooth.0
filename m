Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP
Date: Sun,  3 Feb 2013 21:20:44 -0400
Message-Id: <1359940845-14451-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to SDP spec, the byte count fields for these PDUs have a valid
range of 0x0002-0xFFFF.
---
 lib/sdp.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index f3a0c17..e212c29 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4169,6 +4169,14 @@ int sdp_process(sdp_session_t *session)
 		rsp_count = bt_get_be16(pdata);
 		SDPDBG("Attrlist byte count : %d\n", rsp_count);
 
+		/* Valid range for rsp_count is 0x0002-0xFFFF */
+		if (rsp_count < 0x0002) {
+			t->err = EPROTO;
+			SDPERR("Protocol error: invalid AttrList size");
+			status = SDP_INVALID_PDU_SIZE;
+			goto end;
+		}
+
 		/*
 		 * Number of bytes in the AttributeLists parameter(without
 		 * continuation state) + AttributeListsByteCount field size.
-- 
1.7.9.5

