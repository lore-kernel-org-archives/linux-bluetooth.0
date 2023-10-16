Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8519BCDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 06:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJPGkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJPGkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 02:40:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20DA97
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Oct 2023 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697438419; x=1728974419;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Crv0Ji7lShfM23NNzUTmYwmGamBhPZNXRYfwpLRfE38=;
  b=Anezgh0lr4YV/b6D+1eKcU/ZVoYoRLtNTDEkuAr8LnDutAzN8HdQ4/Wr
   u9KSV90J1QlSVn/39POzblOmqoOlo4SDQwbNg4K9Knuawn6fNfD5w8XiX
   RXKcSDcTfhzTFoy5GxlVkYA6BG5ibYHKm4I+tgOvcdR1PWtEjoZnmXL5Q
   hv/I7apGRrmbMyPR1OFqG6sJtkKwLE9ltrEauKuGs/+MRaTz3OB2uWP7g
   lXZCLeOn4Kj0jLvG1MBXlqhHIdXSzlVCSC2wVXdcCDpo2AOka5b9EBq3c
   CcT0oR5LqOL2By2rdylX8AK1IyrjzkocxnG17s81AUCEKJHYTcbYtlISF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382682013"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="382682013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929246525"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929246525"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2023 23:40:17 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH 1/2] profiles: Add support for Audio Locations
Date:   Mon, 16 Oct 2023 12:22:27 +0530
Message-Id: <20231016065228.424400-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support to provide Audio Locations for BAP Sink and Source Endpoints
---
 profiles/audio/media.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 1d98ac5a1a70..51e3ab65d12d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -99,6 +99,7 @@ struct media_endpoint {
 	size_t			size;		/* Endpoint capabilities size */
 	uint8_t                 *metadata;      /* Endpoint property metadata */
 	size_t                  metadata_size;  /* Endpoint metadata size */
+	uint32_t		location;	/* Endpoint location */
 	guint			hs_watch;
 	guint			ag_watch;
 	guint			watch;
@@ -1445,6 +1446,7 @@ media_endpoint_create(struct media_adapter *adapter,
 						int size,
 						uint8_t *metadata,
 						int metadata_size,
+						uint32_t location,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1460,6 +1462,7 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->cid = cid;
 	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
+	endpoint->location = location;
 
 	if (qos)
 		endpoint->qos = *qos;
@@ -1525,7 +1528,8 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				uint16_t *cid, uint16_t *vid,
 				struct bt_bap_pac_qos *qos,
 				uint8_t **capabilities, int *size,
-				uint8_t **metadata, int *metadata_size)
+				uint8_t **metadata, int *metadata_size,
+				uint32_t *location)
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
@@ -1609,6 +1613,10 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->ppd_max);
+		} else if (strcasecmp(key, "Location") == 0) {
+			if (var != DBUS_TYPE_UINT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, location);
 		}
 
 		dbus_message_iter_next(props);
@@ -1633,6 +1641,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	int size = 0;
 	int metadata_size = 0;
 	int err;
+	uint32_t location;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -1650,12 +1659,12 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
 			&vid, &qos, &capabilities, &size, &metadata,
-			&metadata_size) < 0)
+			&metadata_size, &location) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
 					codec, cid, vid, &qos, capabilities,
-					size, metadata, metadata_size,
+					size, metadata, metadata_size, location,
 					&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
@@ -2688,6 +2697,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	int size = 0;
 	uint8_t *metadata = NULL;
 	int metadata_size = 0;
+	uint32_t location;
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
 
@@ -2748,6 +2758,13 @@ static void app_register_endpoint(void *data, void *user_data)
 						&metadata_size);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "Location", &iter))	{
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &location);
+	}
+
 	/* Parse QoS preferences */
 	memset(&qos, 0, sizeof(qos));
 	if (g_dbus_proxy_get_property(proxy, "Framing", &iter)) {
@@ -2804,7 +2821,7 @@ static void app_register_endpoint(void *data, void *user_data)
 						vendor.cid, vendor.vid, &qos,
 						capabilities, size,
 						metadata, metadata_size,
-						&app->err);
+						location, &app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
-- 
2.34.1

