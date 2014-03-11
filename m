Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/handsfree: Fix list of HF features
Date: Tue, 11 Mar 2014 11:16:39 +0100
Message-Id: <1394532999-15744-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing Remote volume control feature
---
 android/handsfree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 0828de8..4f999e1 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -64,9 +64,10 @@
 #define HFP_HF_FEAT_3WAY	0x00000002
 #define HFP_HF_FEAT_CLI		0x00000004
 #define HFP_HF_FEAT_VR		0x00000008
-#define HFP_HF_FEAT_ECS		0x00000010
-#define HFP_HF_FEAT_ECC		0x00000020
-#define HFP_HF_FEAT_CODEC	0x00000040
+#define HFP_HF_FEAT_RVC		0x00000010
+#define HFP_HF_FEAT_ECS		0x00000020
+#define HFP_HF_FEAT_ECC		0x00000040
+#define HFP_HF_FEAT_CODEC	0x00000080
 
 #define HFP_AG_FEATURES ( HFP_AG_FEAT_3WAY | HFP_AG_FEAT_ECNR |\
 			HFP_AG_FEAT_VR | HFP_AG_FEAT_REJ_CALL |\
-- 
1.8.3.1

