Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12941C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16EF213A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 23:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5fz5uux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfCLXC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:02:59 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34723 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCLXC7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 19:02:59 -0400
Received: by mail-yw1-f65.google.com with SMTP id x129so3589124ywc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2019 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=kyeyndBeis+cZ9ZBS+wXHyZNayIj+cUD/tEONnLncjo=;
        b=M5fz5uuxQbjqIikJnavv/M7svP4ZOVofse4yY5leo3YxJm958uq2kXygBKATDpju3b
         lsUe3ukWUjahmc7Iptc/AweovQb1j+OENgmE2tLjLgZiW16tJrwrpjzmfeuUN3XD4wh8
         TLD/aRsytHNnS8xGA4xCd7xof97Hp2zION5Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=kyeyndBeis+cZ9ZBS+wXHyZNayIj+cUD/tEONnLncjo=;
        b=Tqq5SClkOeQ7BRnOcjl00yqVgVn9/84Aq98bFWjsGbKKEHgrq7r5nGP6LNcQALGLgG
         TLaXTMaFNoffPprSOHkTQXQ3tzSvqbW94zmoWZXX455L57TDNuwiBK+0Ls22nw1uFAPg
         TwaQsg5o9W5Svo0YtFTbG5yQDbz3FaXjCquifOKK0k4fSbm7JdZPVP/EksW0ztl1uw00
         ukOr6TC7i5ygVTghK1LltBFdGyCoO5xY9QuwIEAZ5Bgy0u9lkWXF6ARCkn4tGA944I2U
         XigTVpvttJGy6M6RgUtAgABQwq8A7iVGRm19+8AMUn/PByMYRQ6nPdR2+4FG56LTla7X
         3liA==
X-Gm-Message-State: APjAAAWNhmkqLH6dhlzDdFU2d8Dfa5dtj4MBNoE32gIMXREQ0WxBWCu4
        /TIFHm+ZHQeorxLv/KOeq7F9UdnzkI/PU7iMCMc1NA==
X-Google-Smtp-Source: APXvYqzHIJZ7Vtljd8PvSpFNNV9E4FomgwacZqaheNQrdMClbAbgJuf2lqsfwXgoqi6+tNVBBLfgmMzvg5aJ6sk8xlQ=
X-Received: by 2002:a81:37c1:: with SMTP id e184mr11458067ywa.166.1552431778282;
 Tue, 12 Mar 2019 16:02:58 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Mar 2019 16:02:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Date:   Tue, 12 Mar 2019 16:02:57 -0700
Message-ID: <CAG5bF+TdR-A8x9L5vxA9qQFFa46coHXWdbgCKJNnmK-k3mr9dw@mail.gmail.com>
Subject: [PATCH] Bluetooth: btqca: Fix misspelling of 'baudrate'
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename the misspelled struct 'qca_bardrate' to 'qca_baudrate'

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index c72c56ea7480..6fdc25d7bba7 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -41,7 +41,7 @@
 #define QCA_WCN3990_POWERON_PULSE	0xFC
 #define QCA_WCN3990_POWEROFF_PULSE	0xC0

-enum qca_bardrate {
+enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
 	QCA_BAUDRATE_38400,
-- 
2.21.0.360.g471c308f928-goog
