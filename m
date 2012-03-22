Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2 v1] AVRCP: Add parsing support for Volume Change notification
Date: Thu, 22 Mar 2012 16:04:43 -0300
Message-Id: <1332443083-9652-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1332443083-9652-1-git-send-email-luiz.dentz@gmail.com>
References: <1332443083-9652-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
v1: Print volume in percentage

 parser/avrcp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index a6d09c9..850741b 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1198,6 +1198,10 @@ response:
 						value2str(attr, value));
 		}
 		break;
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		status = get_u8(frm) & 0x7F;
+		printf("Volume: %.2f%% (%d/127)\n", status/1.27, status);
+		break;
 	}
 }
 
-- 
1.7.7.6

