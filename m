Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47758C00140
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Aug 2022 16:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiHUQFg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Aug 2022 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiHUQFf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Aug 2022 12:05:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D26BDFA7
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 09:05:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso9082864pjo.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XXxKGTkclPLjZhgu6hyySCx3gnBCEkTHxXOS24p1d1U=;
        b=KjK8yLyrRQ7v1w13DwKLv5eoL31Y4jMit7uYxyRWtjFq0399ioTPXgjgWJVCu8gU4z
         41KQbHMQUPlqkywiw+ze0ihjBh8C2Lrs3RSeju9v9LMqpKUXIWsAL4UFB1J+eTx5+Xe5
         sKh61Bfja5T3IhipKvAesfct2HaVfeXc+sG8iSidODszI63HrVN0z/6Ds+jec/WHj78s
         haBICd8s6c99xDlg9JVfdtpwInifZCcPOh0GEYRPkMAWo4iBFUzua9kuK6eUhU1TY9UZ
         ROnaNtRQJjqVwRNcIERFqDp7QV+RsbHkpi3u/qCMe5OmEsLYbpe8WBleSmilBDOJ3yu+
         fg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XXxKGTkclPLjZhgu6hyySCx3gnBCEkTHxXOS24p1d1U=;
        b=Nhz8+sVMYfQ6X1WnHvkVSi9Z4s/D05AL91sau/03OSVSAtXumNRvgAWTA1WTOO3+oU
         +pN5zEaKi5NHOAbI/+cXVsFNHAQ2yU6vJ8SjmnRNDu7INTYa09r2hk0qrGkDzotVSwX7
         zx9F+qDqbwr7uF9RSXoOHG1fAeM3H5P+o13kstILB+pjnpMunylR2AQtSy4WKG8UufHI
         OvGLvwEJ26IczH/qgDkHy9c5XkuOK0ZzX4do/iwHwAwImNjM5BZTj37D3ALZZpjE6JT2
         063EI3AuzKh65w1g+LhABS0rMn0bcGTuDt+4YgD16AIM1PmA4Nt8CYvZG8IORwGLAR4B
         M65g==
X-Gm-Message-State: ACgBeo0ggvMRXmXg8hQtFi6FM4OJwzs8IuMJnUIfQcJJVboXQfxUsTLw
        84KhYQy1eV066HvzmABprfwYA0CQxcnxaw==
X-Google-Smtp-Source: AA6agR5kjegiVQ01ujGmBY/z0h4FPFiw2a9FJ8uVUf5r0bb4ytFtVFEHghvgSrP4fx3P+hFnSZc25w==
X-Received: by 2002:a17:902:db0e:b0:172:b666:f475 with SMTP id m14-20020a170902db0e00b00172b666f475mr15242891plx.58.1661097932879;
        Sun, 21 Aug 2022 09:05:32 -0700 (PDT)
Received: from localhost.localdomain ([137.97.86.182])
        by smtp.gmail.com with ESMTPSA id s8-20020a63f048000000b004297b8cd589sm5826187pgj.21.2022.08.21.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 09:05:32 -0700 (PDT)
From:   darkhz <kmachanwenw@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     darkhz <kmachanwenw@gmail.com>
Subject: [PATCH] shared/util: Correct UUID for Microphone Control
Date:   Sun, 21 Aug 2022 21:32:48 +0530
Message-Id: <20220821160248.3481431-1-kmachanwenw@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to the Bluetooth product specification list, the allocated
UUID for "Microphone Control" is 0x184D, not 0x184C.
---
 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index b74a005ce..e1e56459a 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -338,7 +338,7 @@ static const struct {
 	{ 0x1849, "Generic Media Control"			},
 	{ 0x184b, "Telephony Bearer"				},
 	{ 0x184c, "Generic Telephony Bearer"			},
-	{ 0x184c, "Microphone Control"				},
+	{ 0x184d, "Microphone Control"				},
 	{ 0x184e, "Audio Stream Control"			},
 	{ 0x184f, "Broadcast Audio Scan"			},
 	{ 0x1850, "Published Audio Capabilities"		},
-- 
2.37.1

