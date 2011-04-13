Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix unregistering a2dp sep while it is locked
Date: Wed, 13 Apr 2011 12:20:50 +0300
Message-Id: <1302686450-5961-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

If sep is locked it should not be unregistered until properly unlocked.
---
 audio/a2dp.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 719658b..fe627c1 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1741,6 +1741,9 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 		}
 	}
 
+	if (sep->locked)
+		return;
+
 	a2dp_unregister_sep(sep);
 }
 
@@ -2342,7 +2345,9 @@ gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 {
+	struct a2dp_server *server = sep->server;
 	avdtp_state_t state;
+	GSList *l;
 
 	state = avdtp_sep_get_state(sep->lsep);
 
@@ -2350,6 +2355,17 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 
 	DBG("SEP %p unlocked", sep->lsep);
 
+	if (sep->type == AVDTP_SEP_TYPE_SOURCE)
+		l = server->sources;
+	else
+		l = server->sinks;
+
+	/* Unregister sep if it was removed */
+	if (g_slist_find(l, sep) == NULL) {
+		a2dp_unregister_sep(sep);
+		return TRUE;
+	}
+
 	if (!sep->stream || state == AVDTP_STATE_IDLE)
 		return TRUE;
 
-- 
1.7.1

