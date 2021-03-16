Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB09DC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB51E65088
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhCPOmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhCPOmC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:42:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED64C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:42:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so5369627pfv.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ELK1G9BdARpFJ+6eAUnAFfkYdP369w+KJo20CawBBC0=;
        b=kgo23qrtbkYZUFpoV5LbSSsBuZRabn2TcEX8/1ZGbvjmOzKe+G0NwsKlUQJ7GemShj
         DKiwSgoi2mGaN1wQoXOjZYOlKypkgh1dGTFZ5VH9Onmpfpaw8bWNDi1quHfPTWEoJTw+
         Ok+sOm9dHvLwjHq2rD2X/A7dPUt0dLYgibxAfUDc1EP7Lj430M6By6EVunDCR6/9t5pf
         PKSx1bpFhVoYiNV3hqp39rzAZ8UHv3hhXMDBCwmVrfG7fdzvYgzXMv2YyeyDgxGa09Ia
         tGii4VnQ7pUVOXMrTydVv+CEVX+zKVQetF8n5FXkmmkEyOexZDIcEGkU/jiLiaWxRY4Q
         ie0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ELK1G9BdARpFJ+6eAUnAFfkYdP369w+KJo20CawBBC0=;
        b=awexjKQlQazaTZZ/KRilYN6xHNuqoCtcxnE7oE/X9WyGBp4AtNLxm/x47PNq+0yzEO
         BJJ9O19NFXn+dO1Jv2xfuvcHMwtdefnJMbFYuOLmBOMB8B2UoNj31bnySYFFeUmWJ9Tb
         QyARqszXvo+GbwqH8I1daKiWpbRP+oSF8ih9uS1xDwDsMYXtLCEeU68X0Wl0ylUc+8CN
         ByrSyM0JkpGB+lfBMkHMiKoAZJqpvygIG5w3uBGvdRyL0Cgpr2QMTE5kIpAj3hVxO+9p
         obhOLV21VZQm6vJ8mbRs9Z7w9V1YXS+oOg7/xUoXEE8ggCLd8p/+roBfZN8TwBfYK91B
         d7Ag==
X-Gm-Message-State: AOAM531eNIjf7eqhxFsXQdel/iJlIININ8/t+mIPuUiCkBCIkTnaF3Jj
        xJb5oKMV8ee+QJMHxVeth+9TZQElfz8=
X-Google-Smtp-Source: ABdhPJzD3YB02rHhlhHJUEmQh2cWTGu/qYs6K5Z560ahUxq2lEDSAQMQQIYTsVzEXLayPYYsehhNow==
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr4332775pgk.265.1615905721861;
        Tue, 16 Mar 2021 07:42:01 -0700 (PDT)
Received: from localhost.localdomain (76-14-108-251.rk.wavecable.com. [76.14.108.251])
        by smtp.gmail.com with ESMTPSA id u2sm3209289pjy.14.2021.03.16.07.42.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:42:01 -0700 (PDT)
From:   cdwhite13@gmail.com
To:     linux-bluetooth@vger.kernel.org
Cc:     chris.white@dolby.com, kpare@dolby.com
Subject: [PATCH BlueZ 1/1] emulator: Add Create BIG command in emulator
Date:   Tue, 16 Mar 2021 07:41:36 -0700
Message-Id: <20210316144136.410-2-cdwhite13@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20210316144136.410-1-cdwhite13@gmail.com>
References: <20210316144136.410-1-cdwhite13@gmail.com>
Reply-To: chris.white@dolby.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Keyur Parekh <kpare@dolby.com>

This adds support for Create BIG command HCI
command in emulator. These changes are needed for
making the emulator useful for testing
LE Audio broadcast feature.
---
 emulator/btdev.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c824f48ff..d78d472b1 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4473,10 +4473,32 @@ static int cmd_reject_cis(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_create_big(struct btdev *dev, const void *data, uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CREATE_BIG);
+
+	return 0;
 }
 
+static int cmd_create_big_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_create_big *cmd = data;
+	int i;
+
+	for (i = 0; i < cmd->num_bis; i++) {
+		const struct bt_hci_bis *bis = &cmd->bis[i];
+		struct  bt_hci_evt_le_big_complete evt;
+
+		evt.big_id = cmd->big_id;
+		evt.num_bis = cmd->num_bis;
+		evt.phy = bis->phy;
+		memcpy(&evt.latency, &(bis->latency), 3);
+
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_COMPLETE, &evt,
+					sizeof(evt));
+	}
+
+	return 0;
+}
 static int cmd_create_big_test(struct btdev *dev, const void *data, uint8_t len)
 {
 	/* TODO */
@@ -4625,7 +4647,8 @@ static int cmd_set_host_feature(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_LE_REMOVE_CIG, cmd_remove_cig, NULL), \
 	CMD(BT_HCI_CMD_LE_ACCEPT_CIS, cmd_accept_cis, NULL), \
 	CMD(BT_HCI_CMD_LE_REJECT_CIS, cmd_reject_cis, NULL), \
-	CMD(BT_HCI_CMD_LE_CREATE_BIG, cmd_create_big, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_BIG, cmd_create_big, \
+			cmd_create_big_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_BIG_TEST, cmd_create_big_test, NULL), \
 	CMD(BT_HCI_CMD_LE_TERM_BIG, cmd_term_big, NULL), \
 	CMD(BT_HCI_CMD_LE_BIG_CREATE_SYNC, cmd_big_create_sync, NULL), \
-- 
2.21.0 (Apple Git-122.2)

