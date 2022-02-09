Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5194C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 01:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiBJB7H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:59:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiBJB6C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 20:58:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1A2B6A5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:44:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x3so530797pll.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 17:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rV4Eu7WBcbdGqPKustrUZI4J/tnCnXCXuSWzYwJDk84=;
        b=bAK7uBL5uWhFyhVQLbCtGjRcAmCB/u/M9czo7hEt96y7XzxyDtv95xutzsYfCsMsNf
         QJisKGRh/AtAvkZ0ZjhERNS6AEZlhbx44Gz2nhl+4Xg/E6cdkXc8LYUfKMZRnPuMstf/
         zTE34iicFXG45hMGAYRC3vqyAEqaW6aPfyv6YZ3aI0Rd0nSYvBclPGGeYasdkm2sNMdP
         fbsarqphtAmyV9oaiDslTGnCblpM/TOXy1XLrKw/uT47TkrcigDa0ZDCo4ZDIJjAAlKJ
         fNyDzJjXG3NTmtl1WPpTuBRKfLaEPAPS1U4RCTPCteM8BL3q4LELZ+UWw6jXnOCgZMi6
         rk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rV4Eu7WBcbdGqPKustrUZI4J/tnCnXCXuSWzYwJDk84=;
        b=r4Iy2AFLArsgH6vKktQakzmUgobHEsiHgqsG41H1uIQxP5OwVWijIuuXMVWsCiERr4
         c1xucgWxBx1efR04+SSxlqLlS9gSkQFYObYtFhY5TKBugqesDCFG2EZ/VejKkwa29i5g
         wCRXvJwqkX5IDF6RzTWer6o7HRdJg7Ho2g1wcRoEdsHtAu+b6BJdnzhEmWAGAscdYK/m
         Q8tZITuCeIC58WVi7H9d1LgWhWR4KhDMNM5qrk3W5yqeDqe+NA+MH9TfKD1v3oTuIZ/E
         +KiYml7Cddzkw0VNRUb4epUDNHLftp1Qwi7VvqNEPvq7girSOaK7+r5cE7mJIdZkrHJ6
         jEFA==
X-Gm-Message-State: AOAM531h0SL09R/z37kiL2cNSdtHId7pu3oIe5Z6bPHW+XRuDHWiUlbo
        qrUKW9k8UNSLCIjTUTWxBqwu7f5dWTAqJw==
X-Google-Smtp-Source: ABdhPJzfBhWXb8U3kPImfNGYNQrk+e22U3vPJsRm8zjHg1QRmOk9Sz37l4hX1qRSimgnOM1XNY94fA==
X-Received: by 2002:a17:903:40c2:: with SMTP id t2mr4862998pld.143.1644450956044;
        Wed, 09 Feb 2022 15:55:56 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm3240799pfi.7.2022.02.09.15.55.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:55:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] bthost: Increase number of credits
Date:   Wed,  9 Feb 2022 15:55:52 -0800
Message-Id: <20220209235553.150294-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209235553.150294-1-luiz.dentz@gmail.com>
References: <20220209235553.150294-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This increase the number of credits so bigger packets can be sent by
the likes of rfcomm-tester.
---
 emulator/bthost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index bb1219d28..d751e7dd4 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2322,7 +2322,7 @@ static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
 	pn_cmd.ack_timer = pn->ack_timer;
 	pn_cmd.max_retrans = pn->max_retrans;
 	pn_cmd.mtu = pn->mtu;
-	pn_cmd.credits = pn->credits;
+	pn_cmd.credits = 255;
 
 	rfcomm_uih_send(bthost, conn, l2conn, RFCOMM_ADDR(1, 0),
 			RFCOMM_MCC_TYPE(0, RFCOMM_PN), &pn_cmd, sizeof(pn_cmd));
-- 
2.34.1

