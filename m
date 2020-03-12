Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CD4C1975A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26820716
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWGU82y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCLWim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:38:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34898 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLWim (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:38:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id u68so3990524pfb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=kWGU82y8ALOAHJQGVjHyL/Y648wA1DzeL5JS5bTUORucZ6lJsPIBzxMC4HH8ssLfeV
         jfmooP93ktewYjsuW/nyVajfgX/Wg3SPAGWJkUi16H04RzlBqB0hNwTE0ATDzYOTYqDr
         2hnVaedB81tD/9tuqOouhRisVLt6EduBxsR9EgQLjhNmDdcq4Vmjg1oOOIeZenPTs8NL
         82PsX4gxDAHm+/zZqbk5wgrqTFBb5yKGldqjXZ6TwU2Ol/iQbrBFWDWnHQJwT+bedAyq
         trpqQs0/36ns71F0ZcjONKXE2M1IITX29J854bqWxRm21AM1M5bSdK/qwrL4Hfh/lOl3
         lC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=LzxGC0OlXlmjIGlSP96UdHLbimkaMVcOL6C7FMe6TWkFC+HdrPWc2Hnzu6OU2IBX79
         hMSgJwlCFfEFUgWuu37XGv/eX45VoJKhontae0MLFsE1B5o3y0r9gHNgOkANdBYRGQK6
         4dyfgnXj+Prh/HH+/+4pKMud7QbcfSmvbBWieRFA6eqW7hQY37xJ+hGm+Zks7Nmw0PDE
         25IIr+ENG6Xacq+W4wneOUp7M9sy2Hzs8/A7J5eRVZIJHkAe46U4lIy2EwiPYD261Tbu
         1vb45X4T4MDsIcaHFHTEMSr6ehPjRew9eiZSTvbYEEpcB0QLGNGAIngOmJr3PPuYVphu
         JIUw==
X-Gm-Message-State: ANhLgQ1zOAURrP6wcXOO7yo9f4BQs9E+CbEXykXenK6vPOfv/fffzHkY
        mJvZDWgOFeaVrOMyBp6AcyhtXbt7854=
X-Google-Smtp-Source: ADFU+vuV+1YcibKzR0lbiw9G7kYf3HG5MgPB3uh5wmY1wEbSmnFSuc13UwGL36bjqy8bfxA2gFuK+A==
X-Received: by 2002:a63:1003:: with SMTP id f3mr10112792pgl.450.1584052721009;
        Thu, 12 Mar 2020 15:38:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g5sm5118190pfo.192.2020.03.12.15.38.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:38:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] input: hog: Attempt to set security level if not bonded
Date:   Thu, 12 Mar 2020 15:38:38 -0700
Message-Id: <20200312223839.6236-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to set the security if the device is not bonded, the
kernel will block any communication on the ATT socket while bumping
the security and if that fails the device will be disconnected which
is better than having the device dangling around without being able to
communicate with it until it is properly bonded.
---
 profiles/input/hog.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index dfac68921..f0226ebbd 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -49,6 +49,8 @@
 #include "src/shared/util.h"
 #include "src/shared/uhid.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
 #include "src/plugin.h"
 
 #include "suspend.h"
@@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
 	}
 
 	/* HOGP 1.0 Section 6.1 requires bonding */
-	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
-		return -ECONNREFUSED;
+	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
+		struct bt_gatt_client *client;
+
+		client = btd_device_get_gatt_client(device);
+		if (!bt_gatt_client_set_security(client,
+						BT_ATT_SECURITY_MEDIUM)) {
+			return -ECONNREFUSED;
+		}
+	}
 
 	/* TODO: Replace GAttrib with bt_gatt_client */
 	bt_hog_attach(dev->hog, attrib);
-- 
2.21.1

