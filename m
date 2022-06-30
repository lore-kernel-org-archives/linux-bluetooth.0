Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82676C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiF3U1R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiF3U1R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 16:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A70A3457A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656620834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=B3cZCUIF3lnhc5FF1faZXpJlZvOkKmHLoTPPOnd8z5Q=;
        b=DAitonEnoSpypeRtw2gov2mEO5Tcf8s7j/eA/VjWSOaaPmVzKX6bEKRJMkyORVOC2MWnX7
        APR7Nu7dGHzFd8yR4HSJG6ocKU7R9BPs11p8DyeTL6IpKJbBOffzGC8bs1UU6ukd5h49Kw
        VyziPFnW/3tc2M+5qv68d0fuaRbbngo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-8fyMovxMOzWiOVhpqfPx4w-1; Thu, 30 Jun 2022 16:27:11 -0400
X-MC-Unique: 8fyMovxMOzWiOVhpqfPx4w-1
Received: by mail-wm1-f72.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so206809wmb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=B3cZCUIF3lnhc5FF1faZXpJlZvOkKmHLoTPPOnd8z5Q=;
        b=g8PRCrcshdqAR2POIPUttUePeCuPUuGWmG0I2vZz6ZmA6WZDzV5jntfI700ZlQZc+N
         lkdzO1Dj1Z2eyvscKVp0UTXeB2Boip1v4MflKjsfK3oSLBeabsybWls8wpdZuo4pQ1Y3
         PMg8R0Rw5zOSsNoeF+Hvxp2OwPRJ64SkIWTY3AktE3aD8vzEicvEdvrNps3nYTP16Hti
         UYExGxihRCrqc14w0w8jgaMG4FGYAbPQq5GQ2OSMv+uQN9DLR1ZwZ/6A4zxpuKKNfLm2
         pihP4EjdEB1QbDk9BL+y0prER0WwJRe9nI/7ZF6vJKPvN6ZtCcj0CeCSkxaHPVu0xGi3
         4u/Q==
X-Gm-Message-State: AJIora8/wpCmT4awc6gk1Xawvu4KHd7JxyYzMczjCOyFqSHM6ryhIth7
        QwsFouZF7nt/ejFQjR404KJxuVbLdrTi+J83GMuBWfp+g60LAEeo/Xsvs5WQgsk0xt9TuzLwf24
        rFXSiiczC8A/DbINNq7CSl7SsD6Bq
X-Received: by 2002:a1c:4405:0:b0:3a1:886d:c33c with SMTP id r5-20020a1c4405000000b003a1886dc33cmr1979074wma.200.1656620830388;
        Thu, 30 Jun 2022 13:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vN3emLAhFi79LfaVq/yG2oz3uypiyXu0Rea6T98wAbOL8ANlXOGgUJAGGt8l7pf/DJEfTVhg==
X-Received: by 2002:a1c:4405:0:b0:3a1:886d:c33c with SMTP id r5-20020a1c4405000000b003a1886dc33cmr1979048wma.200.1656620830194;
        Thu, 30 Jun 2022 13:27:10 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d448a000000b0021b8c99860asm20440516wrq.115.2022.06.30.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 13:27:09 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:27:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: mark broken
Message-ID: <20220630202700.18187-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Issues around the driver are not addressed
- issues around device removal:
https://lore.kernel.org/r/20211125174200.133230-1-mst%40redhat.com
- no spec
- no QEMU support

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index e30707405455..c5bb105416bd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -435,6 +435,7 @@ config BT_HCIRSI
 config BT_VIRTIO
 	tristate "Virtio Bluetooth driver"
 	depends on VIRTIO
+	depends on BROKEN
 	help
 	  Virtio Bluetooth support driver.
 	  This driver supports Virtio Bluetooth devices.
-- 
MST

