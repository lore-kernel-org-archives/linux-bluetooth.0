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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49731C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E923A9B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbhAHVP7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbhAHVP6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 16:15:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E7C061793
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 13:15:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b5so6902804pjl.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JEXWlJdDePFBm/HsaJp0B5wQRXw/bAWWRY47hJSwmwk=;
        b=aVqkssl8SOQPvp8wTGTwTEDaW2fcPgFHKle6CEVwCykstkoauJBEK7EoGXcfqQgv08
         qtKkj+5gYRDjprZA2V8Agj5QvPK/QeGBe7WKE73pyx7NqwGJp27fXd2FDFB7jk0qy8/N
         P+PnRiEKClnpqAjCl+DtyDvS+pMY45i+BXMU3fTVABO5dsFfg0WHsg7PQ/ecQ0CVqk+Y
         duAC6xS0LaencojiL63AVKZO4CFvs9T8c1rGCBEamnUAHvsBG3pWXpV5LYPyEAwKZHst
         /xxqeqphpfYPz9gjWsCCGwS6T5jXKhS+nBv/nV7Bq52KnxZE0+NWpfnm6TjWGDfY8+Gp
         10ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEXWlJdDePFBm/HsaJp0B5wQRXw/bAWWRY47hJSwmwk=;
        b=LhYpeFPGL6SduyY4JjThj4iayK4zcG0fll8GyCQTbDjAs9sQiS6BE2UXKC5HKO+0gY
         kz+2X+vpLzOZDRn9D+TMgz3Wipy2XK2YTNjwmW0iY1FpRDUtYeKjkMEmyreDNLuns2kS
         C2KXODbGvpk0t8KYepCiAwE3ZI3XroL85DPt6RXG0+XA/G/CxV6p08HDdcxEJmL+y/hE
         ZIiKmEkglD2b329LvTiuFKqodiU2DAYj3wIN3J/blMUn/KYK0PXwrn0z7fWDHRvMRDXj
         vLU/pzePgUnx/BLsw1yuiHu2GOzP2l/HNdLBBByas0qhPLBZEkeZNF5mCuQphs4lmDGL
         BCww==
X-Gm-Message-State: AOAM530ebGffsFDBHZP8qPgV4maoDfJB4vxTj62mSxvmYLNKawAGCZvi
        XJj1ThKVAtkcsoeqO3/XO8/sjsayVsA=
X-Google-Smtp-Source: ABdhPJyM1zlkQtHqgGeBjMPsTlB5iO5hsX68FOGD/oIFRuTWeA+ld2WLin+4iv88w6fpNOOiLa/U4Q==
X-Received: by 2002:a17:902:6807:b029:db:f60f:52f7 with SMTP id h7-20020a1709026807b02900dbf60f52f7mr5752345plk.54.1610140517167;
        Fri, 08 Jan 2021 13:15:17 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 21sm9721699pfx.84.2021.01.08.13.15.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:15:16 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] device: Enable ATT layer debugging
Date:   Fri,  8 Jan 2021 13:15:12 -0800
Message-Id: <20210108211513.5180-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108211513.5180-1-luiz.dentz@gmail.com>
References: <20210108211513.5180-1-luiz.dentz@gmail.com>
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

