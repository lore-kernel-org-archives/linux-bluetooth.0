Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFCC282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13BD218DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYNq/zUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfDXIj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:39:28 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43458 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfDXIj1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 04:39:27 -0400
Received: by mail-ed1-f48.google.com with SMTP id j20so15123838edq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ziLQF++THfmGlS5v4VvJuBeywwctjd7oWnZg0WevTus=;
        b=LYNq/zUet2gXBReCEKAsz+O9MSrHwJ1gdGYdsXfGWV3wLskJ7VKkKZhBV6/Aj9fgLb
         ww5IZ6ZaDgA8x5JeULPrLBqGTuEv1UWZV6hoD1/MzhpngD6f6e6P75f8yNxJ7VFfNXPi
         hp0GdDMvlzIIc7/gmwQqtIvEl/2dD78Yqriu40ewjuHB6o+NLtx4oweeNT7GkjK5eyT1
         m6795h6cz5w1hGRbIbLP4RPRhKHsurgAHCZuLDUzFtkaVAVCxLy5qN0T8teumdB82InJ
         9V4rQ5YFAN6n6uQsRVRN389rTS8pmiAW0ULsaPEit65kF+c5OW+g4xo9BWU8HaHxvBoy
         xpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziLQF++THfmGlS5v4VvJuBeywwctjd7oWnZg0WevTus=;
        b=AOeuDiqrkpphIK7EKCXQWeEOf6MLffsAUqfbsfKmsDaqh1zjPNwAqc/gikgm6VLmME
         7BgTjblFCYHVSLAGsAjbV1ABgJfjGAM/tFaHfJNFv4a9vJC+uz5g198NLnZb8G9IPF5w
         dFGPcIl6ffJUEr0pQPX46IAbtC4MJ+SW+D4iClxw2QpMN/fgF4Zd9JQFG2zf8qNnmjGR
         ZdVTcpe0kI057PDeso0OUlszjD6XMi+PAV3vUobXLGx1gYz6DO/a51KMy6FQf3geNBlP
         +7VeN0b+bxqXvQjroU0JtWU5Yia7QJLnwmumERYUUAM7S5AOuWGWATTNNtZ5/BSlHp7i
         jCNQ==
X-Gm-Message-State: APjAAAXtGPh6nXRL8udUI/p5dx1qMemMKXoEmEFik892i8u98EJrQijZ
        qx1ZedpHgls2zEios+njelROtM0SuIQ=
X-Google-Smtp-Source: APXvYqz3fk5Ipq9BOlProCIWc03JOmnY5bIQdB0HlMdCcmrwbZdNMo/LvQkG+hrBjK54apZX5AGSXA==
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr15479654ejb.108.1556095165576;
        Wed, 24 Apr 2019 01:39:25 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h57sm5430623eda.90.2019.04.24.01.39.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 01:39:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/settings-storage: Document LastUsed Endpoints entry
Date:   Wed, 24 Apr 2019 11:39:21 +0300
Message-Id: <20190424083921.15679-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424083921.15679-1-luiz.dentz@gmail.com>
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the use of LastUsed entry inside Endpoints group.
---
 doc/settings-storage.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 44b0b4961..f595f9817 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -169,7 +169,9 @@ In "Attributes" group GATT database is stored using attribute handle as key
 all data required to re-create given attribute. ":" is used to separate fields.
 
 In "Endpoints" group A2DP remote endpoints are stored using the seid as key
-(hexadecimal format) and ":" is used to separate fields.
+(hexadecimal format) and ":" is used to separate fields. It may also contain
+an entry which key is set to "LastUsed" which represented the last endpoint
+used.
 
 [General] group contains:
 
@@ -220,6 +222,9 @@ Sample Attributes section:
 					followed by codec type and its
 					capabilies as hexadecimal encoded
 					string.
+	LastUsed:<xx>		String	LastUsed has one field which is the
+					endpoint ID as hexadecimal encoded
+					string.
 
 Info file format
 ================
-- 
2.20.1

