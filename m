Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44365C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGYIrM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGYIqk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D041FD7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso8369933a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274694; x=1690879494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q90pg3qDzBvVPqD6CaJUpw83QakxOeK89A7ElltIbrY=;
        b=b/bELl+u9cAb6gssmCrAqNgn80T1vdQqXdUVzY80r2kcECrAv1Y6Ue2BKePme3mUyQ
         Ypnspl0J9yuA8Z24bAAEmVhv495uKpCTbVKjoCKQ2sQn/Kh5FtNR51CgGKKGDDW/cXSS
         hj3Y4H5g/hJwLH5BId0iAK+kH3ojyI9d4MI8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274694; x=1690879494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q90pg3qDzBvVPqD6CaJUpw83QakxOeK89A7ElltIbrY=;
        b=acwZqAM+WB3DxfyAoUUD14QdsGWZ0nUf/YcQMfCg18/6RUlxclNFt1rLIPLVPWNIOx
         4bnFPniiAOe+n89FZquo7hqQ84iHAi2lmLiaY8W4lZfhJZ/1XT7kEMx5tRcX+brKaCs/
         Q34oCUREmQYYh3mpbdsaejr+98DAZC2888aPgM9mMIV/ZNGdijqm+gdFDGPxlMoxDKZ7
         1h8XqEI8h3/6Y9qf9L/uzlhf2xd6NJW/xUOe7FgCQlnd2tzN3eVqtYapMyml7CKQVpMW
         XRrgfM2g45Hq+Mk4hemmEV4hNb2Hi+aSbVVHjQVZbm5vG1l540sUYauO58IoF3D0076c
         SEBg==
X-Gm-Message-State: ABy/qLY6wwPgtHnKMQN/t2ZwbMtAu9XHtJIuELGGPIPlXzINjTCjf7oS
        iVdmrKXr1p5T4+445w3t9ReXsZyohqSyjEbR9n8=
X-Google-Smtp-Source: APBJJlFiJyy/2zFqyFGD/qlsVjJ4eHB1AqDKHmY+VldQVTBj/9d148Js2GHpgBxfym+PcZr8V55+Gw==
X-Received: by 2002:a17:906:2216:b0:989:3e0d:89fb with SMTP id s22-20020a170906221600b009893e0d89fbmr13885411ejs.45.1690274694717;
        Tue, 25 Jul 2023 01:44:54 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:54 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/8] device: Rename start_discovery function
Date:   Tue, 25 Jul 2023 10:44:27 +0200
Message-Id: <20230725084431.640332-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
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

