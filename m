Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Don't register Device ID record on sdp server start
Date: Thu, 10 Oct 2013 11:38:49 +0200
Message-ID: <1381397929-7817-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381397344-7389-1-git-send-email-szymon.janc@tieto.com>
References: <1381397344-7389-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes SDP code no longer depends on main_opts. DID record is now
registered from main() after sdp server was started. This is OK since
mainloop is not yet running and record will be present when first
request comes.
---

v2 - commit message improved

 src/main.c        | 4 ++++
 src/sdpd-server.c | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/main.c b/src/main.c
index eafe2ed..91d90b4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -550,6 +550,10 @@ int main(int argc, char *argv[])
 
 	start_sdp_server(sdp_mtu, sdp_flags);
 
+	if (main_opts.did_source > 0)
+		register_device_id(main_opts.did_source, main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version);
+
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
 	 * best order of how to init various subsystems of the Bluetooth
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 10e46a1..b411abe 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -42,7 +42,6 @@
 
 #include <glib.h>
 
-#include "hcid.h"
 #include "log.h"
 #include "sdpd.h"
 
@@ -238,10 +237,6 @@ int start_sdp_server(uint16_t mtu, uint32_t flags)
 		return -1;
 	}
 
-	if (main_opts.did_source > 0)
-		register_device_id(main_opts.did_source, main_opts.did_vendor,
-				main_opts.did_product, main_opts.did_version);
-
 	io = g_io_channel_unix_new(l2cap_sock);
 	g_io_channel_set_close_on_unref(io, TRUE);
 
-- 
1.8.4

