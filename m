Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662A3C4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184E122B2D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 12:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eApvrKwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgIYM1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYM1G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 08:27:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCBBC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 05:27:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so3027282pfi.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b6h9h7KGCgp2Fmjt8/xk5iaXlAGfTMxsta23UpCu97s=;
        b=eApvrKwIc2nxuMN0p5iMYtBA5BQfZv2BR1n4pXSiLZhDYMv0XGobc0iBkBbtEhA2aW
         TaXXbC3J7XYW4LtSBEfNYWMRRhvkLvZyO847541HtPmIFSwxGjiYuF9gDvi3nv+7Z2wG
         rQ5Bs4iZyeEwnevF8UAttBsobuPkwvBWn/fodOvzo2gejKQEVQZdi7qWmHy72Hu79y2f
         4uerRkuvde/D0JN4ITijIrt6M0g2VEFKxnBEkKIbcwGsClMx162DSF7cARvuph3AUR4a
         ontwwXSQb7TXDz72uZoBGYsHu1pqSaqcklfDneDGJt5pFs+fUjsokD4bBsMrpIT3kxub
         yKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6h9h7KGCgp2Fmjt8/xk5iaXlAGfTMxsta23UpCu97s=;
        b=tOYHbMvfhkDK6e/ujlDD3EkOLPNRxE1pzljeF1OC3+qbYAhI7J0QuCTYuyaZ/dc7WI
         zFiv/81h1rHlsoXc2gtlcfEgoY4wQ/Qo8vF1Kmr+PvT0kDgQJd0WGAVNUAXftk8uk9gK
         jP1TXL+y0K4kloSukCO9p46UojDpTpU0V7rb+rxbIlkRV4j2pPth3UIcoo1aAuuwF6La
         eCXaEoe4f8VhV6OifS+31skilAiICeuGbC9h+LjOC7Y5gQTDDXg9tBgJiOX3gsRgX0ec
         gJwEjN3i5lAPmQC9+QjdZk3Atn1Fffxa/a9TYzUacGQzXvLu3J58ztocKgj4OY4+YdSC
         Klfg==
X-Gm-Message-State: AOAM532JR+pmJzM9kf22zBBzypoP3pI/elBCjY7XoO3UcFs6MtlERjVQ
        YLH99xmSdClqN5Tjje7p0xvtN/4a2kxphiYE
X-Google-Smtp-Source: ABdhPJznSqRYlqycZMg8g3bYXOTcKI98VVAvnzpqDwt2MKVFIVjJ8HlchbSj1Fn9H4bGdwRjoioyog==
X-Received: by 2002:aa7:9518:0:b029:142:2501:35e3 with SMTP id b24-20020aa795180000b0290142250135e3mr3754128pfp.67.1601036825541;
        Fri, 25 Sep 2020 05:27:05 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id a27sm2775956pfk.52.2020.09.25.05.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:27:04 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: Fix - update own_addr_type if ll_privacy supported
Date:   Fri, 25 Sep 2020 18:02:15 +0530
Message-Id: <20200925123215.15569-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During system powercycle when trying to get the random address
hci_get_random_address set own_addr_type as 0x01. In which if we enable
ll_privacy it is supposed to be 0x03.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d2b06f5c9380..6f12bab4d2fa 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1885,7 +1885,13 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 	if (use_rpa) {
 		int to;
 
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		/* If Controller supports LL Privacy use own address type is
+		 * 0x03
+		 */
+		if (use_ll_privacy(hdev))
+			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
+		else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (adv_instance) {
 			if (!adv_instance->rpa_expired &&
-- 
2.17.1

