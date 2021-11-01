Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755F660F36
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhKAWGs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhKAWGr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:06:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD056C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:04:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y20so6890851pfi.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waJ8YTnl6YDRMAbsDpRsL34qGCFoLNpUcKaLNTaZ7K8=;
        b=Sr9Uc15Ak9XY0E6j9wotgUZwUXUrMpFZqmVgxCkgqJNRbLxVulWwGbVJtcTS1dPin6
         JR69gRUMDKvr0ZbEptKIPLBR3/3vZjcoenvVimbN3XiV1jVL30sarXdTT0Nkd+QyJNoH
         VU6Ia3tKdZ9LO7p9ItmI/+6x6f1tHU+zmd7OXthgYIs+3Xvu/XfquzbHjKg/ZxnaKFHZ
         ySyYIA5xzB/H6qFPqJRqnxXIbkJFozCAjkxeQ3Ya7BdVTYtEJoKOwmiGJtIcIKsJlRIX
         lg4JSZXRTfgizm3z8MXGcIz5wc1HNDslez921VcxLNlqLiQnN4X5LsAmoNcDd0z2xwTp
         eNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waJ8YTnl6YDRMAbsDpRsL34qGCFoLNpUcKaLNTaZ7K8=;
        b=nkiLy+Yj1mSF7mD5emX4k+082kvnzeB9k+7phULl8YKjGM7pDMPgql+s9K/dOvyS6+
         0Zdq3Vd1Y2cOaUv3L930Vp/8EWgnMofkhxhFtv328wxqQ6G9SJrDHl5nJAuXS29Ubve0
         gDIgDb/OD5yL/aAEMZU7OUiMuMdxJMctibfTTHTXBd/dtaObf1dOTxWNrC05DGbX/FST
         KpwGTTS5Or5Nl3KOedk3msE65NrFHegt39g9L1uu/rXEsm3/c2bOzm3QcROMMduE2EPH
         86CPhC0yZhxNUeG5JIRrqavednekU1caZbln+FetKcF3DsbQ3b1JD144n2lPk2s3rJ4/
         HBDw==
X-Gm-Message-State: AOAM533Fp3C49X5CE8CM9qeoasQ7Sk1AdakaqEIZdeJT2f6ZWfo3Lir3
        7Emu2hzFkdaWSdSjdZB6EnNlNWZoqX0=
X-Google-Smtp-Source: ABdhPJznZkQCQKcen4yoOpDJhZzGCHRGOohhscHmaDBrcxGxMtWnt+9avILspyJAXuu7HwC+Rf5Qkw==
X-Received: by 2002:a63:688:: with SMTP id 130mr5893234pgg.395.1635804252870;
        Mon, 01 Nov 2021 15:04:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s18sm17233752pfk.160.2021.11.01.15.04.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:04:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] main.conf: Fix Privacy modes
Date:   Mon,  1 Nov 2021 15:04:11 -0700
Message-Id: <20211101220411.2753274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device privacy 0x01 uses RPA regardless of the discoverable setting thus
it conforms to network mode not device mode.

Also this improves documentation to state what is the expectation of
each mode since it may not have been very clear by just using the terms
from the spec.
---
 src/main.c    |  4 +++-
 src/main.conf | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 5ca8d5644..3c9ab231e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -666,8 +666,10 @@ static void parse_config(GKeyFile *config)
 	} else {
 		DBG("privacy=%s", str);
 
-		if (!strcmp(str, "device"))
+		if (!strcmp(str, "network") || !strcmp(str, "on"))
 			btd_opts.privacy = 0x01;
+		if (!strcmp(str, "device"))
+			btd_opts.privacy = 0x02;
 		else if (!strcmp(str, "off"))
 			btd_opts.privacy = 0x00;
 		else {
diff --git a/src/main.conf b/src/main.conf
index e05291d8e..919675185 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -67,8 +67,14 @@
 
 # Default privacy setting.
 # Enables use of private address.
-# Possible values: "off", "device", "network"
-# "network" option not supported currently
+# Possible values: "off", "network/on", "device"
+# "network": a device will only accept advertising packets from peer devices
+# that contain private addresses. It may not be compatible with some legacy
+# devices since it requires the use of RPA(s) all the time.
+# "device": A device in device privacy mode is only concerned about the privacy
+# of the device and will accept advertising packets from peer devices that
+# contain their Identity Address as well as ones that contain a private address,
+# even if the peer device has distributed its IRK in the past.
 # Defaults to "off"
 #Privacy = off
 
-- 
2.31.1

