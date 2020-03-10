Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AEAC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EA920675
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6yYUTTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCJRgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:36:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42249 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJRgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 13:36:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so6619053pgs.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=V6yYUTTgX6TOk1mqlNf1kgYI2NI5wQle5Ge699pKO2eU3pOgTV3K3BzYmAq4kpLCbv
         +8G/QDoaKj2z47AYZG8rrTtadq9bq3OBJY7fmZInzFxRRbhPPksUniDVj0esLiDwWl6P
         UKJJLajN0TyFXEgc/yo0vqtKyhf1VmEOG8VKDc3A9xHALdQgtUQKKmmScEbfTRgkz5z2
         i/mZkCeqmqyvmNoBBokdOIZsgLrxKdGrvmt1w3dpDBAZIRj3o6K+iZ3yxjqTN6nARxAh
         At5bgd4wvOYEMA5N7io6qCIUrbIX4iIi0og7A2p2HlWCxe4gHrPYLV7wij/BWhFVCwjP
         z0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=TUTYsjpl8s8DsNa5OXyo3dRW4onqZrUHR8e133LfulDi5aRXA02wNUxVyUr+pzlzSJ
         jsu3LHOzrvs7k1pm4Td8c8agpCmk0AX62DduxWcogjAs5WlZMHUVR3fThNaSEP+IIieQ
         eoAA/nDGJbgju3Sy3QTNf32i/tUDn4NN3w9iFwGsCS32epHuK9p258CZgC25ZflTz9/h
         nsqT0C7qbVhdkf/9AgtwM7SXlJUvu1JANguSyw5m1NmSqy7O1Mnw3+OlACgk5MYa5uUw
         /MP9A8cTI6K+s2WVO9HCmJfu1raZ0iJS7aCIXuwlHsTgZTpExOthFzF+Q8E/kz2U88bb
         X+vQ==
X-Gm-Message-State: ANhLgQ22DzNA0mr3vKylgP2Ss/lU3QR/5eaFFPIZLKZfXtfJoVLFTzuv
        One+haSK+V0HN4jGTSAOkceUcyxR0k0=
X-Google-Smtp-Source: ADFU+vv48JaniZZps+A8cVhy9oIORwOf681JBPmE8omsfHt+QQdLXIH1DuX0YUdV1gS48fixtImafw==
X-Received: by 2002:a63:3d45:: with SMTP id k66mr21757821pga.56.1583861810993;
        Tue, 10 Mar 2020 10:36:50 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l3sm2893388pjt.13.2020.03.10.10.36.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:36:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
Date:   Tue, 10 Mar 2020 10:36:49 -0700
Message-Id: <20200310173649.32722-1-luiz.dentz@gmail.com>
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

