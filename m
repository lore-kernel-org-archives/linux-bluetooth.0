Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 3/5] Add parsing for ATT Write Command
Date: Wed, 23 Mar 2011 11:46:39 -0300
Message-Id: <1300891601-11412-3-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 6a1b1b5..b85ff0c 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -562,6 +562,7 @@ void att_dump(int level, struct frame *frm)
 			att_read_by_group_resp_dump(level + 1, frm);
 			break;
 		case ATT_OP_WRITE_REQ:
+		case ATT_OP_WRITE_CMD:
 			att_write_req_dump(level + 1, frm);
 			break;
 		case ATT_OP_HANDLE_NOTIFY:
-- 
1.7.1

