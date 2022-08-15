Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10947C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 02:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiHPCw0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Aug 2022 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiHPCwI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Aug 2022 22:52:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8072C0D52
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:20:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso15769112pjf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=OY8t43HKMKk9/dPk/QiOXNH/7gvwR0Dmd+QfnXfhHEE=;
        b=iKdz/8M52vFoeUcpXAO5ZZVFIvcfQpQOlGspt5NiZL+hwS6wYSOimFNuX+9yD0bagq
         /Bx5EvFLTCX54Dl/Fm925EjjmHwJepDaWtYKAMsouGOYOKSVZxxTVh5JjgGOzFsVLmPv
         VOUmV/IiSJKr0bS1hRJfthyuAg1mj2Nn+N52R5kZaetPUD6b8JZEWNMpjhEyYUampbom
         8ZUfhUFRYlNEMpNmjpQW1V865UKeqKMq8Z/LCnfChEVVbVZ+INXvxEk5nf5bnYoyZwtZ
         p6sSNdjd1WDR06OJTeuVQhHpembsgl8GkLBi9UXQo834388P/33AQYkZY7pch3nilR7D
         ylew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=OY8t43HKMKk9/dPk/QiOXNH/7gvwR0Dmd+QfnXfhHEE=;
        b=SgyXyRzAqFzOkJUHOyr30FV80SgkEsCxByqX8QTIifehbyDUYMeEqjEOE+lH1pc2ek
         NZS34zKDitsdBpoTeS4691cCZG3d3+lXf3193hpvYQ6FIDQlCAdiBOJoNZUYovvoqN1U
         UyW09CQZ84WEELxM1QEhPoCuzLz1zyrFKmc7cO9HEWyd0q7KuCGtetaac+bxEFO5RG42
         B+sETMohZZKg2pb52s+Ry/gmCCcoOsK8yIVNYUaNoUi8DP4MVZGs21DY3KB8Z3Y1fK8g
         PeKWAT5yAE2TNxk88D3k1lTBl0+6xeekCdt2oKgCfJFVkNAsvozgyECuJ4uLlxbFt71k
         97vQ==
X-Gm-Message-State: ACgBeo3xVgSgC+NfSKAHS4m58MWpZ++TAEg6fgAn+r//lDmcymKPhPok
        LeCG/Z/Y4gtDl++GOS6ZR2oB/rqKuyRjBw==
X-Google-Smtp-Source: AA6agR5L4q0b5l3vchE+EBTJ8MDq+jYL4NLosPQdbMFoaphsmiJl0h9d/w3gkb/xGYCa8ws/5FPMhw==
X-Received: by 2002:a17:903:1cd:b0:171:3543:6b13 with SMTP id e13-20020a17090301cd00b0017135436b13mr19685446plh.96.1660605611893;
        Mon, 15 Aug 2022 16:20:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902710600b0016ed20eacd2sm7464139pll.150.2022.08.15.16.20.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:20:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Check flags are supported
Date:   Mon, 15 Aug 2022 16:20:06 -0700
Message-Id: <20220815232006.1252933-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure the flags are supported before attempting to set it.
---
 src/adapter.c | 4 +++-
 src/device.c  | 5 +++++
 src/device.h  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3fa3018093b3..d33fc9bd661c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5428,10 +5428,12 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 				mgmt_request_func_t func, void *user_data)
 {
 	struct mgmt_cp_set_device_flags cp;
+	uint32_t supported = btd_device_get_supported_flags(device);
 	const bdaddr_t *bdaddr;
 	uint8_t bdaddr_type;
 
-	if (!btd_has_kernel_features(KERNEL_CONN_CONTROL))
+	if (!btd_has_kernel_features(KERNEL_CONN_CONTROL) ||
+				(supported | flags) != supported)
 		return;
 
 	bdaddr = device_get_address(device);
diff --git a/src/device.c b/src/device.c
index bc99420228d2..698c668b5420 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6821,6 +6821,11 @@ uint32_t btd_device_get_current_flags(struct btd_device *dev)
 	return dev->current_flags;
 }
 
+uint32_t btd_device_get_supported_flags(struct btd_device *dev)
+{
+	return dev->supported_flags;
+}
+
 /* This event is sent immediately after add device on all mgmt sockets.
  * Afterwards, it is only sent to mgmt sockets other than the one which called
  * set_device_flags.
diff --git a/src/device.h b/src/device.h
index cc474bd889ec..9e81fda9e948 100644
--- a/src/device.h
+++ b/src/device.h
@@ -177,6 +177,7 @@ int device_discover_services(struct btd_device *device);
 int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
 uint32_t btd_device_get_current_flags(struct btd_device *dev);
+uint32_t btd_device_get_supported_flags(struct btd_device *dev);
 void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
 			      uint32_t current_flags);
 
-- 
2.37.2

