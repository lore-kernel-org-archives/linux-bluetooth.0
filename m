Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62827C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiLBAvI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiLBAvC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:51:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238BCCECA
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:51:02 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w129so3484438pfb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abZSiyeyD5TDfxzaY7Wlf7GTc9GtM0cy6S/iptmDoTY=;
        b=Iw+D41BY4oQJ02fcPswRlHSj3iP9aazEQMRsFIc/fjy5hy0QR3sJLReICcy05XYVwf
         uMdtsz7CwJryDDlCy2eXUKRbzZwCZX4u9Vcpgd5+va09FymPUmBvFGR2ofC9JK71WHUy
         qu403dP+WOXWDQcQHbkVMWDYebjuodNiysnKMjZ2Wdiyr6Gb8aptruzUpi40rF32Mp/1
         LjcGmFQ9hmSUU+D6Iw8xfIlaljcscoGwhYK+IlF64bnmZd9iIwSJvORLiKx/aOxXrb5S
         K34mBcjJ19xlqSEl1OBBlu8b23uMhK7zcDTrS/l56A0WoMcJT//0WJd6WTbyxpWiyVH9
         37ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abZSiyeyD5TDfxzaY7Wlf7GTc9GtM0cy6S/iptmDoTY=;
        b=CCbqi0BhnV4a7Stw52qm9eVAmQme/B3WYBOXcHPaJao2PtKweqBaii8s/u94IyhAI1
         1U9DPw1jOeG9xvQCcON3d/ezBfFpBf+todQSY1dVhpY2T+jZPqMFLbJRquuqV9uAi1xN
         rABfywgPjRZZ0ckHKeV1P1B6B0NHCYzd57x9tdKyN9FNMksOZOOQhfPG9jkeNz+qeRW8
         XYCyCWaOgVtIRddGfLoy1ElDN8WBpuXNRMWbrbuJGb1bytRgkh1LKvvtsIrfcxRWwgYt
         9lcWAGl4dZbBLtntW/bOU1bWYmY3+DHdQWHCt92J0+HKbR9obf0GU9TkIJeL3R2kgvjN
         3C9Q==
X-Gm-Message-State: ANoB5ploGqVA68buoqaMA+IHDU4WW2YZGJm6xtnbo4BoI/ja0VFeuKWc
        lEazwsHTdpzsx3tAlreC4U5edUM+dJn+Zg==
X-Google-Smtp-Source: AA0mqf4j2Ath+rezdPjChTGrQ+AQSjhY9lZpCo2BT87NebHiko1/oa6YYUCUoR32sUir6FqT2Ra53g==
X-Received: by 2002:a63:eb4b:0:b0:477:a350:2172 with SMTP id b11-20020a63eb4b000000b00477a3502172mr41229624pgk.167.1669942261049;
        Thu, 01 Dec 2022 16:51:01 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:51:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] bap: Fix not waiting Endpoint.SelectProperties
Date:   Thu,  1 Dec 2022 16:50:50 -0800
Message-Id: <20221202005051.2401504-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are multiple Endpoint.SelectProperties wait them to complete
before attempting to proceed to configure a stream otherwise streams
may not be linked properly and may end up creating multiple CIS
instead.
---
 profiles/audio/bap.c   | 58 +++++++++++++++++++++++++++++++-----------
 profiles/audio/media.c | 27 ++++++++------------
 2 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9cee9fd030da..f28843ae6b38 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -83,6 +83,7 @@ struct bap_data {
 	struct queue *snks;
 	struct queue *streams;
 	GIOChannel *listen_io;
+	int selecting;
 };
 
 static struct queue *sessions;
@@ -503,7 +504,8 @@ static void ep_free(void *data)
 
 	bap_io_close(ep);
 
-	free(ep->caps);
+	util_iov_free(ep->caps, 1);
+	util_iov_free(ep->metadata, 1);
 	free(ep->path);
 	free(ep);
 }
@@ -566,20 +568,14 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	return ep;
 }
 
-static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
-				struct iovec *metadata, struct bt_bap_qos *qos,
-				void *user_data)
+static void bap_config(void *data, void *user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_ep *ep = data;
 
-	if (err) {
-		error("err %d", err);
+	DBG("ep %p caps %p metadata %p", ep, ep->caps, ep->metadata);
+
+	if (!ep->caps)
 		return;
-	}
-
-	ep->caps = caps;
-	ep->metadata = metadata;
-	ep->qos = *qos;
 
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
@@ -594,13 +590,43 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 
 	if (!ep->stream) {
 		DBG("Unable to config stream");
-		free(ep->caps);
+		util_iov_free(ep->caps, 1);
 		ep->caps = NULL;
+		util_iov_free(ep->metadata, 1);
+		ep->metadata = NULL;
 	}
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
 }
 
+static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
+				struct iovec *metadata, struct bt_bap_qos *qos,
+				void *user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	if (err) {
+		error("err %d", err);
+		return;
+	}
+
+	ep->caps = util_iov_dup(caps, 1);
+
+	if (metadata && metadata->iov_base && metadata->iov_len)
+		ep->metadata = util_iov_dup(metadata, 1);
+
+	ep->qos = *qos;
+
+	DBG("selecting %d", ep->data->selecting);
+	ep->data->selecting--;
+
+	if (ep->data->selecting)
+		return;
+
+	queue_foreach(ep->data->srcs, bap_config, NULL);
+	queue_foreach(ep->data->snks, bap_config, NULL);
+}
+
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
@@ -616,8 +642,10 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	}
 
 	/* TODO: Cache LRU? */
-	if (btd_service_is_initiator(service))
-		bt_bap_select(lpac, rpac, select_cb, ep);
+	if (btd_service_is_initiator(service)) {
+		if (!bt_bap_select(lpac, rpac, select_cb, ep))
+			ep->data->selecting++;
+	}
 
 	return true;
 }
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 6947cf96392e..fbb350889564 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -725,24 +725,21 @@ struct pac_select_data {
 	void *user_data;
 };
 
-static int parse_array(DBusMessageIter *iter, struct iovec **iov)
+static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 {
 	DBusMessageIter array;
 
 	if (!iov)
 		return 0;
 
-	if (!(*iov))
-		*iov = new0(struct iovec, 1);
-
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
-						(int *)&(*iov)->iov_len);
+	dbus_message_iter_get_fixed_array(&array, &iov->iov_base,
+						(int *)&iov->iov_len);
 	return 0;
 }
 
-static int parse_select_properties(DBusMessageIter *props, struct iovec **caps,
-					struct iovec **metadata,
+static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
+					struct iovec *metadata,
 					struct bt_bap_qos *qos)
 {
 	const char *key;
@@ -845,11 +842,6 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec **caps,
 fail:
 	DBG("Failed parsing %s", key);
 
-	if (*caps) {
-		free(*caps);
-		*caps = NULL;
-	}
-
 	return -EINVAL;
 }
 
@@ -859,7 +851,7 @@ static void pac_select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	struct pac_select_data *data = user_data;
 	DBusMessageIter *iter = ret;
 	int err;
-	struct iovec *caps = NULL, *metadata = NULL;
+	struct iovec caps, meta;
 	struct bt_bap_qos qos;
 
 	if (!ret) {
@@ -881,12 +873,15 @@ static void pac_select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	qos.cig_id = BT_ISO_QOS_CIG_UNSET;
 	qos.cis_id = BT_ISO_QOS_CIS_UNSET;
 
-	err = parse_select_properties(iter, &caps, &metadata, &qos);
+	memset(&caps, 0, sizeof(caps));
+	memset(&meta, 0, sizeof(meta));
+
+	err = parse_select_properties(iter, &caps, &meta, &qos);
 	if (err < 0)
 		DBG("Unable to parse properties");
 
 done:
-	data->cb(data->pac, err, caps, metadata, &qos, data->user_data);
+	data->cb(data->pac, err, &caps, &meta, &qos, data->user_data);
 }
 
 static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-- 
2.37.3

