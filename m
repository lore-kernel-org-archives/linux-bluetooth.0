Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AFC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 21:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIUVrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiIUVrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 17:47:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B77A6C09
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:46:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso201219pjk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=vwM4v1MnP7853alqfAnZiMdkfGJRHdUbxt+yknv4j4Q=;
        b=bCBmV2BvznmUXhOYE54f6j/Ijqj1bRHoHhNTgYMa+aa2i58/QSMAw6EpE+kh/8W+jg
         TypN7q3Ipv7c0PVv/h4WZBYpHxmwyJPNZacmRAPQbj+w55gfx1Ta9cONtWHSbLtwhqyk
         Cb7d9sULus/3mXDXv7XM7kj31JBfNA0EsKxA/NNB1GOH5xHdBbRYXnOdUxFC7Uzn4w8I
         bTa1aYMq+W9acPKddVp3JXcxEg55dtQzt+mAIelmCtrB6Rqbf4g56CLZ66h7MqLIEPeP
         Y7ZWmh6DMSOoMomLDR6lqsz5X5xHPvxCh/YuJovbFddTX5BeB5kcE4Q7vNNRe1Z+A7zc
         0yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=vwM4v1MnP7853alqfAnZiMdkfGJRHdUbxt+yknv4j4Q=;
        b=LbYaEtxr1Fv2vL+KNKTe8QunfJ6x7OQY4pta+zyVreH2Dx6karTLdbMwz1nBBoxALG
         XkVqO5N08QIXLhJuVm/80agyEAeS0OP8Vd50z5k3vAFYVhSmrL4XvzvTEeE0JOBNXfUA
         CbwsT5KmcLPrHEQoXUc5MNbAUvBbHhP3/ZzG0UdZOlXovWyPrvbPiif4vh7g7cjrCwwl
         TYt4pUJRmbMj9VdiBJPilApWy3YgfUti39Zxz0F3DItgB3JOTR9uo/Nnn6VhkDQAxGZV
         XBYDXfATlAq1zKNwCgZ3pZ+5NK54xaGJNWhSU8c3FGXPJecZbI1KmLPuG7uTAybCpUV9
         xu1g==
X-Gm-Message-State: ACrzQf1/STC7Kx+gxVd3p+fcXYFFibmtd6/wT7x1wcAqy5XjLOg99eks
        jPGoPwuPuULCesm3wwYs9itEVYlEMIM=
X-Google-Smtp-Source: AMsMyM6IOZEBhpAq2Rf9NtdNNkcW2j+UHqt9zRa1HysLiQU+iS+UghaqgGvqVMFx/RLanum9t1onqw==
X-Received: by 2002:a17:902:c410:b0:177:82b6:e6ed with SMTP id k16-20020a170902c41000b0017782b6e6edmr232748plk.27.1663796818299;
        Wed, 21 Sep 2022 14:46:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b001782a6fbcacsm2506526plg.101.2022.09.21.14.46.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:46:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] gatt: Fix not setting permissions for CCC
Date:   Wed, 21 Sep 2022 14:46:54 -0700
Message-Id: <20220921214656.2241730-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CCC shall always have both Read and Write permissions set in addition to
what application set.

Fixes: https://github.com/bluez/bluez/issues/399
---
 src/gatt-database.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 89a3dc47560b..a212dfc4e694 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1238,7 +1238,8 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				NULL, NULL, database);
 
 	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
-								    0, NULL);
+						BT_ATT_PERM_READ |
+						BT_ATT_PERM_WRITE, NULL);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
 	database->cli_feat = gatt_db_service_add_characteristic(service,
@@ -1726,8 +1727,10 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 			*perm |= BT_ATT_PERM_WRITE;
 		} else if (!strcmp("notify", flag)) {
 			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+			*ccc_perm |= BT_ATT_PERM_WRITE;
 		} else if (!strcmp("indicate", flag)) {
 			*props |= BT_GATT_CHRC_PROP_INDICATE;
+			*ccc_perm |= BT_ATT_PERM_WRITE;
 		} else if (!strcmp("authenticated-signed-writes", flag)) {
 			*props |= BT_GATT_CHRC_PROP_AUTH;
 			*perm |= BT_ATT_PERM_WRITE;
@@ -2896,6 +2899,9 @@ static bool database_add_ccc(struct external_service *service,
 				!(chrc->props & BT_GATT_CHRC_PROP_INDICATE))
 		return true;
 
+	/* Always set read/write permissions */
+	chrc->ccc_perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_READ;
+
 	chrc->ccc = service_add_ccc(service->attrib, service->app->database,
 				    ccc_write_cb, chrc, chrc->ccc_perm, NULL);
 	if (!chrc->ccc) {
-- 
2.37.3

