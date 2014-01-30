Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 01/15] android/client-av: Fix checking for a2dp interface
Date: Thu, 30 Jan 2014 12:23:07 +0100
Message-Id: <1391081001-30723-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-av.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/client/if-av.c b/android/client/if-av.c
index 0470e0d..8d1f69b 100644
--- a/android/client/if-av.c
+++ b/android/client/if-av.c
@@ -80,7 +80,7 @@ static void connect_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
-	RETURN_IF_NULL(if_hh);
+	RETURN_IF_NULL(if_av);
 	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_av->connect, &addr);
@@ -101,7 +101,7 @@ static void disconnect_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
-	RETURN_IF_NULL(if_hh);
+	RETURN_IF_NULL(if_av);
 	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_av->disconnect, &addr);
-- 
1.8.5.2

