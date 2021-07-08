Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54451C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3D61C69
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGHG04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGHG04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:56 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E838C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:24:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z13-20020a170903408db0290129a6155d3cso1533648plc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FA/zELt0dKCtzElqqEMLMgkIf4ij5eY0jDxfzz2qSTg=;
        b=FLmPkLBAUkkmpLXpTw5C+EottRvtDvkQs8+CpwMWe1eTsQbk40OFAObFPDoBQ+RjFI
         tIks/u2k9Qap0qCzGnEWpXQVzRTQjIEsb9pAZX4g2Mf8ADfoZ5Xl6+K8rT5gHcHZWZpU
         v+NYzz9IPjQr2kw1v0EDksyA2SDHF8O1n+jnH+OVSMRkYzSkbndK4nxPhFHPLdpeeOoV
         fBqMM+aw5TRmFBruAXZi6YomrCxG4rIc56jFRsX2cotyB/nvLzxvWPv04bgxo3MI4fi5
         /9LXl13kv8aaEvzKChL7Ee0sj5gfmIRn81bG9WwGHyAlxkcATS2v9IrFMcu/uzdLiIML
         d78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FA/zELt0dKCtzElqqEMLMgkIf4ij5eY0jDxfzz2qSTg=;
        b=b9MFWaEHm4X2rdTISicZNM4e7GtwysXbA5srmZV9Fk3doziVH1iLIWlueOgLJvWEAV
         by35xcZyEr20NMBB/LTFb1q6uE7BkWgOluEkZ7Hgd8x2+tA969bNnZOhLJOPcODumBq2
         02dum2yR7B20nTWKe7m9B1V3M+xX4uzv/JXTax9z8wt3mSjvE3DbS89KdE53HN9mabrL
         ozEs27K2CNc1jYYJQS6lyTHGz37WskTH2mHnJwQ9nGehohcwak+++R5CbrwMdejSXTzy
         sRJ8wMz+1iMTPzdSebDbpjMic26LQ4esGqup+/+GT6vHHOym7KrnPqj2r+hWEuaIdt1n
         /Lcw==
X-Gm-Message-State: AOAM5311bNDOr2d7wZf5JdUD1GJUfyX0PYV5P2iF1qXlwSpqi++7LG+Y
        reC+fYCaW5lIrN5CesMv7ywhEc4vcN9/QOfZYrU4Aucl0a2P6+Y7yj2htBFdcGy+UHlMTPIn8Ba
        KCmSZuMP7CH/XAxTLdaqW7JeNRS9eSRNSwGK29PWF1nVK8QU1AmlcUxm+gGs9nwfn8Xt+E23JHw
        kfALIkG8dEU9k=
X-Google-Smtp-Source: ABdhPJzZOeJNMBJGPeut210seJHIUAar6aDb8zhVfWmOX3LnUlyRXejnEc9ABP3b2U/NS/OBZbpl6dC3V0wa4veksg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a62:dd12:0:b029:314:96ff:4e9b with
 SMTP id w18-20020a62dd120000b029031496ff4e9bmr29394060pff.71.1625725454692;
 Wed, 07 Jul 2021 23:24:14 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:14 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.14.Ib24a67a8a849f311d5213f83eaac3cfbc54b7b58@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 14/14] core: fix a possible crash when removing devices
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This patch changes the logic of probe_service so that the same service
will not be added to a device.
---
The crash can be reproduced in the following steps

1. set service allowlist to ['aaaa']
2. pair with any device
3. after the device is disconnected, set service allowlist to an empty
   list
4. remove the device from adapter

In step 3, when allowlist is set to empty, profile that was blocked
will be added to each devices. However, in step 2, profiles the device
provides had already been added. Due the logic of
device.c:probe_service, there will be 2 identical services in
device->services, which causes a double-free error when removing the
device.

 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0d7444706336..dba26f787066 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4709,8 +4709,11 @@ static struct btd_service *probe_service(struct btd_device *device,
 		return NULL;
 
 	l = find_service_with_profile(device->services, profile);
+	/* If the service already exists, return NULL so that it won't be added
+	 * to the device->services.
+	 */
 	if (l)
-		return l->data;
+		return NULL;
 
 	service = service_create(device, profile);
 
-- 
2.32.0.93.g670b81a890-goog

