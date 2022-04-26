Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C17C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355996AbiDZXHE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355994AbiDZXHB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 19:07:01 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19778C7DE
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f2so314255ioh.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Upa4p2fK0/wqfCCgaMpeFcUQl2tIIqKk2ieT4fuRaVM=;
        b=EG8ACBZvYOJUEhFPqF7JamjJZyvLrh3A5+0WsZ+ubImCtzxFUNbMNjKntNT/XKmiRK
         DAM4twuPTSC7sadQVqyOXhSNhMe2ZimRkcWmaKkIJdP6vx7cwabrxwkFkcWB8FCRgke4
         k67uv+K6CjWTcfA28mLJFPjaRU+u3YLV+AuJ0ZLONL/QCCYXOQq413YQ7qnHAd/nrRWA
         76jytvt0Vg5G5BKDjlGGLJhUAkUTDeJhtfaOxfR4vV/cmLcAcpX61f2c6GY+5TIaMMV2
         KWltZxDdmcz/KQZd8ALiUChEzgnw2pxLh4sI3bcgqIsXBoZsHXQbxboAnCleG6ArsxH2
         pg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Upa4p2fK0/wqfCCgaMpeFcUQl2tIIqKk2ieT4fuRaVM=;
        b=PNjYbgbXXwoMvXZAl6VeeWZJm/o/mz38m4jHE76lrUnnkrzFSUvvs/sUnggmJtuS0L
         jrOk2SzpeCPMSJzDMp3s7P9X7r+l8zYAPT2H4W3tKyrjYnGOCD8PJKNdnVM8j9B3DwZH
         u5TfITlxkvgGwLBgMesALib5EwQatQnlZe/4A0PWzqFGR3+3SW/gGrVXn8oOW7l4VcMQ
         L+uSmNtsCDSHcllmES6I1ASCWc0Afeodk6Fjm7a3B+6WFkV5CpizLxB6JicJvoJUGK4v
         uExPU22CkwXxS/JXegw6vNZ+2L3NDBqQ48xb4lPQzB+Gia/x6XagCXZUH+nf8RoLb2Pr
         aKJw==
X-Gm-Message-State: AOAM531qvJatYj2vFz1gBrb3afIpJUDmXryHxS1Q0tesgZRdz4AUokXI
        akYIugNeo6XUj8pSWbuVUQ24kZspxmY=
X-Google-Smtp-Source: ABdhPJw1l/RQHLBFsZ9Yp3Wc74glhpkg9G5/Utqi7v67Uow9JguwkYbc6Thj6jjYgX5ujZFS3yfObw==
X-Received: by 2002:a05:6638:24d6:b0:323:cda4:170d with SMTP id y22-20020a05663824d600b00323cda4170dmr11009789jat.269.1651014231806;
        Tue, 26 Apr 2022 16:03:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a056e020df000b002ccc1d58ca5sm8437194ilj.54.2022.04.26.16.03.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:03:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] btmon: Fix not decoding LC3 id
Date:   Tue, 26 Apr 2022 16:03:47 -0700
Message-Id: <20220426230347.857783-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426230347.857783-1-luiz.dentz@gmail.com>
References: <20220426230347.857783-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enablind decoding LC3 codec id (0x06).
---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 9d7677bb1..d409e4e63 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1337,6 +1337,9 @@ static void print_codec_id(const char *label, uint8_t codec)
 	case 0x05:
 		str = "mSBC";
 		break;
+	case 0x06:
+		str = "LC3";
+		break;
 	case 0xff:
 		str = "Vendor specific";
 		break;
-- 
2.35.1

