Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix problem with operator name length
Date: Wed, 13 Oct 2010 14:49:30 +0200
Message-Id: <1286974170-12282-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To follow the HFP specification we must ensure that network operator name
will have at maximum 16 characters. In current implementation we do not
check this constraint. This patch fix this. Now operator name with more
than 16 characters will be truncated to 16 characters.
---
 audio/telephony-maemo6.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 1aac034..bbd2d2f 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1498,8 +1498,7 @@ static void update_operator_name(const char *name)
 		return;
 
 	g_free(net.operator_name);
-	net.operator_name = g_strdup(name);
-
+	net.operator_name = g_strndup(name, 16);
 	DBG("telephony-maemo6: operator name updated: %s", name);
 }
 
-- 
1.7.0.4

