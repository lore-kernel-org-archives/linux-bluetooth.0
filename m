Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE79C04AA6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9692087B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEJpuqKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfD2MDH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:03:07 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:40758 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfD2MDG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 08:03:06 -0400
Received: by mail-ed1-f45.google.com with SMTP id e56so2591113ede.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ziLQF++THfmGlS5v4VvJuBeywwctjd7oWnZg0WevTus=;
        b=UEJpuqKM9O9bZYcyL878YZpRn+W5pnvSn7bNxCbcdeQ6/yhQWp5kcuyr58g8B8Qg0E
         eZqdFKgsel38IwMjzr/W7zpdh0ACBghDtO1/sg4lHQsl3uK3e2VgpAJXTbXDML2bw2wI
         eUBDAONqycTeEaR3Y3Knr+33sqMAZDFOs7gOYczIeClfGEBQwTey1BgtnklL8Y0qIxbQ
         YkSnH1l//XQisGemSew/9vk7PSxcMlGtdkyf27uGD2omgba5PdhUH6qIdI6DGrPuNXLa
         NOAsKjH7vQCUEsv70elAfXrHage41XpmU7jfC0AKfxMCVucMkzY64JTzcMxDBiMZmto1
         HgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziLQF++THfmGlS5v4VvJuBeywwctjd7oWnZg0WevTus=;
        b=JMyxJaaKPBR/pd7RFg9h4hnvTv8EeapMkYJKW/pK+2xlEoSVe/vyD8cdc53WYGd5dS
         qtJ+vYn1PYkug67ej1fSVe7T5mJKRfhRdn+2nRGH4AD4+4o53MEB8GqVWdu6Q7dpL/oV
         I5TzyhFUuklfXdmND/La5gbcKabrMzxamW1QZ+6cQyqxOuRv002VZSrEKFrA9m+nS1c/
         70/7W6pfQgmuQr+YO887cI3ud7EucVjD1YcWLAxgKvdnRPukDDHA5lc72Cd96QfcMiGo
         XlgoN6D0FkSLR328no0N+TkMjVrZ6EMD1y8YGVACXUrWSkEMnFL6MyLo/ZjlBREQ2qOj
         RtoQ==
X-Gm-Message-State: APjAAAU4D5XtQAhfTLNSId1wiGiY8rGasJI342yFPKSe5cknXJ71iX5x
        NADpLFP4/1FQnigHsxbKyKwyDpuPPPk=
X-Google-Smtp-Source: APXvYqycyTVXrU1AvzGpN853T2dexPguCUPbSGWlXyAOMLZlt8Vbbs3WQlHjpwlmxd6rHLkivMMbEA==
X-Received: by 2002:a50:9785:: with SMTP id e5mr14563195edb.94.1556539384166;
        Mon, 29 Apr 2019 05:03:04 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id 10sm5783306ejn.37.2019.04.29.05.03.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 05:03:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] doc/settings-storage: Document LastUsed Endpoints entry
Date:   Mon, 29 Apr 2019 15:02:58 +0300
Message-Id: <20190429120259.17880-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429120259.17880-1-luiz.dentz@gmail.com>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
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

