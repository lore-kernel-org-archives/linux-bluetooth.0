Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 07/11] Add support for handing the New LTK mgmt event
Date: Tue, 17 Jan 2012 20:28:46 -0300
Message-Id: <1326842930-31623-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This event would cause this key to be permanently stored.
---
 plugins/mgmtops.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 6d98ad9..610bb72 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1386,6 +1386,38 @@ static void mgmt_device_unblocked(int sk, uint16_t index, void *buf, size_t len)
 	btd_event_device_unblocked(&info->bdaddr, &ev->bdaddr);
 }
 
+static void mgmt_new_ltk(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_ev_new_long_term_key *ev = buf;
+	struct controller_info *info;
+
+	if (len != sizeof(*ev)) {
+		error("new_smp_key event size mismatch (%zu != %zu)",
+							len, sizeof(*ev));
+		return;
+	}
+
+	DBG("Controller %u new LTK authenticated %u enc_size %u", index,
+				ev->key.authenticated, ev->key.enc_size);
+
+	if (index > max_index) {
+		error("Unexpected index %u in new_key event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	if (ev->store_hint) {
+		btd_event_ltk_notify(&info->bdaddr, &ev->key.addr.bdaddr,
+				ev->key.addr.type, ev->key.val,
+				ev->key.authenticated, ev->key.enc_size,
+				ev->key.master, ev->key.ediv, ev->key.rand);
+	}
+
+	if (ev->key.master)
+		bonding_complete(info, &ev->key.addr.bdaddr, 0);
+}
+
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
 	char buf[MGMT_BUF_SIZE];
@@ -1487,6 +1519,9 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	case MGMT_EV_USER_PASSKEY_REQUEST:
 		mgmt_passkey_request(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
+	case MGMT_EV_NEW_LONG_TERM_KEY:
+		mgmt_new_ltk(sk, index, buf + MGMT_HDR_SIZE, len);
+		break;
 	default:
 		error("Unknown Management opcode %u (index %u)", opcode, index);
 		break;
-- 
1.7.8.1

