Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 3/8] Cancel pending callback if stream is canceled
Date: Fri, 26 Aug 2011 17:39:33 +0200
Message-Id: <1314373178-11337-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 8cbaeb4..c5f21e6 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -859,7 +859,27 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
 
 gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
 {
+	struct gateway *gw = dev->gateway;
+	GSList *l;
+	struct connect_cb *cb = NULL;
+
+	for (l = gw->callbacks; l != NULL; l = l->next) {
+		struct connect_cb *tmp = l->data;
+
+		if (tmp->id == id) {
+			cb = tmp;
+			break;
+		}
+	}
+
+	if (!cb)
+		return FALSE;
+
+	gw->callbacks = g_slist_remove(gw->callbacks, cb);
+	g_free(cb);
+
 	gateway_suspend_stream(dev);
+
 	return TRUE;
 }
 
-- 
1.7.1

