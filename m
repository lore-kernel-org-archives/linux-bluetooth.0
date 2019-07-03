Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E0C06513
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DA020828
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEv2EaPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGCPmZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:42:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39817 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCPmZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 11:42:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so2953937ljh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YDyqh4zzo0vsQ0OP4FmNqILMnXYH/ZGzbLd/fOT39zU=;
        b=iEv2EaPp2AeLSWXYGw6U9lBOdcR3ni4Z+Yk6wC1YybpMTIMx8RjM8YCYSsNmy+9Nyi
         k7CNpAF9zy1pb2Vh9h2t34n+C5aRLO8eW2EOTowNSheU1EsVHnXbkhzznMk/K7A010if
         OmL0FImA5ZEMC8qFGf8YPK1uIRz2sA/7BSxWXWhaFGxMm8xFHUxSDONiqSpHZSVPyy3S
         tH3//PcPyyOD6Jd1GPwssT6IyR5OieR19iMxOe70H9aYefBq8ia1iktMpwaTjcRLwPe0
         u2f6ZcFugrE5bikWIVAKie2ALY9QFLDxwx5lRcOrj+hwQvKsPyfu0f4qryKvh38vFG0P
         Ur4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDyqh4zzo0vsQ0OP4FmNqILMnXYH/ZGzbLd/fOT39zU=;
        b=A/8lIWZv9Cm1KlHrQeiXAdDkw2Jh7HqIbQiAAv0D09hg7jqerUUQajC1wvv4xLu9AC
         F+vWATULJ4Z50EAchCPx4iZDpLe1Cr3VQsBTB5YHjTfzwauANUDEhmMJDzubl3p74y++
         0IndrcPArZ3dStN0vvPVc1aicIyg0OVLQW4vX5s8LAvyblz/vHPGSwsujwlmc8ux9enr
         2MBNxI6uf4n7OdloegzYsiln1grEh9U8FoyFfI7ie7R+6n4I9POtWH5r2gzB5f37LVIS
         kD9qqgGc9K0irArLuS517hn2QQ8E035N38Sgqj5BduziW8APFX/fEZpl3ou2KwIZctey
         w8Qg==
X-Gm-Message-State: APjAAAXN6u4A+PG8UMKPbvfCaQsVLadkB9RBS4qygMSeAuWW9QKoDAQY
        OTvpRqMsE9MCtm8k8YxwxNzu57vnMWSWWg==
X-Google-Smtp-Source: APXvYqxfkaHVrni6H9OkygOBiTv4CSMWre9Yp5jEPYGNcMH/J8nc+go1hXBfTXrMQ3kC614rSBYkqQ==
X-Received: by 2002:a2e:551d:: with SMTP id j29mr22333066ljb.213.1562168542577;
        Wed, 03 Jul 2019 08:42:22 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id h4sm545207ljj.31.2019.07.03.08.42.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 08:42:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Require medium security for ATT socket over BR/EDR
Date:   Wed,  3 Jul 2019 18:42:19 +0300
Message-Id: <20190703154219.6988-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703154219.6988-1-luiz.dentz@gmail.com>
References: <20190703154219.6988-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Encryption is required according to the spec:

  BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G page 2397:

  5.1.2 BR/EDR channel requirements

  The channel shall be encrypted. The Key_Type shall be either an
  Unauthenticated Combination Key or an Authenticated Combination Key.
---
 src/gatt-database.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 548eabaa3..d90927559 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3535,7 +3535,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	database->l2cap_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
 					BT_IO_OPT_PSM, ATT_PSM,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_MTU, main_opts.gatt_mtu,
 					BT_IO_OPT_INVALID);
 	if (database->l2cap_io == NULL) {
-- 
2.21.0

