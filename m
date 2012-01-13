Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd] client: Remove unused code in pbap
Date: Fri, 13 Jan 2012 19:47:50 +0530
Message-id: <1326464270-20110-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/pbap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 9e9eb05..73d496a 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -364,7 +364,6 @@ static void read_return_apparam(struct obc_session *session,
 {
 	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct obc_transfer_params params;
-	unsigned char *buf;
 	size_t size = 0;
 
 	*phone_book_size = 0;
@@ -404,7 +403,6 @@ static void read_return_apparam(struct obc_session *session,
 					hdr->tag, hdr->len);
 		}
 
-		buf += APPARAM_HDR_SIZE + hdr->len;
 		size -= APPARAM_HDR_SIZE + hdr->len;
 	}
 }
-- 
1.7.4.1

