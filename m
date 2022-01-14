Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jan 2022 22:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiANWKB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiANWKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 17:10:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37CC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 14:10:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso14307507pjd.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 14:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqeC7/uqbCWSa4exECy/H1Jn/IUxGmmEMEe9B3hE86E=;
        b=dNP+DfMqsf00nTGpKnPZECXol0LnF3Rp4VRiNRAM+Ry/4kF2Cbos0FHS4gBHIcaPx/
         p8OngSeREPjPERuDnuRI5oeK8dL3qE/t1/7eO6vrrDSzGR7nOci23nldf1orYTPZ+t1o
         cC2GpR985z5CJPDbw3stnHoZcOGmYr70e3jskKvEK2AWlickDYTR4wKH5/c9TJB6k9mK
         zYkx7tXQ4qXR0F1YBcQP5/LrJ/mrrcAHMsXlR1bOqqx6nJ2/XiRO7XC+AFvdeQCIO1If
         VwmXQ8Yaa/QDfOHPkkmkq5M7tnB6ZV9E7UMKfrguV4XOUNL/RiIxA3mvfIA5XcdLIsxS
         +N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqeC7/uqbCWSa4exECy/H1Jn/IUxGmmEMEe9B3hE86E=;
        b=LrPrjN7IuUqSTA42deu2S+IYoGG+xMttkm1og5N5JMq735vfTCKosjx8YEJd7L4irS
         DJ1QsjN1ELLzLcFEdzssy5U65etJuqcHky4LjU2ljiLLn5G8fS5PkPU3pEcxGKqDwwBm
         /MB4yGr4Pov9ymogIFxWAy8suAawQY/UwnBKkYeHbBtMi9rTQD28pAev3n3Ao/Pc8x3j
         wL8pgMoALS9D0K9R1B7P9nRt4fSiwN8JdrogCqEXcjNt+/cPGxhuA8VcrUjVu9ZPZauU
         Tj+jgdMAbf91FHHpuu7qe5Wu0yfBX4nNxMup3yhaOmendS5ZOi7k5E4QQWk3ybiVbCdB
         bZlg==
X-Gm-Message-State: AOAM531rYFFFrw0C/WTy9LOiRt3Uygi/Ty/azsRcv31EfPnnlGv/hkuj
        +0kDKah0DgyUoD4k5OvDewZbcvyT65M=
X-Google-Smtp-Source: ABdhPJxx48yKxkp4HPbiIpt0rNFvd//eG1olplt4qdYsTwmwtpqwg3+nYwfZN92ms07MhDooKehC9A==
X-Received: by 2002:a17:903:32c2:b0:14a:2099:eb38 with SMTP id i2-20020a17090332c200b0014a2099eb38mr11717206plr.58.1642198200276;
        Fri, 14 Jan 2022 14:10:00 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k19sm7220081pfu.178.2022.01.14.14.09.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 14:09:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor/avctp: Fix parsing of GetElementAttribute
Date:   Fri, 14 Jan 2022 14:09:58 -0800
Message-Id: <20220114220959.917157-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AVRCP byte order is always big endian:

Audio/Video Remote Control / Profile Specification - Page 20:

 'Transfer Octet Order; Packets shall transfer multiple-octet fields in
 standard network octet order (Big Endian), with more significant
 (high-order) octets being transferred before less-significant (low-order)
 octets.'
---
 monitor/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index dc03195a8..fb2628282 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1192,7 +1192,7 @@ static bool avrcp_get_element_attributes(struct avctp_frame *avctp_frame,
 	for (; num > 0; num--) {
 		uint32_t attr;
 
-		if (!l2cap_frame_get_le32(frame, &attr))
+		if (!l2cap_frame_get_be32(frame, &attr))
 			return false;
 
 		print_field("%*cAttributeID: 0x%08x (%s)", (indent - 8),
-- 
2.33.1

