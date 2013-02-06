Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH v2 4/5] hostname: Fix setting adapter name to empty string
Date: Wed,  6 Feb 2013 22:40:37 +0100
Message-Id: <1360186838-16904-4-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
References: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If pretty hostname is not set empty string is received. Don't update
adapters' names is such case.
---
 plugins/hostname.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 0b75fac..74c25df 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -117,6 +117,12 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 			DBG("pretty hostname: %s", str);
 
+			if (g_str_equal(str, "") == TRUE) {
+				g_free(pretty_hostname);
+				pretty_hostname = NULL;
+				return;
+			}
+
 			g_free(pretty_hostname);
 			pretty_hostname = g_strdup(str);
 
-- 
1.8.1.2

