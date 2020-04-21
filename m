Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A2C55186
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBEB20724
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGEdqjt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDUWZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgDUWZ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 18:25:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968F8C0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o10so64680pgb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NqUyV570SxIwHn5IfZYHj6GJexRq84v1iT9G6VlcL1E=;
        b=fGEdqjt3Sr1/Yf+7N31XQyWfEn+qPbwcq80632bf4cOtU2GuMOll5N/VcEoqA0beJi
         ml61rZ20wIOzCNIDXnaXRk5tNwjyaFEjGFKxdZ/OhlxtYUC3DVE96mCwQRcU5Bgtr6uG
         JnYO/1TyW3n8l+O7AQxxIzxDE4qDrKzKGirsSSxEW6RvPNzyQXvP+kj+W8telJnVWbB0
         q289q5FqDSvlP9TGd5xw3O3x0N1U4m4sPsuKOt4VIgB5jYHoKdCCcyTaiK8cn+6ctZ/d
         cymdmtIym/8OuCzVBY5p8rK04fQ2Jo03QJ1eETrQVr6KmjbuNEevtmxmWmjSM/r7sTZ9
         +ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqUyV570SxIwHn5IfZYHj6GJexRq84v1iT9G6VlcL1E=;
        b=mPXp/EsKV6MurGeRBVCcPGVXTj9ipfv4PImkfTFUFDGCkKZFycas7M7HJOs72Zsaez
         nblyzMZGhc//ETupaQ5Mg+HdAecOdCpbHyc+/S6+pQPESl7rqE/fLx+UuxCjj9LxMhiH
         xpgoBSsqlUzEvbAT911bnAVB6aJLdQFianAbQgXlAgDZAM2gUwZY+VXyCbz3BzpQ9b0n
         Pn/tWfCFCJ4Z2RNvxvz1XCOucHXiDiXMNtfrtk04cHtS8rRctG1MAJ7gFBum62Hvos5V
         TeZCFJ6v/vVQGgGx3+bF2a7VDws8Xbc6rj0SI8u5fsMqfBadsVgCd1f9khHTj/uFITew
         mMBA==
X-Gm-Message-State: AGi0PuZY1KcgcyWR4U7FqyXbb4Mc/bA7mfIf7nC/XKLg1t8gm2qLhtA+
        xt/8B5WAuhtffv+lyXvgg5KRVOT8lyo=
X-Google-Smtp-Source: APiQypL1+/cQTNtvS55YAs4TzreSWYYI9E4kgi7UxQdUJ2NFzo+6FA3vqmcwOsks+5tLkf7zvjhdIQ==
X-Received: by 2002:a63:1e5a:: with SMTP id p26mr23165151pgm.233.1587507925788;
        Tue, 21 Apr 2020 15:25:25 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e196sm3384040pfh.43.2020.04.21.15.25.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:25:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] emulator: Add support for LE Set Host Feature
Date:   Tue, 21 Apr 2020 15:25:20 -0700
Message-Id: <20200421222521.226385-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200421222521.226385-1-luiz.dentz@gmail.com>
References: <20200421222521.226385-1-luiz.dentz@gmail.com>
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
index 0de273e53..f9e1e6675 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -469,6 +469,7 @@ static void set_le_60_commands(struct btdev *btdev)
 	btdev->commands[43] |= 0x40;	/* LE ISO RX Test */
 	btdev->commands[43] |= 0x80;	/* LE ISO Read Test Counter */
 	btdev->commands[44] |= 0x01;	/* LE ISO Test End */
+	btdev->commands[44] |= 0x02;	/* LE ISO Set Host Feature */
 }
 
 static void set_le_commands(struct btdev *btdev)
@@ -3861,6 +3862,15 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 		break;
 
+	case BT_HCI_CMD_LE_SET_HOST_FEATURE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE60)
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

