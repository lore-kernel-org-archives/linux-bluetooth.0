Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 19/32] Remove hdp_device pointer from health link struct
Date: Wed,  2 Jun 2010 15:19:15 +0200
Message-Id: <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |    6 +++---
 health/hdp_types.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 0a98118..70ffde5 100644
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

