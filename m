Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DEEECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbiH0AGC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbiH0AF7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F2E8337
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so1031259plb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=OewMMH2FhTMDlAG1e4dJh9VaKQQF/YVhC1cCT3PeBg8=;
        b=FwbS5FfxBJeXPqU+BpdMLFYjyhhzAPkqAiid5GolgEluI2GHOzsq0ve+KIdw17mSTD
         MoGcx7AihUUUo1HBkROBerHQJtuvsQbRtVw9eGyUwWInQtwX0ekdcOEUhvrNMZWkosal
         ltAn02/vA/beTe6+jR6No3gltTf/Q8bjL5KBX0TWr/eEqiVLv+gqfkAxvbQH3HnA7b78
         iZWItAkGyzv4m4rG727dXEiHfz8DNioC5DL1MiltJjkmghHW++1hU7OZnqOiYHesoipJ
         6IGkuDK0GN6Fa/VsBlEj1jG/8G6fQgaqDQkPiNVBesGMhnR+71uKffJQoMXoQ+yC9svU
         1w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=OewMMH2FhTMDlAG1e4dJh9VaKQQF/YVhC1cCT3PeBg8=;
        b=4nkXqK6qFGFcXPNNSe9dk1ullacxF3ngR+dos2+TvLAKDe3g/rQEPAmQYU/PyOont2
         9UZyPWbHNtkaHYVq1eLm9a6mVAS1Nf3JJ8eNIKMXlmO7nKE1SwOCKS0MnbuuwZZcVz1j
         06yXZ74vMXMuRXTPthkDxMGfC22lPEKd1zuPk6gZ4YLcpwEhlAW7qjiEV5NyP10ltIMF
         7LD5SZv5NwIs0MJ6Nt7oEX7DYnG8CjPuDM255SzSBEnUrZVRP+kbciQtUHZoWzbtVPlj
         VYPfSbwNvHMHjTnRK+EY4ZG0qOnQ76dqdkurf93Ma19k+WFkY/5F2BdUdRJu0ejWFmYn
         t0ng==
X-Gm-Message-State: ACgBeo1Tu3fZBCnZstM8g30vBGqV27JJhKZoMOr2Sro/kWkZq8//pOoP
        ydNawvfnMeGvsoVD66lrVZwWBVQjqCM=
X-Google-Smtp-Source: AA6agR5mTA5TJTH3ymjGgOTZPXI5eZWC5HvaiXqEpSQfi2b59pE5QTZxh/BeHzz8OwV3fMlpZOQjPQ==
X-Received: by 2002:a17:90b:3149:b0:1fb:71ad:256b with SMTP id ip9-20020a17090b314900b001fb71ad256bmr6735949pjb.18.1661558756164;
        Fri, 26 Aug 2022 17:05:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/11] profiles: Allow linked transport to release the fd
Date:   Fri, 26 Aug 2022 17:05:39 -0700
Message-Id: <20220827000540.113414-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Frédéric Danis <frederic.danis@collabora.com>

Multiple transports can be linked when using LE Audio BAP.
In this case only one transport is used to Acquire the file descriptor
which will be shared by all linked transports.
In the same way, any transport can Release the file descriptor.
---
 profiles/audio/transport.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 47db2a8026b2..f36e609cbd7a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -281,9 +281,26 @@ static void media_owner_free(struct media_owner *owner)
 	g_free(owner);
 }
 
+static void linked_transport_remove_owner(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct media_owner *owner = user_data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(stream);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	DBG("Transport %s Owner %s", transport->path, owner->name);
+	transport->owner = NULL;
+}
+
 static void media_transport_remove_owner(struct media_transport *transport)
 {
 	struct media_owner *owner = transport->owner;
+	struct bap_transport *bap = transport->data;
 
 	if (!transport->owner)
 		return;
@@ -295,6 +312,9 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		media_request_reply(owner->pending, EIO);
 
 	transport->owner = NULL;
+	if (bap->linked)
+		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+				linked_transport_remove_owner, owner);
 
 	if (owner->watch)
 		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
@@ -452,11 +472,34 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 	media_transport_remove_owner(owner->transport);
 }
 
+static void linked_transport_set_owner(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct media_owner *owner = user_data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(stream);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	DBG("Transport %s Owner %s", transport->path, owner->name);
+	transport->owner = owner;
+}
+
 static void media_transport_set_owner(struct media_transport *transport,
 					struct media_owner *owner)
 {
+	struct bap_transport *bap = transport->data;
+
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owner = owner;
+
+	if (bap->linked)
+		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+				linked_transport_set_owner, owner);
+
 	owner->transport = transport;
 	owner->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
 							owner->name,
-- 
2.37.2

