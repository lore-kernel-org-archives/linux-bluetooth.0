Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C7C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B89E6124C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFKCJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFKCJT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 22:09:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093FC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 19:07:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so4905393pjz.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3W+ptAt8pudYPms9bhH6xWeReFXen6e/6oFzS927c0=;
        b=hRLBnvzFXzfd1CXnW/l84VexjeKL1Sooi/NGT3LEFkZOAlkPbNzhMs+WmI9OSZ9qqt
         Ecl8QGe5tnNs3nA+pWmkWRL+xAmG5zCak7APb08VAz93fh+dbp+IziR8ALjHUzT6pZ8F
         WkU76N7UAIy/4nq/Cq51k0C/h85987JCITLDTRpWYW0FJHJti2IckcUzaqoVfT/4UZpW
         01J8kgKoOnsyX+Vp5EHGOFQDoC1xF5YMr/kcSjcYQemSgygFNauIm1MDWQ5HiNS/ZP5t
         Y8gzQB1UefikyTaKstdyMCUJmo9HhM1ZnPPdx9wz+noOtDWomAKFwkt9NS6FPKXq/Q9x
         dRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3W+ptAt8pudYPms9bhH6xWeReFXen6e/6oFzS927c0=;
        b=uAjLMUzCNtL3aVyDErXJi2/j8HQe8eUZ1aNiZc3YhfE2d2LvB2h3L4f9q1fX/bACU/
         K+qsn+uqtwXMpMY9u88eJQuNRLb/t6TqyMX+G01xmpRpJTPzlH53fBqzIp20RW1t8NBY
         xR/JJLXZPzyX/UJld7rmUjTqyKmSsirXrLsOLS4yVfJD5uTlV6RHdb587RctpSDcJ6dZ
         6nJQ8pay67vvBxXcpq67pRe+xv+wCThZFpRvLmvegVgjE49siYxaa+JFeafr+4F13Gaz
         wQZ+ziRSchEekOsdjHL6NtJDkb2AMyzRBIrg9q8zyIOr6LVr+/erVnmJhBepwDtNLo3E
         WWBw==
X-Gm-Message-State: AOAM531hIkvzsMHoyjbeglXts+RPhWLQ2Q3O2M3BTPjzmcz1bRQtH/SM
        tf5XMMM7DwJw9v2BjF6gLaGvlZk55Ik=
X-Google-Smtp-Source: ABdhPJw5qbLdhecOTXI6TXIafSsTneWxgp+s++o89j5RDzLyWdneiAMk+eCXhG7yhSNMC+1COBnU3g==
X-Received: by 2002:a17:902:d284:b029:106:64e4:6bed with SMTP id t4-20020a170902d284b029010664e46bedmr1635633plc.73.1623377230426;
        Thu, 10 Jun 2021 19:07:10 -0700 (PDT)
Received: from mimieux.endlessm-sf.com ([2604:4080:13bd:8000::36d])
        by smtp.gmail.com with ESMTPSA id br14sm8674050pjb.41.2021.06.10.19.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:07:09 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessos.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     jprvita@endlessos.org, jprvita@gmail.com
Subject: [PATCH BlueZ] profile: Fail RegisterProfile if UUID already exists
Date:   Thu, 10 Jun 2021 19:06:49 -0700
Message-Id: <20210611020649.15179-1-jprvita@endlessos.org>
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

