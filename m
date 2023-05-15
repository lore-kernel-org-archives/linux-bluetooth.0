Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999BC7EE26
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 21:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbjEOVF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245326AbjEOVFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 17:05:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54051991
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab267e3528so95302095ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184752; x=1686776752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cTAOIXAq0oIiEHGSrM64rKJl+f/1F4LAw7ra9PqE78=;
        b=sUiRiWJcY7gdqlkzlZJhUW+IU5ppuwqHnLAgH9rctVOCJkbkN5WmvAQmsgsihvIRPl
         D1uVKCnrfkPQqupc7oYFAGFhUHS+g95yjOdbCvVT/0KJBqg3UYKgCrDGqgPFB4KmxLV5
         8V+fvQ5ruQI1oTUtZuAVaAQaOrtUa/bS/UVDwhFaK5rOrhgCzHEWFcbNZzCSosGgKHzx
         H5b/6o5M9dZx9pQlPcou7J0SPkCpJtUlDEFJtvGa+1dagW0UUi08Cx08Dp2cFk4aMUyW
         q950IJYr7nu1SzwDXfa7BytlUOOy5yAYL4fFDzkDHhCREb5KKlGw4W8tJLg5JGIbDUMf
         yQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184752; x=1686776752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cTAOIXAq0oIiEHGSrM64rKJl+f/1F4LAw7ra9PqE78=;
        b=SthuUYOB35lzoQgevokiY+BKOWkAXZyEwyK8MjoyUp+op8fIkodNJu879FSug7uKQA
         jD3AXiivFhfrT1Kc4AyY6ZKq0vbExJFd1VwyaBTvOtX/eYPnIrDoMn6tOwtsF8j8JHx5
         nDJVi7Mw5T36iDSnHJVecghrEq8pW5EsVywAXTdkMGQt++BdYCo4qt+MNUFsvzVz1FgL
         2xSupaie3l3rCzC/hi2kLmMoUSGfQjFAiIfUgtGoEq27GwHoXpF6nb3g1Ref/pq81bHb
         LN6SVu0IHdlhr5Uc1eh3TuFo3ImTRG9jVToerPsR3DLrgaP1Jh/Vlm0n0vm12pUpe4cq
         oxhQ==
X-Gm-Message-State: AC+VfDy+2L18j3UslfyYQT9iuMrwDznDOqR71fAOtliczy1LwkS6apug
        HRacP2P2J1VQo/gEdRfdMQbVmIpAYRI=
X-Google-Smtp-Source: ACHHUZ5A/WL8T65QebNbFfDaa8iGiiKgT+/TxOuFZmxG919+NBEHeT488pw395qGuAirQIISTUy4wQ==
X-Received: by 2002:a17:903:2292:b0:1a2:3108:5cc9 with SMTP id b18-20020a170903229200b001a231085cc9mr47532554plh.40.1684184752344;
        Mon, 15 May 2023 14:05:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm13990050plb.58.2023.05.15.14.05.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:05:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] csip: Mark driver as experimental
Date:   Mon, 15 May 2023 14:05:42 -0700
Message-Id: <20230515210545.718701-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515210545.718701-1-luiz.dentz@gmail.com>
References: <20230515210545.718701-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/csip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
index c273c02b8e76..ec042afd54eb 100644
--- a/profiles/audio/csip.c
+++ b/profiles/audio/csip.c
@@ -334,18 +334,20 @@ static struct btd_profile csip_profile = {
 
 	.adapter_probe	= csip_server_probe,
 	.adapter_remove	= csip_server_remove,
+
+	.experimental	= true,
 };
 
 static unsigned int csip_id;
 
 static int csip_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&csip_profile);
+	if (err)
+		return err;
 
-	btd_profile_register(&csip_profile);
 	csip_id = bt_csip_register(csip_attached, csip_detached, NULL);
 
 	return 0;
@@ -353,10 +355,8 @@ static int csip_init(void)
 
 static void csip_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&csip_profile);
-		bt_csip_unregister(csip_id);
-	}
+	btd_profile_unregister(&csip_profile);
+	bt_csip_unregister(csip_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(csip, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

