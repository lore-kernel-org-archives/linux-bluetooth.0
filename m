Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEAEB64DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 22:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjFTWoC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFTWoA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 18:44:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F16F10FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:43:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e64e97e2so2950334b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687301038; x=1689893038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ5FIZj/SKdAeq20bSrvzdHR7dTVT01cacr2mmglXvI=;
        b=jSSJG/Ne3eVDrfXS5B7+xJ1Pdv3CFv8wLQ9mcEQLMcxq3k8lXUp60nL1IDKN4bZdHr
         q5LU67tMp4vlk3GlhjDGyu+wCyIhSKRi2Arh/LrGxSdnAlI2Qh1mx1OmpjrdqyNpcask
         +YFEKseci18NXIDUPltno273x3PNIZ9zYhgaF2QMbRN6VmN/910Nypu4F/bv159O+d4b
         QIOo9SB1THMhPD9Ma1N5w8rYPn5FYXD2R1IElDL19X1LCmOER/YxD6nAWr521kNu84pV
         tJXdv4qUHEdlCWIUN9RcZtLyEhb7J45T0UQG4Fgp+CxV7cstYnEOVhjSdumBNfNW8sLn
         3q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687301038; x=1689893038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJ5FIZj/SKdAeq20bSrvzdHR7dTVT01cacr2mmglXvI=;
        b=aAnnO3g6XBSKfjIIQkpEK/gyV5Cgch3ovObmW+u8HO032MEOfposX52JtaM9QdlGEL
         DvkXtatbIhIxpxQ9wxa0RhPFz4RVOFmj6fbltObpdLAjS0uKqRw4nZ8ewOcbcO4nMf+n
         YP2uiOf4EikcWlW0UqVZKjYJgEwyeAipTAeKdSi0cKSuYaueH6weUdCE8NXHaQj/r3T6
         hcPzl373/lrm1fZuzMU2a6MST3XVvUwz2aBvby3Ri4C0ElL+BIjZP3K3Az4AEd68Q3Mj
         Hkg4tYINufpEC/ccOz7ofzgA16cHVxM0ACih9UdPaxP9/+uYlv+B3XWAL/dy0IjrdfO2
         G6AA==
X-Gm-Message-State: AC+VfDyr3j8QsrmSi6snAmXsQY4A5JwnRl72/WndBM8Sh9eQciU8l62Q
        TVpTs9kT7d/QH7IOuNolD/Ou4pwfyyZMnA==
X-Google-Smtp-Source: ACHHUZ4zrj6HtUpnqVhLyYIgJ7Ip067fS/pLwz7gZiQdUzsklcJP0QNr+kRjz/Kz8CnZCAytun3EsQ==
X-Received: by 2002:a05:6a20:4423:b0:120:452f:1c09 with SMTP id ce35-20020a056a20442300b00120452f1c09mr10357079pzb.26.1687301038267;
        Tue, 20 Jun 2023 15:43:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b0062cf75a9e6bsm1734532pfm.131.2023.06.20.15.43.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:43:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] btdev: Fix CIS Establish ISO Interval
Date:   Tue, 20 Jun 2023 15:43:54 -0700
Message-Id: <20230620224354.729781-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620224354.729781-1-luiz.dentz@gmail.com>
References: <20230620224354.729781-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO Interval is actually using 1.25 ms slots so it needs to be properly
converted.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 462f352ea252..ad637ecb8afd 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5977,7 +5977,7 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		evt.p_ft = 0x01;
 		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
 		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
-		evt.interval = le_cig->params.c_latency;
+		evt.interval = le_cig->params.c_latency / 1.25;
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
-- 
2.40.1

