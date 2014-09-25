Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3] emulator/hciemu: Fix not handling failed read correctly
Date: Thu, 25 Sep 2014 16:32:38 +0200
Message-Id: <1411655558-18167-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If read failed due to signal or blocking watch was removed resulting
in closing /dev/vhci and emulated adapter being removed.

This was affecting android-tester since premature removal of adapter
is considered error on android daemon.
---
 emulator/hciemu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 50285e4..fcaeb70 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -179,6 +179,13 @@ static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
 	fd = g_io_channel_unix_get_fd(channel);
 
 	len = read(fd, buf, sizeof(buf));
+	if (len < 0) {
+		if (errno == EAGAIN || errno == EINTR)
+			return TRUE;
+
+		return FALSE;
+	}
+
 	if (len < 1)
 		return FALSE;
 
-- 
1.9.1

