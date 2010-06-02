Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 27/32] Change function name when retreiving remote SDP records
Date: Wed,  2 Jun 2010 15:19:23 +0200
Message-Id: <1275484768-25838-28-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
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
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 1d626d7..cd344d0 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -266,7 +266,7 @@ static void fill_up_health_instances(DBusMessageIter *dict, gpointer data)
 	}
 }
 
-static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
+static void health_records_found(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct instances_aux *cb_data = user_data;
 	DBusMessage *msg = cb_data->msg;
@@ -314,7 +314,7 @@ static DBusMessage *get_health_instances(DBusConnection *conn,
 
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(&src, &dst, &uuid, sink_health_instances,
+	if (bt_search_service(&src, &dst, &uuid, health_records_found,
 						cb_data, NULL) == 0)
 		return NULL;
 
-- 
1.6.3.3

