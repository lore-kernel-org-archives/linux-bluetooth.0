Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A12C4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B446135D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 19:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhFATGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 15:06:17 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77BC061574;
        Tue,  1 Jun 2021 12:04:34 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j1so396889oie.6;
        Tue, 01 Jun 2021 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMAgZF7duW/UBs3zqaxQqh55RXQkmEY7w7zfn2JeuWM=;
        b=lTibGVqmD3fk35o3Ypk641kCHOffLCFHfN0t+Zv+nijjWr08dbhMm3FC6+5IvAxBkZ
         PSruYhjMrAXrdkvovRY+SED6Rt2lTUWV8P3oZ+CYSw+2XNN1JJgnNjgmm/qJrtXX7Fap
         qYp/RulJ6M1l7OvhMs7320PA3JMXdx604bSoo5XTUw3ZLWd9bU1L+9aZLQ6E/PF62h37
         CoglFdHwJG2zuwpZWg4eKDPP5OMgvZW1Jhpuv4ooAzU1WOrbKrwCr8U2yQJ6jRNtzlVX
         jHbFKUYtS+l0W/M9hJrkWZLpAnwBAsAtGKJ9UpOco7ECYGPJxhvWX3c/MPDehAJ6oN3n
         dPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yMAgZF7duW/UBs3zqaxQqh55RXQkmEY7w7zfn2JeuWM=;
        b=Mnr0s958pKyKHj2t2DoNCQMCM6qdex2q4w2KRmvM9cdH34SMfL1tjcMMzUSBmNw9Zt
         V+8deB0gurjilW2y+ZnJhWEQQXx6GeKMYPfI+uE0hwOxS2x7AbNy2r2USV1tkRgany6q
         lF53C+r1Z6I0W6vt9e7sZnVtuTEkQEsQZjJIiX3zp2nltritK5etAbZBeGcd+H9buERw
         NBlkuNpx65IgZMJRPg88avXm7CRO+LEYrThcTTuAOAgvxGIUci/I17YBLUV6DU8YkmuA
         N7kq614OKw9bjf2mT07exRNT52aCsDiqpiP5c1NKjTVRJvVOnv8dTTld/9udYCF8zTm/
         hndA==
X-Gm-Message-State: AOAM530PtdBBVxZh6iV1Bbjrxp0neEnT0qAqdzmkejErOE9HDX5RoFEN
        t8QxumwUAtKnnabSDS1GEUw=
X-Google-Smtp-Source: ABdhPJz8TdhKPwFGlIVD78DZ3rP2frRr8ZBgAQzwC9PrHKF3iMVuCmI5zI5H+fZfekGGAnmweQCFqQ==
X-Received: by 2002:aca:1317:: with SMTP id e23mr997976oii.94.1622574274224;
        Tue, 01 Jun 2021 12:04:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l20sm3515720oop.3.2021.06.01.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:04:33 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add a new USB ID for RTL8822CE
Date:   Tue,  1 Jun 2021 14:04:18 -0500
Message-Id: <20210601190418.25628-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some models of the RTL8822ce utilize a different USB ID. Add this
new one to the Bluetooth driver.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d603ef39bad..7a8e1d240f15 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -388,6 +388,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xc822), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xc852), .driver_info = BTUSB_REALTEK |
-- 
2.31.1

