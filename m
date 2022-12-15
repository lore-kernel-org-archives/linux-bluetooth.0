Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B52C10F1E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 21:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLOVLJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiLOVKr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 16:10:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB98FD06
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 79so444153pgf.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3ZpecbXZ7MA8B74RHhsu6KPOaD9oS4NsyjOCiHMjQo=;
        b=S+DorWfj6MGaIHeoeSn13MVS8+Gw2wMdHyj/LQy4moZeMm39Gklokaw+NdMDKGCt6M
         GEjxFhf6aBCgQaqoM6nGU3jp3jWj1jxXOnidwDKvBH5yQmpuoh3/zslWjCtAxrWSlFt8
         Hkir2IucDYi7K+kmJD+/qw9zEfFSXYtXFbNRtCDzg1m4Gdmw1dKT2DFtrYFrSaJjHUnr
         hZTutCfGntiLHe2gFhfMnt6zjXUmKfQRiB+SJflHeQpwvPQl9vT7kYPiUiHA3zYYlmCp
         5sl/VL4sB4vfA+nYwTgD4Ymw+HLXPwGjtW+ArqG7QbXJ3+mwkYRDZlbbtKcSApyn5U6q
         B3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3ZpecbXZ7MA8B74RHhsu6KPOaD9oS4NsyjOCiHMjQo=;
        b=E8LBOvBHIlRqEZKo6N6EeOmd/KgI5YlM531ERfouWKQd4cBu51oSQaMLtd0x08QO4E
         TmvyQGtqFv+3O0RTRY+XyWVPDvJgLFFSIb2w8eTGcOnQH0xox9z8tysl2E36UI6JWOXw
         J3aQhutFhyasDiV74RVLrrtjtTNQe8gZJqxAj3sSsx7JN7AaKUAIR7RVUxKKM0e8p/MQ
         cE8jyJnADfk+WdAoFpMyFdLca//nhydUm8FDST3DuqXzMO4G2cyKBDhttfc5MtfG7Z3h
         sVLEgqZWCJ3cREjRvFsEvFGgv8YnW/kjq1/IMvaTX62xjc+7LL+7ZeXnf6ezwA1WSzUe
         SI1w==
X-Gm-Message-State: ANoB5pnKWe3c/tx8CDbsJaSzbjzbqxbhhFPb+QNysj9CpCYrPmh27tV3
        wbQ3DRB1GYQesaJfXtTN/iD/EeGpjQR82VFY
X-Google-Smtp-Source: AA0mqf4lDAUS5VCtmJg+tNIUsoN4AABgd+x41oUkRjstyl5Mk/9eaKYEQYNkb37CWphmb69Wsx0GRQ==
X-Received: by 2002:a62:e519:0:b0:575:bf29:d1e0 with SMTP id n25-20020a62e519000000b00575bf29d1e0mr31749258pff.26.1671138644763;
        Thu, 15 Dec 2022 13:10:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c20-20020aa79534000000b005779110635asm54908pfp.51.2022.12.15.13.10.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:10:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] client/player: Fix transport.send/receice tab completion
Date:   Thu, 15 Dec 2022 13:10:37 -0800
Message-Id: <20221215211037.2686489-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221215211037.2686489-1-luiz.dentz@gmail.com>
References: <20221215211037.2686489-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commands transport.send/receive were not settings any completion
callback so this makes sure it uses transport_generator to generate the
list of transport that could be used to send.
---
 client/player.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 6e33274d320d..eba233329276 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3654,9 +3654,11 @@ static const struct bt_shell_menu transport_menu = {
 						"Release Transport",
 						transport_generator },
 	{ "send",        "<transport> <filename>", cmd_send_transport,
-						"Send contents of a file" },
+						"Send contents of a file",
+						transport_generator },
 	{ "receive",     "<transport> [filename]", cmd_receive_transport,
-						"Get/Set file to receive" },
+						"Get/Set file to receive",
+						transport_generator },
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
 						transport_generator },
-- 
2.37.3

