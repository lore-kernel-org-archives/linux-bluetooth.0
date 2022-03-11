Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 22:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiCKWxd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiCKWwj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4D1FAA28
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:30:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso9381847pjo.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a1kdBcW1ovP6W2aWzDgrwGNjIzPejdhY2ndu+42ImDc=;
        b=qVQSLvlhy7lSByDxFMKc714W2DXuho1XiSwbzHO9e+QFJn05Irjs8qWrwCBI4W44nX
         p2+/e+oJFoy9Rl/5crQoxNVtKnFY2Y0l42k4btKII21shSaRbTDgawLudD6PVzSIkkjX
         b0LQuuTk1+bJASAjSEQZJfoYSyWT4WXbfA1tSLeR4nBD3k4mcike8UAp8jWpzjJ2dna/
         JjzifXsZ0kUk9Veo/FUPHA46tULdqSrHXAfFu9L1UBsMPHlgbO87S1B8+1OiMzQTwRYy
         jbOcnoOMGPkhuED7uf6b2PgDT9kvXu+au9NkS1rY/855kUeoZwq0d+nxARgLaRtpU9CT
         r0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1kdBcW1ovP6W2aWzDgrwGNjIzPejdhY2ndu+42ImDc=;
        b=n2sVr+F2e8LNZTUog2mrXngFtgT9DRoNfYyboA3x/iF48S0SVHCsJNX9uEqWwzNhlv
         wPYJ+ZeHLm0yA/rydt3lU3+jcYmXff0F7oX6hY7Ml/tjM+tPpeDH8gEGiVQPCz7PNlFa
         sUIAf83c8k2EPW94ptTY50/Q/oqhbvHgzOxD3DhRJLhI8L7KYJL+zwWu1cGF0NQ8dJee
         4bgqhLTdAEt+HZXF0AcOQQCBX74Gt8oo0+URExfz8inSeIQSxzy6WRCfIVv8rtkTE2Zj
         CorpXdspzyV90/zQRP04Gs6OfjHY0GCO2sd+RC+mpUQBt0QgmfAC5kRF8dbYRXkVe1TC
         dLTw==
X-Gm-Message-State: AOAM532mSSuj75R+91SuWCKa6wRFlS/nRdU+d4tcOAHtqexsmsq68VSf
        UN25TMiPP4egepc7avuHRH6q6Md830Q=
X-Google-Smtp-Source: ABdhPJx0Bb5r4WGFe+svNOTKMcGswRACt3/bJD3jAb5Pkz8RRJj+vidNF418cAYiobmNk/RXulol4Q==
X-Received: by 2002:a17:902:ef4d:b0:14f:e82b:25fd with SMTP id e13-20020a170902ef4d00b0014fe82b25fdmr12168985plx.80.1647033452517;
        Fri, 11 Mar 2022 13:17:32 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090ad68300b001b8bcd47c35sm13927508pju.6.2022.03.11.13.17.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:17:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] btdev: Fix CIS Established
Date:   Fri, 11 Mar 2022 13:17:30 -0800
Message-Id: <20220311211730.3285028-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311211730.3285028-1-luiz.dentz@gmail.com>
References: <20220311211730.3285028-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CIS Established was using the ISO latency instead of SDU interval for
transport latency.
---
 emulator/btdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 09eadd24f..c60ce6dbe 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5774,10 +5774,10 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 				sizeof(remote->le_cig.params.c_interval));
 		memcpy(evt.cis_sync_delay, remote->le_cig.params.p_interval,
 				sizeof(remote->le_cig.params.p_interval));
-		memcpy(evt.c_latency, &remote->le_cig.params.c_latency,
-				sizeof(remote->le_cig.params.c_latency));
-		memcpy(evt.p_latency, &remote->le_cig.params.p_latency,
-				sizeof(remote->le_cig.params.p_latency));
+		memcpy(evt.c_latency, &remote->le_cig.params.c_interval,
+				sizeof(remote->le_cig.params.c_interval));
+		memcpy(evt.p_latency, &remote->le_cig.params.p_interval,
+				sizeof(remote->le_cig.params.p_interval));
 		evt.c_phy = remote->le_cig.cis[0].c_phy;
 		evt.p_phy = remote->le_cig.cis[0].p_phy;
 		evt.nse = 0x01;
-- 
2.35.1

