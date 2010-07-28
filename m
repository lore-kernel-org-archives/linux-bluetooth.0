Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 13/16] Add functions for getting mdl properties
Date: Wed, 28 Jul 2010 10:07:30 +0200
Message-Id: <1280304453-9328-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304232-2939-6-git-send-email-santoscadenas@gmail.com>
References: <1280304232-2939-6-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c     |   16 ++++++++++++++++
 health/mcap_lib.h |    3 +++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 050a896..df75752 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -635,6 +635,22 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 	return NULL;
 }
 
+int mcap_mdl_get_fd(struct mcap_mdl *mdl)
+{
+	if (!mdl || mdl->state != MDL_CONNECTED)
+		return -ENOTCONN;
+
+	return g_io_channel_unix_get_fd(mdl->dc);
+}
+
+uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl)
+{
+	if (!mdl)
+		return MCAP_MDLID_RESERVED;
+
+	return mdl->mdlid;
+}
+
 static void mcap_free_mdls(struct mcap_mcl *mcl, gboolean save)
 {
 	GSList *l;
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index b9fc9a5..b6286a1 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -127,6 +127,9 @@ void mcap_mdl_abort(struct mcap_mdl *mdl,
 				gpointer user_data,
 				GError **err);
 
+int mcap_mdl_get_fd(struct mcap_mdl *mdl);
+uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl);
+
 /* Mcl operations*/
 
 void mcap_create_mcl(struct mcap_instance *ms,
-- 
1.6.3.3

