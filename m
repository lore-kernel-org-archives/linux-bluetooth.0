Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64962C77B61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 20:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjDYUrf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDYUre (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 16:47:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0D13F99
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5465fc13so5052263b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455652; x=1685047652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrG2MhT2z2SJPX4B7uDj5q7JMtwew5msulcQVSX1wpc=;
        b=qUtMzLuNUZfnVHuuxlfduel9JUGO5O3lEL8NQL5G6aTRcX4+IiZv66QMaCaKea/Dj8
         c/7yf4IiMVZSB9QQV46hl07A+FV+l8MPpnpKJWExBeujhzHQYWM6R9Tp1Njn3EqyAiOG
         nqz+E/rDuEWBzzN9KmLP+o8zpwoBP498Xo5CD6OeF4ocZ6bqVTnGgyhFckOGSIRtJZfZ
         2rv+eBqoK+KXI3c6G4Esw+v25EO+lUqIhgvIo/LZapqynVMuwfY/M8k0eHckg3ABZC43
         WjAbHpHZjSFi73eDTxseQBMSJ5v34RybMFeVKmL110PCWPC2pqj5sbq7ZPefRnMarsDT
         6dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455652; x=1685047652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrG2MhT2z2SJPX4B7uDj5q7JMtwew5msulcQVSX1wpc=;
        b=FfuwR5YpQpkBBgzUHwPgvgOWfOYK0EVoUydOaHvNk5H3SWPYKoajvOes2k2vKQ8YVZ
         UJhECP4Z3tSv65amKR7ZGj+Xcr3nUUxBeqOuF3Iio36/W0MOO+hOb/0GFTtkD2ZGgSoe
         2deK2zjNMSyCrQvGrQYfeOy+pRz0NZ7DihXyzPz/bLwuvQCsucFRVtHr9qClPdbnYNSS
         iJF25XIEBbE+PeNEb+ZpYu72MPiByoCTrrfolccM+CNdu0S/uBjyid7cgnC1xZc9co5e
         3ZwW1BAcz+7WDoHnQ9A3htZlPpnqFsjxyxQgtPCH/2N6uvZqFDy8MhCblnEG8aAKF1ES
         NPHQ==
X-Gm-Message-State: AAQBX9f/+Fq+/mtLgJ4NbvcnyzdGtZVFZY+8785+94PWpYMrEMrJkcSQ
        W6736p6mDWWPISgP8pbD+CHHsn0mxqg=
X-Google-Smtp-Source: AKy350aOt0q9nQpPN+pPNs2dPFxnD0dR6AKs8Khwi990qm40dGz+sbD9kNMl4adlkazXWCQRF8e63A==
X-Received: by 2002:a05:6a20:d806:b0:ef:c4f6:9122 with SMTP id iv6-20020a056a20d80600b000efc4f69122mr21060832pzb.24.1682455652244;
        Tue, 25 Apr 2023 13:47:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm8247454pjq.43.2023.04.25.13.47.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:47:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] media: Fix not storing Preferred Delay properly
Date:   Tue, 25 Apr 2023 13:47:23 -0700
Message-Id: <20230425204729.3943583-1-luiz.dentz@gmail.com>
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
index 540e91bc6706..23c63f4172dd 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1477,11 +1477,11 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
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

