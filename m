Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 04/15] shared/att: cancel_all before calling disconnect cb
Date: Mon,  8 Dec 2014 16:40:44 -0800
Message-Id: <1418085655-7304-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved the call to bt_att_cancel_all to before the call to the registered
disconnect callbacks in bt_att's internal disconnect handler to make
sure that all affected user_data is destroyed. This is to prevent cases
of invalid access, where a user_data destroy function refers to data
that the upper layer might free in the disconnect callback.
---
 src/shared/att.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 9511bb2..fc8c598 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -554,6 +554,8 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	util_debug(att->debug_callback, att->debug_data,
 						"Physical link disconnected");
 
+	bt_att_cancel_all(att);
+
 	bt_att_ref(att);
 	att->in_disconn = true;
 	queue_foreach(att->disconn_list, disconn_handler, NULL);
@@ -565,9 +567,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
 		att->need_disconn_cleanup = false;
 	}
 
-	bt_att_cancel_all(att);
 	bt_att_unregister_all(att);
-
 	bt_att_unref(att);
 
 	return false;
-- 
2.2.0.rc0.207.ga3a616c

