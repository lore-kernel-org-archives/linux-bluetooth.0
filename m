Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD6C46467
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjASX6b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjASX63 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CE9FDCD
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x24-20020a17090ab01800b00229f43b506fso2446200pjq.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYVOxWJSoQIjBEbbykchz25YyxslhqehlcquO50uVeg=;
        b=ovB1F8QIV+m20xrqyY2Rn+PsNimYB0jj5ti70flNUunR8WPt+HbN/MX4dI2SjmaOls
         XBmTK75njSCJziRasvRtTFsn8azHNOsloEFWMSfGc2FmFNGGCgjwdaFHkSYLjJz1rmOE
         OiFLshTgaLmQSDcYIsns/CW3qqG1kTynsuTodqbPf/poQ/upV7A1pW7AFGFzaWxRYzxN
         /Lra01qmMefdSDrXrWuNl1UJbLmaREj0goOUEqxom+KlkZDPpUY+J99vDcrtMIDUZHtP
         rME+YrdvWMY7e35Y05Hru5Npw8IJI3W6WRvL3ImjMF/WIhOxy8SZQNsv+JF0nDB3+Xt/
         fk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYVOxWJSoQIjBEbbykchz25YyxslhqehlcquO50uVeg=;
        b=QRjs5oYmM1nmFYPxuHIbtZaQxrQI7x+csB6GHu0GDHQMwY/8Nckb7ncESIhko1LJaM
         iTvoIIFt9zGcvGOfB95z2ccEQnF7tQtbRAMUh5OSP9rVlGjazS7wVlnYh/MfDcVrNgN0
         BLqOQn2GuGUz4dozZvLEU3cyxJD4+/54o5UnZo/XnRF/ZAhpYiA7eMmMKNSobMdyKpXu
         Csctdjy1CGzX5KOhCqQy8+SEH1FOQvDSqdvsqRDcrSOHMaX9ROz38b1nFph15j9Li6EI
         eClN3yiX/BcCNZLzodV+OZ9zWN376FHjP+r9DiLRN5GPpKI64ERHk5eSnMjvo83hh/TO
         njCQ==
X-Gm-Message-State: AFqh2kq0T0FIMXG0jIWVNA9FpsN7FvsOSNGiB65wrao5UaNCsTGfUdSz
        Z/qjCzoCev1Jl7LWGD554Vqpq0ptbwHKDw==
X-Google-Smtp-Source: AMrXdXt0OOnnElqTQeUfdwkvzMCy3hApGBGTgKT4YH23zxevECJA12kr4mzhNr5YClno7AKZ4nEvJA==
X-Received: by 2002:a17:902:eccd:b0:194:dec8:9824 with SMTP id a13-20020a170902eccd00b00194dec89824mr1607384plh.26.1674172695047;
        Thu, 19 Jan 2023 15:58:15 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:14 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 12/12] mesh: Switch beaconing net key
Date:   Thu, 19 Jan 2023 15:57:55 -0800
Message-Id: <20230119235755.46002-13-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

When transitioning from Phase 1 to Phase 2 of a network key and we are
beaconing, we need to halt the beaconing on the old key version, and
begin beaconing on the new key version.
---
 mesh/net.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index 049f0c44c..de4552343 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2625,6 +2625,13 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	if (subnet->kr_phase == KEY_REFRESH_PHASE_TWO)
 		return MESH_STATUS_SUCCESS;
 
+	/* Stop beaconing on old key */
+	if (net->snb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, false);
+
+	if (net->mpb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, true);
+
 	subnet->key_refresh = 1;
 	subnet->net_key_tx = subnet->net_key_upd;
 	/*
@@ -2632,6 +2639,15 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	 * it hears beacons from all the nodes
 	 */
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
+
+	/* Start beaconing on new key */
+	if (net->snb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, false, 0);
+
+	if (net->mpb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, true,
+							net->mpb_period);
+
 	refresh_beacon(subnet, net);
 	queue_friend_update(net);
 
-- 
2.39.0

