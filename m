Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6546CC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjG1FcC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1Fb7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:31:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135E30FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcc0adab4so243139566b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690522317; x=1691127117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0XUCmlKoYv3z/UHv9/Pxont4XvJxVdjohyTi4iXz0I=;
        b=lD7CKRzwk2kTEzpVin32UAdAlCrP2B84ngD1k6T94in0VfWfNOjYg04hgGoon/dPIK
         LPKXIcxzXXI54uNUhD4bUEyNo3Q9QFAMuVD63khoRsH5T8XPjnmznT8BgaukhEA4IyDg
         BKZyr3noW8D+VRzRjKzi9gVL6KhC/p+2N6y2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522317; x=1691127117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0XUCmlKoYv3z/UHv9/Pxont4XvJxVdjohyTi4iXz0I=;
        b=AWXOj9kKn0bGbICVQ6h6XWNIyhBfwKKs30YV/vxzVBezQZqZo6cncE4ZhIx7fyP+13
         eJweeq4kLsTjnh8bHxwmyOpd/pwkwsImjqrhMw0GWdkESgUhAKqFOOn7GdQx89Km24if
         kmuX44DgrBUXKD1xSj0lImT3zkPLNTyB85s+NZaa+zUtTpB5ulueapi5D+U+N5T4gdAV
         iUrH8zXI6s4vXNEbvQgj8ttzTejG2zL1nAcG3mq5rn/gmgH04o0F56zEtcBWeGUfeqPT
         dAOz4QQuTiYn/L0eH3b8ed6ofzG8pLGQ7RlV5ARLEtb9JZtJhtHhKDJGXjQqU1YzlNSn
         zJFw==
X-Gm-Message-State: ABy/qLYpiTkk25EzCNnFCqH0yWrAK1AjOwN0E7Zr+ozInz1fRo1z2tcv
        zlCS3ixcIO4bJrAdYxtez7hMOAI7UcvWXW+23pw=
X-Google-Smtp-Source: APBJJlG+Tx5aQPBDBD6OQC78Xc1IOigsSbW3yFYKJiDlwL53oX9/eSgpdYPkG1zMJvrvWySkCmFkxw==
X-Received: by 2002:a17:907:a073:b0:994:34a6:50cf with SMTP id ia19-20020a170907a07300b0099434a650cfmr376557ejc.49.1690522316958;
        Thu, 27 Jul 2023 22:31:56 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009888aa1da11sm1590113ejb.188.2023.07.27.22.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:31:56 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/5] device: Fix returning discovery error for Device.Pair
Date:   Fri, 28 Jul 2023 07:31:51 +0200
Message-Id: <20230728053153.584222-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
References: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
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
index 6f28e261e..5a39a6f83 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6302,6 +6302,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	struct bonding_req *bonding = device->bonding;
 	struct authentication_req *auth = device->authr;
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	int err;
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
@@ -6351,8 +6352,16 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
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

