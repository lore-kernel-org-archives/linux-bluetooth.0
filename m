Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC 1/2] sbc: Add sbc_reinit_a2dp
Date: Thu, 23 Jan 2014 14:20:23 +0200
Message-Id: <1390479624-5858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sbc_reinit_a2dp that can be used to reconfigure a previous
initialized sbc_t with new A2DP configuration.
---
 sbc/sbc.c | 49 +++++++++++++++++++++++++++++++++++--------------
 sbc/sbc.h |  2 ++
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 51bca55..534027e 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1087,19 +1087,14 @@ SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
 	return 0;
 }
 
-SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
+static int sbc_set_a2dp(sbc_t *sbc, unsigned long flags,
 					const void *conf, size_t conf_len)
 {
 	const struct a2dp_sbc *a2dp;
-	int err;
 
 	if (conf_len != sizeof(*a2dp))
 		return -EINVAL;
 
-	err = sbc_init(sbc, flags);
-	if (err < 0)
-		return err;
-
 	a2dp = conf;
 
 	switch (a2dp->frequency) {
@@ -1116,7 +1111,7 @@ SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 		sbc->frequency = SBC_FREQ_48000;
 		break;
 	default:
-		goto failed;
+		return -EINVAL;
 	}
 
 	switch (a2dp->channel_mode) {
@@ -1133,7 +1128,7 @@ SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 		sbc->mode = SBC_MODE_JOINT_STEREO;
 		break;
 	default:
-		goto failed;
+		return -EINVAL;
 	}
 
 	switch (a2dp->allocation_method) {
@@ -1144,7 +1139,7 @@ SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 		sbc->allocation = SBC_AM_LOUDNESS;
 		break;
 	default:
-		goto failed;
+		return -EINVAL;
 	}
 
 	switch (a2dp->subbands) {
@@ -1155,7 +1150,7 @@ SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 		sbc->subbands = SBC_SB_8;
 		break;
 	default:
-		goto failed;
+		return -EINVAL;
 	}
 
 	switch (a2dp->block_length) {
@@ -1172,14 +1167,40 @@ SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 		sbc->blocks = SBC_BLK_16;
 		break;
 	default:
-		goto failed;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
+					const void *conf, size_t conf_len)
+{
+	int err;
+
+	err = sbc_init(sbc, flags);
+	if (err < 0)
+		return err;
+
+	err = sbc_set_a2dp(sbc, flags, conf, conf_len);
+	if (err < 0) {
+		sbc_finish(sbc);
+		return err;
 	}
 
 	return 0;
+}
+
+int sbc_reinit_a2dp(sbc_t *sbc, unsigned long flags,
+					const void *conf, size_t conf_len)
+{
+	int err;
+
+	err = sbc_reinit(sbc, flags);
+	if (err < 0)
+		return err;
 
-failed:
-	sbc_finish(sbc);
-	return -EINVAL;
+	return sbc_set_a2dp(sbc, flags, conf, conf_len);
 }
 
 SBC_EXPORT ssize_t sbc_parse(sbc_t *sbc, const void *input, size_t input_len)
diff --git a/sbc/sbc.h b/sbc/sbc.h
index a542845..d6f123e 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -87,6 +87,8 @@ int sbc_reinit(sbc_t *sbc, unsigned long flags);
 int sbc_init_msbc(sbc_t *sbc, unsigned long flags);
 int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 					const void *conf, size_t conf_len);
+int sbc_reinit_a2dp(sbc_t *sbc, unsigned long flags,
+					const void *conf, size_t conf_len);
 
 ssize_t sbc_parse(sbc_t *sbc, const void *input, size_t input_len);
 
-- 
1.8.4.2

