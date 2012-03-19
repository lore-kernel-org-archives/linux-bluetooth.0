Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] AVRCP: Add parsing support for Volume Change notification
Date: Mon, 19 Mar 2012 14:41:32 -0300
Message-Id: <1332178892-8987-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com>
References: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index d746937..9698934 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1198,6 +1198,10 @@ response:
 						value2str(attr, value));
 		}
 		break;
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		status = get_u8(frm);
+		printf("Volume: 0x%02x\n", status);
+		break;
 	}
 }
 
-- 
1.7.7.6

