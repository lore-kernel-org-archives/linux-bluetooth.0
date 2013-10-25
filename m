Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/15] android/hal: Add support for handling adapter properties change event
Date: Fri, 25 Oct 2013 10:56:16 +0200
Message-ID: <1382691378-31940-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index eb400ee..9c7fbea 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -35,6 +35,37 @@ static void handle_adapter_state_changed(void *buf)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
 
+static void handle_adapter_props_changed(void *buf, uint16_t len)
+{
+	struct hal_ev_adapter_props_changed *ev = buf;
+	bt_property_t props[ev->num_props];
+	struct hal_property *hal_prop;
+	void *p;
+	int i;
+
+	if (!bt_hal_cbacks->adapter_properties_cb)
+		return;
+
+	hal_prop = ev->props;
+	p = ev->props;
+
+	for (i = 0; i < ev->num_props; i++) {
+		if (p + sizeof(*hal_prop) + hal_prop->len > buf + len) {
+			error("invalid adapter properties event, aborting");
+			exit(EXIT_FAILURE);
+		}
+
+		props[i].type = hal_prop->type;
+		props[i].len = hal_prop->len;
+		props[i].val = hal_prop->val;
+
+		p += sizeof(*hal_prop) + hal_prop->len;
+		hal_prop = p;
+	}
+
+	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -45,6 +76,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_ADAPTER_STATE_CHANGED:
 		handle_adapter_state_changed(buf);
 		break;
+	case HAL_EV_ADAPTER_PROPS_CHANGED:
+		handle_adapter_props_changed(buf, len);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.4.1

