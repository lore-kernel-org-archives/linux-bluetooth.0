Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F42EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F52D611CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJTVvF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhJTVvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E8C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t21so9035337plr.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ndjWbXCP42+Q0KhyY6fdnIZgO4C/N1hZKNFhKSb9mqM=;
        b=IkX+kpp0KWNTjF5TCzM+DOyCQOJ/79katJozrrn2Fg1GdLgGaHpIDiTMQ8C8oRYcfP
         iZFdY6ZQMq1V8VpPqT/IC7+JLxvFKPY5SEIPMj/bAi2CbLfpd9iujmMYti9W4Z38qX7K
         sTFOd8h4cghlzMh+m7bbJfUFbUqnHLm/idHms7S3Bo397cYJeM9ErBjVgxeiEGt1UYb9
         p9VcueEJzIwfITh1GTJVoXPxfENCRkI670sZncF5z/hbYMAY6lqj5KLICqsKUkfCVBKu
         mdkraeDU1MFP4VATjvf+4VluaUEOZgsLoimTVYPt2cb6sqSvLfhIXlL2E5mKkn7ON6/O
         BsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndjWbXCP42+Q0KhyY6fdnIZgO4C/N1hZKNFhKSb9mqM=;
        b=enF6xIDEC9E0XQYeuaxm9X5lCv6cCd0GK0nFJqtNbyGoDatWPibB71slgLkpoBWSQq
         5j0ib7v9VBqLGl3w6fAqA5YlwfzNuGAZoZf7tKe8bgrO9rJPWUVm7qA35kLE3mkxIm5H
         mlTlg4cQ8TBdg9/o4BTsypfp0nYgqaL1F0QQ+FpLr+Rclv/2c4SbOWb3KE0kV4sTqaAq
         Ny52RZ9EHb4eWyjEY9FTf/vxnmwhrXZwPYkS4sB1Qgu/fayCu7x9Rx+MT7NpZ1Vgp4vU
         GCWqhjIVQ74ymyf4vajfW0+QJpNVsW7Yny/ewITT8hYj4MlHMUSZS4Xd5z3foW8fSdqH
         91zA==
X-Gm-Message-State: AOAM530UPZM7r9k28ZRE4O+02TpiurUkX//XX+BgM9JNp3XXgYX7Z/bb
        KpKzIhQdRa0BSrYtU3c3MvXomV6FAho=
X-Google-Smtp-Source: ABdhPJwu857tmrDpDKXB2bDMrpIUdAeaczv/caoX3Ku3K5VoD0jKoyNNregwd3kShaf1KZ/5hDaP7w==
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id ij16-20020a170902ab5000b0013f4c709322mr1414723plb.89.1634766529182;
        Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13sm7257664pjl.15.2021.10.20.14.48.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:48:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] monitor: Enable decoding of MSFT extension with emulator
Date:   Wed, 20 Oct 2021 14:48:42 -0700
Message-Id: <20211020214843.431327-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020214843.431327-1-luiz.dentz@gmail.com>
References: <20211020214843.431327-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables decoding MSFT extension with emulator instances since it
shall be the only one using Linux Foundation as manufacturer.
---
 monitor/packet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 9b81cfc89..9030f2493 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4021,6 +4021,15 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 */
 				index_list[index].msft_opcode = 0xFCF0;
 				break;
+			case 1521:
+				/*
+				 * Emulator controllers use Linux Foundation as
+				 * manufacturer and support the
+				 * Microsoft vendor extenions using
+				 * 0xFC1E for VsMsftOpCode.
+				 */
+				index_list[index].msft_opcode = 0xFC1E;
+				break;
 			}
 		}
 
-- 
2.31.1

