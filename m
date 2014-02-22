Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] shared: Fix not marking writer as active in mgmt
Date: Sat, 22 Feb 2014 19:40:18 +0100
Message-Id: <1393094418-1416-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index ae90b89..bfc7258 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -209,8 +209,11 @@ static void wakeup_writer(struct mgmt *mgmt)
 	if (mgmt->writer_active)
 		return;
 
-	io_set_write_handler(mgmt->io, can_write_data, mgmt,
-						write_watch_destroy);
+	if (!io_set_write_handler(mgmt->io, can_write_data, mgmt,
+						write_watch_destroy))
+		return;
+
+	mgmt->writer_active = true;
 }
 
 struct opcode_index {
-- 
1.9.0

