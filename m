Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C0EC38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiJYVNG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJYVNE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 17:13:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC9106A55
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 14:13:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l127so11616005iof.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1j5E6UcwROAS9jfW/Gu/SH25ZzySS6zxIVHIV97uLD8=;
        b=lt+SQMk/rRguF/jZilDUuCpzTApyT+VTe7+IzGStwjw++s3Iqthkx/efmvyCN2dK+6
         KVGuilyL04l3QWywWDVKw6v46ogCdqBQ94tZzeijcKzuBW6a9WbPuiKqPBGstQj6pSHu
         omjjribmfzJGvP+kOp14LEofZHb8tVbfKPwdopy2QorFQtYpyzqcC5XCxM3d390ZgkYU
         RYUPla46eqgSmiQH2dvFamQ0mej8DAoahe7Nb3bbCZsXLnbXffy83gXaYoorWunAmHJ9
         WCTNs8JFo3MsI73HbO/AsCF9GqWjf74sdAf6IR4Cev6RK7OntHwUSeKUqAPThw6lhjhd
         ZrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j5E6UcwROAS9jfW/Gu/SH25ZzySS6zxIVHIV97uLD8=;
        b=02JbOOY7ETfhNAfA/henYjJ0l5Ls9VB4EPN3MrmkRoxfI4W+gfc7PLjyxiWksK/tZU
         gNOrKp66du+wcHU/B9XZ+T7icyC9PEZi0Wstehvst+hBW8njRbNQhSzZXfScsiJgNR1E
         2rI6rmPzOScKoYbtYpVtddXIS6jFLp7nf53E2Dtjkhtr0CSypYKkOyAfw1cq8jzjFElj
         8KnL9FsaZvwKJjaBQThjKVvtkFmog+51d2XEn1yU5kQbQrcVbasJf7yPueIKDiHrlwJK
         sj40W35oiQpGuiHlsCzTg+aJUoaQvEaxuR0uBRKig3WYzX0DHLDbCCZPyIh2K4QZ95nu
         mjQg==
X-Gm-Message-State: ACrzQf39LeLYhcItbBfXTqKiMyc/Q0gis74ayaJ3+J1xwWPwq18/XjhV
        fQkXN6u9rcExxQ5CvUG7IAlhKPzgkCs=
X-Google-Smtp-Source: AMsMyM6C0OVUU1EGpZjukwgx/GTWjIyFNUoxUmBBrqv8YQidM6/zzzrjZqBvDfynGZSdUF/6CPYZ8A==
X-Received: by 2002:a02:662c:0:b0:363:c768:2b55 with SMTP id k44-20020a02662c000000b00363c7682b55mr26390629jac.5.1666732382410;
        Tue, 25 Oct 2022 14:13:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w11-20020a02394b000000b003636c046e73sm1253337jae.95.2022.10.25.14.13.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 14:13:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Default CONFIG_BT_HCIBTUSB_POLL_SYNC=y
Date:   Tue, 25 Oct 2022 14:12:58 -0700
Message-Id: <20221025211258.1385541-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025211258.1385541-1-luiz.dentz@gmail.com>
References: <20221025211258.1385541-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

poll_sync has been proven to fix races of USB data and event endpoints
so this enables it by default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fc36057d546d..89b4d47b7c79 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -48,6 +48,7 @@ config BT_HCIBTUSB_AUTOSUSPEND
 config BT_HCIBTUSB_POLL_SYNC
 	bool "Enable USB poll_sync for Bluetooth USB devices by default"
 	depends on BT_HCIBTUSB
+	default y
 	help
 	  poll_sync synchronizes the USB data and event endpoints by
 	  prioritizing the later.
-- 
2.37.3

