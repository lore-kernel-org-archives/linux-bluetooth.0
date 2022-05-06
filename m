Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20933C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444718AbiEFWWH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391110AbiEFWWG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:22:06 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A87CDF43
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:18:22 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y11so5659313ilp.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=CZy9qrgiFazTtXZBY35mx0enXi8AR5CJHzilglzTfZq92uMCvNRQKrW+A5XMZr+CLg
         MZ9pp8K6GFKB3cXgVjFpLPHbsEGdMTdgWynZhapwJKkpEA8oMfv5mv6UF5OdtmeTmCpx
         xd62WtPeehpLLtM/pHgYAQgE84Jeol9WXRnBikgM8MOXlz5R6v/YBnH9IEKOYotvt2Vd
         pAG2hRvfDQJ6WXWIMb5mcXPa8ldICl7wHX4tjIRi791PVRCKhtSo0K3u+vm7EXIu0xk7
         8fBfLazoq3ZXpFsyccEp+VjAxu1cap6SBYDeMmGlvkrL02Y2WhBBAxRTNkM48Q5y+k4V
         MEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=4/mcosy4dKpLUTuId0VCjsvo5hy+yfXGr496qUTZpEyvOZaCBIXnis1faayMg9I/Bj
         P6U/HcGTqKH+35FllAtlrrLPzDqsKfz7VdOfs66inz62keSLHBJd9pizoMwlQ/mbc9xU
         lGyjFOMo0FvPl9iguF8SMOK/vSqL+FaxjbvUK5haqUL5AqOc8h0Uy/IgzQ2hZu6ceCVx
         OXzVHTaToLGahxR88gcCtB+0keLdM+aeE70eGqTYiKzbnAwWWF7ZtECNvX4GBCICUl2+
         YP3UsqpJePI6pz9tSAs3AybSbtN0jLoiJ8qG45TXFVt0S/sfyRLY9Kd0fOOYDu7vRH9k
         WeKQ==
X-Gm-Message-State: AOAM531bM+YPtcmrdmV7u0WJZ5+Hl5ipI32J0+ii7XNcDtOUaEp8ogQu
        Yox0f5eXvyyteG0SqnKrd2fFoPeWzYs=
X-Google-Smtp-Source: ABdhPJzEv9RamZA3+O+ciHMEZBTfh17M1TOf7kkih8+LhdC1Ek+8fVo4AcFVSBr78Xas4wdtD+kwtQ==
X-Received: by 2002:a05:6e02:12b4:b0:2ca:e755:ee4a with SMTP id f20-20020a056e0212b400b002cae755ee4amr2195952ilr.65.1651875501418;
        Fri, 06 May 2022 15:18:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g4-20020a056e02130400b002cde6e352c8sm1480822ilr.18.2022.05.06.15.18.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:18:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 2/7] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Fri,  6 May 2022 15:18:13 -0700
Message-Id: <20220506221818.3933843-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506221818.3933843-1-luiz.dentz@gmail.com>
References: <20220506221818.3933843-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.1

