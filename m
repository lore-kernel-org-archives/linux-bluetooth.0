Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pan: Initialize GError with NULL
Date: Mon, 20 Jan 2014 11:00:08 +0100
Message-Id: <1390212008-5376-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390212008-5376-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390212008-5376-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following issue:

bluetoothd[10552]: android/pan.c:register_nap_server()
bluetoothd[10552]: android/pan.c:nap_create_bridge() bnep
(bluetoothd:10552): GLib-WARNING **: GError set over the top of a previous GError or uninitialized memory.
This indicates a bug in someone's code. You must ensure an error is NULL before it's set.
The overwriting error message was: l2cap_bind: Address already in use (98)
bluetoothd[10552]: android/pan.c:destroy_nap_device()
---
 android/pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index dfd7762..3544d74 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -542,7 +542,7 @@ static void destroy_nap_device(void)
 
 static int register_nap_server(void)
 {
-	GError *gerr;
+	GError *gerr = NULL;
 	int err;
 
 	DBG("");
-- 
1.8.5.2

