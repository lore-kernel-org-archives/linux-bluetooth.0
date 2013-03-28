Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 04/16] sbc: add odd member variable to sbc_encoder_state
Date: Thu, 28 Mar 2013 11:18:51 +0100
Message-Id: <1364465943-959-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c                   |    1 +
 sbc/sbc_primitives.c        |    3 +++
 sbc/sbc_primitives.h        |    1 +
 sbc/sbc_primitives_armv6.c  |    1 +
 sbc/sbc_primitives_iwmmxt.c |    1 +
 sbc/sbc_primitives_mmx.c    |    1 +
 sbc/sbc_primitives_neon.c   |    1 +
 7 files changed, 9 insertions(+)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index ffdf05d..75b30a3 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -36,6 +36,7 @@
 #include <config.h>
 #endif
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index dce0ed2..cd16835 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
 #include <string.h>
@@ -521,6 +522,8 @@ static int sbc_calc_scalefactors_j(
  */
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
+	state->odd = true;
+
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4s = sbc_analyze_4b_4s_simd;
 	state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index e01c957..16f6c3b 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -40,6 +40,7 @@ struct sbc_encoder_state {
 	int position;
 	/* Number of consecutive blocks handled by the encoder */
 	uint8_t increment;
+	bool odd;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles "increment" blocks at once */
diff --git a/sbc/sbc_primitives_armv6.c b/sbc/sbc_primitives_armv6.c
index 068648a..dcc3ef4 100644
--- a/sbc/sbc_primitives_armv6.c
+++ b/sbc/sbc_primitives_armv6.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
 #include "sbc.h"
diff --git a/sbc/sbc_primitives_iwmmxt.c b/sbc/sbc_primitives_iwmmxt.c
index 0c8f329..247bb69 100644
--- a/sbc/sbc_primitives_iwmmxt.c
+++ b/sbc/sbc_primitives_iwmmxt.c
@@ -25,6 +25,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
 #include "sbc.h"
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 03070f5..d723b0c 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
 #include "sbc.h"
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index eda4ed3..46ac1fc 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
 #include "sbc.h"
-- 
1.7.9.5

