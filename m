Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F2DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F6323A9A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbhAHTFI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAHTFI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 14:05:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F2C0612EA
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 11:04:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w1so5962113pjc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JEXWlJdDePFBm/HsaJp0B5wQRXw/bAWWRY47hJSwmwk=;
        b=KLexHvVY0383JlMSJNnkPezS+SR1yWpXuKVSBwNiKwzFzGG/AHJLsvAEI1G7OJmQt8
         Hl+O3YmwYWlN/ZLb7sl+Bn+97JKHnQgAopIeY46x806OcuRfmxg2n2WVk0uYmHMYTB5a
         PdtOd+KtUwWvgu741MfYal/pdeMA8oQqBYTMQu8+XfhM3HveaEv2eb5ukI2lg6Y5Op3F
         XAOklcoZlFiChacATw+7AiljOh5vT+nCg/JJvvInXUeF/+xsfSni3wEbDldHKq7dgOBp
         SkeKLZmbdevuqkl23CbSSGhlr72Pi1umz/vbrk9QpZvY94oWLxmfX0qmCCc1JK3pF+Po
         JwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEXWlJdDePFBm/HsaJp0B5wQRXw/bAWWRY47hJSwmwk=;
        b=Z6HCjszByIW3XMWhgB8ve7IKaArOjjqcQupz9Nx1DDOGHuh4N1TGBbph8bw7VMIpBX
         Y0tdHjhm5RA2Dqu54JAZMjDVEKxkbHTAhCgzXho20pOsK2b3HbThjwnAQvuNh59NaxnJ
         DFmSUmS9hoS43AO9/2Otnx4o1kQJrhS+UFpfC6E4EGxaI9qdq+efiEfzD+CMqMdtR7xp
         VuAfnYiemjhXDRC3Fu53oXRHdooAz0KPg29MIQLwwJnFKcnm4KSActHdDVGqpfn4Idcb
         L6jYykAToQXbtAH5CY9a63shNR+bnF1wkRw+cUrCxtFz26nwgDJwb9CVdRmX1njYBgUi
         aQsA==
X-Gm-Message-State: AOAM533aPXgg8AxhR7Uw656LEdn6X+WwU0d7xDwK5C8t21J1s9CgPfs7
        4+iMXRVvd2CzmGIvTmkrEa6+3RnqYJU=
X-Google-Smtp-Source: ABdhPJxwavj9U0H9T6x8HUb4Nue73n+QewA0Py3/Q+A9cgajk8kQ43CbRSNvko3nwfQZw+ts3lBAdw==
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr5237598pjb.136.1610132667528;
        Fri, 08 Jan 2021 11:04:27 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g16sm9304181pfh.187.2021.01.08.11.04.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 11:04:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] device: Enable ATT layer debugging
Date:   Fri,  8 Jan 2021 11:04:23 -0800
Message-Id: <20210108190423.4185474-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108190423.4185474-1-luiz.dentz@gmail.com>
References: <20210108190423.4185474-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_att_set_debug to enable ATT debugging which is useful for
detecting error such as an ATT transaction timing out.
---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index 2e97876ec..fe885aa64 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5336,6 +5336,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 
 	bt_att_ref(dev->att);
 
+	bt_att_set_debug(dev->att, BT_ATT_DEBUG, gatt_debug, NULL, NULL);
+
 	dev->att_disconn_id = bt_att_register_disconnect(dev->att,
 						att_disconnected_cb, dev, NULL);
 	bt_att_set_close_on_unref(dev->att, true);
-- 
2.26.2

