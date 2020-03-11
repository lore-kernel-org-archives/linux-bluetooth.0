Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F8C0044D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FC2205ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzO753Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgCKS7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:59:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34440 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKS7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 14:59:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so1697968pgn.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=lzO753XctsfcZ0zmrUEIB0hI9K5H6MKzslXKnE9ucyux0XrNBLLIq9M8zeawLxT8VN
         6r4NzfDDwq/oYT1QD+EFnmkC6dDMTOMOQRoEw3Ghx9qNJk4bmtjrSNFra/nVubQu9ZPx
         S5HxjqL+Lw83tQsDc8MMKnNKCT1giXUAFvYOX2HYUniX6uF+VLajjO+OMVsXXVBpXLeZ
         H0Aw9VlTKVdiH0ZnDgs4bPTZldLlka77FxAP3T4mnZLpNGEPt4deQYujvPdCrdERscZC
         t0h6qzTGy0P4u9fmmovz9YLkUtsWdYuzn8tprhIqhHDgVFN4jHx1quWMuN0rfqfiMnWM
         C5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=mvJUE5G2F93PMkiXvhAYxgOt1Mnf4TxPClOvyx0V+qhfVDc6h/mZzOwydN+sCOPBtF
         1hGoCmxZEjrOKq8g3ljH3+pigmCSg/+X0AlKKghhJOwYBgMtDcA88wDgYFGJRB+oDdSz
         WHo1MFyw/o/+4ZjkuPjcUlmlgr233TgTOGa7LTnEmYhsseFIX0QuaRMJD9wXICwSwVhI
         fOYziWxSi9fC6aydSzLRkfIHsWXTq2qAfEqAKlBRMGfSsnMeCLTo2qmvr5levXCFpxY8
         R/rEk4rXRnPtQPD0NGBeGvZ28pk3x5gmAkvqz8fwnZdp5wd6jkUmSY3hVrkgKIUN3wgd
         PLUQ==
X-Gm-Message-State: ANhLgQ3xGBbT3Tn4JZ3jiXhaVrjLdaKyutQ7u07vxgplkcrX41fcAEgJ
        vq9R5chxEruYR9AkVtsAAHk8VTRJjPw=
X-Google-Smtp-Source: ADFU+vtnzca7ev71glKhOx7IM0T058KrXNu8b/LKSIG5LpecpB/zPdRFXJOGCQv3NWmmvwpWIj5VFA==
X-Received: by 2002:a63:68a:: with SMTP id 132mr4202411pgg.12.1583953155383;
        Wed, 11 Mar 2020 11:59:15 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mp5sm6169252pjb.48.2020.03.11.11.59.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:59:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] input: hog: Attempt to set security level if not bonded
Date:   Wed, 11 Mar 2020 11:59:07 -0700
Message-Id: <20200311185913.8785-1-luiz.dentz@gmail.com>
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

