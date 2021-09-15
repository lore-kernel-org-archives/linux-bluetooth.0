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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB34C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A621761214
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhIOIew (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhIOIev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9DC061768
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4-20020a258b84000000b005a203c5e066so2613564ybl.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2inuUBrBzTO4N62ZgQ9Uqv+tvOoPHCUyPsQHgkEaRik=;
        b=pdNkKUhuwVPEyVy2irh5gNP3tgxDeLq+keevbb05N2B9/n9TJpWpEMUeV+73SzgfZz
         mM+HF6J4UzYYdxgddu9F21FTp2TZ1qJTqQ94fNMpkDHfDviHrJ8OX24ZjdWym7oLFNN6
         gLgS9pTrywnzlWCxot5vxFl9719W5MCOR5drISWTxFhxBxNQkh1TFWFc/dIJ3COUVRXG
         61FaxozeB9JebmieXVRvRPgsOFeUrkq+riFxCrzeJSlPJ1OGmQ0J+ITfuLrmqAG+WYE/
         fAW7iIMtlLlr2P1pd2Cizc7tlLCa29w9JK5me5qKYKfB3MhoJQ1XOAVHflRxLSuktLed
         DlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2inuUBrBzTO4N62ZgQ9Uqv+tvOoPHCUyPsQHgkEaRik=;
        b=AeHFdaZQqfpKkpO7R2H5CEJNd8S9XFJApJD9J6Zl/fUYGqXTTXrqWAT2CqE0PLROQo
         Sx4id9HFntcCXh9UhRDx3qcmcdconJAqFee4HktVzbJJ/XyX/kvErkPLAmghrKdvvOmb
         LcTmu/953deqb3hq3ngxMk6Rdw8voZW3EMfUdACDDgro9+51VMDvMgpRSGsJqL7NnmxB
         BntPqWVZbCohdAYYvo6PJN8zlBd8ZWWE91cTHpt33UF0ksltNmuJwnFuDX/UlDaV1+RQ
         K20gCFewiKzy5JOEjiL2YkxySdPCFgBTb0l1yd5QrrlFxhsYOdSaqYuFG0vE3Za90E/U
         Tx1A==
X-Gm-Message-State: AOAM531jP7N/hJaKtuxAQzgMKlx0HSbA/wdAp+od19YzB+nUBNL/L7j0
        0lehsCPqXHefxURzeYztJ710X+66iFmPLVbDl9ausaSljbr2bmkWb1COPZEM10Qfo52rpkiiNhi
        34K/JHb9YmfAX62ok4/L9edf4K2ptoeYDlKMDmoIdslLGEJJJGOs0Xk2a1AOty22doQunHEcWJD
        GY
X-Google-Smtp-Source: ABdhPJwS5k/Jn5A4UafDzkdYifr2pSrq/9VvgbFJMJ4QczaspGxTQ9eU41fp2z+w6Vhi4gNSfkKgNJeZxMxc
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a25:1504:: with SMTP id
 4mr5013067ybv.375.1631694809922; Wed, 15 Sep 2021 01:33:29 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:32:06 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.10.I222c5f74a0e9d3c7c08c0682494150bdec037dd6@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 10/13] client: Inclusive language changes
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

Use "parent" to describe dbus hierarchy.
---

(no changes since v1)

 client/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 9a36a8c65d..229d53262f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -387,19 +387,19 @@ static void print_experimental(GDBusProxy *proxy)
 	}
 }
 
-static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
+static gboolean device_is_child(GDBusProxy *device, GDBusProxy *parent)
 {
 	DBusMessageIter iter;
 	const char *adapter, *path;
 
-	if (!master)
+	if (!parent)
 		return FALSE;
 
 	if (g_dbus_proxy_get_property(device, "Adapter", &iter) == FALSE)
 		return FALSE;
 
 	dbus_message_iter_get_basic(&iter, &adapter);
-	path = g_dbus_proxy_get_path(master);
+	path = g_dbus_proxy_get_path(parent);
 
 	if (!strcmp(path, adapter))
 		return TRUE;
-- 
2.33.0.464.g1972c5931b-goog

