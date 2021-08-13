Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA9C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44993610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhHMMWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbhHMMWy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E73C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w23-20020a170902d71700b0012d8286e44bso149763ply.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7hrEu2fNpRaehPhFqihvASmaPScllc6ZaPjMYEhrZiY=;
        b=Fi8GD32qLJtRhKSGas+J4NJxyjVmb/DFOvT1D7YeIpIInwgi9gPG9nM197iD0SLPS9
         S1BNNe3N42qgdXhh7pTdekmnA2kTioitPIlxbFf8IhZaxX1P4013puLZIvQKivgLVezh
         1x43sJwazbVmKV103ywh+niyj0xlvPfAkrP4hQfix+hbpBVdTZzJRtPFpxP4OVVR8NdR
         BSCxMsweiPeYkrWQoXHEgZh6fRX8DAXNHCmU9jj3B8zgcQjENtXWZ74ra/mwjsSOxSxV
         3IagFw+LmBLZ9fuTOod+3v09lXzI5lGG9gpp4SRXebXvW741bFzoIhroNZhusrbQiWmp
         J+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7hrEu2fNpRaehPhFqihvASmaPScllc6ZaPjMYEhrZiY=;
        b=fAtaRj9zfmZkeANbYepAs1ZerfIX8GeYt96s4DnEqcv486mRdVtUXU4bhfvyu1W26M
         HFecjEeWUGyHh6nYe+tyVakZtfkp72NysWHobuXJXtkt38KgPKSEvmOIBOx7zwGaXjML
         RIDSOflHeyykBFsxDP7b3msXN7C1XUnHlI0h5MWwmKlCSvx//ZT7iX2uRjmVZ2TDML3J
         KNuDCru7hyoNZrAevUX+5HWEHOOBsIrH8GeTWEen2R2OReE42lom/r67qKjMuOz8TCc4
         VSxXLP7qCCDCEG6ZQ1x7QfxqZXeQcqMSYxBDe+hf/zrT0z2KkQfwvIgDd9ttnDDh/gkm
         rYLQ==
X-Gm-Message-State: AOAM532EFS+JEF5R+7C6eR4aVXLp/AMcGCqt3Dl9Iqu0T5aOU4uo2MqB
        y9z3SRUccYoWpc7YVmDDxS48cH59lgZ6aMLW6qV/Dj1UzwjKpMzfcSTyIalHOZHqbusHxExCefI
        x79DfRDFFhlW+7bOv7mUIKqm7N3WFnHarxBV0v4nfBzpdyhB1xUcMx23m0jjc3xsnScAiF+OmN+
        MW
X-Google-Smtp-Source: ABdhPJyTtGcCZxsNNgdHC7j4gsduAsxwDeD+gzDIL4UbmVNoN8JpMzz010vOgq2VQQgA7Agx+u9ezDjoiqBU
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:90a:f416:: with SMTP id
 ch22mr2460130pjb.128.1628857347631; Fri, 13 Aug 2021 05:22:27 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:32 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.47.I50be9be1265bc743325cfdb9fa0bdbce9671a304@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 47/62] profiles/audio: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected in the BT core spec 5.3.
---

 profiles/audio/avctp.c | 10 +++++-----
 profiles/audio/avctp.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 9f717f35bb..702ded1366 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1614,7 +1614,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	return;
 }
 
-static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
+static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean central,
 						uint8_t mode, uint16_t psm)
 {
 	GError *err = NULL;
@@ -1625,7 +1625,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, psm,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_CENTRAL, master,
+				BT_IO_OPT_CENTRAL, central,
 				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_INVALID);
 	if (!io) {
@@ -1636,20 +1636,20 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 	return io;
 }
 
-int avctp_register(struct btd_adapter *adapter, gboolean master)
+int avctp_register(struct btd_adapter *adapter, gboolean central)
 {
 	struct avctp_server *server;
 	const bdaddr_t *src = btd_adapter_get_address(adapter);
 
 	server = g_new0(struct avctp_server, 1);
 
-	server->control_io = avctp_server_socket(src, master, BT_IO_MODE_BASIC,
+	server->control_io = avctp_server_socket(src, central, BT_IO_MODE_BASIC,
 							AVCTP_CONTROL_PSM);
 	if (!server->control_io) {
 		g_free(server);
 		return -1;
 	}
-	server->browsing_io = avctp_server_socket(src, master, BT_IO_MODE_ERTM,
+	server->browsing_io = avctp_server_socket(src, central, BT_IO_MODE_ERTM,
 							AVCTP_BROWSING_PSM);
 	if (!server->browsing_io) {
 		if (server->control_io) {
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 23e3732cde..ca5ff9126d 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -145,7 +145,7 @@ unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
 							void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
 
-int avctp_register(struct btd_adapter *adapter, gboolean master);
+int avctp_register(struct btd_adapter *adapter, gboolean central);
 void avctp_unregister(struct btd_adapter *adapter);
 
 struct avctp *avctp_connect(struct btd_device *device);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

