Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4223BC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjEPU7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEPU7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633859FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab01bf474aso988035ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270771; x=1686862771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaiRL7R9hAB8QTE8OFJBjT36cb1wdquZAEQfKkG1Kg8=;
        b=JNed/x21mTPkRVq/ZuqL4g0ZYF4oMT2yKL2Co4vRJ4l+QljxPn79nol/7stF59mwve
         A3pJ1R2FOfdwxzEBWxfKsMEXEIGadag6t92/tN9Qq9t42apmxKHPZQkTYlnu4q5THxIc
         6muHidYLI5wSXbMC0GxSPEqpFmzKv8moBAbEjGSV+YhoL/cZsPwB/lSgmHROPU84KYw+
         Ae1NMQWEtojyWNZsSDhN0KPL3sazSikUtCFp1XMAClEC4qwYhqkHHrh5P7N9ujhQBhH/
         5Z4p4M1GM2159K/7q4tMA3LKd3ikowMK9ego/m9O94K2ZgQ8LyLPZRaX0HM9o/ox9L98
         X8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270771; x=1686862771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaiRL7R9hAB8QTE8OFJBjT36cb1wdquZAEQfKkG1Kg8=;
        b=j/frkFG1prDCPDrwprCRl/iiuXAVg/vhQGKQoJxZvOmstO7zYAWtSd33HOBP4X2ygh
         Yp05bXwq7UTM/k5QJ8ENjodwKAq5yOhvNuO3SR7H0KH5jFenqRQBSZ9IYUQhEpSIZO1d
         FHSfAXvM+HhdpeMaW9gi8cjRpVCpBRi8f/O0k/IAhZbF4QQHAzVwURe9+8tMVWTKm1vX
         CQ24xvlXRFFlKaS+FRw7UvHq4+Dkq5XLERoYtQAGnKU5yX2mubNqW0vW0HYbwgFLeYFg
         8Ui2rMrYeD8hudL+ZPF7azt3JtdUmTdnhOsgOIbvQgNv+VGXatxnjfdtlXVLZquAHWw9
         9VUA==
X-Gm-Message-State: AC+VfDxYPZVJxqSnwWzn7AEhE8Z0krYLSygpCTOEJpEzFzyIscXQqJNy
        C6jZo3fleJhl0ai8k8P2v5elffxZvwY=
X-Google-Smtp-Source: ACHHUZ77vupnpJ7OrYzI74PeVdNnkEPxoyYt9QkVIKnPA2nd8BW2iI2SF32CZd3gAkVwL9Q0COYoNA==
X-Received: by 2002:a17:902:cece:b0:1a8:626:6d9d with SMTP id d14-20020a170902cece00b001a806266d9dmr51463195plg.62.1684270771031;
        Tue, 16 May 2023 13:59:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] bass: Mark driver as experimental
Date:   Tue, 16 May 2023 13:59:17 -0700
Message-Id: <20230516205924.1040506-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/bass.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index a7fcc9718d56..fae7fe00412a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -276,18 +276,19 @@ static struct btd_profile bass_service = {
 	.device_remove	= bass_remove,
 	.accept		= bass_accept,
 	.disconnect	= bass_disconnect,
+	.experimental	= true,
 };
 
 static unsigned int bass_id;
 
 static int bass_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&bass_service);
+	if (err)
+		return err;
 
-	btd_profile_register(&bass_service);
 	bass_id = bt_bass_register(bass_attached, bass_detached, NULL);
 
 	return 0;
@@ -295,10 +296,8 @@ static int bass_init(void)
 
 static void bass_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&bass_service);
-		bt_bass_unregister(bass_id);
-	}
+	btd_profile_unregister(&bass_service);
+	bt_bass_unregister(bass_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(bass, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

