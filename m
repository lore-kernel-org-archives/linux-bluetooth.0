Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B40DC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjG1FcB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjG1Fb7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:31:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D43582
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6260946a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690522316; x=1691127116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q90pg3qDzBvVPqD6CaJUpw83QakxOeK89A7ElltIbrY=;
        b=X2lvqdfDnvTGLn/sjIoU+lwO6TZwY4lArj4CnpAnmlxWDF5RKj6CbZpnOf1ffi/DoF
         rOU0gq+UzNpwXlJ+pr9HyROy+go2gsl95nhvBNvzmu8+zCRCCwzSvYRDKEdhteKJsqG/
         Kuz3G0Cnsg9dBc7i9GUPr1FRJgOsKZVt29W6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522316; x=1691127116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q90pg3qDzBvVPqD6CaJUpw83QakxOeK89A7ElltIbrY=;
        b=g1wZQp+m8thQbQwVY0TeI8hbd0FJH6ichklqzsSzOPBOerFoqQrQ1y9SsrWdKTnsem
         ouAfIuA6B7LhfU5KMFV9g0bRZocEIvmZ1eVhCex2O2S0yyL29ASIAZy2zKfe7ywdMMbf
         wUXTM/aVNSSJf2cyD6RAq4kzAtylyqynY8hYkj8f8nEmWIGOqJqzKuwoeIEwe+YzyO/i
         8DNTG5xTHh3cypKLpkGwIUz0DAzlkarDXtGsjsiegD4qvevvAK+rT5DShDgYs/aY+iPL
         LPJlOXNOPiPnPWOWwbxm4yhLBk/oLiKEeIKcUclvh5wPraRmt+3m2GMTrT0duIfS5Rx5
         fkUQ==
X-Gm-Message-State: ABy/qLY1PVGiJPHh7RfvhA2AkYlGIo6iTa6He9T6uSVSD+WqG9Bvsmg/
        0sqF2UwPEx2WuaFHpfbIbBVZMDMcTsu2nhhKUTc=
X-Google-Smtp-Source: APBJJlHhcfYgwA517kaK8ZjXd1urxfnuenvPqpg+e7HmpjtxIp94tU5P9C1ZjS91ALDaX1hM5j+a8g==
X-Received: by 2002:a17:906:9b85:b0:99b:f3ad:e0d6 with SMTP id dd5-20020a1709069b8500b0099bf3ade0d6mr16674ejc.2.1690522316333;
        Thu, 27 Jul 2023 22:31:56 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009888aa1da11sm1590113ejb.188.2023.07.27.22.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:31:56 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/5] device: Rename start_discovery function
Date:   Fri, 28 Jul 2023 07:31:50 +0200
Message-Id: <20230728053153.584222-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
References: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename it to start_discovery_cb to indicate that it is callback function
from timer.
---
 src/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 82740216d..6f28e261e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6203,7 +6203,7 @@ bool device_is_connectable(struct btd_device *device)
 	return state->connectable;
 }
 
-static bool start_discovery(gpointer user_data)
+static bool start_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -6363,7 +6363,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			DBG("setting timer for reverse service discovery");
 			device->discov_timer = timeout_add_seconds(
 							DISCOVERY_TIMER,
-							start_discovery,
+							start_discovery_cb,
 							device, NULL);
 		}
 	}
@@ -6406,7 +6406,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 		timeout_remove(dev->discov_timer);
 		dev->discov_timer = timeout_add_seconds(
 						0,
-						start_discovery,
+						start_discovery_cb,
 						dev, NULL);
 	}
 
-- 
2.34.1

