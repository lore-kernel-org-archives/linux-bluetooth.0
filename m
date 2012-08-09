Return-Path: <cyrus@holtmann.org>
From: Ludek Finstrle <luf@pzkagis.cz>
To: linux-bluetooth@vger.kernel.org
Cc: Ludek Finstrle <luf@pzkagis.cz>
Subject: [PATCH] irmc: Fix possible memory leak in handling of location
Date: Thu,  9 Aug 2012 11:01:55 +0200
Message-Id: <1344502915-487-1-git-send-email-luf@pzkagis.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/irmc.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 2a8c543..0a0dc93 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -401,6 +401,7 @@ static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
 {
 	struct irmc_session *irmc = context;
 	int ret = 0;
+	void *retp = NULL
 	char *path;
 
 	DBG("name %s context %p", name, context);
@@ -422,22 +423,26 @@ static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
 		path = g_build_filename("/", name, NULL);
 
 	if (g_str_equal(path, PB_DEVINFO))
-		return irmc_open_devinfo(irmc, err);
+		retp = irmc_open_devinfo(irmc, err);
 	else if (g_str_equal(path, PB_CONTACTS))
-		return irmc_open_pb(irmc, err);
+		retp = irmc_open_pb(irmc, err);
 	else if (g_str_equal(path, PB_INFO_LOG))
-		return irmc_open_info(irmc, err);
+		retp = irmc_open_info(irmc, err);
 	else if (g_str_equal(path, PB_CC_LOG))
-		return irmc_open_cc(irmc, err);
+		retp = irmc_open_cc(irmc, err);
 	else if (g_str_has_prefix(path, PB_CALENDAR_FOLDER))
-		return irmc_open_cal(irmc, err);
+		retp = irmc_open_cal(irmc, err);
 	else if (g_str_has_prefix(path, PB_NOTES_FOLDER))
-		return irmc_open_nt(irmc, err);
+		retp = irmc_open_nt(irmc, err);
 	else if (g_str_has_prefix(path, PB_LUID_FOLDER))
-		return irmc_open_luid(irmc, err);
+		retp = irmc_open_luid(irmc, err);
 	else
 		ret = -EBADR;
 
+	g_free(path);
+	if (retp)
+		return retp;
+
 fail:
 	if (err)
 		*err = ret;
-- 
1.7.1

