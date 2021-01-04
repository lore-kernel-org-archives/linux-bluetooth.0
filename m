Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC36C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E63E22209
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhADSmg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADSmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 13:42:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA9C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 10:41:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z21so19610450pgj.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jA29PE8TQ07+vq58+RAFivnrt39dPE9GXr+2apO0HUM=;
        b=d1Nr7ic+iwEn5K4umDvk/TRfRyk8TbdmcydDhtZE8hZzLdhuHUnW0sHCJ2FOK1eQbO
         LQ3dYOyXN1P2+daYvwR5QUZtwrP8LIh8bphol6R4QZAUF+nT33iKrC7byCcYoGu2vR/G
         yEplkt5BR8ah2opBNIo0EMTDMC4yl2BAbp4NmmVTsdRzLGtfuBsuvYhtqyZg4ZzxAIln
         n38+rAceUj9IpO5K6d3zVk9eupLGvC535/FzJ3RU+Xn/YUPrtCqlRG9qoB9gjTOS7eys
         Ldc15ycIcPYSpnsvLogvUljA2upQX4ymYu/D3zDK6NSty36HcjM3M589hzrNjQINQTt7
         xMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jA29PE8TQ07+vq58+RAFivnrt39dPE9GXr+2apO0HUM=;
        b=VieMgkL7OfCm6jpJYxIFnMb7Qo6JMudxr+fShDPrw/sjryUVlkKA4Lvpq+lWN9SmSG
         dIrcze4pGZMHlBBHwhDtdWSjbEn7MbUYzXA4bfKAa5v6sLp9UUh2p9y2D2b7a0Yq5Cz7
         +nyKW4cfthMbi8OJYXPLf7d+kfSESWclvIWh/EPUmH5u5k4yWwyb03rAURziPgWx9p5H
         mMQxjV/sEHhh0eF0arb3Sxcko8kFGkiuybRMgVt1EoO2edqj0C0iKSkyZyidNkoYIb1o
         0dcXdr7+Kpmg0diZ3X4mEaQYefUweTuIKzm8W2KaESOydsH9CWX6TaRUghKVSyMCWoR8
         52ZQ==
X-Gm-Message-State: AOAM532j/XVg3y73cFoHgk0bKXsuvCjDOnTaM2lEPlDO9ODq69X2CVmB
        0dMHlUEtPi1IP3/8d9prKQn43p98gxQ=
X-Google-Smtp-Source: ABdhPJyhUSkS8n08sZbKmu3B3prGBPs5wH7pSCXESPswcdc1esgKxXTMjLIDsS7Q4zQFGMHtyZ6s/g==
X-Received: by 2002:a63:ec4d:: with SMTP id r13mr26093325pgj.53.1609785715126;
        Mon, 04 Jan 2021 10:41:55 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q15sm47144618pgk.11.2021.01.04.10.41.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:41:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix potential buffer out-of-bound
Date:   Mon,  4 Jan 2021 10:41:53 -0800
Message-Id: <20210104184153.3218489-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When client features is read check if the offset is within the cli_feat
bounds.

Fixes: https://github.com/bluez/bluez/issues/70
---
 src/gatt-database.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 90cc4bade..f2d7b5821 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1075,6 +1075,11 @@ static void cli_feat_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
+	if (offset >= sizeof(state->cli_feat)) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
 	len = sizeof(state->cli_feat) - offset;
 	value = len ? &state->cli_feat[offset] : NULL;
 
-- 
2.26.2

