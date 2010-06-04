Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 27/32] Change function name when retreiving remote SDP records
Date: Fri,  4 Jun 2010 10:30:20 +0200
Message-Id: <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
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
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index a480b8e..bb03ffa 100644
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

