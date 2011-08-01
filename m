Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 01/13] Don't parse response AVRCP pdu if ctype is NOT_IMPLETED
Date: Mon,  1 Aug 2011 11:42:06 +0300
Message-Id: <1312188138-32265-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index ff6862d..a1768e3 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -347,6 +347,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 		return;
 	}
 
+	if (ctype == AVC_CTYPE_NOT_IMPLEMENTED)
+		return;
+
 	switch (pduid) {
 	case AVRCP_GET_CAPABILITIES:
 		avrcp_get_capabilities_dump(level + 1, frm, len);
-- 
1.7.6

