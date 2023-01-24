Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A21C54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjAXU06 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjAXU0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:41 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB44A1D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p24so15865698plw.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtMvIzjwni9e7pW6GiJL02ZOc+4ONpLeTG01hI6pPpI=;
        b=hptV0sQS4sXTRn7tyouh3vJGFNEotAlFQT55BX7MkDVrvKAoRKL+Z3aEwlWvzDRf1d
         eaDa47rpO7S7Ua5PRXDOmjm3acc/pvJUNgpTAjNUUrIkSJwNHqazvdz26XRvIO5JUzf+
         bxGfuO4y+z1Q5sA9xkNPxymECCqH0DLVqgq88uiHw9DBS23uNUzOQ5TE8QujJka1Jkdk
         0Hn+GiOVdzLA/axpnQV8tUcD4ZV51s3cRHDUcLBskYzmcE83j0Kifnq3GtAPOGhcLToU
         qchrFg2ckcxKq2+fEMVQpPlU1YXAZUX2IqxHq1lAMSvc8EeK+0UQRu+3g/udaVj1w53H
         zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtMvIzjwni9e7pW6GiJL02ZOc+4ONpLeTG01hI6pPpI=;
        b=UQXX6DdGPLXj2tqnpcbp1DJEjkXMFs4JattjB/uheaHlG+M6b6xUHspdFQuyNbZT17
         rXS3rIe2vXqtbPsQyMhrDSxM0mHgOpIDFrJuYBOFS2plLNXmLfcWzxrssrFUlYh1ofxs
         0XgH1PhRyQ5p42sFi0wSyqc3OO5YNpn2DGQDE7Cf0Nr7emnF5/hVxr9+PybBfF6vhGzs
         p6ik4JmePRgMg7RKB8vqgtTGPXsKoVsIfESiedbRGp59vpCbUmBIyN8Oo1agrDA3zdkC
         qpa9KTvCmA9GMa4LtJIil+uCFyzD8/k395bvPdE38mrOasemozxsG83fWAP9NusjYx3W
         AflA==
X-Gm-Message-State: AO0yUKXpsRswwuI2DcjF61k3DaqE39gRsa6+c+4KfxsM59t9e6XZpqxy
        19Az4T6fz2WQed0kf9WRnSi6G6zTxi5/EQ==
X-Google-Smtp-Source: AK7set8drr39ilQ0YsrRMy1RGeyAQiv6QhB4cXzuVDJv1wcvrBMfHdoKRdCnsTMba92srQO90V0a0A==
X-Received: by 2002:a17:902:e812:b0:196:1f80:1079 with SMTP id u18-20020a170902e81200b001961f801079mr1956806plg.6.1674591990857;
        Tue, 24 Jan 2023 12:26:30 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:30 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 11/13] mesh: Switch beaconing net key
Date:   Tue, 24 Jan 2023 12:26:14 -0800
Message-Id: <20230124202616.310544-12-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
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
index 81f1e57ee..05ca48326 100644
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
2.39.1

