Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: fix parsing of apparam on pbap driver
Date: Tue, 17 Jan 2012 12:15:09 +0200
Message-Id: <1326795309-27078-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both hdr and size need to be updated otherwise no parameters will be
parsed.
---
 client/pbap.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 9e9eb05..84465ac 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -364,8 +364,8 @@ static void read_return_apparam(struct obc_session *session,
 {
 	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct obc_transfer_params params;
-	unsigned char *buf;
-	size_t size = 0;
+	struct apparam_hdr *hdr;
+	size_t size;
 
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
@@ -376,9 +376,10 @@ static void read_return_apparam(struct obc_session *session,
 	if (params.size < APPARAM_HDR_SIZE)
 		return;
 
-	while (size > APPARAM_HDR_SIZE) {
-		struct apparam_hdr *hdr = (struct apparam_hdr *) params.data;
+	hdr = (struct apparam_hdr *) params.data;
+	size = params.size;
 
+	while (size > APPARAM_HDR_SIZE) {
 		if (hdr->len > size - APPARAM_HDR_SIZE) {
 			error("Unexpected PBAP pullphonebook app"
 					" length, tag %d, len %d",
@@ -404,7 +405,7 @@ static void read_return_apparam(struct obc_session *session,
 					hdr->tag, hdr->len);
 		}
 
-		buf += APPARAM_HDR_SIZE + hdr->len;
+		hdr += APPARAM_HDR_SIZE + hdr->len;
 		size -= APPARAM_HDR_SIZE + hdr->len;
 	}
 }
-- 
1.7.7.5

