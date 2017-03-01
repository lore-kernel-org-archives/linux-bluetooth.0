Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, pgynther@google.com, luiz.dentz@gmail.com,
        Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH v2 3/3] hog: Optionally destroy uHID device when disconnected
Date: Tue, 28 Feb 2017 17:06:56 -0800
Message-Id: <1488330416-10463-4-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
References: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unlink bluetooth classic HID, HoG persists the uHID device after across
connections. This is fine for stateless devices that require fast reconnections
but some device utilize hidraw to configure them upon connection and with the
persisting uHID device, reconnections are hidden from them.

Similarly, applications such as game emulators may be using the presence of the
HID or the accompanying input event devices to indicate that it is available,
thus changing behavior.

This patch introduces a configuration option that, when set, destroys the uHID
device upon disconnection, it gets re-created upon reconnection, just like on
initial connection.
---
 profiles/input/hog-lib.c | 29 +++++++++++++++++++++++++++++
 profiles/input/hog-lib.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index dab385f..b2a371e 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -129,6 +129,13 @@ struct gatt_request {
 	void *user_data;
 };
 
+static bool uhid_destroy = false;
+
+void bt_hog_set_uhid_destroy(bool state)
+{
+	uhid_destroy = state;
+}
+
 static struct gatt_request *create_request(struct bt_hog *hog,
 							void *user_data)
 {
@@ -1565,6 +1572,25 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
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
@@ -1651,6 +1677,9 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
+
+	if (uhid_destroy)
+		destroy_uhid(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
index 415dc63..de8c42f 100644
--- a/profiles/input/hog-lib.h
+++ b/profiles/input/hog-lib.h
@@ -39,3 +39,4 @@ void bt_hog_detach(struct bt_hog *hog);
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
 int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
+void bt_hog_set_uhid_destroy(bool state);
-- 
2.7.4

