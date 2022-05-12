Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 00:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiELAzV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 20:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbiELAzT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 20:55:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0860ABC
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 17:55:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d25so3382677pfo.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2bPaQQOKSXG/fl2BdmohaiLMnjYT9dp+p5sZticNedE=;
        b=Xmoohfhng62wNpgq4b/P4DcymjyRQ/tFBcSEJ6zDLKfmsrDDyP1qM2lgCFW0jp8hNI
         0C2rugyOhDEbHK4RUlA0yVHXnkVT1lCEYiY8gS7euLN851JHQsUVQdd/n6FP1hvFfpxM
         YDfpQb+O07i0bETfT8o1oML/4roQABsJ8j7Qu34qV7p+Si5eLWlZ+dF9aMuThapE2Ipm
         8zH9QpDG7enSCsSmqCgHQjbRSU38Ut8HEvCoUomuQFxlZxP8+XUnh7d+m3ldOxLSRt+m
         52orAX0d32tdRbkfjcS2ubHMHWjFEh7n+BJ5CqVW1bcFyU9nUMVHtztcmvMPjKvabDER
         7EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bPaQQOKSXG/fl2BdmohaiLMnjYT9dp+p5sZticNedE=;
        b=mFpwXF7t8NFCAoa4HU+1f+acMGPXFfThQXeqyWsCKOQNAbTOIIeDDf9epaYWvAmQwQ
         QHAGwp0USKmqEJw+v58MNg2PxqWKR5GJtIa61ajxCcmJMfyBjcj0IQf2Uwd/5Y3VM7Xo
         wVwdrulinRMeolZ1D1IJ0PQ55EqJNPw5+5LTG4nosJ3PptV5JNdboKEHXuP6j/F7t1bR
         NJHUd3vVfdcZO4VmeWGrjePbM5+MWXdt+MYcYepLXYhm9zmxWj+t9Z9dJot3ZhYx1DR+
         Dl4t+5uWvrzeL1I0q2D7jQvsUUMGZTrJDZpjNpQedEKsG+0usYs9lUwLs72MyoYZ8yyu
         i1DQ==
X-Gm-Message-State: AOAM531p2746jXTWePDEa37Tw222oTp/CvjKwv6h8Frs7ln+WdpFsBHu
        M6mj1LY2uJKqnw/qw9KbXDd2TDu3ECc=
X-Google-Smtp-Source: ABdhPJytV0eeMmdFr6ttF2nlxbwWFmwrzEkcvJt55ZvUzFXUhNXnh9gMmoBh7p0fkm1YmdwNwLBweg==
X-Received: by 2002:a05:6a00:8cb:b0:510:9ec4:8f85 with SMTP id s11-20020a056a0008cb00b005109ec48f85mr18774107pfu.24.1652316917923;
        Wed, 11 May 2022 17:55:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b0015e8d4eb2c6sm2590176plh.272.2022.05.11.17.55.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:55:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] service: Add initiator argument to service_accept
Date:   Wed, 11 May 2022 17:55:15 -0700
Message-Id: <20220512005515.844857-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512005515.844857-1-luiz.dentz@gmail.com>
References: <20220512005515.844857-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initiator argument to service_accept so profiles accepting
the connection can use btd_service_is_initiator to determine if the
connection was initiated locally (central) or remotely (peripheral).
---
 src/device.c  | 18 ++++++++++++++++--
 src/service.c |  4 +++-
 src/service.h |  2 +-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index b0309a1e7..a39eb8c64 100644
--- a/src/device.c
+++ b/src/device.c
@@ -158,6 +158,7 @@ struct bearer_state {
 	bool bonded;
 	bool connected;
 	bool svc_resolved;
+	bool initiator;
 };
 
 struct csrk_info {
@@ -297,6 +298,16 @@ static struct bearer_state *get_state(struct btd_device *dev,
 		return &dev->le_state;
 }
 
+static bool get_initiator(struct btd_device *dev)
+{
+	if (dev->le_state.connected)
+		return dev->le_state.initiator;
+	if (dev->bredr_state.connected)
+		return dev->bredr_state.initiator;
+
+	return false;
+}
+
 static GSList *find_service_with_profile(GSList *list, struct btd_profile *p)
 {
 	GSList *l;
@@ -3256,6 +3267,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 		return;
 
 	state->connected = false;
+	state->initiator = false;
 	device->general_connect = FALSE;
 
 	device_set_svc_refreshed(device, false);
@@ -4169,7 +4181,7 @@ done:
 	}
 
 	/* Notify driver about the new connection */
-	service_accept(service);
+	service_accept(service, get_initiator(device));
 }
 
 static void device_add_gatt_services(struct btd_device *device)
@@ -4191,7 +4203,7 @@ static void device_accept_gatt_profiles(struct btd_device *device)
 	GSList *l;
 
 	for (l = device->services; l != NULL; l = g_slist_next(l))
-		service_accept(l->data);
+		service_accept(l->data, get_initiator(device));
 }
 
 static void device_remove_gatt_service(struct btd_device *device,
@@ -5899,6 +5911,8 @@ int device_connect_le(struct btd_device *dev)
 
 	/* Keep this, so we can cancel the connection */
 	dev->att_io = io;
+	/* Set as initiator */
+	dev->le_state.initiator = true;
 
 	return 0;
 }
diff --git a/src/service.c b/src/service.c
index 14a4c292b..7c4dc8fe0 100644
--- a/src/service.c
+++ b/src/service.c
@@ -172,7 +172,7 @@ void service_remove(struct btd_service *service)
 	btd_service_unref(service);
 }
 
-int service_accept(struct btd_service *service)
+int service_accept(struct btd_service *service, bool initiator)
 {
 	char addr[18];
 	int err;
@@ -198,6 +198,8 @@ int service_accept(struct btd_service *service)
 		return -ECONNABORTED;
 	}
 
+	service->initiator = initiator;
+
 	err = service->profile->accept(service);
 	if (!err)
 		goto done;
diff --git a/src/service.h b/src/service.h
index fa930f985..dc0d1d132 100644
--- a/src/service.h
+++ b/src/service.h
@@ -35,7 +35,7 @@ struct btd_service *service_create(struct btd_device *device,
 int service_probe(struct btd_service *service);
 void service_remove(struct btd_service *service);
 
-int service_accept(struct btd_service *service);
+int service_accept(struct btd_service *service, bool initiator);
 int service_set_connecting(struct btd_service *service);
 
 /* Connection control API */
-- 
2.35.1

