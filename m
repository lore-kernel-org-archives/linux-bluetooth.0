Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH] btio: Fix uninitialized usage compilation error
Date: Fri, 31 Oct 2014 11:23:35 -0700
Message-Id: <1414779815-22862-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When compiling with --enable-maintainer-mode these throw
errors because of -Werror=maybe-uninitialized

---
 btio/btio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 6277507..4ec286c 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -970,7 +970,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 	struct l2cap_options l2o;
 	int flags;
 	uint8_t dev_class[3];
-	uint16_t handle;
+	uint16_t handle = 0;
 	socklen_t len;
 	gboolean flushable = FALSE, have_dst = FALSE;
 	uint32_t priority;
@@ -1180,7 +1180,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 	int flags;
 	socklen_t len;
 	uint8_t dev_class[3];
-	uint16_t handle;
+	uint16_t handle = 0;
 
 	if (!get_src(sock, &src, sizeof(src), err))
 		return FALSE;
@@ -1311,7 +1311,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	struct sco_options sco_opt;
 	socklen_t len;
 	uint8_t dev_class[3];
-	uint16_t handle;
+	uint16_t handle = 0;
 
 	len = sizeof(sco_opt);
 	memset(&sco_opt, 0, len);
-- 
2.1.0.rc2.206.gedb03e5

