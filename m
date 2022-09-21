Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE7C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiIUVuq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUVup (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 17:50:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96AA1D0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:50:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso210667pjk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=qlKvWp0Os9aiXZyYfv0kVK3MbkzSRbQQj0/fdk6t3Eo=;
        b=Po89RPGGB0VMkLrMPND4baeH0t8OY/N7R/chuJ7epyn3bmOXthfe+Z4gIv3SjXoJSE
         p2JjcLZTjRfnz0BF6Fl9qnvxmrSO+LJFHGjE87h01UAyKlz0tyS+tFIJ5gegDejEGh1w
         eqjd4BU8m6HJErZLsm3gXcIScA9dME9Y8XCdoHa7fqcLAggh9b4eLBWp97VOmOJlPzku
         sjtZXvUhvd/BcPmQxNUNaYaUyYH1xeKDEhqeHewjyVAscXHookQa25rj4te2o37Q9bOq
         MEHjTctWgqpDsknfmmm2qlUTr05688eNnQyPDbJR71z2s1fMMaLST9fZB0P8sD7wEXxW
         KWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=qlKvWp0Os9aiXZyYfv0kVK3MbkzSRbQQj0/fdk6t3Eo=;
        b=pXut4e3Wcm6T94tgXp8WXCd755uhuToRyJS02tCr6eaCMdTS92vBYaXnqNtVw7jOYh
         qFjZ2zMz6hdm7nhr9dTTcYnbs3a3IQmygRCK4yzj+aS12m0ssV3vHPuN/FIB4Q3s4uZr
         tlp2Xb+731kRBE44QWatLTVKWimgtF/tCHS2/+Ey+xtyyGS7sCNFrFPTuDmoVMLoXOLu
         qilhLKdjVtBGNAUj/s4bBjQ6mdbqqGiB/9u9MO/UuO626QL7ypJ0P843/xzwSCF9539L
         zXrxaZXweXIwHo3fE35e5bPrqifVsxiSOdwFkw+tGaimEJyI+9QKwuFDS7jybYNSInQ4
         hXyg==
X-Gm-Message-State: ACrzQf2g/NmIpuxN7MxL2xHhIj5sftTxCDzzyM5VfmbS1hwktcsd8tuH
        5hNj16RowlThEbEyulcKVWyZ3Pxp+8s=
X-Google-Smtp-Source: AMsMyM7VPS9TDmQHJY98HMEUMXuzVrdU31si7S3MI4IcbFxMRElQN9LG0as/aPhkjwiytn5o0rUFBA==
X-Received: by 2002:a17:902:6549:b0:178:12e9:8d7b with SMTP id d9-20020a170902654900b0017812e98d7bmr139865pln.14.1663797042905;
        Wed, 21 Sep 2022 14:50:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t9-20020a655549000000b00434ea8956f6sm2426487pgr.3.2022.09.21.14.50.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:50:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix scan-build warnings
Date:   Wed, 21 Sep 2022 14:50:41 -0700
Message-Id: <20220921215041.2243423-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

src/gatt-database.c:3541:14: warning: Value stored to 'iface' during
its initialization is never read [deadcode.DeadStores]
        const char *iface = g_dbus_proxy_get_interface(proxy);
                    ^~~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/gatt-database.c:3542:14: warning: Value stored to 'path' during
its initialization is never read [deadcode.DeadStores]
        const char *path = g_dbus_proxy_get_path(proxy);
                    ^~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 src/gatt-database.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index a212dfc4e694..c72f4a4d5c54 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3538,8 +3538,8 @@ static void register_characteristic(void *data, void *user_data)
 {
 	struct gatt_app *app = user_data;
 	GDBusProxy *proxy = data;
-	const char *iface = g_dbus_proxy_get_interface(proxy);
-	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *iface;
+	const char *path;
 
 	if (app->failed)
 		return;
-- 
2.37.3

