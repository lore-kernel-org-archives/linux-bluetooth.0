Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 34/39] android/hf-client: Add Subscriber Info event
Date: Tue,  9 Sep 2014 21:57:19 +0200
Message-Id: <1410292644-23497-35-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 22 ++++++++++++++++++++++
 android/hal-msg.h       | 11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index c4a4943..82d9b56 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -217,6 +217,25 @@ static void handle_command_cmp(void *buf, uint16_t len, int fd)
 		cbs->cmd_complete_cb(ev->type, ev->cme);
 }
 
+static void handle_subscriber_info(void *buf, uint16_t len, int fd)
+{
+	const struct hal_ev_hf_client_subscriber_service_info *ev = buf;
+	uint16_t name_len = ev->name_len;
+	char *name = NULL;
+
+	if (len != sizeof(*ev) + name_len ||
+		(name_len != 0 && ev->name[name_len - 1] != '\0')) {
+		error("invalid sunscriber info, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (name_len)
+		name = (char *) ev->name;
+
+	if (cbs->subscriber_info_cb)
+		cbs->subscriber_info_cb(name, ev->type);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -272,6 +291,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_CLIENT_COMMAND_COMPLETE */
 	{ handle_command_cmp, false,
 			sizeof(struct hal_ev_hf_client_command_complete) },
+	/* HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO */
+	{ handle_subscriber_info, true,
+		sizeof(struct hal_ev_hf_client_subscriber_service_info) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b88da52..85671a5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1845,3 +1845,14 @@ struct hal_ev_hf_client_command_complete {
 	uint8_t type;
 	uint8_t cme;
 } __attribute__((packed));
+
+#define HF_CLIENT_SUBSCRIBER_TYPE_UNKNOWN	0x00
+#define HF_CLIENT_SUBSCRIBER_TYPE_VOICE		0x01
+#define HF_CLIENT_SUBSCRIBER_TYPE_FAX		0x02
+
+#define HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO		0x92
+struct hal_ev_hf_client_subscriber_service_info {
+	uint8_t type;
+	uint16_t name_len;
+	uint8_t name[0];
+} __attribute__((packed));
-- 
1.8.4

