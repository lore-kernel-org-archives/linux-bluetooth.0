Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C6BC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGYIrR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjGYIqk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6324210
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso841420866b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274696; x=1690879496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSkJantJe5ant6WDLniA5WbG6ARZppIgsiumlG3ocv4=;
        b=u0bYL9FZ4auw1EPCtLTpBwiUo2Js7OBpQuj8h8Wf5pjXxI6oEOBzI9Ta2liL7zLgRa
         HHfGVwHTw3bc/8w1fc8NhzPsjE9kiM0pN5sBm1mNmp0GG8P17P36BJCihdDCSUSzV1lM
         TZtsgxstsWQrh+5TgTx70TtCXfcH5cfodj5AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274696; x=1690879496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSkJantJe5ant6WDLniA5WbG6ARZppIgsiumlG3ocv4=;
        b=aNfVdn1UCJKNzxRyh4wdmtiYaLbAv3V53YtOPwvSG7ZlPjUBVQ7z7+es0JwK7U+g/N
         47FZk56zMmO56xluZNMD14JrAwfpAbPu4ZMK1OIZwF8+jt3pLo42SkT1ABdSd6x0MJoI
         FB52LA2UGn9OARgUm3BCpyRN5KaLHXGB7UQwkFOW3aAOvub0LzED+omWQkqBrv+jq7fP
         sxjZY7DLQDJrLuzJh7HBgSbuaJOMWkVStjEbEdRZPKhAAMFh5hCgQdupf6YaM39NK3s1
         V9ybO1Jg/nV/0IrnAWwCNgXL2a0OLZ4KtxMBxuUwVy7UZx9R+1TCSe1ZaGgoceaGoOAH
         KZkA==
X-Gm-Message-State: ABy/qLYo4DuGW8CVZlWGKKvUmucYAdhuJ6fMNsNxSEKKC/9QT9N/zT/7
        Uew0BkZt/dw8mWsVa6QxkH1NRNRU4Cmkoy4lyMI=
X-Google-Smtp-Source: APBJJlF5tJrLMnWvqHcDQuuBB16ZChDYp3kE8VfshbFi1gzXqbVcvxGVyBSq/zwwJiJt6e048AZ5hg==
X-Received: by 2002:a17:907:2713:b0:993:fe68:569d with SMTP id w19-20020a170907271300b00993fe68569dmr10361335ejk.17.1690274696169;
        Tue, 25 Jul 2023 01:44:56 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:55 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 6/8] device: Handle error from discover services request after pair
Date:   Tue, 25 Jul 2023 10:44:29 +0200
Message-Id: <20230725084431.640332-7-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.
---
 src/device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 446e978ee..35c46e451 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6309,6 +6309,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	struct bonding_req *bonding = device->bonding;
 	struct authentication_req *auth = device->authr;
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	int err;
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
@@ -6358,8 +6359,16 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		DBG("Proceeding with service discovery");
 		/* If we are initiators remove any discovery timer and just
 		 * start discovering services directly */
-		device_discover_services(device, bdaddr_type, bonding->msg);
-
+		err = device_discover_services(device, bdaddr_type, bonding->msg);
+		if (err) {
+			if (device->pending_paired) {
+				g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Paired");
+				device->pending_paired = false;
+			}
+			/* Disregard browse errors in case of Pair */
+			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
+		}
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
 		if (!device->browse && !device->discov_timer &&
-- 
2.34.1

