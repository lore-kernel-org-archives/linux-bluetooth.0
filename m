Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC20C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7D961376
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFKCKo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:10:44 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41558 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFKCKn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 22:10:43 -0400
Received: by mail-pl1-f179.google.com with SMTP id e1so2028837plh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 19:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3W+ptAt8pudYPms9bhH6xWeReFXen6e/6oFzS927c0=;
        b=RG4bQDOWFZ8Tnd/hLtS9Vcu+8IVafGQnMYvKaa4z7JE9xYtS/OAp40gD2CxmI1ROgi
         d/IMJQQGtOHB+ClLu5JVoH+h5lM2/+CBXATUPe/nWP/AAgOfNQhMddnwDmqpQ3sGAEKK
         V5ulOWE+wqAIz6VTlSaPRVcvgEt+7/tG3aguuE16b0BZeqpkmnGGjU4sNyS+qdTT+N7q
         foDgxsD6wQeJwy9Ct0e+kDPCjvCFEp5iX9Nsdhtg5gIR3HjADRCqgqlb6q4CPV1kr8IK
         hXXMajmIHm6S9BWTuoI0kOUoP7eFlylD79m0FWgoGpmvremP9eeu8vb91XpHEMJpcOXM
         6cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3W+ptAt8pudYPms9bhH6xWeReFXen6e/6oFzS927c0=;
        b=qkPkt+/44QydDI3AU3GofCwe+VDw/g5D6iUHFyNR+gG+taIT6qHwrv6XMHd1Il8wE+
         GFUaEQLbzzM3zJtijkorKEN8EWQfIu+IDdRLWiGZUDQGA4UyuLgvDDiWc0DbA0f6HGVP
         Z20IeIgwhW0yw/qXz0noWgyXYJwEYFj/ve2ZhjMtRd5Zw2Iy9vlg42FPTETwt9wultIc
         XkOorMF4xBvNP+qKRXUEobmgPqOCHY5DfLkPitvtU08/Jk/vxnh4QJypuLEo2VT8xs7p
         uMfH9uBiSyJ9hBhpDCDrmhIk1vFeEj+f8fER0/5uFo/MgOIXvqV+VWQsjgY+dZaNXL9d
         Nliw==
X-Gm-Message-State: AOAM5319IvaX7CROSxLFNz6aLVc1x8AHYfr7G1zKld55/Gekukdw1eT+
        gXLqm8JWygqWpqK8NUbMV3smru9P2WA=
X-Google-Smtp-Source: ABdhPJwNN5n7JmdD+gLRQG94OMz0iv8+2CStL570OK6jDVsdjmOwAu3iNwDnq4yMk5ZHzcnQ7zJ9lg==
X-Received: by 2002:a17:902:8b8a:b029:108:7849:dae0 with SMTP id ay10-20020a1709028b8ab02901087849dae0mr1626226plb.36.1623377250587;
        Thu, 10 Jun 2021 19:07:30 -0700 (PDT)
Received: from mimieux.endlessm-sf.com ([2604:4080:13bd:8000::36d])
        by smtp.gmail.com with ESMTPSA id m134sm3608060pfd.148.2021.06.10.19.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:07:30 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessos.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     jprvita@endlessos.org, jprvita@gmail.com, linux@endlessos.org
Subject: [PATCH BlueZ] profile: Fail RegisterProfile if UUID already exists
Date:   Thu, 10 Jun 2021 19:07:28 -0700
Message-Id: <20210611020728.15233-1-jprvita@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: João Paulo Rechi Vita <jprvita@gmail.com>

If a process tries to register a profile implementation that is already
registered, RegisterProfile should fail.

This should help address issues when two instances of PulseAudio are
running at the same time, and the second instance tries to register an
audio profile implementation that has already been registered by the
first instance. Two situations where this may happen is when more than
one user is logged in, or during the transition between the GDM session
and the user session, when PulseAudio gets started on the new session
before the old session has been fully terminated.

https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/303
https://gitlab.gnome.org/GNOME/gdm/-/issues/486
---
 src/profile.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 5e460b639..60d17b6ae 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -749,6 +749,30 @@ void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 	}
 }
 
+static struct btd_profile *btd_profile_find_uuid(const char *uuid)
+{
+	GSList *l, *next;
+
+	for (l = profiles; l != NULL; l = next) {
+		struct btd_profile *p = l->data;
+
+		if (!g_strcmp0(p->local_uuid, uuid))
+			return p;
+		next = g_slist_next(l);
+	}
+
+	for (l = ext_profiles; l != NULL; l = next) {
+		struct ext_profile *ext = l->data;
+		struct btd_profile *p = &ext->p;
+
+		if (!g_strcmp0(p->local_uuid, uuid))
+			return p;
+		next = g_slist_next(l);
+	}
+
+	return NULL;
+}
+
 int btd_profile_register(struct btd_profile *profile)
 {
 	profiles = g_slist_append(profiles, profile);
@@ -2441,6 +2465,12 @@ static DBusMessage *register_profile(DBusConnection *conn,
 	dbus_message_iter_get_basic(&args, &uuid);
 	dbus_message_iter_next(&args);
 
+	if (btd_profile_find_uuid(uuid)) {
+		warn("%s tried to register %s which is already registered",
+								sender, uuid);
+		return btd_error_not_permitted(msg, "UUID already registered");
+	}
+
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
 		return btd_error_invalid_args(msg);
 
-- 
2.20.1

