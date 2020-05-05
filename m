Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D1C47254
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CDF206CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 08:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="U8tIPkXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEEI3H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgEEI3H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 04:29:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4388C061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 01:29:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e25so705062ljg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbmXiioAexDWRA9kx32VdJzE/B5sJe9BpjPEz9aNvzs=;
        b=U8tIPkXGcgkaeCjSlzaWgqLHtlTHmdoPHVgn2kcuYCepsJnsC0cpKVN4AOTwSku+6Z
         pRHlE/fmupMZVu/Sfvv0nxA8wPWD9QlyEDjw/tTkZmG5bx8cwHzwlIUKPf5u128BPDxR
         oaPq/dFdd9ObwgtrXLrvz23GmQOhcfnzg6ulaCyPBzD2p7jCfuIMjY4RUu+IJi0VmDoT
         6OFGFccSY4WJF59nqf/GxPBqLtpDW4pJpNL7oN7EJIw7OYqhTVsOudESTXSqj8L4uL9e
         s3wazHC/RZGsq4eFKQM9wFfSJsYeyH8YDZ1CVlr5A+yXYVD9igLfL2INA8InGNjoMM9S
         68UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbmXiioAexDWRA9kx32VdJzE/B5sJe9BpjPEz9aNvzs=;
        b=mJB/QBfe4dcKAKvniDbeiNJm8IbP3xJMFxlFF9vMRKXI4JJOmRTBh9bZHGpeLXAT/l
         utOApt2S7qh4qoDZaDtkouKLYPkV4XV4aCxxjGYjVKM2E9k5InvGDSnczqck8gwdCEkc
         VEDyzLFXwMWrcNX+T8cU7aWeBEnznmz1QKViwPA+PfP4jOuVVk8+myAUNVxfI0YDKgH9
         0zPnZwi+DARMbqnxjK2KtcI3UTaTKHnaqeJXEoWfsiKj/foNVKD2jMjGEz0Umk1KP91o
         mtQIRT7BXrh/ARyLahbmtgRytfFm1QWQ+hqKoiuS6+S6Ieh5mCg6D2fPbbhiuZEf62pY
         gTJw==
X-Gm-Message-State: AGi0Puboz7SgJRZuOC3nENbcQrxewEoPmyjH9tZLF7OR5T/pizM8YeuF
        aNnv5ApMu38zi23e8qgKVmC/GKPspaxvhXVX
X-Google-Smtp-Source: APiQypLCbHmQDctUXgfCOo77w1EtNLmHnoXMRlXaf4dzn8Rji123mxr6td+9AZVAi1dsCAkEf+BOJA==
X-Received: by 2002:a2e:8046:: with SMTP id p6mr1057698ljg.21.1588667344790;
        Tue, 05 May 2020 01:29:04 -0700 (PDT)
Received: from linux.fritz.box (cg1-gate6.net.internetunion.pl. [188.121.15.3])
        by smtp.gmail.com with ESMTPSA id i76sm1215134lfi.83.2020.05.05.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:29:04 -0700 (PDT)
From:   Mariusz Skamra <mariusz.skamra@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH BlueZ] client: Update write callbacks with invalid offset error handlers
Date:   Tue,  5 May 2020 10:29:01 +0200
Message-Id: <20200505082901.258762-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds invalid offset handlers to write callbacks of attributes.
---
 client/gatt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 416eda953..5713f8343 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -2141,6 +2141,12 @@ static void authorize_write_response(const char *input, void *user_data)
 		goto error;
 	}
 
+	if (aad->offset > chrc->value_len) {
+		err = "org.bluez.Error.InvalidOffset";
+
+		goto error;
+	}
+
 	/* Authorization check of prepare writes */
 	if (prep_authorize) {
 		reply = g_dbus_create_reply(pending_message, DBUS_TYPE_INVALID);
@@ -2272,6 +2278,11 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 	}
 
+	if (offset > chrc->value_len)
+		return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidOffset", NULL);
+
+
 	/* Authorization check of prepare writes */
 	if (prep_authorize)
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -2683,6 +2694,10 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 		return g_dbus_create_error(msg,
 				"org.bluez.Error.InvalidArguments", NULL);
 
+	if (offset > desc->value_len)
+		return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidOffset", NULL);
+
 	if (write_value(&desc->value_len, &desc->value, value,
 					value_len, offset, desc->max_val_len))
 		return g_dbus_create_error(msg,
-- 
2.25.4

