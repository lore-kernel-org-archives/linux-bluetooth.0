Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7404EC004D2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310F420645
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXGjoZHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310F420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJBPGw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:06:52 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37211 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJBPGw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 11:06:52 -0400
Received: by mail-ed1-f50.google.com with SMTP id c22-v6so1281667edc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=W3rN/NkoO39rkK1uULDlbOWioDBuQU5Mvk+CRXM87uU=;
        b=JXGjoZHomdFs2cqfTKhaNzyFt+WhxdzPp4npYIJwrwodrOs18opZo6g8K8kSmwFrOz
         lGByosD0s1sWlGiLikJS6uKgsaZnmHfGKXOqwiTBg9kzSbmRdqve+BQlfBS1fHbjB55S
         rWVldex8y9LsvF9X3yGXJ7zOjGHftTBvcG43fEeTgRMkFiGuNl4vRsSzeSXILQdKtMYQ
         +kyOwxqJ/ahOaTFxbxQfxUxQvxchdNndFfVrCH4A8y4czWzS9M75pdYmCZKSVQ23VZ1Y
         mxc6zQI9Vrj9QLS4wiWPBfnKKbjCXEcCU8/yVk6HiNuvdXJEiS+4ce10ONAG2J5NWQ1u
         8tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=W3rN/NkoO39rkK1uULDlbOWioDBuQU5Mvk+CRXM87uU=;
        b=RLxyq5mrlTDq4dOavz9GNhBQqoS98VpsKoS7Ba1WLrcpj17xsB6442jZHxx1BizD8Q
         hUPx72DzOLlm0PnksWYw1k5zAx2KUTMHZ3k5iKxRQIaoHgYPkMH/C/i0qd6IbJO4svQo
         nXIBcL222UcQ8ysHoei+Y9bu9CjTekZK+M95OtikJJLfyh465BDJIPlun+gX8kgmN1W3
         NL5crRLn8IIiV0mpq3QB3fG7Zo5k5J9f7gqxnMvFVhwrhFAzSziQ1978cMAyCUt6m6A3
         qCrQbx6acmQ/NYePZaM6B6pd/gplriRZE/AHvq84dpL3At34Wfdj2kZMms+4BtrK9+2X
         S8bw==
X-Gm-Message-State: ABuFfoheTR8aI7U1HUJW+ZvFPIn/CmAqDAv9iSRAxR55+9TSY8a9qnm0
        KK/BKGiz1+HdKlpvyJuuJedMInfC
X-Google-Smtp-Source: ACcGV603RvlrLCTDZmyLJW3utNEEkrExtRpNyW8Iq9yhhqRPklWyJIEZqEo0iTsKkkPoy9Qyz0xnPg==
X-Received: by 2002:a05:6402:135a:: with SMTP id y26mr22277448edw.222.1538468686200;
        Tue, 02 Oct 2018 01:24:46 -0700 (PDT)
Received: from vudentzs-t460s.fi.intel.com ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id r23-v6sm6215676edi.17.2018.10.02.01.24.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:24:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] gatt: Fix attempting to create device on disconnection
Date:   Tue,  2 Oct 2018 11:24:41 +0300
Message-Id: <20181002082442.20802-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002082442.20802-1-luiz.dentz@gmail.com>
References: <20181002082442.20802-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If ATT is disconnected and the state points to an invalid device it
must have been destroyed in the meantime and should not be recreated.
---
 src/gatt-database.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index abcf7b759..febc2f840 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -326,8 +326,8 @@ static void att_disconnected(int err, void *user_data)
 
 	state->disc_id = 0;
 
-	device = btd_adapter_get_device(state->db->adapter, &state->bdaddr,
-					state->bdaddr_type);
+	device = btd_adapter_find_device(state->db->adapter, &state->bdaddr,
+							state->bdaddr_type);
 	if (!device)
 		goto remove;
 
-- 
2.17.1

