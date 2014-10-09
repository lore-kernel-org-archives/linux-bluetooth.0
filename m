Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>
Subject: [PATCH 09/10] android/client: Add code for mce method
Date: Thu,  9 Oct 2014 14:45:13 +0200
Message-Id: <1412858714-2845-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>

This patch adds implementation of mce method to haltest.
---
 android/client/if-mce.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/client/if-mce.c b/android/client/if-mce.c
index c671fb2..76c9f73 100644
--- a/android/client/if-mce.c
+++ b/android/client/if-mce.c
@@ -58,6 +58,12 @@ static void init_p(int argc, const char **argv)
 
 static void get_remote_mas_instances_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_mce);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_mce->get_remote_mas_instances, &addr);
 }
 
 static struct method methods[] = {
-- 
1.9.3

