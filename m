Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 5/5] android/hal: Add support for handling SSP request event
Date: Tue, 29 Oct 2013 12:52:42 +0100
Message-ID: <1383047562-4799-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
References: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a1a4ef4..f14fbb5 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -88,6 +88,18 @@ static void handle_pin_request(void *buf)
 		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev);
 }
 
+static void handle_ssp_request(void *buf)
+{
+	struct hal_ev_ssp_request *ev = buf;
+	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
+	bt_bdname_t *name = (bt_bdname_t *) ev->name;
+
+	if (bt_hal_cbacks->ssp_request_cb)
+		bt_hal_cbacks->ssp_request_cb(addr, name, ev->class_of_dev,
+							ev->pairing_variant,
+							ev->passkey);
+}
+
 void bt_thread_associate(void)
 {
 	if (bt_hal_cbacks->thread_evt_cb)
@@ -124,6 +136,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_PIN_REQUEST:
 		handle_pin_request(buf);
 		break;
+	case HAL_EV_SSP_REQUEST:
+		handle_ssp_request(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.4.1

