Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] HDP: trivial: Fix redundant debug print
Date: Thu, 12 Jun 2014 15:07:37 +0300
Message-Id: <1402574857-8837-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/health/hdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index d511015..d256c9f 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -933,7 +933,8 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 	struct hdp_device *dev = data;
 	struct hdp_channel *chan;
 
-	DBG("hdp_mcap_mdl_connected_cb");
+	DBG("");
+
 	if (dev->ndc == NULL)
 		return;
 
-- 
1.8.3.2

