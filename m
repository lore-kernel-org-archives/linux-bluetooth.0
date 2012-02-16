Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 3/6] client: fix incorrect error check
Date: Thu, 16 Feb 2012 15:00:31 +0100
Message-Id: <1329400834-8400-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous statement always returned success.
---
 client/pbap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 4910536..4bb7a70 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -300,8 +300,8 @@ static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
 		return TRUE;
 	}
 
-	obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
-	if (err != NULL) {
+	if (obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap,
+									err)) {
 		g_free(pbap->path);
 		pbap->path = path;
 		return TRUE;
-- 
1.7.6.5

