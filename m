Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E830C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbiBJWOy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:14:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiBJWOx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 17:14:53 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC811145
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:14:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t36so1947982pfg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvgV6liMx30J7bWbl7GImuY5vwckT7tkG/hOPlL74GY=;
        b=X9RUd0z735mcpq9v4uHPwj13RVT4pNg7yxuYQVwT5khdS6M7EPAZthfxyieQWS7iQb
         R3r3k+CRW6brXCl42dVhyZBQ+RKeTtoiGHS4WX+w+wpnndUgZw8nwzURm2sXxuXZEBmf
         Abbj4GYPHeOaqyGYdvWgxqXGqMC+FUMk2WVEo9GVjfrJv4063EVGBv9oVh3JR2B6crjJ
         sa1YykE92cDFHpiuZO3DX1rL5IZiLMtgYtJ2ZXupRQJXQH53ua1gIkD2FYRxd60ub9FF
         z13Tl1dOpBWgQZ85iFYvb+3BTkV1fMUIXxBRrUZpsAM/4jUZylr52pD+5MwTJl2rVyXf
         USLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvgV6liMx30J7bWbl7GImuY5vwckT7tkG/hOPlL74GY=;
        b=NzFJuTffKAwSeSQysbVtrvDd0n15utszb0svkDpUDbhSsFZJu5j50Yyreog5XVLqsU
         uAa5u7q50MCtE9a5bGpJp+ouYADTsNeFPz1I2FVQviFJtQB0N8BhuJNz9yPqA04G0FKj
         Wpz1KF/j5dsA4ZGDmZrPhqHfCYDhOftOhysTN1fHwwvisDR98Yyx8ZA3ZDsIEISXCFo2
         vQVjvrRQD38lGppiwVRYYarIHkZ9eECMtzj71k8isOE1PLV9NrtMnITpNJeeTk94K8Zf
         o+ThgsUP/s5S4oMI3zn7HpD2tV1hzUCPXXYMDj7tK4esOC/R0u0oytTwHReL4S8dHg84
         XNbQ==
X-Gm-Message-State: AOAM532lwAA0p+uIH3W5K6Le9/TewheKXOS1YBX+M++UbIu7O140hDlA
        jQ6nabqSUEMTwF+DfQYPmJPxs4/ggLGE7g==
X-Google-Smtp-Source: ABdhPJxAXFp/tlhLzmZ6duDPdB2A55HpjQ99vJicRP5nbogeNXiMimF9F+mbd2lSfKcWLozQD9JdkQ==
X-Received: by 2002:a63:8bc7:: with SMTP id j190mr2307604pge.473.1644531293066;
        Thu, 10 Feb 2022 14:14:53 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d8sm17922212pfj.179.2022.02.10.14.14.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:14:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix crash when removing device
Date:   Thu, 10 Feb 2022 14:14:51 -0800
Message-Id: <20220210221451.418234-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calling btd_adapter_remove_device from device_remove_connection can
cause a crash, so instead of removing it immediatelly this set a the
temporary timeout to 0.

Fixes: https://github.com/bluez/bluez/issues/290
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 6d29eb896..b5a47d302 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3285,7 +3285,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 						DEVICE_INTERFACE, "Connected");
 
 	if (remove_device)
-		btd_adapter_remove_device(device->adapter, device);
+		set_temporary_timer(device, 0);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
-- 
2.34.1

