Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/11] core: Reuse --compat/-C switch for enabling deprecated interfaces
Date: Fri, 28 Dec 2012 14:51:06 +0200
Message-Id: <1356699069-5469-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 2e8ba34..f6c4ee6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -524,10 +524,12 @@ int main(int argc, char *argv[])
 	if (option_experimental)
 		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 
-	g_dbus_set_flags(gdbus_flags);
-
-	if (option_compat == TRUE)
+	if (option_compat == TRUE) {
 		sdp_flags |= SDP_SERVER_COMPAT;
+		gdbus_flags |= G_DBUS_FLAG_ENABLE_DEPRECATED;
+	}
+
+	g_dbus_set_flags(gdbus_flags);
 
 	start_sdp_server(sdp_mtu, sdp_flags);
 
-- 
1.8.0.1

