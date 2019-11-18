Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B5C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06F120726
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 10:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="wKtJWqXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfKRKvi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:51:38 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38261 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfKRKvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 05:51:38 -0500
Received: by mail-lf1-f50.google.com with SMTP id q28so13412859lfa.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 02:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG9mkhY41A9aJo8uXnA3XR223mAbRrRtP+kn9Z03/Nk=;
        b=wKtJWqXxluyGtE+zLqa4yY3rcvS7VFF2zpBmBsF0thlG4zHfADRAsx24yYLqPurfh1
         v01axuqVikXpHaPeuja9oq8g/jA7QAwi3EVmkVV7E+XVXmu3kEoEMhw5y1HyvoHGkV8/
         ++fIQlKayIZ1YvalPprewYfDfJx4vvMLUH88JQadT80Cfno8glyf1QoKTsHA5l63sTHi
         SKc5LhzmMOy5db4Nr2AWYbBIg4ItuwzlSD6SOyLl+blUwaxN6nLQsbVv7IiKIUbJgKOZ
         PaIdE1BDWlQ9ea6dOyOagmTBLkU5fmmV0azGMinV0mKvCgDp+qAaZWAGwZSzz8WvV8Oc
         2G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG9mkhY41A9aJo8uXnA3XR223mAbRrRtP+kn9Z03/Nk=;
        b=nWQ+lV99lIW15s2VYy7VEXCuxoGvhH1u2AifjnGpoWTufXfP9KVTcF//fQBaKbipJe
         Evbxa9XD+C9xCO6gUHNWKqK+ZyinAgC26qs7WpPm7eqs/L7RA5FHvJ8HJZZTfeoo3JqO
         UFcEjIYxdeghdjf3tlIMqBVpYfAP3nLbIn3rFa3N4RgEx5DmZcHEcQUeL2eM58JuanQT
         9GVCS0R7leoAVZT4bJQm0rP4iZWxpGD33uWntiCeMfWdpfxqhtsB1Oj20JSw7Weahua1
         ZGLHfgKOK+aBfSf7kgE6gWoOdD+2C6R+++emFhJ8I3JJEC6mOOQzsYebOD43DgEG+8TE
         Kp6w==
X-Gm-Message-State: APjAAAUx2v3+qRVHYN3kXALg5vdhibG8Vyl2MstsQhvYZePREj1V2lfY
        oKRONKh6SM338uYF+KrW6Bj/WLSOcmFTgQ==
X-Google-Smtp-Source: APXvYqxFPKSluv7VfjIETWZfBPJZB5kVmPK/bW7G6XXCRaKccEutS4dakLns7z+FTsx7p3t10wIe4Q==
X-Received: by 2002:a19:800a:: with SMTP id b10mr20822316lfd.15.1574074295299;
        Mon, 18 Nov 2019 02:51:35 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id j8sm8075766lja.32.2019.11.18.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:51:34 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ] mesh: Fix crash after deleting all subscriptions
Date:   Mon, 18 Nov 2019 11:51:18 +0100
Message-Id: <20191118105118.28881-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Rafał Gajda <rafal.gajda@silvair.com>

---
 mesh/model.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index a06b684a5..40c5e6b18 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1426,9 +1426,8 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 	for (; entry; entry = entry->next)
 		mesh_net_dst_unreg(net, (uint16_t) L_PTR_TO_UINT(entry->data));
 
-	l_queue_destroy(mod->subs, NULL);
-	l_queue_destroy(mod->virtuals, unref_virt);
-	mod->virtuals = l_queue_new();
+	l_queue_clear(mod->subs, NULL);
+	l_queue_clear(mod->virtuals, unref_virt);
 
 	return MESH_STATUS_SUCCESS;
 }
-- 
2.19.1

