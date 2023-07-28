Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C258C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 10:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjG1K4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjG1K4V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 06:56:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD231BC6
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 03:56:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso274408666b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690541778; x=1691146578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LTlNM0U4GQn+qLoV44uEkUkueaNxcTTS45n3Q1KHm4=;
        b=MoQZ7/In+YXAIXkLppkUOXd5d4xBRx/iprSBU4S+wCgZ8PWr4FYv/J+EJwugT7xpcX
         6HX0hc8Q73IEaBUEYGl0G0kkjGuxfjTiUww9tXoJ4WzRyBZXhh7+ow/Bp0l+bbOFmZAJ
         bx7OgNUD4OV1wrkui3CKma+z+7n6CMfAB7XQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541778; x=1691146578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LTlNM0U4GQn+qLoV44uEkUkueaNxcTTS45n3Q1KHm4=;
        b=Ebv3WoPdjg2/Jk4djBr8BuBmYxNWLQo4mRqGLiaggcOa3Dn5aPEe07bTZ1RNWBWQK4
         y8r8HoB3eYAUf+466lf/9SbQSTaxc4m5KWXmf4w4JKzt6Wx9tZrtYSCOIliixsZ1d7f9
         IJS+amy4yivZsKbHgePdLZq7lYcG71rov9YMJ/aSQFsC2+h525/GbmsLbJn8zh8uUFNC
         aXd6n/J5eSYnwg875qvi0FaCShvl4vc6wL0lJLP/Dhc/GN/PkmoY/5EC6JCLTVv/WkUT
         vymqWQvDX2mHjxN5DkgFeUU6W0NwRFFK4EnD6xwKQjGk3fypekyaXJvD/fVZxVRpMS/8
         XUpg==
X-Gm-Message-State: ABy/qLbbAyl1eQZMEpXQq8pOVBkVEVE06dHaV3dlE099QFA7Us6mqj1O
        w6yljeqZRFfhFbPU5ZwVvzXyJgLAf+czMJvCGVM=
X-Google-Smtp-Source: APBJJlEVRAOIIQgB4OhqsB1RbTm4PgllSTNhx3mOBiAXEYzlRIbPI5vTjebSQWmcXvHiLLjcm6zKTg==
X-Received: by 2002:a17:906:189:b0:993:fba5:cdef with SMTP id 9-20020a170906018900b00993fba5cdefmr1469785ejb.8.1690541778206;
        Fri, 28 Jul 2023 03:56:18 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b00982cfe1fe5dsm1925370ejc.65.2023.07.28.03.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:56:17 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: Fix peripheral adverts when Discoverable = false
Date:   Fri, 28 Jul 2023 12:56:04 +0200
Message-Id: <20230728105604.948472-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728085713.683655-1-simon.mikuda@streamunlimited.com>
References: <20230728085713.683655-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a problem with this configuration: Type = peripheral,
Discoverable = false and Adapter is discoverable

In this state device will start advertise discoverable advertisements
even when user wanted non-discoverable advertisements.

This change will add empty Flags when "Discoverable" parameter is set.
---
 src/advertising.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d959bf38f..2c9a5a443 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -727,11 +727,6 @@ fail:
 
 static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 {
-	if (!flags) {
-		bt_ad_clear_flags(client->data);
-		return true;
-	}
-
 	/* Set BR/EDR Not Supported for LE only */
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
@@ -1447,7 +1442,8 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 	}
 
-	if (bt_ad_has_flags(client->data)) {
+	if (bt_ad_get_flags(client->data) &
+			(BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) {
 		/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
 		 * page 2042:
 		 * A device in the broadcast mode shall not set the
-- 
2.34.1

