Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared/hciemu: Fix not handling failed read correctly
Date: Thu, 25 Sep 2014 12:38:34 +0200
Message-Id: <1411641514-5323-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If read failed due to signal or blocking watch was removed resulting
in closing /dev/vhci and emulated adapter being removed.

This was affecting android-tester since premature removal of adapter
is considered error on android daemon.
---
 src/shared/hciemu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 3892fea..c0b1eae 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -179,8 +179,12 @@ static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
 	fd = g_io_channel_unix_get_fd(channel);
 
 	len = read(fd, buf, sizeof(buf));
-	if (len < 1)
+	if (len < 1) {
+		if (len < 0 && (errno == EAGAIN || errno == EINTR))
+			return TRUE;
+
 		return FALSE;
+	}
 
 	switch (buf[0]) {
 	case BT_H4_CMD_PKT:
-- 
1.9.1

