Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 09/16] sbc: Use plain C primitive if doing msbc on neon
Date: Thu, 28 Mar 2013 11:18:56 +0100
Message-Id: <1364465943-959-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

neon has it's own optimized input reordering. Until this code gets optimized,
the neon assembly code will not work with the mSBC input reordering.
However, the plain C version of mSBC can be used in this case.
This patch makes use of plain C code if the block increment is 1 which is
typical for mSBC.
---
 sbc/sbc_primitives.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index d85ea86..2f144b4 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -569,5 +569,13 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 #endif
 #ifdef SBC_BUILD_WITH_NEON_SUPPORT
 	sbc_init_primitives_neon(state);
+
+	if (state->increment == 1) {
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_simd;
+		state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
+		state->sbc_enc_process_input_4s_be = sbc_enc_process_input_4s_be;
+		state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le;
+		state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be;
+	}
 #endif
 }
-- 
1.7.9.5

