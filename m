Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E057AC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD70208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 22:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruWzmCIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761836AbgJXWKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Oct 2020 18:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761223AbgJXWKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Oct 2020 18:10:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D46C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2020 15:10:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so7723427ejg.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2020 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0RwAXA1G4Yd1XxdVZWnRgx+3m7cW4ykV1KGiZuq12c=;
        b=ruWzmCICx2+gmZc+K4fDNb1X5oybXNBMQ0MoKd49y1xmpiWxGf3dWYnEIUvLNt7+2E
         DtZt28OTvwlp+gzdbDv9X5Ii2nqI6yzOvF4blG/MXw9bEceb3Kn5schWQp/4Yd6yEeZ6
         GpmxznzZwQRWPljXlnueT63Ahwcfb4/NQmRAbduWLO+/zIT8rSTGd/GtUVk8uBccYQqf
         39JvhPQTlxnZCb7M8NZlYyJ2med7W/atSp6S0aMYmjCKW3+pJd6Z8Ey5JWs3j28ZC6te
         Fk6MUGpiF8UTfTN56NFuU9h5+omQ5W50A0paKpKhTh7OzNaFz55D0lkibohVIgSHABUL
         cUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0RwAXA1G4Yd1XxdVZWnRgx+3m7cW4ykV1KGiZuq12c=;
        b=X/+xZAQu0gbIq64qk1cJhcXh5Z+WIXM4VJ3WyDQwG/Skc61eFf/fRM4QsJlL847qFS
         ekWMUac/xkVCR0jTQqCSUbjgMgeL8Y3hGNFGf3JdLO1VLm431uYERCrDcb1Ewv2bkSuP
         S31QYgQVmyLw69bKmnYQ16pI92PQ5mwYho9nDyKDVnUEs6I5dU/AMYu16ItkoMQ8CQot
         Qsofg1EdYIgTt4QEQa6ozx8L5jtbZmf5KPSzBd0+UuCXfI1sOXD0qccq0G41LZRNNLlH
         F6xrRBuOeVOm50XH0iDIG2ZLuroSz3+S48LWa3ADJl0bO92nqZgR/z5y3SEUZw3JOAUG
         5szQ==
X-Gm-Message-State: AOAM532F8fluvXOKkM7nthaQ06HntDcpw5ej9zlzHgYsw6AJYzR7LfR+
        rzf0e7//X5SVZpIK2/S+nB6uREaiLac=
X-Google-Smtp-Source: ABdhPJwBNptyaEa2g1/WdBcCREawpedf+wpSBpLiIbGaCJa2iOBkvdiCj68iGd8dtbfSmc4/jvcAiQ==
X-Received: by 2002:a17:906:454:: with SMTP id e20mr8429799eja.84.1603577409928;
        Sat, 24 Oct 2020 15:10:09 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id yz15sm2929703ejb.9.2020.10.24.15.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 15:10:09 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, pali@kernel.org,
        Marijn Suijten <marijns95@gmail.com>
Subject: [PATCH BlueZ] audio/media: Destroy transport if SetConfiguration fails
Date:   Sun, 25 Oct 2020 00:09:56 +0200
Message-Id: <20201024220956.3051848-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

set_configuration creates a transport before calling SetConfiguration on
the MediaEndpoint1 DBus interface.  If this DBus call fails the
transport sticks around while it should instead be cleaned up.

When the peer retries or reconnects (in case of BlueZ: See
avdtp_parse_rej for SET_CONFIGURATION returning TRUE on failure,
resulting in connection_lost with EIO) set_configuration finds this old
transport and returns FALSE.  The peer will never succeed this call
unless it randomly decides to call clear_configuration or BlueZ is
restarted.
---

Hi all,

This issue was found while playing around with broken configurations in
PulseAudio.  All attempts to set a configuration after the first failure
are rejected.  Note that BlueZ disconnects if SET_CONFIGURATION fails,
is that expected?  I did not analyze any of this code yet but it seems
rather harsh for something that's not fatal and perhaps better
propagated to the calling application?

As far as I know Pali's A2DP codec additions to PulseAudio expect this
this behaviour; if SetConfiguration fails it'll simply attempt the next
profile until finding one that succeeds.

I moved the functions up above endpoint_reply instead of
forward-declaring them as they were pretty close already and aren't that
many line changes, let me know if that's okay.

 profiles/audio/media.c | 77 +++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 74064d398..0632fbe8a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -271,6 +271,37 @@ static void clear_endpoint(struct media_endpoint *endpoint)
 		clear_configuration(endpoint, endpoint->transports->data);
 }

+static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
+{
+	struct media_transport *transport = (struct media_transport *) data;
+	const struct btd_device *device = user_data;
+	const struct btd_device *dev = media_transport_get_dev(transport);
+
+	if (device == dev)
+		return 0;
+
+	return -1;
+}
+
+static struct media_transport *find_device_transport(
+					struct media_endpoint *endpoint,
+					struct btd_device *device)
+{
+	GSList *match;
+
+	match = g_slist_find_custom(endpoint->transports, device,
+							transport_device_cmp);
+	if (match == NULL)
+		return NULL;
+
+	return match->data;
+}
+
+struct a2dp_config_data {
+	struct a2dp_setup *setup;
+	a2dp_endpoint_config_t cb;
+};
+
 static void endpoint_reply(DBusPendingCall *call, void *user_data)
 {
 	struct endpoint_request *request = user_data;
@@ -298,6 +329,21 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 			return;
 		}

+		if (dbus_message_is_method_call(request->msg,
+					MEDIA_ENDPOINT_INTERFACE,
+					"SetConfiguration")) {
+			struct a2dp_config_data *data = request->user_data;
+			struct btd_device *device =
+					a2dp_setup_get_device(data->setup);
+			struct media_transport *transport =
+					find_device_transport(endpoint, device);
+
+			if (transport == NULL)
+				error("Expected to destroy transport");
+			else
+				media_transport_destroy(transport);
+		}
+
 		dbus_error_free(&err);
 		goto done;
 	}
@@ -396,37 +442,6 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
 }

-static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
-{
-	struct media_transport *transport = (struct media_transport *) data;
-	const struct btd_device *device = user_data;
-	const struct btd_device *dev = media_transport_get_dev(transport);
-
-	if (device == dev)
-		return 0;
-
-	return -1;
-}
-
-static struct media_transport *find_device_transport(
-					struct media_endpoint *endpoint,
-					struct btd_device *device)
-{
-	GSList *match;
-
-	match = g_slist_find_custom(endpoint->transports, device,
-							transport_device_cmp);
-	if (match == NULL)
-		return NULL;
-
-	return match->data;
-}
-
-struct a2dp_config_data {
-	struct a2dp_setup *setup;
-	a2dp_endpoint_config_t cb;
-};
-
 int8_t media_player_get_device_volume(struct btd_device *device)
 {
 	struct avrcp_player *target_player;
--
2.29.1

Marijn Suijten
