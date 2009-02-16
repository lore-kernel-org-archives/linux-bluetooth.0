Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH] sbc: provide implementation info as a readable string
Date: Mon, 16 Feb 2009 15:59:51 +0200
Message-Id: <1234792791-5797-1-git-send-email-marcandre.lureau@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is mainly useful for logging and debugging.
---
 sbc/sbc.c                 |   14 ++++++++++++++
 sbc/sbc.h                 |    1 +
 sbc/sbc_primitives.c      |    1 +
 sbc/sbc_primitives.h      |    1 +
 sbc/sbc_primitives_mmx.c  |    1 +
 sbc/sbc_primitives_neon.c |    1 +
 6 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 29258d0..e2e7c61 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1221,6 +1221,20 @@ uint16_t sbc_get_codesize(sbc_t *sbc)
 	return subbands * blocks * channels * 2;
 }
 
+const char *sbc_get_implementation_info(sbc_t *sbc)
+{
+	struct sbc_priv *priv;
+
+	if (!sbc)
+		return NULL;
+
+	priv = sbc->priv;
+	if (!priv)
+		return NULL;
+
+	return priv->enc_state.implementation_info;
+}
+
 int sbc_reinit(sbc_t *sbc, unsigned long flags)
 {
 	struct sbc_priv *priv;
diff --git a/sbc/sbc.h b/sbc/sbc.h
index b0a1488..f9d506b 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -89,6 +89,7 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 int sbc_get_frame_length(sbc_t *sbc);
 int sbc_get_frame_duration(sbc_t *sbc);
 uint16_t sbc_get_codesize(sbc_t *sbc);
+const char *sbc_get_implementation_info(sbc_t *sbc);
 void sbc_finish(sbc_t *sbc);
 
 #ifdef __cplusplus
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 303f3fe..6b0be3f 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -456,6 +456,7 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 
 	/* Default implementation for scale factors calculation */
 	state->sbc_calc_scalefactors = sbc_calc_scalefactors;
+	state->implementation_info = "Generic C";
 
 	/* X86/AMD64 optimizations */
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 2708c82..3d01c11 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -62,6 +62,7 @@ struct sbc_encoder_state {
 	void (*sbc_calc_scalefactors)(int32_t sb_sample_f[16][2][8],
 			uint32_t scale_factor[2][8],
 			int blocks, int channels, int subbands);
+	const char *implementation_info;
 };
 
 /*
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 1870a9b..08e9ca2 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -313,6 +313,7 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 	if (check_mmx_support()) {
 		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
 		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+		state->implementation_info = "MMX";
 	}
 }
 
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index d9c12f9..f1bc7b4 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -240,6 +240,7 @@ void sbc_init_primitives_neon(struct sbc_encoder_state *state)
 {
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_neon;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_neon;
+	state->implementation_info = "NEON";
 }
 
 #endif
-- 
1.6.1.224.gb56c

