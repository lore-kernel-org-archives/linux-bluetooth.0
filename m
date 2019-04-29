Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95CC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429822087B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANGSXzea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfD2MDI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:03:08 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38102 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfD2MDI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 08:03:08 -0400
Received: by mail-ed1-f54.google.com with SMTP id w11so2161507edl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XrMZZaRE0/qbQkSetLW3CffdqpM8Oxe6NMPPfynTHKI=;
        b=ANGSXzeawu/i2GUTnt+VXC16+14Ac/biK1/6gWEz+cRB48HCxA4WykrFQ3hZJ6vg/h
         PQaPruOoQc7Be+Ve/PBHHJM0lNOM64/+OAke2R/L1ZZ7kpJSHWjNcw+aHB5EycIBCj3w
         AMwyRS/PYJOIpQjHMs+Cmutc2gTu+apq6ui+E9FxRwpYEMJnB5cFRX0ATvO3Lu3YAoa2
         KGBpAauMPKi8BNToZ8Nxn8CUAL02DzKaLYuEyHH1j9X0G9+sOiL/lXDF9agc5rufcOGy
         UCMkkyB/yO2b9mXQynJFjmDRFl3U4WmT6GyykEAJ4d8lk7+3IsXtJOMEgnUi0WtoKSCc
         1wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrMZZaRE0/qbQkSetLW3CffdqpM8Oxe6NMPPfynTHKI=;
        b=W1F9XevfqzybZHmOYq8RnYTBZX1NawtJohCp4E+JpA6hU9o5WFQpAOgD/m0wXetiH0
         HZSddluDEGLgb/0KIR+2Y2fp2RlBpz8ffYhBeMfxHs0tFLJExpBpo66YnYYPBAuYVRwF
         LL1UrdjuHZ9JH0wXRPFGil984ZcizwFwR5uhV084IOOKKHqjopz8EwsLay6oCloA4yRl
         mEpdjSwNJ6HHpQrTuuTqtZQGsk5/kXSI11nQNPShybdUYmxNMw5ZhZYlYeL97T9fmyve
         AMvvKv7bQYidTuM2Sxwi1s9G9frE88sDRjHPZxMq6Sf5LsZQEI2pz0gF3YJQTBJ0X+7/
         M3Jg==
X-Gm-Message-State: APjAAAW5naHf53rBLG3Ani9rrZdbaJN7+CVsvs447kr3GSZIGfCCkIGo
        wWDO7C/wtBo+TNvzOsntSISt14s6C2A=
X-Google-Smtp-Source: APXvYqyH7N3Uwb02JXYdoPkvS0UFc5b98mj11co/gDiKDq2VrPOcjyOBUp4mVi6li5B1cWv2Dnoz8A==
X-Received: by 2002:a50:b1d1:: with SMTP id n17mr12699931edd.131.1556539385878;
        Mon, 29 Apr 2019 05:03:05 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id 10sm5783306ejn.37.2019.04.29.05.03.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 05:03:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on other available endpoints
Date:   Mon, 29 Apr 2019 15:02:59 +0300
Message-Id: <20190429120259.17880-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429120259.17880-1-luiz.dentz@gmail.com>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Endpoint may not be able to select a valid configuration but there could
be other endpoints available that could be used, so instead of just
using the first match this collects all the matching endpoints and put
them into a queue (ordered by priority) then proceed to next endpoint
only failing if none of the available endpoits can select a valid
configuration.
---
 profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a23abdd97..4d378a91a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -105,6 +105,7 @@ struct a2dp_setup_cb {
 struct a2dp_setup {
 	struct a2dp_channel *chan;
 	struct avdtp *session;
+	struct queue *eps;
 	struct a2dp_sep *sep;
 	struct a2dp_remote_sep *rsep;
 	struct avdtp_stream *stream;
@@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 
 static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 {
-	if (size < 0) {
-		DBG("Endpoint replied an invalid configuration");
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+	int err;
+
+	if (size) {
+		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
 		goto done;
 	}
 
-	caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
+	setup->sep = queue_pop_head(setup->eps);
+	if (!setup->sep) {
+		error("Unable to select a valid configuration");
+		queue_destroy(setup->eps, NULL);
+		goto done;
+	}
+
+	setup->rsep = find_remote_sep(setup->chan, setup->sep);
+	service = avdtp_get_codec(setup->rsep->sep);
+	codec = (struct avdtp_media_codec_capability *) service->data;
+
+	err = setup->sep->endpoint->select_configuration(setup->sep,
+					codec->data,
+					service->length - sizeof(*codec),
+					setup_ref(setup),
+					select_cb, setup->sep->user_data);
+	if (err == 0)
+		return;
 
 done:
 	finalize_select(setup);
 	setup_unref(setup);
 }
 
-static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
+static struct queue *a2dp_find_eps(struct avdtp *session, GSList *list,
 					const char *sender)
 {
-	struct a2dp_sep *first = NULL;
 	struct a2dp_channel *chan = find_channel(session);
+	struct queue *seps = NULL;
 
 	for (; list; list = list->next) {
 		struct a2dp_sep *sep = list->data;
@@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 		if (!rsep)
 			continue;
 
-		/* Locate last used if set */
-		if (chan->last_used) {
-			if (chan->last_used->sep == rsep)
-				return sep;
-			first = sep;
-			continue;
-		}
+		if (!seps)
+			seps = queue_new();
 
-		return sep;
+		/* Prepend last used so it is preferred over others */
+		if (chan->last_used && chan->last_used->sep == rsep)
+			queue_push_head(seps, sep);
+		else
+			queue_push_tail(seps, sep);
 
 	}
 
-	return first;
+	return seps;
 }
 
-static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
+static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t type,
 					const char *sender)
 {
 	struct a2dp_server *server;
-	struct a2dp_sep *sep;
+	struct queue *seps;
 	GSList *l;
 
 	server = find_server(servers, avdtp_get_adapter(session));
@@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
 	l = type == AVDTP_SEP_TYPE_SINK ? server->sources : server->sinks;
 
 	/* Check sender's seps first */
-	sep = a2dp_find_sep(session, l, sender);
-	if (sep != NULL)
-		return sep;
+	seps = a2dp_find_eps(session, l, sender);
+	if (seps != NULL)
+		return seps;
 
-	return a2dp_find_sep(session, l, NULL);
+	return a2dp_find_eps(session, l, NULL);
 }
 
 static void store_remote_sep(void *data, void *user_data)
@@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 {
 	struct a2dp_setup *setup;
 	struct a2dp_setup_cb *cb_data;
-	struct a2dp_sep *sep;
+	struct queue *eps;
 	struct avdtp_service_capability *service;
 	struct avdtp_media_codec_capability *codec;
 	int err;
 
-	sep = a2dp_select_sep(session, type, sender);
-	if (!sep) {
+	eps = a2dp_select_eps(session, type, sender);
+	if (!eps) {
 		error("Unable to select SEP");
 		return 0;
 	}
@@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	cb_data->select_cb = cb;
 	cb_data->user_data = user_data;
 
-	setup->sep = sep;
-	setup->rsep = find_remote_sep(setup->chan, sep);
+	setup->eps = eps;
+	setup->sep = queue_pop_head(eps);
+	setup->rsep = find_remote_sep(setup->chan, setup->sep);
 
 	if (setup->rsep == NULL) {
 		error("Could not find remote sep");
@@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	service = avdtp_get_codec(setup->rsep->sep);
 	codec = (struct avdtp_media_codec_capability *) service->data;
 
-	err = sep->endpoint->select_configuration(sep, codec->data,
+	err = setup->sep->endpoint->select_configuration(setup->sep,
+					codec->data,
 					service->length - sizeof(*codec),
 					setup_ref(setup),
-					select_cb, sep->user_data);
+					select_cb, setup->sep->user_data);
 	if (err == 0)
 		return cb_data->id;
 
-- 
2.20.1

