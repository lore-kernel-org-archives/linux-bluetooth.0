Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FEAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 06:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiBQGcC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:32:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBQGcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 01:32:02 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC4EB17A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 22:31:48 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d16so4164930pgd.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 22:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8ubtBNhywXSPHMUDhWuH1xqiy5cEFXR8e31SAkW3sU=;
        b=mNFd6E7p+iIpSCP7U6v6amEA9CUX1aVJmOFD7y81pPVQxI6c/dCcrisBHI+URTTsZK
         uV9i9zwBXd7DNT6Vcf1PlpqUyv+F5buGqVpAXV5DiIJIb7Y7DJ38qmbvSbHycZnJcUeO
         XtnxTQvXfx/I1gi5VffRjDFjkzArrZkBHY6K+K+Y+3/QUSwwLlPUKfVh7GNwjK7mN82z
         EVJuGve7pQF8LBD6MDViFTsIVCQlA+Ltpeb9civCskmd/mi+0Ad+6KKKuHy5BKrNJ6Sx
         BimtDCU+33NUI64+K4rUBfx6NceR9+sof6kXb4F6FBFzANjjXAipp9yDsxLGK4eKH3X2
         HW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8ubtBNhywXSPHMUDhWuH1xqiy5cEFXR8e31SAkW3sU=;
        b=JbtzBS/2oByIxUE6TZMgPS6/qcx2pU47ttv51A+XruQhPD33v/DZFziK6Y2crlWfs1
         AYgiT6LDzMKaRhzL7Koosb/yHQvF+ZCe3RJ/PUVUY91Jb4JluuEPwlUYqMK1Tg0K9D1y
         DZua/WtYZAl17mJNB1QbbBdmoEj/inYzXQ48cyWlNJAsHpBiU/KM+Hu/u06UPnawRVTi
         5X3ngZc97D3ViN05ejgS4HNy/LnqsSlFXa33gHfX+G8/z+fn06bhp1m6qWN+wq6cvEeA
         AL6GyCR/jAKavckeW8a4MCDHSYBCpXnqkVeB4ltlputxo8qpaLWNfFkCBbXYKfm0rzM/
         /5ug==
X-Gm-Message-State: AOAM530YqjQ60UR8z68Rc0lF1WSwyW9kmr/baATO8AgBNeZ/XRMpTepP
        GNmw76MEagoIubR+vNaJ0rHPWj6+RjU=
X-Google-Smtp-Source: ABdhPJzpzdLPgRNrSJntVEUxFPxh2LjDeVLnTJqLZ06kd0q9uepcE20lSaCw/4eb3sB/EaIPyHGdOA==
X-Received: by 2002:a63:fe56:0:b0:372:7499:614 with SMTP id x22-20020a63fe56000000b0037274990614mr1281435pgj.301.1645079507809;
        Wed, 16 Feb 2022 22:31:47 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::b99a])
        by smtp.gmail.com with ESMTPSA id z27sm6988104pgk.78.2022.02.16.22.31.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:31:47 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] shared: Fix the incorrect type with bit shift
Date:   Wed, 16 Feb 2022 22:31:45 -0800
Message-Id: <20220217063145.50497-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the following runtime error:

$ sudo ./monitor/btmon -w test.btsnoop
  Bluetooth monitor ver 5.63
  src/shared/btsnoop.c:339:18: runtime error: left shift of 65535 by 16 places cannot be represented in type 'int'
---
 src/shared/btsnoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index a29bc928f..0a68282bc 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -336,7 +336,7 @@ bool btsnoop_write_hci(struct btsnoop *btsnoop, struct timeval *tv,
 		break;
 
 	case BTSNOOP_FORMAT_MONITOR:
-		flags = (index << 16) | opcode;
+		flags = ((uint32_t)index << 16) | opcode;
 		break;
 
 	default:
-- 
2.25.1

