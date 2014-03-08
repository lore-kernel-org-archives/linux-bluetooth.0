Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/20] android/handsfree: Add AG and HF features masks
Date: Sat,  8 Mar 2014 01:19:45 +0100
Message-Id: <1394238004-15691-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index dc5c73d..3fc4487 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -49,7 +49,28 @@
 #define HSP_AG_CHANNEL 12
 #define HFP_AG_CHANNEL 13
 
-#define HFP_AG_FEATURES 0
+#define HFP_AG_FEAT_3WAY	0x00000001
+#define HFP_AG_FEAT_ECNR	0x00000002
+#define HFP_AG_FEAT_VR		0x00000004
+#define HFP_AG_FEAT_INBAND	0x00000008
+#define HFP_AG_FEAT_VTAG	0x00000010
+#define HFP_AG_FEAT_REJ_CALL	0x00000020
+#define HFP_AG_FEAT_ECS		0x00000040
+#define HFP_AG_FEAT_ECC		0x00000080
+#define HFP_AG_FEAT_EXT_ERR	0x00000100
+#define HFP_AG_FEAT_CODEC	0x00000200
+
+#define HFP_HF_FEAT_ECNR	0x00000001
+#define HFP_HF_FEAT_3WAY	0x00000002
+#define HFP_HF_FEAT_CLI		0x00000004
+#define HFP_HF_FEAT_VR		0x00000008
+#define HFP_HF_FEAT_ECS		0x00000010
+#define HFP_HF_FEAT_ECC		0x00000020
+#define HFP_HF_FEAT_CODEC	0x00000040
+
+#define HFP_AG_FEATURES ( HFP_AG_FEAT_3WAY | HFP_AG_FEAT_ECNR |\
+			HFP_AG_FEAT_VR | HFP_AG_FEAT_REJ_CALL |\
+			HFP_AG_FEAT_ECS | HFP_AG_FEAT_EXT_ERR )
 
 /* offsets in indicators table, should be incremented when sending CIEV */
 #define IND_SERVICE	0
@@ -1150,7 +1171,13 @@ static sdp_record_t *hfp_ag_record(void)
 	proto[1] = sdp_list_append(proto[1], channel);
 	apseq = sdp_list_append(apseq, proto[1]);
 
-	sdpfeat = HFP_AG_FEATURES;
+	/* Codec Negotiation bit in SDP feature is different then in BRSF */
+	sdpfeat = HFP_AG_FEATURES & 0x0000003F;
+	if (HFP_AG_FEATURES & HFP_AG_FEAT_CODEC)
+		sdpfeat |= 0x00000020;
+	else
+		sdpfeat &= ~0x00000020;
+
 	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
 	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
-- 
1.8.5.3

