Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiEaUzX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344745AbiEaUzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:55:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D419D064
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:13 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a10so15419341ioe.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=ZNyRgjQ+Z70EEa//H0mHspLwn3KywMsBEEITpff15MmxmGKMMXq9yqt2YNBHAsIhKj
         jZN0adtdZHQ3VYdP4YiQsj528TT8JGz0dcV5aNJ3aZimodkNMzX37WjXlL9KPHSzxD1+
         se2Qfu83hDdyeH7QLc+OjlCmkVj0bu/+esNlSxXFSAS5JBRVYYWpXX2WscNCPELrxKYI
         BNxKNgt+iCyNId8tiZ3mKLimBdvcNg5AvXUVHHxMmi0Ecw3orwjQ5cfQEkY0OvbocV/4
         1bfGIg70oieNB+sQVE3YIaSr8dA43XuKlZwSeHM30WLRqVGooTr6SwIp/Sus9V38ZJ9A
         0Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=lajXDwNe7qpb0aGI2mQp9/ecunOhVsSQni/v9Ff3u0verTJI/13NNNQOAHPFU89go7
         AN+YpIOePKUqMjXnaLE4i5Sk7CEEGBtAijW2t2kSUl4CdoP8vGGHjFLfLZLjHwYMw+md
         sQaqNj/dLa6a+iYoP+LN1017hwDONnPTfCX8dw7ss9tXxKDZSWf4rlgAVv3NAmDwlZdi
         62+Oz82u0KLK0tmRTZCNGVTGEmMv55YbQ1i/gNQCZuIyZ0uDlKIsd5wMo0+H34X1+jeu
         4S3A7POB4Gn0QblshPNFsbyQJJrJXnbXxYtGFz//QfctVzWt70v9Kgl0MTg4lqKU+UPv
         4Mzw==
X-Gm-Message-State: AOAM533qJll9w/3fBsk6rWDMsKTccvTVcGUsD6LvByfBkYYH1avtdwfN
        ARk9qoozl6kLnZUbCbw9DmPELPiDuKg=
X-Google-Smtp-Source: ABdhPJyBfakJR7l4FI+wMX5+ea0IHvUVApO5IDDhSnWCUb//dhtvn+O23J5800swjp00EOhfDOCNAQ==
X-Received: by 2002:a05:6638:2485:b0:32e:e533:4159 with SMTP id x5-20020a056638248500b0032ee5334159mr19372631jat.293.1654030512613;
        Tue, 31 May 2022 13:55:12 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v1-20020a922e01000000b002d10dc367a1sm4808460ile.49.2022.05.31.13.55.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:55:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Tue, 31 May 2022 13:55:03 -0700
Message-Id: <20220531205509.1062466-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531205509.1062466-1-luiz.dentz@gmail.com>
References: <20220531205509.1062466-1-luiz.dentz@gmail.com>
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

