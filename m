Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] profile: Fix error message in ext_auth
Date: Thu,  1 Aug 2013 16:12:58 +0200
Message-Id: <1375366378-20689-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/profile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index 4a980f2..90c3535 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1010,7 +1010,7 @@ static void ext_auth(DBusError *err, void *user_data)
 	bt_io_get(conn->io, &gerr, BT_IO_OPT_DEST, addr, BT_IO_OPT_INVALID);
 	if (gerr != NULL) {
 		error("Unable to get connect data for %s: %s",
-						ext->name, err->message);
+						ext->name, gerr->message);
 		g_error_free(gerr);
 		goto drop;
 	}
-- 
1.7.9.5

