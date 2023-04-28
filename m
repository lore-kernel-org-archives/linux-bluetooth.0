Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150AFC77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbjD1Squ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjD1Sqo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8A2128
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a516fb6523so2862455ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707602; x=1685299602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5PZrWIw9wJtuIkYP9O2VU+XSk2bbMScan7h1oDUe4c=;
        b=HvHUhHfBB4xTFA1HwP2QMYPm9IT6neWuUFtbtsU0BSERKoBVqQLPmSRbXrHkAHTdeu
         WgdeTFKKInKn8BanBiTcqH5pisG+iRHSfuC6wNOHZZ42cCbgbko6RyzviPmuPi/6MgqY
         bJvg6/tyaSF9ca1ayGRLWBBXH5c7yIVjQ+Mf+p3/C4MWm8AEMchvQRmdkKl7tXH9qeeY
         TXh1EJfNRiAPsrAvl+nuPyCVr8iCOl6SntBWwEJYeMxwMi+cueUASZZ6qrZ23TcaxT+A
         1Lgn7iKUlev+6DxRptsHvB/tjYUeomS4iob4tw/Q0NLIiqg3CmTh7KymiytbRDDr4sRX
         xniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707602; x=1685299602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5PZrWIw9wJtuIkYP9O2VU+XSk2bbMScan7h1oDUe4c=;
        b=HnTBMNPCwPvu+QlvfNdghMWMgSFEkm8+9gMOkzX5L1uac4wEyI4a9awFCABERDn5wg
         gdUrGauAR/fmySH2v+Dks678CCk4/dRL1RBP6VYvLybdx1BPdkakeYGqUySs7T/47F/U
         o1MdrXL3F5BH8f+Wo1rM9UMTZFQI7A7syHvszCP3VnsjcQnPIsEne3fkTXZFfk5LUKHQ
         V4Qj7YOW4yIMDzPOC+hKeByRpdkUal3oHBWE/Fg3eYJr21ZGpiuMnW4KFGvzTu9g2F3N
         KManL8qVOkcogT+pLlXkIWN/XYg4hys5yJdKL/szFFXU36HdhiVqNIMp8linoDr4pu16
         ZF9w==
X-Gm-Message-State: AC+VfDySd/6NaaEdC1M/5HxxwTy/4AssthEE5+ON7d5OvHzQVEfrqaz3
        lAoqY4ZOArQ/As+PFOf5GGoQnO1hM4Y=
X-Google-Smtp-Source: ACHHUZ4xKeAsQT6d521E3mWeUMBoUHSYgZ9EM4PV0Hxg8Ij2zO9YXJiVvW5tOdAzUhKImdRHisQKhQ==
X-Received: by 2002:a17:902:f552:b0:1a1:a06c:4892 with SMTP id h18-20020a170902f55200b001a1a06c4892mr7461662plf.13.1682707602280;
        Fri, 28 Apr 2023 11:46:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 1/9] media: Fix not storing Preferred Delay properly
Date:   Fri, 28 Apr 2023 11:46:32 -0700
Message-Id: <20230428184640.849066-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Preferred Delay properties were being stored as qos->pd_* instead of
qos->ppd_*.
---
 profiles/audio/media.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 52c4bd80a94c..6ce668e31303 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1483,11 +1483,11 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 		} else if (strcasecmp(key, "PreferredMinimumDelay") == 0) {
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
-			dbus_message_iter_get_basic(&value, &qos->pd_min);
+			dbus_message_iter_get_basic(&value, &qos->ppd_min);
 		} else if (strcasecmp(key, "PreferredMaximumDelay") == 0) {
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
-			dbus_message_iter_get_basic(&value, &qos->pd_max);
+			dbus_message_iter_get_basic(&value, &qos->ppd_max);
 		}
 
 		dbus_message_iter_next(props);
-- 
2.40.0

