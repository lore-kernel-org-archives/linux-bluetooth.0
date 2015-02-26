Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12] profiles/network: Remove not needed get name by bnep id function
Date: Thu, 26 Feb 2015 12:53:33 +0100
Message-Id: <1424951614-8527-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function and service structure declaration is no longer needed
since related code was distracted.
---
 profiles/network/bnep.c | 21 ---------------------
 profiles/network/bnep.h |  2 --
 2 files changed, 23 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 0a73e54..7ec166c 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -54,17 +54,6 @@
 
 static int ctl;
 
-static struct {
-	const char	*name;		/* Friendly name */
-	const char	*uuid128;	/* UUID 128 */
-	uint16_t	id;		/* Service class identifier */
-} __svc[] = {
-	{ "panu",	PANU_UUID,	BNEP_SVC_PANU	},
-	{ "gn",		GN_UUID,	BNEP_SVC_GN	},
-	{ "nap",	NAP_UUID,	BNEP_SVC_NAP	},
-	{ NULL }
-};
-
 struct __service_16 {
 	uint16_t dst;
 	uint16_t src;
@@ -85,16 +74,6 @@ struct bnep {
 	void	*disconn_data;
 };
 
-const char *bnep_name(uint16_t id)
-{
-	int i;
-
-	for (i = 0; __svc[i].name; i++)
-		if (__svc[i].id == id)
-			return __svc[i].name;
-	return NULL;
-}
-
 int bnep_init(void)
 {
 	ctl = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_BNEP);
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 21a09f6..31f9b67 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -26,8 +26,6 @@ struct bnep;
 int bnep_init(void);
 int bnep_cleanup(void);
 
-const char *bnep_name(uint16_t id);
-
 struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
 								char *iface);
 void bnep_free(struct bnep *session);
-- 
2.1.0

