Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07157C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E2361212
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJTVvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhJTVvD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E172C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v20so17068277plo.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=76GO2CCD9FbdnJE+ftTy7d9/A/v6QSCB5OpjDlt2ma4=;
        b=Re55dmEIRzPnbuBgP2g9tV6FNboq+4h3YdAVrNTb81vOYmbq2Q96jBOemPGCZebiFZ
         EA/9Y5jUgGyhXISgJRgWU3mly/U8I0iMtyhlH4Lat4TK9p6RGpy/HNZTwyow3R78YBJe
         bduRkvV559MtY6FldlqzWoqSTUqoTiSMxa3LiUWLmlV+8OiGajfGB8/3zlDKLSuXZJkA
         MQznWrBIgCz72+WD6XwP+NoI4Nnh35laF1qipVExtoCWB7BP2Ew5a4AWZEWD0GrV7zdS
         71msTQTOC2+8Zsfde0y9PXukl8F96/m1BO0PSfuXGwzcut911yq2v57LAKrlBhU7IHmB
         9lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76GO2CCD9FbdnJE+ftTy7d9/A/v6QSCB5OpjDlt2ma4=;
        b=XN9w3ICU7e9cwBNB9B0V5Q1Ljy7ARXWi1KOkRx4vezzgrUo4MP4o1KF/YHH64XYe5S
         hdA0wQDrYzVz3CeOhwG6DgL63rXKOB1SSZfyjnNTInyeSgcsCX8rLjF2dwNGP0k/8deb
         y0Y7Mve0ZGqp5yGItc6fIm9S/hq2hGudhcKZzZqIOzBzPbSjPN3+OvgtJdgUoOIXhh/X
         kf0/QavWhIVlpbW4qPdYCxUXq/atZYFnksYefVL0Tpxri2tu9YmTJBkwH6HiDpyNSVy+
         Pab/Yjca0OuPMpW/MIu+4IkQsbRaKeip2VCyv5l1HwB6nyVQQ+di+5yxK0dW5f4lokYZ
         svyw==
X-Gm-Message-State: AOAM532c92r8V3xH7zyV+zMlpnF0cBOufj5RkBCjHYbhExURUGFFImvn
        ZuhmbPGBaO/+NkAQjZPu5IaDqhOKKf0=
X-Google-Smtp-Source: ABdhPJwAHE0diVmUPGlRC288FlCWnBdYhHZeWWobfcJgxRAoB+CdTN0BJnmBWRQNsZt+e4al87WZNw==
X-Received: by 2002:a17:90b:4b07:: with SMTP id lx7mr1618209pjb.195.1634766528441;
        Wed, 20 Oct 2021 14:48:48 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13sm7257664pjl.15.2021.10.20.14.48.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] btdev: Use Linux Foundation as manufacturer
Date:   Wed, 20 Oct 2021 14:48:41 -0700
Message-Id: <20211020214843.431327-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020214843.431327-1-luiz.dentz@gmail.com>
References: <20211020214843.431327-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the emulator use Linux Foundation manufacturer id which
shall be simpler to distinguish emulator instances since it is unlikely
there will be other vendors using it.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d9c55d99d..18aefed11 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6263,7 +6263,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->type = type;
 	btdev->id = id;
-	btdev->manufacturer = 63;
+	btdev->manufacturer = 1521;
 	btdev->revision = 0x0000;
 
 	switch (btdev->type) {
-- 
2.31.1

