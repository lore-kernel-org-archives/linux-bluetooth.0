Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 01/12] android/handsfree: Define proper type for device structure
Date: Wed,  8 Oct 2014 12:15:03 +0200
Message-Id: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a815d3b..0b82223 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -110,22 +110,7 @@ struct hfp_codec {
 	bool remote_supported;
 };
 
-static const struct indicator inds_defaults[] = {
-		{ "service",   0, 1, 0, false, true },
-		{ "call",      0, 1, 0, true, true },
-		{ "callsetup", 0, 3, 0, true, true },
-		{ "callheld",  0, 2, 0, true, true },
-		{ "signal",    0, 5, 0, false, true },
-		{ "roam",      0, 1, 0, false, true },
-		{ "battchg",   0, 5, 0, false, true },
-};
-
-static const struct hfp_codec codecs_defaults[] = {
-	{ CODEC_ID_CVSD, true, false},
-	{ CODEC_ID_MSBC, false, false},
-};
-
-static struct {
+struct hf_device {
 	bdaddr_t bdaddr;
 	uint8_t state;
 	uint8_t audio_state;
@@ -152,7 +137,24 @@ static struct {
 
 	GIOChannel *sco;
 	guint sco_watch;
-} device;
+};
+
+static const struct indicator inds_defaults[] = {
+		{ "service",   0, 1, 0, false, true },
+		{ "call",      0, 1, 0, true, true },
+		{ "callsetup", 0, 3, 0, true, true },
+		{ "callheld",  0, 2, 0, true, true },
+		{ "signal",    0, 5, 0, false, true },
+		{ "roam",      0, 1, 0, false, true },
+		{ "battchg",   0, 5, 0, false, true },
+};
+
+static const struct hfp_codec codecs_defaults[] = {
+	{ CODEC_ID_CVSD, true, false},
+	{ CODEC_ID_MSBC, false, false},
+};
+
+static struct hf_device device;
 
 static uint32_t hfp_ag_features = 0;
 
-- 
1.9.1

