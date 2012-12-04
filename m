Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] profile: Remove not local variable needed in ext_connect
Date: Tue, 4 Dec 2012 11:15:24 +0100
Message-ID: <1354616124-10995-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354616124-10995-1-git-send-email-szymon.janc@tieto.com>
References: <1354616124-10995-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

src is not used anymore.
---
 src/profile.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index b98db36..a085ab2 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -763,11 +763,9 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 	struct ext_io *conn = user_data;
 	struct ext_profile *ext = conn->ext;
 	GError *io_err = NULL;
-	bdaddr_t src;
 	char addr[18];
 
 	if (!bt_io_get(io, &io_err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST, addr,
 				BT_IO_OPT_INVALID)) {
 		error("Unable to get connect data for %s: %s", ext->name,
-- 
1.7.9.5

