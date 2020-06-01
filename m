Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 21:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A71206E2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 21:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCDsnM2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgFAVjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgFAVjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 17:39:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D7C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 14:39:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so442102pld.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3DGPZyXFVCUVK4ptdjFPYjHEGLbSbhhVWGkExQslGk=;
        b=SCDsnM2SD8QTFlUcoJSl3ZahLiX5i/KGuaxCTL6n2dcypupTP3YQOZRWj92IWs1hEw
         YCZM2M7KX+XewCRPym7+q1n4Zg013RzljIym1j0uvXk/SUsIQ18mKl9uLrwGdTYa+4zu
         otiI6vd5lEK70B44Y2V0rodPzn90+59g5rFXeBjtiuYQs3BigcG/v+5ztRV9i55HFJV5
         JYiggyJtpiRmcKeNCBZhilvjctzDRNEDly754fHgc+1EyejIea0Mz3bZJUvw8AYkWjWI
         0Hch5jC/eErcKIagGyHzlW7bUPf5cFEpReUPXiu1V/XmirT5DTNqa5LMIzoXJ4SqXLmj
         6pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3DGPZyXFVCUVK4ptdjFPYjHEGLbSbhhVWGkExQslGk=;
        b=pxGmje4+utTE2eQ9ldLolF3EEygherxQa7Im2cjoPSVwtkUzIzKF3e0xNgR4olzhIU
         m0xJewMAS/e6EDBYstQ8K0sypdB00F/bcBFwVy1adJeSC/1JYVs2L/oBx32cpys/w4V1
         r05g7ZfLJB7I6YHK0/zNVmmw2tPJgjnlAKR948DmQwMSZ+g9nGe44QVvfRygFrofzevx
         EOcxdSjMyPYDPCdRC7XAkrJs2EtJJ7FqB4oxo9GJaj2z6xFlklNMa00jlMRasfwTxxzU
         c4sw/8XMZJYILJ7SXu8wjJ0loATdgtE7CHF7mLf/PGRUf+N6AragNPHu+LLkLKFBTKaP
         nYkg==
X-Gm-Message-State: AOAM533IiDc9tJtI006pxJa/NyoxnB3+yI5fAAqDTy8UY+5UxKAgtRYr
        BlvAsoWVUKNgRlcfRxwQFkzWzCHI
X-Google-Smtp-Source: ABdhPJw4f9UPFsePIFw9NG+O/1O8KPUTXGifIglEs4Or8gY0c0hW7ipE7ZaGpPFyfLpV3XpkccVd+A==
X-Received: by 2002:a17:90a:c215:: with SMTP id e21mr1607110pjt.224.1591047544430;
        Mon, 01 Jun 2020 14:39:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s15sm345399pgv.5.2020.06.01.14.39.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:39:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix crash on transport_cb
Date:   Mon,  1 Jun 2020 14:39:02 -0700
Message-Id: <20200601213902.389278-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There have been reports of crashes on transport_cb where the setup
would most likely already have been freed but transport_cb would still
be called, so instead of assuming the setup pointer would be valid try
to lookup the list of active setups and log a warning when it happens.
---
 profiles/audio/a2dp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 7f14c880a..d88d1fa69 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2217,6 +2217,14 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct a2dp_setup *setup = user_data;
 	uint16_t omtu, imtu;
+	GSList *l;
+
+	l = g_slist_find(setups, setup);
+	if (!l) {
+		warn("bt_io_accept: setup %p no longer valid", setup);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
 
 	if (err) {
 		error("%s", err->message);
-- 
2.25.3

