Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 09/16] sbc: Use simd primitive if doing msbc on neon
Date: Tue, 30 Oct 2012 10:39:28 +0100
Message-Id: <1351589975-22640-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index a4767ef..9311848 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -568,5 +568,8 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 #endif
 #ifdef SBC_BUILD_WITH_NEON_SUPPORT
 	sbc_init_primitives_neon(state);
+
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_simd;
 #endif
 }
-- 
1.7.9.5

