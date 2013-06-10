Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/15] AVCTP: Fix coding style
Date: Mon, 10 Jun 2013 13:36:57 +0300
Message-Id: <1370860630-30359-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix unnecessary extra tabs
---
 profiles/audio/avctp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 314dbfb..46c5485 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -812,9 +812,8 @@ static void browsing_response(struct avctp_channel *browsing,
 		if (p->transaction != avctp->transaction)
 			continue;
 
-		if (req->func && req->func(browsing->session,
-						operands, operand_count,
-						req->user_data))
+		if (req->func && req->func(browsing->session, operands,
+						operand_count, req->user_data))
 			return;
 
 		browsing->processed = g_slist_remove(browsing->processed, p);
-- 
1.8.1.4

