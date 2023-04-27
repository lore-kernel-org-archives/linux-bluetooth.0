Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3100C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbjD0TdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245502AbjD0Tcw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:32:52 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBA410D9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:49 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-32ac0743030so67431255ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623968; x=1685215968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5PZrWIw9wJtuIkYP9O2VU+XSk2bbMScan7h1oDUe4c=;
        b=RDNI+J+ulYs7YK+0tLOq6QEIhaX9cIXYyqD40UTRyVZMnukLlJ2hNwA3BFng8BXlVc
         cIdiYGZnPuCVeInd1+gStc6drbmgY7dzJ3oT5XP5PgpDdHIVL529t16+qa8SfQSHeKkH
         0XuTlucRhBJmfepdFUcY5ag0zz6ETQ3OKfnxGKd0pwhF7hc7jPpCKak9kzetU8e98Ym/
         7RmAEHAJbyPZYYbkqrPqq7Uh3zsxILPrvh8zeUe5sXqlpQn1mOuF/O7Vn1PWngKOwPU8
         7cIeQp7zoQe2PF/jXXUifZfHoIdp2uQnCPD2ZvF/8VLy/0hTVjNXPtOHT3Ij2bDvJ7Mi
         Ofbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623968; x=1685215968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5PZrWIw9wJtuIkYP9O2VU+XSk2bbMScan7h1oDUe4c=;
        b=lOR7VT7YETxuWln5A1vsHDiaJqoOOYG1S8/nWH+L2xLROCjLZunHHrrxKUtnup+uzC
         eU97rKzaWk1QA26i8tdZu7XZGLROn22MlDcyKKeIFMep+y5mF7ZIHFvA5FZdW+9Kjj1j
         jcUkRcGKXa0eB1zPlx4P7MOcajomXt+0rvtJ/AWJTiEfwF2J/eE0GgNzQJHijUKXgDKx
         opGlX3TAU5CykRltTFhD2lhzxJ0Xr+yObV/GETip8ZMyDJo0nLEBTx+GxHOM7DMcz50D
         NpCQDsI60R73pPnjdMH171ElkiyZlobivHuOoMF9JPxANYtMO8lxn1+sWbFQZabBDAvJ
         MO+g==
X-Gm-Message-State: AC+VfDxWZyIy0E9fZVuETchyIi48fHy95Hyzus+PtIVlsxqgNm6IUxLB
        02JmxW0XCmcLG+CO1Qf1269SDHM3vdo=
X-Google-Smtp-Source: ACHHUZ76O2gb88AKRlptZfNZPc4nLHDySbkrZ6ItZiwDkv5z/RKY/SztyAeAGx4Z/zoz5Wb5lE+oZg==
X-Received: by 2002:a92:d344:0:b0:32b:681d:b1e7 with SMTP id a4-20020a92d344000000b0032b681db1e7mr2055462ilh.8.1682623967890;
        Thu, 27 Apr 2023 12:32:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.32.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:32:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/9] media: Fix not storing Preferred Delay properly
Date:   Thu, 27 Apr 2023 12:32:37 -0700
Message-Id: <20230427193245.323502-1-luiz.dentz@gmail.com>
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

