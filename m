Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68144C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCJAD7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCJAD6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:03:58 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF0BE1924
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:03:57 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h31so2113925pgl.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 16:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678406636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0nUJSxocIvA+OmUt4v9m1vIukatm1AEaBHe6pdzfYs=;
        b=QVJ/ShGylqOS7QRiIQTeHd0apzw/kQ8A3u7NK7maJktxNg1Im+XI8AOrd79lMy/1B5
         KVnvuOEZ1nLBmAyK4BcXClL4850M7bok+cCpRlEov2GroLjl302UFJbL9kxvkhxYnJyX
         J7dDknKFA+QFHcbVaefR4qFrPPBfyfb6mTaiG696ngqFz2aOhSmiJQqz3ls4Wra9KQlG
         FFOZRD8NGfon6/5JKEKYywmQ8tK4jfgKyH6M5iARH7BeLJG1Gw5/Yb/edv1GKgSZGlEz
         NVqoG3GsB5dqkhRXLKIyAUMZWz708TdYN5z+1Y79AhWyEtyh5ylqfcrejyMTW6BfwK02
         T2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0nUJSxocIvA+OmUt4v9m1vIukatm1AEaBHe6pdzfYs=;
        b=XVhMorK0C/sOloW85oxbO192N+FvT7GUv3RI59zQ22Oa70cDvWaFya7Z3D6JXXXju1
         nMr+cn4ntgvDALbo6Q8bGKOaSP4jvlQ/bvOnJzisD26cyJZzOv344NoikXaV2X0nVwsa
         gvtxsD0ahbz0g6S6eNqqNgP7gt+B7CmgG3lA+a6RoEOIlF9zmOqWK2mt6qO7B+fSQ6Vh
         LEukSF23AAaVYYDl1ddhw+uucrOSmkzA2ACJ2gczlC02QO5/qJ+HCeW3SmvHf2wm2EOK
         8+5g/DD09bkfLnPdKywp1aH79hUjjbmqRK0NYoh4ZytYwMY99cUAvEFg+kTFnTPgWJWb
         6KgA==
X-Gm-Message-State: AO0yUKUi453kMohyfkRmpVLCB/MuTCkruYn6Ij/KQWZhNUYjwvi12gqR
        w48yXdVhVjgA7KpxaCzIWH0asJ02R68=
X-Google-Smtp-Source: AK7set/aN25WQZET/Nc/pdp+9bYaWf7YQHIBzT8/E+VsZiy8lfi3fP6OMSWblWuQaG1RN4EIVp9Gdg==
X-Received: by 2002:a62:1d4b:0:b0:5a8:bd14:d6f1 with SMTP id d72-20020a621d4b000000b005a8bd14d6f1mr3666948pfd.7.1678406636349;
        Thu, 09 Mar 2023 16:03:56 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7938e000000b00593e4e6516csm137845pfe.124.2023.03.09.16.03.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 16:03:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] main: Disable EATT by default
Date:   Thu,  9 Mar 2023 16:03:53 -0800
Message-Id: <20230310000354.3404030-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

EATT is causing some problem with some platforms as they also attempt to
configure it may cause a connection collision which needs to be handled
by the kernel.
---
 src/main.c    | 2 +-
 src/main.conf | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 2a4d9be05d7a..3198091fc12c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1148,7 +1148,7 @@ static void init_defaults(void)
 
 	btd_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
-	btd_opts.gatt_channels = 3;
+	btd_opts.gatt_channels = 1;
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
diff --git a/src/main.conf b/src/main.conf
index 11172c9dd7c6..d108934a8ae9 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -255,8 +255,8 @@
 
 # Number of ATT channels
 # Possible values: 1-5 (1 disables EATT)
-# Default to 3
-#Channels = 3
+# Default to 1
+#Channels = 1
 
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
-- 
2.39.2

