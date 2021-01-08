Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1AC433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E423A9B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbhAHVQA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbhAHVP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 16:15:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE37C061796
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 13:15:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c13so4338131pfi.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=od4kyhO8B6Ups457tn7S8TzdwrA5OCwrTrq+s7sYrME=;
        b=GxdykE+DobF8eM8ACQxN9PmHumAZSVLOx9hWOAb2gns+cz5CLvfCZR/PXoHzJdjpxs
         oX/lxp1lRn9SriuKCwk3C5Jfb0xzeFkkbnh4L2lJlvLUN7imshrOjF4qgmFunahSNMtp
         rVLi6bjIYla+kpw6tMmbkUK+rWuVInyaFspPHTTjvEMd4t9OpwFswP4abjEbqmHTIu6R
         A/CjPYwud8j1ghxYAaHEvHPn1gWswHe0k6St7LtHYpOrtTv0ynEOwkK5wMpTcSwSxbwd
         v9LPQEYCSG+Jhk0K6HASUBNLOsmH/VSyzbSIEpxKXC9MT3yxMnflO2CUGMQcrum4nuVk
         PPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=od4kyhO8B6Ups457tn7S8TzdwrA5OCwrTrq+s7sYrME=;
        b=qSQgAibaqfxWaotpNrovQ0SG1HnpXDoTo1HHZPwEBxABxxRbIgigfKrIuxIdOmgvo4
         ulsgflRYReD+XYka0lh6qBgiR5dO/Fcz4pp9cLmfKGiieRJ1jay/QQCNcuHtUy9Ugd7b
         HVd2s/vRSWFdeJm9c1Q5X7kzKzu9oMnXA9OJMl6PH7k+7HHxfQ6c/Rmov9gGwjwDxQD8
         7A1lUJOMENXHGpQ0ur1d0lA91QRJvz7mesxfNcAE25rmK1J9tlm1hnz/ii1rrEBsYe6r
         Dkg1l5EfZ6c9MW6diLr+OP0mPZgx+LUkWdYF46E4WpAYmerCB/qc4F3qPcOcxMr/XALr
         Q7/g==
X-Gm-Message-State: AOAM530ul9vnk/1x/QZxD27v7kBF4qH1ThHRj/CiBCCIDbfcRgY/n5qZ
        ZkvATAxXlDkyGM0m1D7mYWON6g/j4xk=
X-Google-Smtp-Source: ABdhPJzh6Umwc27pthbMvB82TT1WzZ1cnsD2FTgMhU2DmS4KbgYWrR4okhhuj9sTRFy/IG1IpEFk9Q==
X-Received: by 2002:a63:4c09:: with SMTP id z9mr9102333pga.260.1610140518117;
        Fri, 08 Jan 2021 13:15:18 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 21sm9721699pfx.84.2021.01.08.13.15.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:15:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] gatt: Fix assuming service changed has been subscribed
Date:   Fri,  8 Jan 2021 13:15:13 -0800
Message-Id: <20210108211513.5180-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108211513.5180-1-luiz.dentz@gmail.com>
References: <20210108211513.5180-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Unfortunately assuming service changed has been subscribed may cause
indication to time out in some peripherals (Logitech M720 Triathlon, Mx
Anywhere 2, Lenovo Mice N700, RAPOO BleMouse and Microsoft Designer
Mouse) even though the expect actually mandates that the client responds
with confirmation these peripherals just ignores it completely which
leads them to be disconnected whenever bluetoothd is restarted or the
system reboots.
---
 src/device.c        | 11 ++---------
 src/gatt-database.c |  2 +-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index fe885aa64..af13badfc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5831,18 +5831,11 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	/*
-	 * If there is no "ServiceChanged" section we may be loading data from
-	 * old version which did not persist Service Changed CCC values. Let's
-	 * check if we are bonded and assume indications were enabled by peer
-	 * in such case - it should have done this anyway.
-	 */
 	if (!g_key_file_has_group(key_file, "ServiceChanged")) {
 		if (ccc_le)
-			*ccc_le = device->le_state.bonded ? 0x0002 : 0x0000;
+			*ccc_le = 0x0000;
 		if (ccc_bredr)
-			*ccc_bredr = device->bredr_state.bonded ?
-							0x0002 : 0x0000;
+			*ccc_bredr = 0x0000;
 		g_key_file_free(key_file);
 		return;
 	}
diff --git a/src/gatt-database.c b/src/gatt-database.c
index b7d2bea1d..d99604826 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -333,7 +333,7 @@ static void att_disconnected(int err, void *user_data)
 		handle = gatt_db_attribute_get_handle(state->db->svc_chngd_ccc);
 
 		ccc = find_ccc_state(state, handle);
-		if (ccc)
+		if (ccc && ccc->value)
 			device_store_svc_chng_ccc(device, state->bdaddr_type,
 								ccc->value);
 
-- 
2.26.2

