Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 04:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3551A2076A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 04:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhmZLbeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJEcp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgGJEcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 00:32:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86527C08C5CE
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2020 21:32:45 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a25so2875301pfl.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2020 21:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LKAAkIEAP0cQja6zPmfnfktGRKXtJMDnwdCtU8F3HvI=;
        b=vhmZLbeS4l0eJcWDi5KfmfvAJfvaNDacLBw/NXdKH+iCV14MpvFPe5YkqPxtrtPu5r
         Ok4ClEB3iFrA9Mh7K6VOuHXJYPZqa0QABxTeTU+zaIwkeVMz6p6E6cipjOzjpRTvDWuG
         Y71UgoegYP0a8TW2Vol8vrTH1r+R6JFH43omR0sZKxpKQpMDPHemp/KjCxy4r5zFyDAM
         ji4Cn+AJV+tnlWmn0tggaCTB2Rr1Ov/0plH8gXD73jiAfZe/LQ1O9dzz6PeR1sELKKW8
         r1vCM5NHyyp6jdzYP24rfSfC+VIvQmKfHTCH7nnN/5TyqE1fOjkIjpyxY9OsAC/QaooH
         zQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LKAAkIEAP0cQja6zPmfnfktGRKXtJMDnwdCtU8F3HvI=;
        b=lpZV981M2kMbZUfCl85T9LmMtKn9x7OQC0cmQnvOCpMr7CRyQ6r/yCBo1miXmhFIur
         za9TigfU/uRNrUB3ZTCNYAzeUMRV3pQF/hV0RmJ2so/DsCf4NyxGyJ7vqNBZD9xHImbf
         EDdNBJdh9FRlTRmZBKrc9L6U0dtW7eLXSt+t0EvFK1JaBGV9II/D+WoBtlYa/uPhEVrS
         2CM1zyT9BrrRBKyc9L8Uy+LYqoR8seoYRrlXHXo+/dizzGHlVlIKUvQfk5N0HVOI4O4R
         tFx2BHjA+mq+DJtrm2KdyotYSN2EZBeL/tx4LN4DKA8PjCHUnvUidNs7bWkoC8wau1OB
         Xrig==
X-Gm-Message-State: AOAM530GM93gk8Rw2/TRJwtCK5+5zD2/cNaCIhwGhCQ3bwBX579N3XMa
        Y9FfQlYr1gYaie+ygJfM0d3TPSOjjIpaqVXu63mLOjuVQq118GJwxfFpd1G9+81yybvqBgSFYok
        /NMD69h1FcdMYXIW6fNSiJacJXuKRKvrwtAz5TzYvIuTlLK9CHKdJL/gySsvbwmtx406zxKdxgO
        /B
X-Google-Smtp-Source: ABdhPJzdOymAy/4jxVXWORX17wmjq6cWBEopaj+GTprV0HhjYf7fKhIpcBNKcFIjP4VxkYpB5CkArk+sGWG4
X-Received: by 2002:a17:902:6506:: with SMTP id b6mr54542666plk.13.1594355564833;
 Thu, 09 Jul 2020 21:32:44 -0700 (PDT)
Date:   Fri, 10 Jul 2020 12:32:33 +0800
In-Reply-To: <20200710123105.Bluez.v1.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Message-Id: <20200710123105.Bluez.v1.2.Ic16589fde45fac0c496dfca2fa27672059114c3b@changeid>
Mime-Version: 1.0
References: <20200710123105.Bluez.v1.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [Bluez PATCH v1 2/2] audio/transport: store volume for initialization
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Sometimes the response of RegisterNotification for volume change
event came before we create the transport for the corresponding
device. If that happens, we lose the volume information. After the
transport is created, the volume is also potentially stuck to an
uninitialized invalid value. The property Volume of
MediaTransport1 will also be left unaccessible.

This patch stores the value of the volume notification response.
When the transport is initialized, we try to match the device
with the previously stored volume and assign that value instead.

Reviewed-by: Howard Chung <howardchung@google.com>
---

 profiles/audio/media.c     | 17 +----------
 profiles/audio/transport.c | 61 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 993ecb3b3..be1ca18ee 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1202,27 +1202,12 @@ static uint32_t get_duration(void *user_data)
 static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
 {
 	struct media_player *mp = user_data;
-	GSList *l;
 
 	if (mp->volume == volume)
 		return;
 
 	mp->volume = volume;
-
-	for (l = mp->adapter->endpoints; l; l = l->next) {
-		struct media_endpoint *endpoint = l->data;
-		struct media_transport *transport;
-
-		/* Volume is A2DP only */
-		if (endpoint->sep == NULL)
-			continue;
-
-		transport = find_device_transport(endpoint, dev);
-		if (transport == NULL)
-			continue;
-
-		media_transport_update_volume(transport, volume);
-	}
+	media_transport_update_device_volume(dev, volume);
 }
 
 static bool media_player_send(struct media_player *mp, const char *name)
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a32073380..2fd04dd42 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -56,6 +56,7 @@
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
 #define UNINITIALIZED_VOLUME_VALUE	128
+#define PEND_DEVICE_VOLUME_TIMEOUT	1
 
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
@@ -116,7 +117,13 @@ struct media_transport {
 	void			*data;
 };
 
+struct pending_device_volume {
+	struct btd_device	*device;
+	uint8_t			volume;
+};
+
 static GSList *transports = NULL;
+static GSList *pending_device_volumes;
 
 static const char *state2str(transport_state_t state)
 {
@@ -810,6 +817,52 @@ static void source_state_changed(struct btd_service *service,
 		transport_update_playing(transport, FALSE);
 }
 
+static uint8_t get_pending_device_volume(struct btd_device *dev)
+{
+	GSList *l;
+
+	for (l = pending_device_volumes; l; l = l->next) {
+		struct pending_device_volume *pend = l->data;
+
+		if (pend->device == dev)
+			return pend->volume;
+	}
+
+	return UNINITIALIZED_VOLUME_VALUE;
+}
+
+static gboolean remove_pending_device_volume(gpointer user_data)
+{
+	struct pending_device_volume *pend = user_data;
+
+	pending_device_volumes = g_slist_remove(pending_device_volumes, pend);
+	g_free(pend);
+
+	return FALSE;
+}
+
+static void add_pending_device_volume(struct btd_device *dev, uint8_t volume)
+{
+	GSList *l;
+	struct pending_device_volume *pend;
+
+	for (l = pending_device_volumes; l; l = l->next) {
+		pend = l->data;
+
+		if (pend->device == dev) {
+			pend->volume = volume;
+			return;
+		}
+	}
+
+	pend = g_new0(struct pending_device_volume, 1);
+	pend->device = dev;
+	pend->volume = volume;
+	g_timeout_add_seconds(PEND_DEVICE_VOLUME_TIMEOUT,
+				remove_pending_device_volume, pend);
+	pending_device_volumes = g_slist_append(pending_device_volumes, pend);
+}
+
 static int media_transport_init_source(struct media_transport *transport)
 {
 	struct btd_service *service;
@@ -827,7 +880,7 @@ static int media_transport_init_source(struct media_transport *transport)
 	transport->data = a2dp;
 	transport->destroy = destroy_a2dp;
 
-	a2dp->volume = UNINITIALIZED_VOLUME_VALUE;
+	a2dp->volume = get_pending_device_volume(transport->device);
 	transport->sink_watch = sink_add_state_cb(service, sink_state_changed,
 								transport);
 
@@ -990,9 +1043,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
 			continue;
 
 		/* Volume is A2DP only */
-		if (media_endpoint_get_sep(transport->endpoint))
+		if (media_endpoint_get_sep(transport->endpoint)) {
 			media_transport_update_volume(transport, volume);
+			return;
+		}
 	}
+
+	add_pending_device_volume(dev, volume);
 }
 
 bool media_transport_volume_valid(uint8_t volume)
-- 
2.27.0.383.g050319c2ae-goog

