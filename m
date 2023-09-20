Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4C6C00E86
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 15:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjITPcM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjITPcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 11:32:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61ACF
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 08:32:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-403012f276dso75515475e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695223923; x=1695828723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wjjHWWK7erfyG5RmuxsB6SmlZaf6G7QituWFcBP0dg=;
        b=cz7PiaX6gtTpTjrVmSzKB17W53eZyefkAHbqeOFDiwWnKoNt8Kg36D6DaGrBzCAh3S
         uh6jvK/qY3k398Os25xPHMu8mrQKm8yNtXBF/GdARofhCa9HJ3sZxsEQYZbH6cm6xRkS
         aK5d/qlER0LUdXaCrZpBVyKI+rl7MArJUNotgEFvNZOxs7Y2vNx88dWmzU5wJk1wZNDK
         MLawSPguoJySgj2o3sy+MN7BNAAIIkWcalanA2KuGGsct1FTHfUHhAa8xktgwNSbIOQ4
         xfu9m+IT7Ln06JV2pT1TdTl0jNalXQLCzQxHqj5qAHXcxnAoWHG8AOkMdRoD1Rul1FuI
         ZFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223923; x=1695828723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wjjHWWK7erfyG5RmuxsB6SmlZaf6G7QituWFcBP0dg=;
        b=qQdbwQn6Vz3Es/OPFW4ivRYxIY+QnRQ3zE1tmX5SESjp35YgWl3YTimvdgNcR/hNuH
         y9MvGHV1eC+EJyXddDnbMlj/fRvxXEUb40MlYwoe6GE/StEOo0tJzo4PSZn1HqoVbqTr
         Tmuqpnc09Vg9K5Cf3ezJc+Wu++xpHE6NpOcvoF/ZBs7PAT58H/m70dE+05rknsgFqO6u
         rB+/7Ejqtkwb3UM0EayaTIV8/KEvxA9zPJdX8MJWezxvEpRDqFCVcb/Jx2gLgDd/nlyT
         EreGuOdlqezMAO+Js49ak6bOrghsXXEZIb9tLBmDF8im/YqYpM+f1au4z4PPpjKbUJHV
         kfIQ==
X-Gm-Message-State: AOJu0YzAlSjnEisgFzhoE37sZnYi0Qr0sERpoOEG2OZcKHkRrUtWCNq0
        FiKwqOSAn1/N6YrMm4/Lbh18OKYVM18=
X-Google-Smtp-Source: AGHT+IGWUU1bcYigSHA2IeHedxv0s/F611HTlTY5DEz8KWSR4tIahWK/n/yhAGg2M2ALiG+Rhso+eA==
X-Received: by 2002:a7b:ce18:0:b0:400:f6f2:66b9 with SMTP id m24-20020a7bce18000000b00400f6f266b9mr2770937wmc.12.1695223923201;
        Wed, 20 Sep 2023 08:32:03 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.105.nat.ftth.dynamic.t-mobile.pl. [46.205.192.105])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fe601a7d46sm2268133wmr.45.2023.09.20.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:31:49 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] vhci: Check whether vhci open setup succeeded
Date:   Wed, 20 Sep 2023 17:30:08 +0200
Message-Id: <20230920153008.967330-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920153008.967330-1-arkadiusz.bokowy@gmail.com>
References: <20230920153008.967330-1-arkadiusz.bokowy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to race condition in the vhci kernel driver, we might read not a
vendor response packet, but a HCI reset command. This extra check will
ensure that kernel driver behaves correctly. Otherwise, the HCI setup
process will fail, because our controller will not respond to "missing"
HCI reset command. In result the virtual HCI will be DOWN and without
initialized Bluetooth address, e.g:

> hciconfig
hci2:   Type: Primary  Bus: Virtual
        BD Address: 00:AA:01:01:00:02  ACL MTU: 192:1  SCO MTU: 0:0
        UP RUNNING
        RX bytes:0 acl:0 sco:0 events:66 errors:0
        TX bytes:3086 acl:0 sco:0 commands:66 errors:0

hci1:   Type: Primary  Bus: Virtual
        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:8 acl:0 sco:0 commands:1 errors:0

> dmesg
[1754256.640122] Bluetooth: MGMT ver 1.22
[1754263.023806] Bluetooth: MGMT ver 1.22
[1754265.043775] Bluetooth: hci1: Opcode 0x c03 failed: -110
---
 emulator/hciemu.c | 2 +-
 emulator/vhci.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 25874ded5..e53fec0a2 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -313,7 +313,7 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 	if (!client)
 		return NULL;
 
-	client->dev = btdev_create(hciemu->btdev_type, id++);
+	client->dev = btdev_create(hciemu->btdev_type, id);
 	if (!client->dev) {
 		free(client);
 		return NULL;
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 7b363009a..80e1825f3 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -122,14 +122,15 @@ struct vhci *vhci_open(uint8_t type)
 		break;
 	}
 
-	if (write(fd, &req, sizeof(req)) < 0) {
+	if (write(fd, &req, sizeof(req)) != sizeof(req)) {
 		close(fd);
 		return NULL;
 	}
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (read(fd, &rsp, sizeof(rsp)) < 0) {
+	if (read(fd, &rsp, sizeof(rsp)) != sizeof(rsp) ||
+			!(rsp.pkt_type == HCI_VENDOR_PKT && rsp.opcode == req.opcode)) {
 		close(fd);
 		return NULL;
 	}
-- 
2.39.2

