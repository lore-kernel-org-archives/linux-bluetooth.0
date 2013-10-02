Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH bluez v2 2/2] bnep: improve error-msg if bnep.ko is not loaded
Date: Wed,  2 Oct 2013 17:57:31 +0200
Message-Id: <1380729451-2266-2-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1380729451-2266-1-git-send-email-dh.herrmann@gmail.com>
References: <1380729451-2266-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

bnep.ko, besides others, can be disabled in custom kernels if
network-support is not required. To avoid strange error messages, handle
EPROTONOSUPPORT as a special case and emit a warning that kernel support
is missing.
---
 profiles/network/common.c  |  7 ++++++-
 profiles/network/manager.c | 16 +++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/profiles/network/common.c b/profiles/network/common.c
index e069892..0b291bd 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -110,8 +110,13 @@ int bnep_init(void)
 
 	if (ctl < 0) {
 		int err = -errno;
-		error("Failed to open control socket: %s (%d)",
+
+		if (err == -EPROTONOSUPPORT)
+			warn("kernel lacks bnep-protocol support");
+		else
+			error("Failed to open control socket: %s (%d)",
 						strerror(-err), -err);
+
 		return err;
 	}
 
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 03b1b3d..6617687 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
@@ -169,11 +170,20 @@ static struct btd_profile nap_profile = {
 
 static int network_init(void)
 {
+	int err;
+
 	read_config(CONFIGDIR "/network.conf");
 
-	if (bnep_init()) {
-		error("Can't init bnep module");
-		return -1;
+	err = bnep_init();
+	if (err) {
+		if (err == -EPROTONOSUPPORT) {
+			info("bnep module not available, disabling plugin");
+			err = -ENOSYS;
+		} else {
+			error("Can't init bnep module");
+		}
+
+		return err;
 	}
 
 	/*
-- 
1.8.4
