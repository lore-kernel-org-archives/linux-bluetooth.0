Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] input: Fix signedness issue on POSIX error code usage
Date: Fri, 24 Aug 2012 17:03:49 -0400
Message-Id: <1345842229-11935-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By convention, error variables containing POSIX error code (usually
called "err") are negative. This commit fixes a couple of places where
positive values are expected.
---
 profiles/input/hog_device.c |    2 +-
 profiles/input/server.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 10c5a45..f0caac8 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -570,7 +570,7 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 	bread = read(fd, &ev, sizeof(ev));
 	if (bread < 0) {
 		int err = -errno;
-		DBG("uhid-dev read: %s(%d)", strerror(err), err);
+		DBG("uhid-dev read: %s(%d)", strerror(-err), -err);
 		goto failed;
 	}
 
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 86e2ac8..8965c4e 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -180,7 +180,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 
 	ba2str(&src, addr);
 	error("input: authorization for %s failed: %s (%d)",
-						addr, strerror(-ret), ret);
+						addr, strerror(-ret), -ret);
 
 	g_io_channel_unref(server->confirm);
 	server->confirm = NULL;
-- 
1.7.9.5

