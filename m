Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84DEC7EE24
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjEPU7h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEPU7f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC576AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so1019155ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270773; x=1686862773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cTAOIXAq0oIiEHGSrM64rKJl+f/1F4LAw7ra9PqE78=;
        b=JnrQ4raWpowF4A2cmnUaGlib1V/qtn8A0o3c7PSUBO0ROQGEdSm+mIIpBkWmlNCBIg
         O72Wd6Y/D8+F63ifTgs7OYTlRHrp3kulrR/T+0MfmmI/3MSw3DyGVk0spUmDXBI/3DsK
         N1HXcDIIdutlWAbS+qG+6Aqk3XV4PW+pQGpNv+Mb8KGXx9WGoVl01ErdSET7HgVIU8HA
         SffPS96kExVljOVJ9BpUZ5WhjBKDEQ9ZlFfIzdk/NWD8meVTRp4ZDT4y+Sya87BC3FJR
         +lqG6bPSq/8rvqMv68KuW7dZ5J2riXulL7F1pd+nq3MmtFx/UjSwq8F6Ihs5TEM9m33L
         qrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270773; x=1686862773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cTAOIXAq0oIiEHGSrM64rKJl+f/1F4LAw7ra9PqE78=;
        b=GVgtr79bM8fT8IUX7PrR5m4jPY9PbWeX1jPpehHtDAukBKf0GQqUfEtbZP6iF3SiVk
         osh0p1d92eonhvFk9CTgaYoR4f4YwuLQNNEGqx6/qXy+OAhXwk6FhSsxyujlEOtZ0Gbj
         g80+EgaA6/D5JmWjK8G55figBsGQ+dcktaDm7hbmWKPidJIifyTa01c+8hCZHF5bA9gx
         k2dOd2yRJ+nbCPI7XNiJkUgEkUt6ZZadxZrwYBO5Diz4x9ArlqwdBRED7fRnHQThemHv
         M2y9cu0ZkPq+aFPCKn7mkM8JyXmqIOIvdCq1vAWJmzsplf8Z5DydjBaxv2PWqIpnAoE5
         ZcnQ==
X-Gm-Message-State: AC+VfDy89Daeqaq2u4z8NiT/qaoRFdnWpOjG0ZZNSMeMCieGwM8EWKTP
        z2vX+5Hnd+Y8EzSH++xWX05YujdvBAM=
X-Google-Smtp-Source: ACHHUZ6jW7kIB/lDAISmOt8WFBMZXJ0NL8NZNm+bR/TPOXpnBDQYFMFiJIcO4mjsh0WXGnxKvvE2cQ==
X-Received: by 2002:a17:902:b418:b0:1ad:dac0:5125 with SMTP id x24-20020a170902b41800b001addac05125mr16107696plr.11.1684270772855;
        Tue, 16 May 2023 13:59:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] csip: Mark driver as experimental
Date:   Tue, 16 May 2023 13:59:18 -0700
Message-Id: <20230516205924.1040506-4-luiz.dentz@gmail.com>
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

