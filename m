Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] profile: Fix possible NULL pointer dereference
Date: Tue, 4 Dec 2012 11:15:23 +0100
Message-ID: <1354616124-10995-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If send_new_connection failed NULL err pointer would be dereferenced.
---
 src/profile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index c9ff553..b98db36 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -800,7 +800,7 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 
 drop:
 	if (conn->cb) {
-		conn->cb(&ext->p, conn->device, -err->code);
+		conn->cb(&ext->p, conn->device, err ? -err->code : -EIO);
 		conn->cb = NULL;
 	}
 	if (io_err)
-- 
1.7.9.5

