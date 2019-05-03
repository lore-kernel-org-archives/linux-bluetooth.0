Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0BC43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EB82087F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHJKdM+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfECJo7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 05:44:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42769 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfECJo7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 05:44:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id r72so4669692ljb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJGE92oE4Jz1YOV4GEYgBupNI6ZSiaKwlyuNmR0DgWE=;
        b=OHJKdM+tbDjEse1WyC0xoShDjdiMy69UZm5mnrSGPczieXwGNa67GKG9eL7V6l2mqn
         hHtdJdWtFtFCwnY5vtFqNXbiC4udB8M1lxhicSxm5vZbevtMKggc1aWz7Ys9MnC7PP1x
         9c45qcbeWP87bLhAubBjfio+q2iJKSXIS1vT5L0vuO4ia/zVR7kz82JT2GPY831cHCd1
         DHk/PLV9LEX8hUKlqVfOLiGDfet1Hh2eY22/XqEpB0WJdJPB9AHVuy3xDPPAaMUj1d/R
         B2MXZw1KwfJs58MCMoDJZGobSwWBuOzXOOKIhRg0XYaervfIUHy0wXRv62m4vzwuAb3h
         PKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJGE92oE4Jz1YOV4GEYgBupNI6ZSiaKwlyuNmR0DgWE=;
        b=UE7jvYEWk5V0plefbpk1qblDr9qtHDPbZQrR2ZBrMM20C7eGU45U/KRrADv9mACpb6
         jcv+Q9F6gEdYRh8c4/n8y0IsDo7aDkktZqY01OQk3e2anyeXv75HPzgyqqdYifPiNz47
         dKEg0DW7FRWGDWyp5vTOtJ7SxqMKIkR4ExTlDzyQFkoX+/pBxE7Rgjd06lpUsoixH4qX
         q81qLv9Ymr7bsae9/223lv88+0DsBb9kCnhSZLv/vQPlqWXHwKZ6XGjLEmJW4Bv4UW36
         K3XU8B6tJC9QUg/l9RWhVFsysUS5ehVNT2RqyBxPVbknZ7eWDTAmALXYcrR8ShUt0t7x
         oXqw==
X-Gm-Message-State: APjAAAUGrMUrYvp+fWopBsFLawpBLhfbQf6cPx1F7YLip7kEU6TFGv+q
        RkeHSfRJMft22mBeVaFN/R9XWzq5pyE62Q==
X-Google-Smtp-Source: APXvYqz9pWRl8BsCA9LQYxAiRxnhTr+oSYUH+a3Sdterj9P7H2OXYuWqCoUFuuj2Nc8P2+mBFHM3XQ==
X-Received: by 2002:a2e:8787:: with SMTP id n7mr4572679lji.31.1556876696842;
        Fri, 03 May 2019 02:44:56 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id e19sm376455lfd.36.2019.05.03.02.44.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 02:44:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] a2dp: Fix crash when endpoint respond with an error
Date:   Fri,  3 May 2019 12:44:51 +0300
Message-Id: <20190503094454.23774-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If endpoint respond with an error the callback will be called with size
set to -1 not 0.
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d0676b577..74ada3bbe 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2418,7 +2418,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	struct avdtp_media_codec_capability *codec;
 	int err;
 
-	if (size) {
+	if (size >= 0) {
 		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
 		goto done;
 	}
-- 
2.20.1

