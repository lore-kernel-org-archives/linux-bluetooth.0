Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48700C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144EE2075C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 10:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="nmMpXqhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfCKKYG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:24:06 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:35890 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCKKYG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 06:24:06 -0400
Received: by mail-lj1-f176.google.com with SMTP id v10so3523281lji.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLG45tkq8s44j+TtBlSIl+s0U4u/mqgOatKIzETiHjc=;
        b=nmMpXqhpCbSnsGlhK30QRHOhNTEpQlwzwa1jUUUlhGcOBPBL9VBrPXWtxGd9GRxmDT
         cOqpwC1HmpTxKWk7bq55dKdj+655CJTUrVASTbiUrBFXWFn0/0gxXa0hQpjP/ESW/ezE
         KXDqrcZj6D//p7LaRM1m2bO4hS2AihGtWnYJ586mbeokVU9za42sD7lij/qVt/OMwOXf
         WcclFl1TnpVF/+XOJghIOdwNWSvqE+zrBVI0CzoipyfDntXYOZG4QZBT+qkXqU11yO7s
         /dBQx3jyH9dvPnMzj8L3+4uNaO1X4FkxP3SUwb1tWl70kIpf2yRo0KpJVS30TonPow6S
         h6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLG45tkq8s44j+TtBlSIl+s0U4u/mqgOatKIzETiHjc=;
        b=pw1khO/7QX1L7nkNp6rVw+bRNm74Fi6gZXiqFBAPZB/KoMeMLTw5jNgw0sj/6aT1Om
         2uBTP+SjCDEtKTiR7jGSYTUg9sEzN4Gpe1y1qpLtfc3QCp+xUYok3Uki78+DCoOV7r1H
         wJR03hvSPsDQsuYapiiuRV39dxxZrXwBzqPs8UJBkcyMZkxSG6CL3zF+Hz22tKg8eeyQ
         ZwJzkYt8iVC+ZGYPoVq3DOcQEQ2JRselF4IS5QJqU/9Ukc7c7JMw630KxC7rCdlyq5p3
         xGP7dAN9NoznIcgRi6Gw2RuBvR3HrcT6iCOYebaygSoglhRNDkrk4woaI0K8AmQngJJH
         h3bg==
X-Gm-Message-State: APjAAAUADhlFDe4QAF8TxWsumWe/e7voBRsu9vB4jye6Sm++VHRHPrng
        ybIoGJ7ah6TJj+2za8Q15CvNge5qxUlgCQ==
X-Google-Smtp-Source: APXvYqyQ0YC/xrKegGO9p246XYZvsEc4ms0uI8fSPU6Q1qDBOvCHjsCCsb/wQ0XD4eUJfGlZCYjkGg==
X-Received: by 2002:a2e:9d0:: with SMTP id 199mr14366589ljj.148.1552299843503;
        Mon, 11 Mar 2019 03:24:03 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id y1sm895459ljj.13.2019.03.11.03.24.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 03:24:02 -0700 (PDT)
From:   Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Don't ignore asprintf returned value
Date:   Mon, 11 Mar 2019 11:24:01 +0100
Message-Id: <20190311102401.14131-1-grzegorz.kolodziejczyk@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Ignoring asprintf returned value leads to unused-result error:

error: ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Werror=unused-result]
 (void)asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       avdtp_get_seid(rsep))
---
 profiles/audio/a2dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 4001ea0ea..d3b93da00 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1772,8 +1772,9 @@ static void register_remote_sep(void *data, void *user_data)
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		goto done;
 
-	asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
-							avdtp_get_seid(rsep));
+	if (asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
+						avdtp_get_seid(rsep) < 0))
+		goto done;
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				sep->path, MEDIA_ENDPOINT_INTERFACE,
-- 
2.20.1

