Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 47/60] Random generation of first mdlid used as based to create data channels
Date: Thu, 22 Jul 2010 10:56:40 +0200
Message-Id: <1279789001-4587-29-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-28-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-12-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-13-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-14-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-15-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-16-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-17-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-18-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-19-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-20-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-21-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-22-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-23-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-24-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-25-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-26-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-27-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-28-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

Add random mdlid generation to avoid mdlid collisions when
two instances create a data channel at the same time.
---
 mcap/mcap.c          |   53 ++++++++++++++++++++++++++-----------------------
 mcap/mcap_internal.h |    1 +
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 3f3268b..f164e76 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -28,6 +28,7 @@
 #include "error.h"
 
 #include <netinet/in.h>
+#include <stdlib.h>
 
 #include "mcap.h"
 #include "mcap_lib.h"
@@ -358,24 +359,37 @@ static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	return sent;
 }
 
-static uint16_t generate_mdlid(struct mcap_mcl *mcl)
+static struct mcap_mdl *get_mdl(struct mcap_mcl *mcl, uint16_t mdlid)
 {
-	uint16_t mdlid = MCAP_MDLID_INITIAL;
-	struct mcap_mdl *mdl;
 	GSList *l;
+	struct mcap_mdl *mdl;
 
 	for (l = mcl->mdls; l; l = l->next) {
 		mdl = l->data;
-		if (mdlid < mdl->mdlid)
-			break;
-		else
-			mdlid = mdl->mdlid + 1;
+		if (mdlid == mdl->mdlid)
+			return mdl;
 	}
 
-	if (mdlid > MCAP_MDLID_FINAL)
-		return 0;
+	return NULL;
+}
+
+static uint16_t generate_mdlid(struct mcap_mcl *mcl)
+{
+	uint16_t mdlid = mcl->next_mdl;
+	struct mcap_mdl *mdl;
 
-	return mdlid;
+	do {
+		DBG("Testing %d", mdlid);
+		mdl = get_mdl(mcl, mdlid);
+		if (!mdl) {
+			mcl->next_mdl = (mdlid % MCAP_MDLID_FINAL) + 1;
+			return mdlid;
+		} else
+			mdlid = (mdlid % MCAP_MDLID_FINAL) + 1;
+	} while (mdlid != mcl->next_mdl);
+
+	/* No more mdlids availables */
+	return 0;
 }
 
 static uint8_t *create_req(uint8_t op, uint16_t mdl_id)
@@ -949,20 +963,6 @@ static void error_cmd_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	}
 }
 
-static struct mcap_mdl *get_mdl(struct mcap_mcl *mcl, uint16_t mdlid)
-{
-	GSList *l;
-	struct mcap_mdl *mdl;
-
-	for (l = mcl->mdls; l; l = l->next) {
-		mdl = l->data;
-		if (mdlid == mdl->mdlid)
-			return mdl;
-	}
-
-	return NULL;
-}
-
 static void mcap_delete_mdl(gpointer elem, gpointer user_data)
 {
 	struct mcap_mdl *mdl = elem;
@@ -1764,6 +1764,7 @@ void mcap_create_mcl(struct mcap_instance *ms,
 		mcl->state = MCL_IDLE;
 		bacpy(&mcl->addr, addr);
 		set_default_cb(mcl);
+		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
 		mcl = mcap_mcl_ref(mcl);
 	} else
 		mcl->ctrl |= MCAP_CTRL_CONN;
@@ -1899,6 +1900,7 @@ static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
 		mcl->ms = ms;
 		bacpy(&mcl->addr, &dst);
 		set_default_cb(mcl);
+		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
 		mcl = mcap_mcl_ref(mcl);
 	}
 
@@ -1983,7 +1985,8 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 		g_free(ms);
 		return NULL;
 	}
-
+	/* Initialize random seed to generate mdlids for this instance */
+	srand(time(NULL));
 	return ms;
 }
 
diff --git a/mcap/mcap_internal.h b/mcap/mcap_internal.h
index 3aaeed5..9dacc12 100644
--- a/mcap/mcap_internal.h
+++ b/mcap/mcap_internal.h
@@ -94,6 +94,7 @@ struct mcap_mcl {
 	uint8_t			*lcmd;		/* Last command sent */
 	guint			ref;		/* References counter */
 	uint8_t			ctrl;		/* MCL control flag */
+	uint16_t		next_mdl;	/* id used to create next MDL */
 };
 
 #define	MCAP_CTRL_CACHED	0x01	/* MCL is cached */
-- 
1.6.3.3

