Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A89DC001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGYIrP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGYIqk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349C420C
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso841417966b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274695; x=1690879495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyB/UXv/9yVmn9xMLGcOhjRpTTudWve/pgKegPw0FUc=;
        b=Bsbcb7Ip66w006uYvhXRjIB+ydNcGZXYUz9iCOnaFf3d0CD18B9AjkdEvlNwmISUfb
         tPwifc3akIX2/4NaWbMJi88ExnAgqF1FuT1x7/V2MIk+grxUsRVFadfPl1FhfLhEk7YY
         R4ElUS6UQqTaeGL1F2CP1MROmjTE4xZ00+kLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274695; x=1690879495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyB/UXv/9yVmn9xMLGcOhjRpTTudWve/pgKegPw0FUc=;
        b=FaDlwV7oy/eq33MK/85aw6fMmZV4yFDm3JNmwmDOpOeGGikJ0raaTQODskA4oqdsnm
         nggxIcszNV6cZTeIqE8S6uFC2ISgRZ86NoLEsgiePY9Hd6nWnpiphxYMODVqnVKlA69g
         0+2LiqW/5SbM0+DMvwr3kERuZ273Rc3c4hv+Tt4XQiv1n+rqyT5wb1XXiDXIzNbTO0V7
         5Y6hv926PN5+eIA0wGY672oAsscAhhYRwNlIDCRPUol4ItMiZOkawGB3YFlToBDFtRsp
         T37ss7c23MIiSDI2beIbKRLOcxzA/nAJNrNTq/NCeqXmY8ZbBvo2lVdWSWnWBodtMvy4
         kFXw==
X-Gm-Message-State: ABy/qLZEr/FMIeA0fHM6eejWOMmCa6Dgz1raJjS3mPnqDZwbr8l5Ug+b
        2kj+a+owFfhHJgfoAW1UyFt/cGgN7Uc6lpcUhAg=
X-Google-Smtp-Source: APBJJlEND45VPtrmrWjPJXj3xgYPr74tl+rn+HIDLVPn9Njfw4Rv61h+nGx2+p9Kvnh6hdGq87UV6A==
X-Received: by 2002:a17:906:76d6:b0:993:f497:adc2 with SMTP id q22-20020a17090676d600b00993f497adc2mr11757236ejn.18.1690274695321;
        Tue, 25 Jul 2023 01:44:55 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:54 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 5/8] device: Fix pairing and discovery with dual mode devices
Date:   Tue, 25 Jul 2023 10:44:28 +0200
Message-Id: <20230725084431.640332-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We'll prefer to pair and discover services on connected bearer first.

There was a problem with pairing, that select_conn_bearer returned BR/EDR
even when we have connection to LE bearer only. In these situation we should
pair over connected bearer, since connection to another bearer can fail.

Similar problem with discovery that after connection on LE bearer discovery
was requested on BR/EDR bearer which can cause connection error (e.g. Page
Timeout).
---
 src/device.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6f28e261e..446e978ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2504,6 +2504,16 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	return dev->bdaddr_type;
 }
 
+static uint8_t select_active_bearer(struct btd_device *dev)
+{
+	if (dev->bredr_state.connected)
+		return BDADDR_BREDR;
+	else if (dev->le_state.connected)
+		return dev->bdaddr_type == BDADDR_BREDR
+			? BDADDR_LE_PUBLIC : dev->bdaddr_type;
+	return select_conn_bearer(dev);
+}
+
 static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
@@ -3018,7 +3028,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	else if (device->le_state.bonded)
 		bdaddr_type = BDADDR_BREDR;
 	else
-		bdaddr_type = select_conn_bearer(device);
+		bdaddr_type = select_active_bearer(device);
 
 	state = get_state(device, bdaddr_type);
 
@@ -3055,7 +3065,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 			err = device_connect_le(device);
 		else
 			err = adapter_create_bonding(adapter, &device->bdaddr,
-							device->bdaddr_type,
+							bdaddr_type,
 							io_cap);
 	} else {
 		err = adapter_create_bonding(adapter, &device->bdaddr,
@@ -6207,12 +6217,9 @@ static bool start_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	if (device->bredr)
-		device_browse_sdp(device, NULL);
-	else
-		device_browse_gatt(device, NULL);
-
 	device->discov_timer = 0;
+	device_discover_services(device, select_active_bearer(device),
+			NULL);
 
 	return FALSE;
 }
-- 
2.34.1

