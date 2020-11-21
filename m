Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9313C388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6D22240
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 07:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="EE7NdVNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgKUHuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Nov 2020 02:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgKUHuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Nov 2020 02:50:20 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9677DC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 23:50:20 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so9340593pga.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 23:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1a83fT3URZZZv5+d5ZTUN04MT0WZ+xVDBmL049R80W0=;
        b=EE7NdVNkuq4EltuY2lOUP7RDa28DiZQAcUi3xMmex6rsYQOprV4rMoFemYaM3/mzmH
         QRwdLGROPundUmGj3Ge+7OnifG/XGyl4i6UAoPRcY77GVQZnAkijlycp+Mark5To0VDg
         vTpOjHEnjmHgArHlLu8IyDDewCp1aP5ltfFBAVzIuLK1VVJD6HMMUs7xh1LcguR3SzjO
         cc2PUpuVMFM88IZFX2r56nKCfwv9aNiBK3Iav3QKJV5Dag9Rx1MunZ+c4XqgW65gKjyf
         qcvNeadCnCKLl6S2wFjAyIzeYw5hVLelksDkkIkbXjFH9fwFRD7ZT+l8uH6BcxZhMNII
         Fuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1a83fT3URZZZv5+d5ZTUN04MT0WZ+xVDBmL049R80W0=;
        b=FYlt1wPhpqbmMpKn8pSOLaUBulcobrChrjMsV5r2wBn5Us6nDNzRAi6X+xh3bn5BaX
         dSSZqTToP6Ox6NV7gylUbMdcCJcIyPtYHHSztyZVFRJ/6FTGx6YImi7VyrMXOAyXxM2+
         6vAfm57vSReCEwax87Kgd5eMFhpGHmK448RAKXE89IF9QcKfMLB8aiXesBLWcVj5SDh0
         Ght+5SbuzJ6DHoofV3suXkHX5aQN/4z2WVWyAcdnyuekX6VeQq3HUj/3DO4ZppfXTCRZ
         61X73G46dFtPgmPROhvQaArUVHm1xQoLb5wqxGWffTw634DBD0YW8TJsn+GbcfjTR5dL
         fVeg==
X-Gm-Message-State: AOAM533Yd3t57O+I20y77YPk9y94nQcCKRYSTG34kooGukyXcCQWmvaP
        TYGoJZfpQ5Z8osGpI2FhVADhAr/b5K4H/QWv
X-Google-Smtp-Source: ABdhPJy6VVR1PaHeFc3rEeLhMbcPZGcYEGo7uxvOpqWgNBwIaBWJ2P5x7YSCfY82c1cAsJKK5XIYZg==
X-Received: by 2002:a62:248:0:b029:18c:992f:e407 with SMTP id 69-20020a6202480000b029018c992fe407mr16961778pfc.37.1605945019913;
        Fri, 20 Nov 2020 23:50:19 -0800 (PST)
Received: from [10.0.0.4] (203-123-108-233.ip4.superloop.com. [203.123.108.233])
        by smtp.gmail.com with ESMTPSA id p15sm7353804pjg.21.2020.11.20.23.50.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 23:50:19 -0800 (PST)
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Dean Camera <dean@fourwalledcubicle.com>
Subject: [PATCH] Fix incorrect memset when clearing response structure.
Message-ID: <b76b25cf-e7d7-1da8-2fef-36a813ec0493@fourwalledcubicle.com>
Date:   Sat, 21 Nov 2020 18:50:16 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The cmd_le_read_supported_states handler incorrectly clears out
the response structure before filling it with what is effectively
a sizeof(int), rather than size of the actual structure.
---
  emulator/btdev.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f02103f0e..65b2048f3 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3331,7 +3331,7 @@ static int cmd_le_read_supported_states(struct 
btdev *dev, const void *data,
  {
  	struct bt_hci_rsp_le_read_supported_states rsp;

-	memset(&rsp, 0, sizeof(0));
+	memset(&rsp, 0, sizeof(rsp));
  	rsp.status = BT_HCI_ERR_SUCCESS;
  	memcpy(rsp.states, dev->le_states, 8);
  	cmd_complete(dev, BT_HCI_CMD_LE_READ_SUPPORTED_STATES, &rsp,
-- 
2.29.2.windows.2

