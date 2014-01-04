Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 07/12] tools: Fix possible uninitialized variable in obexctl
Date: Fri,  3 Jan 2014 21:55:23 -0400
Message-Id: <1388800528-10699-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On set_default_session(), if g_dbus_proxy_get_property() returns FALSE,
desc will be uninitialized. Given that this function already checks for
NULL proxy internally, it is enough to check whether it fails (and if
so, set a default prompt without destination).

Fixes this clang error:

tools/obexctl.c:439:6: error: variable 'desc' is used uninitialized
whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
---
 tools/obexctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 2e38298..f0d5438 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -431,14 +431,12 @@ static void set_default_session(GDBusProxy *proxy)
 
 	default_session = proxy;
 
-	if (proxy == NULL) {
+	if (!g_dbus_proxy_get_property(proxy, "Destination", &iter)) {
 		desc = g_strdup(PROMPT_ON);
 		goto done;
 	}
 
-	if (g_dbus_proxy_get_property(proxy, "Destination", &iter))
-		dbus_message_iter_get_basic(&iter, &desc);
-
+	dbus_message_iter_get_basic(&iter, &desc);
 	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", desc);
 
 done:
-- 
1.8.3.2

