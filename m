Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] L2CAP: add OBEX support
Date: Fri, 17 Feb 2012 11:48:54 +0200
Message-Id: <1329472135-14123-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/l2cap.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 696456a..fba530a 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -1090,6 +1090,14 @@ static void l2cap_parse(int level, struct frame *frm)
 					raw_dump(level + 1, frm);
 				break;
 
+			case SDP_UUID_OBEX:
+				if (!p_filter(FILT_OBEX))
+					obex_dump(level, frm);
+				else
+					raw_dump(level + 1, frm);
+				break;
+
+
 			default:
 				if (p_filter(FILT_L2CAP))
 					break;
-- 
1.7.7.6

