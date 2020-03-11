Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A34C0044D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 18:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547AD2074D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 18:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEvEANjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgCKS7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:59:41 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54919 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKS7k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 14:59:40 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so1409306pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=uEvEANjHkyzpp/8eH3dcISUMBMskPgSf2TWZN1/diarZU15LoRvVDhB0+EKyCO3kka
         UPaxht0YgzHZSZO3d8EdkmevF4V5lV2KsgqAc6Gz+bOoUQaUNQxkhWUKIFlTLz2gTxzC
         vWZV+oABb8GufZnBaPJ7o0HfVWZ/LALxZ0lxGNH3FpN2n7t5fcd4KuFxQlqaZEjUfs4K
         3wEBMKP8LbxWxaonhPluGaGe3p6GBUop/ROZ3V3p3eJZTjecEkyWQVY9ixNEEMlcP0jC
         LEfEZ7xiesMBWoq4i2BbV4Vi9re0bhn796XBHaUMoCYJSd/WKhpAamTmy3nh5LVk+TMM
         Hibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=Q7gP0r2Xq82RRo0/dnwha8IzehJXLo5vdobx6JkD4KBiF8ogMgWNtRLkJoJNisJ/kG
         Tc/MLIwhYBOl5nKnaEa9MzcKIwURwB7ovFOozanL5EHgTML0wg/FJW5SMWslMP9VtVB3
         LUlFm9k5ceWnlovTN8JLDeVEebcNg16nq7Jl6+Bjvo0dVznw6EJoq/FnBOZ/ej0h1xRB
         Ok5PMzrw8IQvFbFLX7ZV/WQWOyy73ATTkKMNAAg552yTRSSXbPosSrUeoqHZ381Dt4M6
         XR/lRwhAhhhmF2S3C9I5p8dkoM/qQ0xMNFlv90QmmJft42oDPr41mOIaakVnim0RDRPs
         9hRQ==
X-Gm-Message-State: ANhLgQ3SBbkVa6AzPCKVYNDR70pew7sCnJyB/vlwTkgfSMkKCT2BMlN1
        g/ioADMR+nYG8V5+IXIHZgTBiIIdW8Q=
X-Google-Smtp-Source: ADFU+vsC8NjdCuEvyGUN7dbKWEGh3Ac9IsY66FJRezBs0OwCCN4vTJof/kKFgZhUcQRyQtprEx7NrQ==
X-Received: by 2002:a17:90b:1991:: with SMTP id mv17mr172284pjb.148.1583953179443;
        Wed, 11 Mar 2020 11:59:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm45693327pfh.26.2020.03.11.11.59.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:59:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] input: hog: Attempt to set security level if not bonded
Date:   Wed, 11 Mar 2020 11:59:36 -0700
Message-Id: <20200311185937.9032-1-luiz.dentz@gmail.com>
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

