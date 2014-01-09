Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] sdp: Fix incorrect sizeof argument
Date: Thu,  9 Jan 2014 18:11:04 +0200
Message-Id: <1389283864-15135-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1389283864-15135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1389283864-15135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

length is a pointer to int table not int* table.
---
 lib/sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index cbdf15e..886e7cf 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4773,7 +4773,7 @@ int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
 			free(dtds);
 			goto fail;
 		}
-		lengths = malloc(plen * sizeof(int *));
+		lengths = malloc(plen * sizeof(int));
 		if (!lengths) {
 			free(dtds);
 			free(vals);
-- 
1.8.3.2

