Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix closing stream of locked sep when reconfiguring
Date: Wed,  8 Sep 2010 18:13:43 +0300
Message-Id: <1283958823-4811-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Stream should only be closed if sep is unlocked otherwise there is a
possibility that sep reconfiguration is triggered although the sep is in
use by the user application.
---
 audio/a2dp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index b062aed..ef0df17 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1393,6 +1393,8 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 		}
 
 		if (l != NULL) {
+			if (a2dp_sep_get_lock(tmp))
+				goto failed;
 			setup->reconfigure = TRUE;
 			if (avdtp_close(session, tmp->stream, FALSE) < 0) {
 				error("avdtp_close failed");
-- 
1.7.0.4

