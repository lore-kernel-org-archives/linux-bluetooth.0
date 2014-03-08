Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/20] android/handsfree: Add stubs for all AT commands defines by spec
Date: Sat,  8 Mar 2014 01:19:46 +0100
Message-Id: <1394238004-15691-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 3fc4487..c49a35b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -287,10 +287,190 @@ failed:
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
+static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
 static void register_post_slc_at(void)
 {
 	if (device.hsp) {
-		/* TODO CKPD */
+		hfp_gw_register(device.gw, at_cmd_ckpd, "+CKPD", NULL, NULL);
 		hfp_gw_register(device.gw, at_cmd_vgs_vgm, "+VGS",
 				GUINT_TO_POINTER(HAL_HANDSFREE_VOLUME_TYPE_SPEAKER),
 				NULL);
@@ -300,14 +480,31 @@ static void register_post_slc_at(void)
 		return;
 	}
 
-	hfp_gw_register(device.gw, at_cmd_bia, "+BIA", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_a, "A", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_d, "D", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_ccwa, "+CCWA", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_chup, "+CHUP", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_clcc, "+CLCC", NULL, NULL);
 	hfp_gw_register(device.gw, at_cmd_cops, "+COPS", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_cmee, "+CMEE", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_clip, "+CLIP", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_vts, "+VTS", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_cnum, "+CNUM", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_bia, "+BIA", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_binp, "+BINP", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_bldn, "+BLDN", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_bvra, "+BVRA", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_nrec, "+NREC", NULL, NULL);
 	hfp_gw_register(device.gw, at_cmd_vgs_vgm, "+VGS",
 			GUINT_TO_POINTER(HAL_HANDSFREE_VOLUME_TYPE_SPEAKER),
 			NULL);
 	hfp_gw_register(device.gw, at_cmd_vgs_vgm, "+VGM",
 			GUINT_TO_POINTER(HAL_HANDSFREE_VOLUME_TYPE_MIC),
 			NULL);
+	hfp_gw_register(device.gw, at_cmd_bsir, "+BSIR", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_btrh, "+BTRH", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_bcc, "+BCC", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_bcs, "+BCS", NULL, NULL);
 }
 
 static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
@@ -432,11 +629,33 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
+static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
+static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+							void *user_data)
+{
+	DBG("");
+
+	/* TODO */
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
+
 static void register_slc_at(void)
 {
 	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
 	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
 	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_chld, "+CHLD", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_bac, "+BAC", NULL, NULL);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-- 
1.8.5.3

