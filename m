Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 2/8] client: fix obc_session_get_buffer
Date: Tue, 21 Feb 2012 14:57:06 +0100
Message-Id: <1329832632-3681-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Size 0 should be reported if no transfer exists. Some existing code
relies on this behavior.
---
 client/session.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index 85f466a..e113d1f 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1128,8 +1128,12 @@ const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
 	const char *buf;
 
 	transfer = obc_session_get_transfer(session);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		if (size != NULL)
+			*size = 0;
+
 		return NULL;
+	}
 
 	buf = obc_transfer_get_buffer(transfer, size);
 
-- 
1.7.6.5

