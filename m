Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, luiz.dentz@gmail.com,
        Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH] hog: Destroy uHID device when disconnected
Date: Mon, 27 Feb 2017 14:40:27 -0800
Message-Id: <1488235227-27632-2-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1488235227-27632-1-git-send-email-juha.kuikka@synapse.com>
References: <1488235227-27632-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unlink bluetooth classic HID, HoG persists the uHID device after across
connections. This is fine for stateless devices but some device utilize hidraw
to configure them upon connection and with the persisting uHID device,
reconnections are hidden from them.

Similarly, applications such as game emulators may be using the presence of the
HID or the accompanying input event devices to indicate that it is available,
thus changing behavior.

This patch destroys the uHID device upon disconnection, it gets re-created upon
reconnection, just like on initial connection.
---
 profiles/input/hog-lib.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index dab385f..f41055b 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1565,6 +1565,25 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	}
 }
 
+static void destroy_uhid(struct bt_hog *hog)
+{
+	struct uhid_event ev = {
+		.type = UHID_DESTROY
+	};
+	int err;
+
+	if (hog->uhid_created) {
+		err = bt_uhid_send(hog->uhid, &ev);
+		if (err < 0) {
+			error("bt_uhid_send: %s", strerror(-err));
+			return;
+		}
+		hog->uhid_created = false;
+
+		DBG("HoG destroyed uHID device");
+	}
+}
+
 bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 {
 	GSList *l;
@@ -1651,6 +1670,8 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
+
+	destroy_uhid(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
-- 
2.7.4

