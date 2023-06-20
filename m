Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C93EB64DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 20:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFTUlC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFTUk7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 16:40:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3907A19B
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:40:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686708c986so3409537b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687293658; x=1689885658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZO83YbwPjy+55gJL4x2i6tv/Ca5kNR5Ca491mYGa+E=;
        b=EOrKmqsoTL25cnzUTpMy6AZgCvBnbNcHLezzoyyXpYbn3TDF4ojrHOefJacHGFywDL
         FCaPv0gPBKxK7KaEgrp3siOO7o6Wz70nmYYnLjASyqD0mPILuLuDe9HEdr0FSNpLjt7p
         PHPQWc1KYmmJEG3pCKOfUEz5WEbU4zQEhxQapVdWIT0h4n0ayPy/Ikb3LBj3ca15/BEC
         +aY4SLQYmERjh6NC3jwVjGrBYhLLcEthCtCrna0M7BphGsIdWCeyFsL233FKgMDfkkV6
         /tGaxyHP6f8FmWpX4vPCCQCjey6O5bsKGbFJP/oQ58dC9RLFmhgE34tTxbHekN9L4TYu
         Qajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293658; x=1689885658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZO83YbwPjy+55gJL4x2i6tv/Ca5kNR5Ca491mYGa+E=;
        b=MDWTft0MIHbQCxgzBBQ6JGyrngYxV7528q8wQtFWOITNWjQSixkThYAMs6a1kHe6F0
         OqQiyAAxSCvIHxVerObqurK/xS13HHhXvreKcJQJIghBpQPvxIcjAMhZCBsbtIkKcmvE
         +582zBieh+eDN0fdRG6UcbBJXCiNaEY0ZD1tRlcs+LUb5fw/ngXZYOZ6IaZpeRHNOTMS
         uqIwPbVcSULPdVFqUTZDtuxQykIJj/X7Gt/RnCJgILrNsj6WyG/GjkQ/aPeB41WcDk4f
         gpuUrVrkBRWpkmBTROpazF04IBsdPYGRjnL+hyoe1ePhP2wprJuSxLvf+xQVEsTZYVw9
         Pl/Q==
X-Gm-Message-State: AC+VfDyXaHh72d40pI4UwuLzwxZwRvDfFgMq1oQh5GdO5CRygXzNiPMY
        Pa9uMET1eX+9OCAjwOGtAcTJY8guCo1rfg==
X-Google-Smtp-Source: ACHHUZ7rDinzcrQkKLyEPHtszhCLerJNsRgriLiBGVVY+n2yHn4cdjB+Yx6OJizpRlk4NsbMlJu9VA==
X-Received: by 2002:a05:6a00:8d5:b0:666:ad0c:c0f4 with SMTP id s21-20020a056a0008d500b00666ad0cc0f4mr18289988pfu.23.1687293657788;
        Tue, 20 Jun 2023 13:40:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79195000000b0063a04905379sm1691596pfa.137.2023.06.20.13.40.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:40:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] monitor: Add missing flags to MGMT Device Found Event
Date:   Tue, 20 Jun 2023 13:40:52 -0700
Message-Id: <20230620204053.643608-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620204053.643608-1-luiz.dentz@gmail.com>
References: <20230620204053.643608-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing flags to MGMT Device Found Event so they can be
decoded properly.
---
 monitor/packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6d73e5abfcbc..4473fda29a46 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12858,6 +12858,8 @@ static const struct bitfield_data mgmt_device_flags_table[] = {
 	{  1, "Legacy Pairing"			},
 	{  2, "Not Connectable"			},
 	{  3, "Connection Locally Initiated"	},
+	{  4, "Name Request Failed"		},
+	{  5, "Scan Response"			},
 	{ }
 };
 
-- 
2.40.1

