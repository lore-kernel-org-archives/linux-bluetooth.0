Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F8C6369E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 03:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BAF21D91
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 03:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgLCDrx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 22:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLCDrx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 22:47:53 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4DC061A4D
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 19:47:12 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id b9so595075qvj.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 19:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HrscAejiPtaiY78VeFUfBvygFWbXvuDCBIOPXXdZXXw=;
        b=I3BAo+CQDMKenAVWONaVeKoFj1nJ8aUQrxRmmOyyVqjo3fUyRisox8QicXrdflSlgi
         pj0JoLQcCO8uzVDf0/2AkNCXJZCmiuuBlEkYMTEcdNt8bFgu19xwhahc6mbSBEtPljI1
         LNDstbXvDXDPWHnCRYk01L8IXshBRGBv70Nrov3QdFwU+Iq78XVekHgOVUUBOTSuejQG
         fp18db2thE2YyZj6Z5xVzwige8Gob4S8mP1AJkPVFo9WLTMoCzxiKwy7PcYbOrKeGJTy
         MNjZuhLJznYiN5K9cNrlYbsvJTIkIK9vkSo/y00Zw0t7rIze18FaImihp4BpNLNwkldO
         K4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HrscAejiPtaiY78VeFUfBvygFWbXvuDCBIOPXXdZXXw=;
        b=ryjGQ/UuewtKZIZbfdxUdfjucP5H6ojog/5imlepVfhUoutucl/n8RPL5H0/q7kwdk
         UOZB2fVIZ/uNFv3a0hBuGrR3UMAOpmlsHoCFrRa/OV7oybUQ9lAssIJpfhY5vkHKj/ld
         Kn/XPA5CBbTqLWmgLI+E7PjSWQXlhEkFonRCgkQO/A4cW1zQzHBHJNnzfH4eKi6ob5mT
         OMtL6mToEdkps/L+MDxVpMnA552pro+Yv2ICKnl3npGGyzs4Dk69sWVwbU6AM8z95s0f
         vmU7rbwTl9yBlgZxxToL+GNGh346gbsgfzUYtchsxwgpgQgHVLDhKTqthbWp/hs2kpcB
         PXTQ==
X-Gm-Message-State: AOAM533w1+f2JHa69cpvp0tzfm475xFI/rD8Dpw3DU/Q4AQU7flnLU9v
        gDqBxCAuzE4v88sHIowBu89xAIx/2UE6og==
X-Google-Smtp-Source: ABdhPJwQE99oqfDhZPKnYQtUULcj/MQOJHllxKIaGoVXvwl4clroLnIkFH0bvTOeWF2rNMuOlTTleOEYEDxfag==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a0c:bf44:: with SMTP id
 b4mr1322420qvj.30.1606967231782; Wed, 02 Dec 2020 19:47:11 -0800 (PST)
Date:   Wed,  2 Dec 2020 19:46:51 -0800
Message-Id: <20201202194547.bluez.v2.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v2 1/2] adv_monitor: Register client app with app-root-path
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, sonnysasaka@chromium.org,
        howardchung@google.com, mcchou@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a client app is registered with g_dbus_client_new(), bluez root
path, i.e. "/", is used as the app root path and signal watches are
added at that root path.

Because of this, InterfacesAdded/InterfacesRemoved signals emitted by
app - while creating/removing advertisement monitor objects at the
app root path - are not received by bluetoothd.

Use g_dbus_client_new_full() to register a client app with the correct
app root path.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: sonnysasaka@chromium.org
Reviewed-by: howardchung@google.com
Reviewed-by: mcchou@chromium.org
---

Changes in v2:
- updated the commit message and title

 src/adv_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index fc058dbf1..a5bc61c48 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -775,7 +775,7 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 	app->manager = manager;
 	app->reg = NULL;
 
-	app->client = g_dbus_client_new(conn, sender, path);
+	app->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!app->client) {
 		app_destroy(app);
 		return NULL;
-- 
2.29.2.454.gaff20da3a2-goog

