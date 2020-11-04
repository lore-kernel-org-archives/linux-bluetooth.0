Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FBCC4741F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D5B20786
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkW8lYDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbgKDXml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732863AbgKDXmi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:38 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF881C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:38 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e21so173639pgr.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I2wQWVcRf4N1MbmSoTwL5Uo3W0ejdtifRaxI4lK0kZs=;
        b=qkW8lYDoV7WuTPOHPOZotJEFhAwYuLE10hYXYqhZtJOTIe+VomAM8+zQHoWZQKGhwi
         QX/OY9M9xMF81G7F60q3kne55QDJfdFORPWPtmJB96vZjL23ehQbeHv/dQGw7c/dZ8ot
         4x9ErtNgjdNH1kveDgWDZtHJzxPHwf4kA0yzTCSmVzwHXY/37FxR8e43MBl8xeVZwhs1
         AdvxGHgKAwNRI0JRxlJYpXZDxNpy4y50IF+FPGV0pzGs/kPct1i4oq+FEBTUJfgEbmxm
         jAHd4ouKLBf0RFG34Ao6oGEiNeSxNHN+FKcb5UcLhXdTmLOhShKFHVhDOSX+tfNZBuKb
         va+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2wQWVcRf4N1MbmSoTwL5Uo3W0ejdtifRaxI4lK0kZs=;
        b=i0q6hutbU+cjF7rE7LVvravDDfmtbDLOewUUgPKJx6Qlm92WkbeWZB8UY7WD6zA6O5
         JLqG/baevrqz9d3LcICGOC5X516GAaUP22Kmp+F/drwV/D+d1Dkxv+MIxQU0wK9VAY9K
         J/ufkFuR8s/O1l770yvTLtSeyAF0ju6Dl3JCr07+gBkfCg3GxIYlKu2kAUWXW/QyVEwO
         DnJboT4IQ+uXv5BGsWWDN7I/BKWIuxaui9LSECPlbNsjbcNPlr7BalIA77M5QOxwNspd
         OeReCaI5xjJlvZk/8+aANclu8nyk8e3xtzg3j/JfxZHwWetCqi6MoO4zKjXtwcSrMesE
         Ow8g==
X-Gm-Message-State: AOAM53196syF0lBFAxvuXAPl1jJQIyrLmhjoaXinfuZaOOZY1pbow8s4
        QJ62Nju3CEVvvQjumNnttEj5DPPsIB6BUw==
X-Google-Smtp-Source: ABdhPJwC/SlJUUY3MFkYXHq5q/F5ROIyunnTaWpmFDfd71hUL461xeW1Z7Ccuh5La5SqoYnBEFGx+Q==
X-Received: by 2002:a62:7883:0:b029:18a:e054:edf1 with SMTP id t125-20020a6278830000b029018ae054edf1mr386669pfc.70.1604533358170;
        Wed, 04 Nov 2020 15:42:38 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] emulator: Return error for ext adv feature not supported
Date:   Wed,  4 Nov 2020 15:42:28 -0800
Message-Id: <20201104234228.2257427-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This return an error if LE Set Extended Advertising Enable is used with
unsupported features.
---
 emulator/btdev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 42276a2ce..a36493346 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3760,8 +3760,19 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->le_adv_enable == lseae->enable)
 			status = BT_HCI_ERR_COMMAND_DISALLOWED;
 		else {
-			btdev->le_adv_enable = lseae->enable;
-			status = BT_HCI_ERR_SUCCESS;
+			const struct bt_hci_cmd_ext_adv_set *eas;
+
+			if (lseae->num_of_sets) {
+				eas = data + sizeof(*lseae);
+				if (eas->duration || lseae->num_of_sets > 1)
+					status = BT_HCI_ERR_INVALID_PARAMETERS;
+				else
+					status = BT_HCI_ERR_SUCCESS;
+			} else
+				status = BT_HCI_ERR_SUCCESS;
+
+			if (status == BT_HCI_ERR_SUCCESS)
+				btdev->le_adv_enable = lseae->enable;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		if (status == BT_HCI_ERR_SUCCESS && btdev->le_adv_enable)
-- 
2.26.2

