Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A9C18E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE10420678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vlowylyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgDAWOu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:14:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40256 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbgDAWOt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 18:14:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so537396plk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ImDv9zhDYlZCVg2ESXGVGfLitxeb2BWAs2xQefNJC4=;
        b=VlowylyfuOJGXMvS8/IFhM4NVn1RLE8M3NPWhsXKvPhE8XjHGszd6P81gFwtRwhO3G
         SfZdUUUm1R3JB3mCN30DXO+soaunEgptYDsJ3fuL9WL3vjZ+sBc6fxNk/5bz+jqS7LDu
         di0Qq1fbqCOycztRO8sKXxgpGOY5AoVTQgNjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ImDv9zhDYlZCVg2ESXGVGfLitxeb2BWAs2xQefNJC4=;
        b=kQMModYXdUP6VoeW7SNqxFYxYElAAJ5iP7LcpmJWMw/kQ7VwdscHLtE6/NXHCJFuVk
         /1llcI4w3bSyyKSx/n3i7i2DWqlL9Ja6tCal2xn987ylKfBS2Vxanp+JLn85tVKtqtzV
         TY8GO9/FPi6cIUlpOZsRL6Mc6e6UyjsCzadWI12D6JB1ed0qYVIx8RJxURdtQIfHqlXc
         u2hgZyRFwiYGpJ23+PK5jutC30be8iwlKGnEVeuA6XCwfprrCUvJ0pobjK8xpictXZ8G
         SeMvPzi9ONXRCPemIg04+mDK1vom6PgqZfT6aW9T91ShHoFXAw7CNVkN6Hr3m/Cm13zK
         hChw==
X-Gm-Message-State: AGi0PuawyUxULrVPfJl2UF96fRlDIqagpMYZ3Jeb0tVpwJqrJtGKcS5p
        dqub6ROGkvlBdRiztFnkjj7vqd9pJ+o=
X-Google-Smtp-Source: APiQypLhDGUcmyamjQBHlsfveIgPJnN4n95sy5UgFbwnMVt4U97ePXBWdwhZ9b688ql0PYyYdOae+Q==
X-Received: by 2002:a17:902:c595:: with SMTP id p21mr20674plx.17.1585779287054;
        Wed, 01 Apr 2020 15:14:47 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id z6sm2394666pjt.42.2020.04.01.15.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:14:46 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao Chou <mcchou@chromium.org>
Subject: [PATCH 5/5] Add SDP records retrieval for a unpaired/unconnected device
Date:   Wed,  1 Apr 2020 15:14:34 -0700
Message-Id: <20200401221434.12185-5-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200401221434.12185-1-sonnysasaka@chromium.org>
References: <20200401221434.12185-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao Chou <mcchou@chromium.org>

This add the support of SDP record inquiry to a device which is not paired or
connected previously.
---
 src/device.c | 130 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 109 insertions(+), 21 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1b5afc226..dd7c32625 100644
--- a/src/device.c
+++ b/src/device.c
@@ -270,9 +270,35 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
+struct pending_sdp_query {
+	bdaddr_t dev_bdaddr;
+	DBusConnection *conn;
+	DBusMessage *msg;
+};
+
 static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
 
+static struct pending_sdp_query *pending_sdp_query_new(DBusConnection *conn,
+				DBusMessage *msg, const struct btd_device *dev)
+{
+	struct pending_sdp_query *query;
+
+	query = g_new0(struct pending_sdp_query, 1);
+	query->dev_bdaddr = dev->bdaddr;
+	query->conn = dbus_connection_ref(conn);
+	query->msg = dbus_message_ref(msg);
+
+	return query;
+}
+
+static void pending_sdp_query_free(struct pending_sdp_query *query)
+{
+	dbus_connection_unref(query->conn);
+	dbus_message_unref(query->msg);
+	g_free(query);
+}
+
 static struct bearer_state *get_state(struct btd_device *dev,
 							uint8_t bdaddr_type)
 {
@@ -3008,28 +3034,13 @@ static dbus_bool_t append_record(const sdp_record_t *rec,
 	return TRUE;
 }
 
-static DBusMessage *get_service_records(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static dbus_bool_t append_records(DBusMessage *reply, sdp_list_t *seq)
 {
-	struct btd_device *dev = data;
-	sdp_list_t *seq;
-	DBusMessage *reply;
 	DBusMessageIter rec_array;
 	DBusMessageIter attr_array;
 
-	if (!btd_adapter_get_powered(dev->adapter))
-		return btd_error_not_ready(msg);
-
-	if (!btd_device_is_connected(dev))
-		return btd_error_not_connected(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return btd_error_failed(msg, "Failed to create method reply");
-
-	/* Load records from storage if there is nothing in cache */
-	if (!dev->tmp_records)
-		return btd_error_failed(msg, "SDP record not found");
+	if (!seq)
+		return FALSE;
 
 	dbus_message_iter_init_append(reply, &rec_array);
 
@@ -3037,18 +3048,95 @@ static DBusMessage *get_service_records(DBusConnection *conn,
 						"a{q(yuv)}", &attr_array))
 		return FALSE;
 
-	for (seq = dev->tmp_records; seq; seq = seq->next) {
+	for (; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 		if (!rec)
 			continue;
 		if (!append_record(rec, &attr_array))
-			return btd_error_failed(msg,
-						"SDP record attachment failed");
+			return FALSE;
 	}
 
 	if (!dbus_message_iter_close_container(&rec_array, &attr_array))
 		return FALSE;
 
+	return TRUE;
+}
+
+static void get_service_records_cb(struct btd_device *dev, int err,
+						void *user_data)
+{
+	struct pending_sdp_query *query = user_data;
+	DBusMessage *reply;
+	sdp_list_t *seq = dev->tmp_records;
+
+	if (memcmp(&query->dev_bdaddr, &dev->bdaddr, sizeof(bdaddr_t))) {
+		reply = btd_error_failed(query->msg, "Device mismatched");
+		goto send_reply;
+	}
+
+	if (!dev->bredr_state.svc_resolved) {
+		reply = btd_error_not_ready(query->msg);
+		goto send_reply;
+	}
+
+	/* Load records from storage if there is nothing in cache */
+	if (!seq) {
+		reply = btd_error_failed(query->msg, "SDP record not found");
+		goto send_reply;
+	}
+
+	reply = dbus_message_new_method_return(query->msg);
+	if (!reply) {
+		reply = btd_error_failed(query->msg, "Failed to create method reply");
+		goto send_reply;
+	}
+
+	if (!append_records(reply, dev->tmp_records))
+		reply = btd_error_failed(query->msg, "SDP record attachment failed");
+
+send_reply:
+	g_dbus_send_message(query->conn, reply);
+	pending_sdp_query_free(query);
+}
+
+static DBusMessage *get_service_records(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_device *dev = data;
+	DBusMessage *reply;
+	struct pending_sdp_query *query = NULL;
+	sdp_list_t *seq = dev->tmp_records;
+
+	if (!btd_adapter_get_powered(dev->adapter))
+		return btd_error_not_ready(msg);
+
+	if (!btd_device_is_connected(dev)) {
+		/*
+		 * Do a SDP service discovery on the device if the device is not
+		 * previously connected. SDP records will be returned later in
+		 * get_service_records_cb.
+		 */
+		query = pending_sdp_query_new(conn, msg, dev);
+		device_wait_for_svc_complete(dev, get_service_records_cb,
+						query);
+		device_browse_sdp(dev, NULL);
+		return NULL;
+	}
+
+	if (!dev->bredr_state.svc_resolved)
+		return btd_error_not_ready(msg);
+
+	/* Load records from storage if there is nothing in cache */
+	if (!seq)
+		return btd_error_failed(msg, "SDP record not found");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return btd_error_failed(msg, "Failed to create method reply");
+
+	if (!append_records(reply, seq))
+		return btd_error_failed(msg, "SDP record attachment failed");
+
 	return reply;
 }
 
-- 
2.24.1

