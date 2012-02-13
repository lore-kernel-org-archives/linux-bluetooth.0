Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 3/6] client: fix incorrect error check
Date: Mon, 13 Feb 2012 15:39:02 +0100
Message-Id: <1329143945-4934-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous statement always returned success.
---
 client/pbap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 4910536..c58557d 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -301,7 +301,7 @@ static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
 	}
 
 	obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
-	if (err != NULL) {
+	if (*err == NULL) {
 		g_free(pbap->path);
 		pbap->path = path;
 		return TRUE;
-- 
1.7.6.5

