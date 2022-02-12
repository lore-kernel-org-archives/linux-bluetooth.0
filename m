Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 08:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiBLIsa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 03:48:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLIs3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 03:48:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005A626553
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 00:48:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so27296588ejc.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 00:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDBGvFT6GeSRvbn8Hj0+9EC7BV/VDaZZ9h/H5UXObh0=;
        b=OwsKCw+aJWH8IGnx/uY05wWXJML62TFWLuPmKCJg2O87RKwjzEFHBNsMSSjSY3G8Rk
         kh+KMW4FESYY9oD3XYV8xwoagFTR3e4THI58tl3m5HM6S9eauieUkqG6NI5TesFgFtRP
         Wx1bBh3Gt3OL8crSv7Ow2wK8TnU/mHu/+SWIKECKKBSsn3B42r6XvI5hAw2liGNAjoCv
         IpIa8jmXMujjVwUghp/ucMYSuDPuANeM+NqnUo5RZQwKit+O8uzu/YNEd2MN4vOfmkZX
         V+/nw2A4svTh2JMbh4Fh3XykkvBww8P7DIWrrwbXCD/O63dPbBkEYEg0yVIu32cIBYOJ
         9w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDBGvFT6GeSRvbn8Hj0+9EC7BV/VDaZZ9h/H5UXObh0=;
        b=ulJnSMtPf0WlwgdWPERfrd/ohPEri1JmDivLSRPOw2HI7IFnRBUve5YB1wAo/wYrLl
         40oobJrTcyzYOft2pY1bZvEk8VEFJMrXGNO4UOfKg9jb6Bjte7Rm0X2SNwN/2xxkN1UG
         H/FMmRJCUDBSSx874khP1Wsemq2LBF+NP+64Nn0yZjNAf4c0tW40u5IyiC2ymMaTb5wZ
         6uFqskAwOF8/wTKdKyQ+9vxaYGJ1uPRDm+w9ySkqD4DjHjLuXvxrYduIS2YQK/5vYHXc
         e/QHhP87GshA9FoPtB9dzINXwen4vIBpzFCNNEhmXIRO+T+UxOYPIhyqIIFjCPHF8qox
         AjQw==
X-Gm-Message-State: AOAM530oRu9DCH3S9rMr3xdHv01M9fPrfIjhAXdRLWpehzsnB3ymQP51
        1N0YNmqaKGxuZnOxJVS+J2jOT2S7Y3Y=
X-Google-Smtp-Source: ABdhPJyL0eQSNQ+i9yMv06DcladflnfMkvCjgQyESNn3MWNcVE2y39iS8Z9Y8OkEptuKGXyPmMUgmQ==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr4319505ejc.295.1644655705211;
        Sat, 12 Feb 2022 00:48:25 -0800 (PST)
Received: from localhost.localdomain (ip-89-103-68-137.net.upcbroadband.cz. [89.103.68.137])
        by smtp.gmail.com with ESMTPSA id h6sm2025854edb.5.2022.02.12.00.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 00:48:24 -0800 (PST)
From:   Daniel Trnka <daniel.trnka@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniel Trnka <daniel.trnka@gmail.com>
Subject: [PATCH BlueZ] adapter: battery provider for non-LE controllers
Date:   Sat, 12 Feb 2022 09:45:42 +0100
Message-Id: <20220212084541.221196-1-daniel.trnka@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable battery provider dbus interface BatteryProviderManager1 for
non-LE controllers, so external clients like pipewire can provide
battery information for bluetooth headsets on non-LE controllers.
---
 src/adapter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eef50f67a..2071cf8db 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8976,6 +8976,11 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		adapter->battery_provider_manager =
+			btd_battery_provider_manager_create(adapter);
+	}
+
 	/* Don't start GATT database and advertising managers on
 	 * non-LE controllers.
 	 */
@@ -9010,11 +9015,6 @@ static int adapter_register(struct btd_adapter *adapter)
 		}
 	}
 
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		adapter->battery_provider_manager =
-			btd_battery_provider_manager_create(adapter);
-	}
-
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
 							services_modified,
-- 
2.35.1

