Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB64C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 23:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444854AbiEFXMF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 19:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355923AbiEFXMF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 19:12:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BE149F11
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 16:08:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fv2so8257710pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZGmnHFBIKFDMNtGKtzPHZvKsJZMXHVNZs1J3SKNZHk=;
        b=mqW4sD/2pzcOlWfkG/4HPMCs+3YOC3HTz3/YfLkj46P1EHnqYACeBsHaaDSqpF/Pw8
         T6lH4Gdek6iE2H0CV6tW3UfK2QLWwYWC+hpoWme7QQH47aEg35dNgVzeMI2lCvHD8r8m
         gsg41UnEH4byU3xGIgFDxw99JITzhGf4aPmm6C3TEok71ewkZXtc5dIVQ8pLayGk8UJH
         IMwL8eeHexoy3iiviawmTLXQ0zBG1P9pMUozGrZFQbDcaGZym5hSFjB0JHO8HyhQ8DHQ
         4z2pSU3hygVC0UaomcYJempNgUgpQGVRYKT/R4Jl9yFnAba3ZCuzgQaDdIhiRsq9TRr0
         6RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZGmnHFBIKFDMNtGKtzPHZvKsJZMXHVNZs1J3SKNZHk=;
        b=ytHsg+Tm9OMEF3DaAmzIF5eHg5HT6qjUPEqDBE7n8IJaKMWEh792tc/hwshCaJqdkr
         LvjpUnGCcycvZL0ypfmsFca/quhgaGkEY6tfJ5NVhpMPxWP5iMvfOy0D75mXPHpvJhR7
         +hK5O39yrL4NlhXu5iwvOQt0WNOY/wfXhFtz6w8mdECobCfsKTl/WJvCfMobGVLLI/qw
         22et3rXKii3p7s/Bljxuwbctb6Es4LlRB5pwvGAbYY3YIpFWmjKeGs9fcUskpa14D0Yk
         RCwpRGJw+6w+Qmm3K41PSP1TCOK2yDysxk3UGBpMpTHgEoRcckSox0y+rm/BvonSpd6f
         Y0TA==
X-Gm-Message-State: AOAM531FGfTdVS803WZ5nxy+0W1Nlm0WY2xuiwH5YwbN3++MZ1fwAB+D
        ytZ9GsbNQA+ugHTC5ltMwpfHm+CyVho=
X-Google-Smtp-Source: ABdhPJyuUPKK531UDv5CcZbxQ4vUzRo1k0FKRHUPt8AXoN1ZB7oTyAiwdVQjrUcT+jeAnL4hlEFHdg==
X-Received: by 2002:a17:902:7e06:b0:159:6c1:ea2b with SMTP id b6-20020a1709027e0600b0015906c1ea2bmr5906550plm.105.1651878500047;
        Fri, 06 May 2022 16:08:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902f14400b0015e8d4eb1fbsm2265822plb.69.2022.05.06.16.08.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 16:08:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] advertising: Treat empty LocalName the same as omitting it
Date:   Fri,  6 May 2022 16:08:19 -0700
Message-Id: <20220506230819.3954905-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This treats empty LocalName ("") the same as omitting it so not name is
set in the advertising data since some D-Bus binding seems to have
problems to omit properties at runtime.

Fixes: https://github.com/bluez/bluez/issues/337
---
 src/advertising.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2110f17c9..ca23774ba 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -533,7 +533,15 @@ static bool parse_local_name(DBusMessageIter *iter,
 	dbus_message_iter_get_basic(iter, &name);
 
 	free(client->name);
-	client->name = strdup(name);
+
+	/* Treat empty string the same as omitting since there is no point on
+	 * adding a empty name as AD data as it just take space that could be
+	 * used for something else.
+	 */
+	if (name[0] != '\0')
+		client->name = strdup(name);
+	else
+		client->name = NULL;
 
 	return true;
 }
-- 
2.35.1

