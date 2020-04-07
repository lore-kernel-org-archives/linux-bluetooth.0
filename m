Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A91FC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 00:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01132076E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 00:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNJjA/k5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDGAZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:25:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42203 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDGAZr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 20:25:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id e1so539804plt.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uz9xAHOPqsqwiudylqlgKt2ReuFJ6ZVH3WRoUDcAiDo=;
        b=cNJjA/k53DUa0StYEgsmuXP5H/ltvyZNE8Igfh6Tw1+7bdZDV1mny6/FnpTst9u0Er
         8K10AZK1eBDe2cDTNV/HLdgifqMbldiOic/zxvMbiesmoeC5H74/S0LwEXBriM5vACtY
         0iSCDcfvF8DxNgDEQFxk58Sp2GaNVQ+gpCuhMWyTnvZzSeVYxDSp/EMsPDzr6uVhzL7/
         t3NPvkotbImcbZJPx7N0fM37heDrd8SI9spX//MhZ0iNYoJkVXN+JyzMJWgK0UKMJhkC
         WFk8mZfD7Lg9uhXpp97sXPvXzVfLXbEw/Auwm+ij5D8i9kyxBg3mRtL3lRvhHBqQRkyd
         ygbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uz9xAHOPqsqwiudylqlgKt2ReuFJ6ZVH3WRoUDcAiDo=;
        b=bIvfyTl+gYc6TVHOUj2McqFF+5hzCFZznvBB+HMuQfgVXqrzeg8HUQW5WDEIWyXcei
         LUMU769cLkjZT5g/Xn8GZliQ36F9KQtdoB5RT0jDM9XQqg1sOI1FwMoj4ySKTHxZT+Ry
         OONefb5eEBcosDp3jm5Rt/roW8JTc+aPB2+DK6RgrZ1Q+EPlQBKsDVyebHj2V/p7QYGM
         DBK//fR81YGtXDIZQwgB4d9puMVUWEfv7NfSf3O02t3M/qr/xrqG/6E1nS00rL1ceWxI
         l+YDCuFpKWITGVSqQZ+PszV1U5p2WC0uXI0tLEnBzsPSqoHtPshVV/h3akhVlo4dw4ML
         NaPQ==
X-Gm-Message-State: AGi0PuY4+9nhdLtJ0vMQBPNWe+GHB4foV0xojP+PuBaTcIceEcs6GOr0
        HRUOFDEc3MADpXcI65Ur6Vg0vW0xAZM=
X-Google-Smtp-Source: APiQypI6Ll1s1mo26i1CtQj6afaTtTmWhy6M4K3nHvl2voQ+u0UGK4afVsjM6BW4AbUOOBAG3ZBTSg==
X-Received: by 2002:a17:90a:a487:: with SMTP id z7mr2249095pjp.32.1586219145419;
        Mon, 06 Apr 2020 17:25:45 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b124sm12554052pfa.34.2020.04.06.17.25.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:25:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Make advertise instances default to discoverable
Date:   Mon,  6 Apr 2020 17:25:43 -0700
Message-Id: <20200407002543.19984-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The more common case is that advertisements are discoverable not the
other way around.
---
 client/advertising.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/advertising.c b/client/advertising.c
index afc8754df..94eb616b2 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -80,6 +80,7 @@ static struct ad {
 	bool appearance;
 } ad = {
 	.local_appearance = UINT16_MAX,
+	.discoverable = true,
 };
 
 static void ad_release(DBusConnection *conn)
-- 
2.21.1

