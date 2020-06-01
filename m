Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4358920738
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OknSwnou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgFAP7D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAP7D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 11:59:03 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A48C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 08:59:03 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r11so217291vsj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eghsQo/vmV+hD8YQND8nywOnlfG3Y84hm+sp1L8bBw=;
        b=OknSwnouuvqn2nJZvUtPDoRdDOTdC/n2Ry+aBDzklCM3gebsEHHL7JAxF9cvPgYi2U
         u0DvsT0Yp6Yf1Dt0cWtnsdtTLllDHbwHPRzVEpsUGPsEh0XX9MR6JDVZzASQ9YEyKSWD
         D5tYsX0o81GcpP5QW2Qo69eT2+dyFfTCCTc08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eghsQo/vmV+hD8YQND8nywOnlfG3Y84hm+sp1L8bBw=;
        b=S6TOE0RSIGq4rtHFBCI/0+Y6C9tFP5RZGja9E3t+oP42hO11pfjJ9KaZn9owyq4VSm
         d0dJEL3IqLj95jlRzR6Pt0PR7aS0nXlFNGIimP+pqU7QVaWHlvoRlkfKwR4Ms8R9OZPa
         1LODwv+FiXpyNN3w8fd5i6qNAQaBKUBWzPvJfNy6RgXKm6zcAVOAd0+EnJ+Gsn1yU5Sx
         ru0DuMJc8tkHfQmgLcQWU8aZPtHeiQw/lBQEvhsoxf1WxKfH3lsd0jalZSq86+Wuog1G
         2+dmCRAwmZIeqRQLF02Fa2uoUD4pTm/8U8nDi6gA3m+i5xJEPneB3YmDaD4xhz8FuuEn
         +nCA==
X-Gm-Message-State: AOAM532CSm6XCFlRBcjzYYDSQMdm96PtOrPh+jFEwFueodp+nOXuuR78
        CXOpq73HtUfz9p2K0FnsxoRUuQLHwkM=
X-Google-Smtp-Source: ABdhPJwcZGnrl567jib+TMM7CiV7WWF15o81aeYfbIo+DIRr64sqXjzAy1rH1Bhy8rwS3E8Yp3kAbw==
X-Received: by 2002:a67:a40d:: with SMTP id n13mr6132680vse.212.1591027142204;
        Mon, 01 Jun 2020 08:59:02 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id m25sm2568vsr.7.2020.06.01.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:59:01 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH] a2dp:fixing typo in endpoint_setconf_ind
Date:   Mon,  1 Jun 2020 15:58:58 +0000
Message-Id: <20200601155858.156798-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch simply fixes a typo in endpoint_setconf_ind.

---

 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6f46c92bf..e3d6cfc9e 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -654,7 +654,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 						endpoint_setconf_cb,
 						a2dp_sep->user_data);
 		if (ret == 0) {
-			/* Attempt to reverve discover if there are no remote
+			/* Attempt to reverse discover if there are no remote
 			 * SEPs.
 			 */
 			if (queue_isempty(setup->chan->seps))
-- 
2.27.0.rc2.251.g90737beb825-goog

