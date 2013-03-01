Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 06/10] gatt: Handle errors when g_attrib_send() in gatt_discover_primary()
Date: Fri,  1 Mar 2013 20:22:29 -0300
Message-Id: <1362180153-11133-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To make the error handling clearer, it was introduced a reference
counting mechanism for the Discover Primary services procedure.
---
 attrib/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 44d3eb6..1f6360f 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -39,8 +39,10 @@
 
 struct discover_primary {
 	GAttrib *attrib;
+	int refs;
 	bt_uuid_t uuid;
 	GSList *primaries;
+	int err;
 	gatt_cb_t cb;
 	void *user_data;
 };
@@ -70,13 +72,33 @@ struct discover_char {
 	void *user_data;
 };
 
-static void discover_primary_free(struct discover_primary *dp)
+static struct discover_primary *discover_primary_ref(
+						struct discover_primary *dp)
 {
+	g_atomic_int_inc(&dp->refs);
+
+	return dp;
+}
+
+static void discover_primary_unref(struct discover_primary *dp)
+{
+	if (g_atomic_int_dec_and_test(&dp->refs) == FALSE)
+		return;
+
+	dp->cb(dp->primaries, dp->err, dp->user_data);
+
 	g_slist_free(dp->primaries);
 	g_attrib_unref(dp->attrib);
 	g_free(dp);
 }
 
+static void set_error(int *result, const int err)
+{
+	/* Do not overwrite errors */
+	if (*result == 0)
+		*result = err;
+}
+
 static struct included_discovery *isd_ref(struct included_discovery *isd)
 {
 	g_atomic_int_inc(&isd->refs);
@@ -179,12 +201,17 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	if (oplen == 0)
 		goto done;
 
-	g_attrib_send(dp->attrib, 0, buf, oplen, primary_by_uuid_cb, dp, NULL);
+	if (g_attrib_send(dp->attrib, 0, buf, oplen, primary_by_uuid_cb,
+				discover_primary_ref(dp), NULL) == 0) {
+		err = ATT_ECODE_ABORTED;
+		goto done;
+	}
+
 	return;
 
 done:
-	dp->cb(dp->primaries, err, dp->user_data);
-	discover_primary_free(dp);
+	set_error(&dp->err, err);
+	discover_primary_unref(dp);
 }
 
 static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
@@ -244,15 +271,18 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 								buf, buflen);
 
-		g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
-								dp, NULL);
+		if (g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
+					discover_primary_ref(dp), NULL) == 0) {
+			err = ATT_ECODE_ABORTED;
+			goto done;
+		}
 
 		return;
 	}
 
 done:
-	dp->cb(dp->primaries, err, dp->user_data);
-	discover_primary_free(dp);
+	set_error(&dp->err, err);
+	discover_primary_unref(dp);
 }
 
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
-- 
1.8.1.3

