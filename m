Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Show P-bit in the l2cap parser
Date: Mon, 12 Jul 2010 13:55:50 -0300
Message-Id: <1278953750-18646-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1278953750-18646-1-git-send-email-gustavo@padovan.org>
References: <1278953750-18646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/l2cap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 174cd3a..ee869dc 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -848,6 +848,8 @@ static void l2cap_parse(int level, struct frame *frm)
 				printf(" ReqSeq %d", (ctrl & 0x3f00) >> 8);
 				if (ctrl & 0x80)
 					printf(" F-bit");
+				if (ctrl & 0x10)
+					printf(" P-bit");
 				printf("\n");
 			}
 		}
-- 
1.7.1

