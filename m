Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/13] android/hal-handsfree: Implement notifications handling
Date: Sun,  2 Feb 2014 22:09:15 +0100
Message-Id: <1391375364-27106-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements all notifications handlers and call proper HAL
callbacks.
---
 android/hal-handsfree.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 181e05f..6e11367 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -31,10 +32,167 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+static void handle_conn_state(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_conn_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state,
+						(bt_bdaddr_t *) (ev->bdaddr));
+}
+
+static void handle_audio_state(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_audio_state *ev = buf;
+
+	if (cbs->audio_state_cb)
+		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *) (ev->bdaddr));
+}
+
+static void handle_vr_state(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_vr_state *ev = buf;
+
+	if (cbs->vr_cmd_cb)
+		cbs->vr_cmd_cb(ev->state);
+}
+
+static void handle_answer(void *buf, uint16_t len)
+{
+	if (cbs->answer_call_cmd_cb)
+		cbs->answer_call_cmd_cb();
+}
+
+static void handle_hangup(void *buf, uint16_t len)
+{
+	if (cbs->hangup_call_cmd_cb)
+		cbs->hangup_call_cmd_cb();
+}
+
+static void handle_volume(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_volume *ev = buf;
+
+	if (cbs->volume_cmd_cb)
+		cbs->volume_cmd_cb(ev->type, ev->volume);
+}
+
+static void handle_dial(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_dial *ev = buf;
+
+	if (len != sizeof(*ev) + ev->number_len) {
+		error("invalid dial event, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (cbs->dial_call_cmd_cb)
+		cbs->dial_call_cmd_cb((char *) ev->number);
+}
+
+static void handle_dtmf(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_dtmf *ev = buf;
+
+	if (cbs->dtmf_cmd_cb)
+		cbs->dtmf_cmd_cb(ev->tone);
+}
+
+static void handle_nrec(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_nrec *ev = buf;
+
+	if (cbs->nrec_cmd_cb)
+		cbs->nrec_cmd_cb(ev->nrec);
+}
+
+static void handle_chld(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_chld *ev = buf;
+
+	if (cbs->chld_cmd_cb)
+		cbs->chld_cmd_cb(ev->chld);
+}
+
+static void handle_cnum(void *buf, uint16_t len)
+{
+	if (cbs->cnum_cmd_cb)
+		cbs->cnum_cmd_cb();
+}
+
+static void handle_cind(void *buf, uint16_t len)
+{
+	if (cbs->cind_cmd_cb)
+		cbs->cind_cmd_cb();
+}
+
+static void handle_cops(void *buf, uint16_t len)
+{
+	if (cbs->cops_cmd_cb)
+		cbs->cops_cmd_cb();
+}
+
+static void handle_clcc(void *buf, uint16_t len)
+{
+	if (cbs->clcc_cmd_cb)
+		cbs->clcc_cmd_cb();
+}
+
+static void handle_unknown_at(void *buf, uint16_t len)
+{
+	struct hal_ev_handsfree_unknown_at *ev = buf;
+
+	if (len != sizeof(*ev) + ev->len) {
+		error("invalid dial event, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (cbs->unknown_at_cmd_cb)
+		cbs->unknown_at_cmd_cb((char *) ev->buf);
+}
+
+static void handle_hsp_key_press(void *buf, uint16_t len)
+{
+	if (cbs->key_pressed_cmd_cb)
+		cbs->key_pressed_cmd_cb();
+}
+
 /* handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
 static const struct hal_ipc_handler ev_handlers[] = {
-
+	/* HAL_EV_HANDSFREE_CONN_STATE */
+	{handle_conn_state, false, sizeof(struct hal_ev_handsfree_conn_state)},
+	/* HAL_EV_HANDSFREE_AUDIO_STATE */
+	{handle_audio_state, false,
+				sizeof(struct hal_ev_handsfree_audio_state)},
+	/* HAL_EV_HANDSFREE_VR */
+	{handle_vr_state, false, sizeof(struct hal_ev_handsfree_vr_state)},
+	/*HAL_EV_HANDSFREE_ANSWER */
+	{handle_answer, false, 0},
+	/*HAL_EV_HANDSFREE_HANGUP */
+	{handle_hangup, false, 0},
+	/* HAL_EV_HANDSFREE_VOLUME */
+	{handle_volume, false, sizeof(struct hal_ev_handsfree_volume)},
+	/* HAL_EV_HANDSFREE_DIAL */
+	{handle_dial, true, sizeof(struct hal_ev_handsfree_dial)},
+	/* HAL_EV_HANDSFREE_DTMF */
+	{handle_dtmf, false, sizeof(struct hal_ev_handsfree_dtmf)},
+	/* HAL_EV_HANDSFREE_NREC */
+	{handle_nrec, false, sizeof(struct hal_ev_handsfree_nrec)},
+	/* HAL_EV_HANDSFREE_CHLD */
+	{handle_chld, false, sizeof(struct hal_ev_handsfree_chld)},
+	/* HAL_EV_HANDSFREE_CNUM */
+	{handle_cnum, false, 0},
+	/* HAL_EV_HANDSFREE_CIND */
+	{handle_cind, false, 0},
+	/* HAL_EV_HANDSFREE_COPS */
+	{handle_cops, false, 0},
+	/* HAL_EV_HANDSFREE_CLCC */
+	{handle_clcc, false, 0},
+	/* HAL_EV_HANDSFREE_UNKNOWN_AT */
+	{handle_unknown_at, true, sizeof(struct hal_ev_handsfree_unknown_at)},
+	/* HAL_EV_HANDSFREE_HSP_KEY_PRESS */
+	{handle_hsp_key_press, false, 0},
 };
 
 static bt_status_t init(bthf_callbacks_t *callbacks)
-- 
1.8.5.3

