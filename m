Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF8CDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 19:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJNTQV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 15:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJNTQU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 15:16:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36FCE
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 12:16:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50797cf5b69so2488799e87.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697310974; x=1697915774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+ti4BEkNtzecO32SRAmxcMtfkv6x0AWlt8vQ2OUSlo=;
        b=BqdsC/ht1sXNBgOVW+B8qOmjAnDSTkFkSiXjwifIKtcxz1xZkVMBB3NFgx48UZ2JbS
         LSnaF4MRHoWa1CYPm9IyP3TDk8KCGZ/4/F3E4jxU4QO+mwaH73WDKQSSV3nSb6mT8kDA
         VZuVBl0jWw+c11hMiEpJRy3/pJGqoHQhCgHu3My99NZJAOEfBS9bO0sytEMVg57lbW5m
         IsZPDy6FsLYVps79bdmC4h9P7dj2cX9yx44b7zS2WUY37XF9m98bEHtQdpMJRPr7DdJn
         TRC0qYq5liMH7NZzSBMdZFarOx+qeDRkvKSnUdemQtkXXoX8AZG0nboEEzXJ9DhDxmDC
         QZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697310974; x=1697915774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+ti4BEkNtzecO32SRAmxcMtfkv6x0AWlt8vQ2OUSlo=;
        b=hg67Y+vMKdcQaafo4wnPbWlaGGcALlt7biEZZm2dH8q/SuCtcFVPvUpHsw/EjTg5sd
         R3QFcx5iBtbTm33V8+k4bwhGJcfQRRIIXemdoKe3uzqd+LsrkJm/gjEiMFzwZlYXMbZ6
         1s5cIynJgqRJlcZ/UFIIRSgCq5koWo3bkKmjiJGEu+4yVq6MErMcUKM9A4QzgOUAXAfM
         AI7n1N39c/JRDWU9WTZJCcPMrsq+MAzyaKfnjkP6FqS8Hz0DGltDwHeZRsbJS2YsAWYL
         6lIW1NTPGVAR5tkE9xNEMXeZV8S2hsuBlOc0HX2aEyEBRqg68DG0KZvuVI+hJStAhQPV
         2vHw==
X-Gm-Message-State: AOJu0YxWw42bOatZ/hKAjRLqTd7Ug+CKQmDjPomCU9eBdHH4tziP863M
        uPqdKnIM8Ke2sIgUQdF/ntc9vgcbE90=
X-Google-Smtp-Source: AGHT+IHbqSoMKwmlyLtdZJab2ihdmICcri/ujh7QJsZIN5pdrzolnBxVO/g8dQku/WMMRvI3ddce7A==
X-Received: by 2002:a05:6512:baa:b0:507:a702:a613 with SMTP id b42-20020a0565120baa00b00507a702a613mr1539726lfv.61.1697310973887;
        Sat, 14 Oct 2023 12:16:13 -0700 (PDT)
Received: from localhost.localdomain (46.205.208.24.nat.ftth.dynamic.t-mobile.pl. [46.205.208.24])
        by smtp.gmail.com with ESMTPSA id x14-20020a19f60e000000b00502e0388846sm3826938lfe.244.2023.10.14.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 12:16:13 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] btdev: Fix NULL pointer dereference
Date:   Sat, 14 Oct 2023 21:16:09 +0200
Message-Id: <20231014191609.1883047-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move conn pointer dereference before the done label, because it is a
goto label in case of error handling - when the conn is NULL.
---
 emulator/btdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3840c6150..c76b89db9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1327,6 +1327,8 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
+	pending_conn_del(dev, conn->link->dev);
+
 	cc.status = BT_HCI_ERR_SUCCESS;
 	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
 	cc.handle = cpu_to_le16(conn->handle);
@@ -1334,8 +1336,6 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 	cc.encr_mode = 0x00;
 
 done:
-	pending_conn_del(dev, conn->link->dev);
-
 	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
 	return 0;
-- 
2.39.2

