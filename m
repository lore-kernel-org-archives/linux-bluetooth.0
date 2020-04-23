Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA4C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000702077D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW98+kaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgDWVzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgDWVzI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 17:55:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD2C09B043
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a32so3056351pje.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qJVViqJR7g6FgE7qSe5uNjE3YJbXGxCZdT6LNpqcZ7U=;
        b=IW98+kaWpLLQhRHLqDMLMMPm6Tc9kh03qR0CmoS+4sRCGKSVmfY7hypZEvmSFVkd6x
         7f/VGQhTC4SQVHw3QqnRwXV8rTb0fZ4UzbxWV5NEE0595QuYUV4ziog+Y5GlyWmMmhhY
         XIJX2kGQUAaTuuPUzgp8poZO9d/qqc1N0X89gydpGr7lT1lHdW18PylmzJ23WMch+Roo
         YGByLYNSU1dEB/7ix5G65wgc0uBpIGkrhibuf0EVcC/wSZvJbN8DSzuFut81I5tx9shJ
         rocS2m/lUWRphf//hwq7tQwR9EAhQvzgQvBXeqEEonCKeFtByRs+G1FYkfALLCeE7e63
         asHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJVViqJR7g6FgE7qSe5uNjE3YJbXGxCZdT6LNpqcZ7U=;
        b=jpNQcNBw202frV1UxIFnzzCxBDZRAEBuOxCGWCutxcrmM05vyOX6a/66Psz8unR7Wx
         vUp+3fWsDHaIit4EWxrWLRqa+eJI5gp24rRn1S0ALyEFrJl8AdkXSHE9SmIJ878gLT2q
         Q05lS8jtRDB7DQdWSeWd2ATVKzERJrNDAm4GartMMKRksIvbq8RKvHpW11LS1yyUm450
         ShxOk9qbSw/17X40msvJHwO5FrJThKclOZf4Q6wrVtfPmbyE0t71Dobgxrc526kkPrCu
         4n2IzhFKHPkv78WG2/YG38nGVk4V5Y/mABUCBV9VH3lUF6BQ0uCOVTWO58oaecJBvkDg
         kN6Q==
X-Gm-Message-State: AGi0PuamK1kHceVZ3l7EI0BoFMBXSvuySR13XISUaYAgo8/ysVEWssoV
        rIvWomRdtjM9bTKslL2bcR+aep87SrE=
X-Google-Smtp-Source: APiQypJ3HMkRu+/HaoSjflbRmVRRht08YPe/6plahPMT3AWAGbn5qIFU4V6DiSCkLkynVh9xbMg46A==
X-Received: by 2002:a17:902:d303:: with SMTP id b3mr5921766plc.12.1587678906804;
        Thu, 23 Apr 2020 14:55:06 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k12sm2972294pgj.33.2020.04.23.14.55.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:55:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] emulator: Add support for LE Set Host Feature
Date:   Thu, 23 Apr 2020 14:54:59 -0700
Message-Id: <20200423215501.427266-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423215501.427266-1-luiz.dentz@gmail.com>
References: <20200423215501.427266-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements support for LE Set Host Feature
---
 emulator/btdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index fc2fb2065..cd355e73a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -469,6 +469,7 @@ static void set_le_52_commands(struct btdev *btdev)
 	btdev->commands[43] |= 0x40;	/* LE ISO RX Test */
 	btdev->commands[43] |= 0x80;	/* LE ISO Read Test Counter */
 	btdev->commands[44] |= 0x01;	/* LE ISO Test End */
+	btdev->commands[44] |= 0x02;	/* LE ISO Set Host Feature */
 }
 
 static void set_le_commands(struct btdev *btdev)
@@ -3861,6 +3862,15 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 		break;
 
+	case BT_HCI_CMD_LE_SET_HOST_FEATURE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
+			goto unsupported;
+
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+
+		break;
+
 	default:
 		goto unsupported;
 	}
-- 
2.25.3

