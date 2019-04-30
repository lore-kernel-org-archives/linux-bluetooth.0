Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA8C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 09:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470722080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="O+9XFUIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfD3Jo6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:44:58 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40824 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfD3Joz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 05:44:55 -0400
Received: by mail-lj1-f176.google.com with SMTP id d15so187276ljc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9iiAMW1B1aaaVdlwbv+tY43/QEOe4l/Jcgkze+qmdM=;
        b=O+9XFUIc0iWYHRkPUnvjO0mOQ5WZWd4pIFNHPIBw5+SU7EDBJSdSRhEsxHnQ6CUnmm
         4uSn0jxnQrLZgubzf6NupvnqRRKpu7xss9lw1HBDQczSeCj6YLpSkXgnx2o98FSfvh0g
         RHlIrv1h0x32Ish72uD0XaClA09nxDk/TuzHsNdMECSyoKEfqMRcl1xe98OEVEc5nL4K
         rAzx7zUgM4DqtkmlVY9oSZwzNR0bma8w5gSCeBN8aImztEohsK3pfGNwkbACyXDqwAV4
         r4X6YfbjIqgZq8WAPqJNv9axBTUTrasqpGOcoydW3c06Pa4bt+IiQ+wZlC8nJI66o6XN
         6mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9iiAMW1B1aaaVdlwbv+tY43/QEOe4l/Jcgkze+qmdM=;
        b=cbqYxTGOf6K9g+BGMVY5c9PWQOkKYivCo/W9GTm+Lodt3CBFfzjMDnFy8v97xgKdpz
         GUWkwZidcuChjSV+gAXtU94Se+lJb8xBUhBw1+xVyf68g6339edDpdTzjwiknhbJU4xu
         eLwQOFAm23dW393nwY4wsSODeUE5rBJeNXe43CGGYlRiFz4ZWamel5j4ACREWM78e9hs
         jTmQcSZZR91F2SM2H0RL3K2WzyX/ltobRGQfVwDxvAL5o4M3kfnSYZybSF1hF9taPFw6
         Tys+lx5Tvty8+I5IaJDjdZcBEyb8V2Y6+6cLyROwSDPcdx6bkkz79KSpr2LuNYoAY31r
         oDjQ==
X-Gm-Message-State: APjAAAUz5So4+Zrs/gGFy+J2KVjf9EMY4ywhg6cHAkTDib3ah00POpAx
        /AGXX0wp+SFDwSJBcDPgaw/d3XOw0bE=
X-Google-Smtp-Source: APXvYqyaxLM8sfzaxjLhJCAr/yFXkKQ57Dty3p+ng3T8ifWQBX7zeZj+ezKtm1j775pkStrFetubDA==
X-Received: by 2002:a2e:2c01:: with SMTP id s1mr18521687ljs.69.1556617493123;
        Tue, 30 Apr 2019 02:44:53 -0700 (PDT)
Received: from scytale.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y7sm7401949ljj.34.2019.04.30.02.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 02:44:52 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH] a2dp: Fixed warn_unused_result warning
Date:   Tue, 30 Apr 2019 11:44:46 +0200
Message-Id: <20190430094446.26135-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This used to break builds when using maintainer mode via
./bootstrap-configure
---
 profiles/audio/a2dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8f141739c..5f5ad508d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1772,8 +1772,15 @@ static void register_remote_sep(void *data, void *user_data)
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		goto done;
 
-	asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
-							avdtp_get_seid(rsep));
+	if (asprintf(&sep->path, "%s/sep%d",
+				device_get_path(chan->device),
+				avdtp_get_seid(rsep)) < 0) {
+		error("Could not allocate path for remote sep %s/sep%d",
+				device_get_path(chan->device),
+				avdtp_get_seid(rsep));
+		sep->path = NULL;
+		goto done;
+	}
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				sep->path, MEDIA_ENDPOINT_INTERFACE,
-- 
2.19.1

