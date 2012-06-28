Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 hcidump 2/4] a2mp: Fix number of triplet calculation
Date: Thu, 28 Jun 2012 16:09:20 +0300
Message-Id: <1340888962-18959-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340888962-18959-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338887361-11585-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1340888962-18959-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Country code is also included in the TLV size.
---
 parser/l2cap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 056e2a6..f6ed91d 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -1168,7 +1168,7 @@ static void a2mp_dump_chanlist(int level, struct a2mp_tlv *tlv, char *prefix)
 	struct a2mp_country_triplet *triplet;
 	int i, num;
 
-	num = tlv->len / sizeof(*triplet);
+	num = (tlv->len - sizeof(*chan_list)) / sizeof(*triplet);
 
 	printf("%s number of triplets %d\n", prefix, num);
 
-- 
1.7.9.5

