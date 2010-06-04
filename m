Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 19/32] Remove hdp_device pointer from health link struct
Date: Fri,  4 Jun 2010 10:30:12 +0200
Message-Id: <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |    6 +++---
 health/hdp_types.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index eb673bd..234109a 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -391,9 +391,9 @@ static struct hdp_link *create_health_link(struct hdp_instance *hdpi,
 	if (*err)
 		return NULL;
 
-	if (g_dbus_register_interface(hdpl->dev->conn, hdpl->path, HEALTH_LINK,
-					health_link_methods, NULL, NULL,
-					hdpl, health_link_path_unregister))
+	if (g_dbus_register_interface(hdpl->hdpi->adapter->conn, hdpl->path,
+				HEALTH_LINK, health_link_methods,
+				NULL, NULL, hdpl, health_link_path_unregister))
 		return hdpl;
 
 	g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 05bfbfe..79419a1 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -104,7 +104,6 @@ struct hdp_instance {
 
 struct hdp_link {
 	struct hdp_instance	*hdpi;		/* HDP session */
-	struct hdp_device	*dev;		/* Health Device */
 	struct mcap_mcl 	*mcl;		/* MCAP mcl */
 	GSList			*channels;	/* Data channels */
 	char			*path;		/* HDP link path */
-- 
1.6.3.3

