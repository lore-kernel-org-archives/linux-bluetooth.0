Return-Path: <SRS0=9bU/=4O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D4C4BA0B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128CC20714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILmD2Hwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBZIOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:14:34 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52709 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgBZIOe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Feb 2020 03:14:34 -0500
Received: by mail-qt1-f201.google.com with SMTP id c11so1261053qtv.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2020 00:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rWT7LWSXKsbLbNE6u40ereC7Eu51tYiWqgFs41V4NLU=;
        b=ILmD2HwouyN7oIB974tZzKo6z4uOUi2s1Wy+4DKBVpRBiDX7cxoie3VA/FSWctyA6i
         JUuAO2XaMDeHj6zpMjRK7dV5HG1HYEHXFJfyrR81dfoE29ZbrrDS9lOFBBL6M5pYgjmJ
         ASJCbNt1WsSGZAL2UGYkZGwkqAqkPNs4nuDTHlGWfxGaaDVsSH5V6dvwW2xuvRp1V/Gp
         oSC/AT/YXSvez6rleLzxlO9PJliNN1emfSCd+mIF3q8fR1r6bpIrpjb5yxJmJdo0nDbb
         CzVXUokjaKsro3eREfX/Z62wmiTVNZGovPCMwkVut8fciRfJLzaf1JuJaC6UZsuNEqYM
         d4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rWT7LWSXKsbLbNE6u40ereC7Eu51tYiWqgFs41V4NLU=;
        b=pGBm0UXhIEVf8fgTzwJCydA9UwWvS241BzErrnfeIEAsOllOtJlzp3wPvo4sY6i41J
         0iYSfZTXChwnOegudz8kklMVjUho35Xxw04c4Aznw7zZiJLqIdkEplUJq9xG9Kpvj1W/
         Kjk2NHyAergdjwI0v3K2NVtTB3kRFGeSJmEh9SxXe/H0cRuQTmDo09qy8nvPjt1HHbar
         C2qAQTAJWL7+gEsmEvk7SYSSS5OR1xXpF3XuVYZ0FaGd+YI/og9TN7Kewkn9auwR+tez
         QbA9+jY8kV2SwoH6XCo+IYs2KeN6ozCxfmmXMmhsPUqRVxdY+vADGVwqw0fIu3kIRHTs
         xorg==
X-Gm-Message-State: APjAAAVgGoQ1bGJDRdd/hZxJO9EedALkS0A9Q+PREn1TQrKDO0R1dq6y
        H+wpVKpjE3zSJcEdS5O2lZbG2tCTutYNpdvvqERemDWbOhs6v94RcM9uDTSSK9v9x1pcfbhd4JM
        O+xMguzE29OzXeKJ6c9AAqNcJcjzRNUz5YvCBZaSfC8p1qF63KBnmi1k4h/a65K9iwk+D0WTBWF
        Or
X-Google-Smtp-Source: APXvYqykx3mtJPaq6Q2NDnBR9fAJEFvIkJ6O73P02niNLqTCBuzZ8gFGwBefIfstHttpgdF0aCy6s+IrQwmT
X-Received: by 2002:a0c:90c8:: with SMTP id p66mr1161893qvp.115.1582704873103;
 Wed, 26 Feb 2020 00:14:33 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:14:24 +0800
Message-Id: <20200226161257.Bluez.v2.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [Bluez PATCH v2] src/profile: Ensure class UUID matches before
 connecting profile
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
might be multiple service records returned in a SDP Service Search
Attribute Response. Also, according to 2.5.2, the service pattern
can match any UUID contained within the service record, it doesn't
have to match only some specific attributes of the record.

Therefore, before using the service record to connect to any
profile, first we must check that the service class ID of the
service record matches with whatever UUID specified in the service
pattern we are looking for.

This patch checks the service class ID of the records against the
requested UUID whenever bt_search_service() is called and filter
out the ones that don't match. For the alternative where filtering
is not applied, use the method bt_search().
---

Changes in v2:
- Move service class matching from profile.c to sdp_client.c
- Create function bt_search for searching without matching uuid
- Update device.c to use bt_search for L2CAP

 src/device.c     | 17 ++++---------
 src/sdp-client.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 src/sdp-client.h |  3 +++
 3 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/src/device.c b/src/device.c
index a8f4c22f3..5ff381959 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4590,17 +4590,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 		if (!rec)
 			break;
 
-		if (sdp_get_service_classes(rec, &svcclass) < 0)
-			continue;
-
-		/* Check for empty service classes list */
-		if (svcclass == NULL) {
-			DBG("Skipping record with no service classes");
-			continue;
-		}
+		profile_uuid = bt_uuid2string(&rec->svclass);
 
-		/* Extract the first element and skip the remainning */
-		profile_uuid = bt_uuid2string(svcclass->data);
 		if (!profile_uuid) {
 			sdp_list_free(svcclass, free);
 			continue;
@@ -5352,9 +5343,9 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 
 	req->sdp_flags = get_sdp_flags(device);
 
-	err = bt_search_service(btd_adapter_get_address(adapter),
-				&device->bdaddr, &uuid, browse_cb, req, NULL,
-				req->sdp_flags);
+	err = bt_search(btd_adapter_get_address(adapter),
+			&device->bdaddr, &uuid, browse_cb, req, NULL,
+			req->sdp_flags);
 	if (err < 0) {
 		browse_request_free(req);
 		return err;
diff --git a/src/sdp-client.c b/src/sdp-client.c
index 413cf30ec..fc8e9ec10 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -143,6 +143,7 @@ struct search_context {
 	gpointer		user_data;
 	uuid_t			uuid;
 	guint			io_id;
+	gboolean		filter_svc_class;
 };
 
 static GSList *context_list = NULL;
@@ -157,6 +158,11 @@ static void search_context_cleanup(struct search_context *ctxt)
 	g_free(ctxt);
 }
 
+static gboolean check_record_uuid(sdp_record_t *rec, uuid_t *uuid)
+{
+	return sdp_uuid_cmp(uuid, &rec->svclass) == 0;
+}
+
 static void search_completed_cb(uint8_t type, uint16_t status,
 			uint8_t *rsp, size_t size, void *user_data)
 {
@@ -195,6 +201,12 @@ static void search_completed_cb(uint8_t type, uint16_t status,
 		rsp += recsize;
 		bytesleft -= recsize;
 
+		if (ctxt->filter_svc_class &&
+					!check_record_uuid(rec, &ctxt->uuid)) {
+			sdp_record_free(rec);
+			continue;
+		}
+
 		recs = sdp_list_append(recs, rec);
 	} while (scanned < (ssize_t) size && bytesleft > 0);
 
@@ -338,7 +350,28 @@ static int create_search_context(struct search_context **ctxt,
 	return 0;
 }
 
-int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
+static int create_search_context_full(struct search_context **ctxt,
+					const bdaddr_t *src,
+					const bdaddr_t *dst,
+					uuid_t *uuid, uint16_t flags,
+					void *user_data, bt_callback_t cb,
+					bt_destroy_t destroy,
+					gboolean filter_svc_class)
+{
+	int err = create_search_context(ctxt, src, dst, uuid, flags);
+
+	if (err < 0)
+		return err;
+
+	(*ctxt)->cb = cb;
+	(*ctxt)->destroy = destroy;
+	(*ctxt)->user_data = user_data;
+	(*ctxt)->filter_svc_class = filter_svc_class;
+
+	return 0;
+}
+
+int bt_search(const bdaddr_t *src, const bdaddr_t *dst,
 			uuid_t *uuid, bt_callback_t cb, void *user_data,
 			bt_destroy_t destroy, uint16_t flags)
 {
@@ -348,13 +381,32 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 	if (!cb)
 		return -EINVAL;
 
-	err = create_search_context(&ctxt, src, dst, uuid, flags);
+	/* The resulting service class ID doesn't have to match uuid */
+	err = create_search_context_full(&ctxt, src, dst, uuid, flags,
+					user_data, cb, destroy, FALSE);
 	if (err < 0)
 		return err;
 
-	ctxt->cb	= cb;
-	ctxt->destroy	= destroy;
-	ctxt->user_data	= user_data;
+	context_list = g_slist_append(context_list, ctxt);
+
+	return 0;
+}
+
+int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
+			uuid_t *uuid, bt_callback_t cb, void *user_data,
+			bt_destroy_t destroy, uint16_t flags)
+{
+	struct search_context *ctxt = NULL;
+	int err;
+
+	if (!cb)
+		return -EINVAL;
+
+	/* The resulting service class ID need to match uuid */
+	err = create_search_context_full(&ctxt, src, dst, uuid, flags,
+					user_data, cb, destroy, TRUE);
+	if (err < 0)
+		return err;
 
 	context_list = g_slist_append(context_list, ctxt);
 
diff --git a/src/sdp-client.h b/src/sdp-client.h
index 9aa5a4d98..3a7212fd2 100644
--- a/src/sdp-client.h
+++ b/src/sdp-client.h
@@ -24,6 +24,9 @@
 typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
 typedef void (*bt_destroy_t) (gpointer user_data);
 
+int bt_search(const bdaddr_t *src, const bdaddr_t *dst,
+			uuid_t *uuid, bt_callback_t cb, void *user_data,
+			bt_destroy_t destroy, uint16_t flags);
 int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			uuid_t *uuid, bt_callback_t cb, void *user_data,
 			bt_destroy_t destroy, uint16_t flags);
-- 
2.25.1.481.gfbce0eb801-goog

