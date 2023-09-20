Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C8C04FE8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 18:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjITSoI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITSoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 14:44:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66214CA
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 11:44:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404732a0700so1771295e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695235438; x=1695840238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75R3CAT6QlBW4zu7W5P0EsSTTEapzv3VNfW7vaKod6Y=;
        b=f8UT5Nn1Yc/QzSYFHh8S83nVTp3FX8Z63/l03Iuo1HStOtkl76DGeBM9oBKcS3Sjh0
         twa65ZjFf5gtYW5kZuLFmgouMGa7hHI2A2WKW6KVqFQkiIaJmHO1uwrx2a6b8RJnkk+Z
         Q1Wud9DSliQLPdvbZXbOkRWBkOvMTyLH4vIz3kyihzrFEeObuKmRKqk3rchkeRETDJ2w
         mLprD97bx5cz55qZ0xGZJJBm3Zi5AzJ/UhHg5lw1d7nBs+zXs5wKo3tqGyVUqHe8IgFd
         zS+eq+xDlOIqjWjh0bo5MWUktXOU6VINsOnbxRQ4nUzmfskvhkDku+Iy14hm4CHarJl/
         1zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235438; x=1695840238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75R3CAT6QlBW4zu7W5P0EsSTTEapzv3VNfW7vaKod6Y=;
        b=MfoxGO8r2sqV7e6HhI02plgl6lgp15YLPmJRAkW3LsbuGAXIv/We8hbeJ4bTSADTWl
         8HE734kr0na32zfnLvBS6X+STKRTgsWUWQGqoaKKTHx9QzstNHsdmDNDEWhYlpQMNfGs
         sv5DvtwOwySzXU8zlwVqt7jZ4/faKhV+NDSdWHx5yyM4kDTdE+oe/k+3PiEyhfZJNsyo
         N0bxEBWXkd4+0om3Tnd7zyY7l5iOGcr/q+1ByPsb4G44E/rcUfMCwIBCc+POkMqylqsu
         NxpzNjgRoEmiEQEeiM3f7rRmR/qhQTMGSlbpUm+pjRr9MsEHJbladNtY1u+brdfb6qGb
         judg==
X-Gm-Message-State: AOJu0Yy4NRrJa3FEEx9lUsYbvuojdPa7Gck/Q9OqaPJ3DhMyNocgOJSI
        n8X3IheKQTyC6HblONRCe4f4spXmOd0=
X-Google-Smtp-Source: AGHT+IEd6qlNtJ34XizWIXCWgeV0/IKpolt4zTKni47i5jpdQUhHzj19FjdO1oTvUjCa9O7Qb2XgDg==
X-Received: by 2002:a7b:c4d3:0:b0:401:6800:703c with SMTP id g19-20020a7bc4d3000000b004016800703cmr3098221wmk.21.1695235438023;
        Wed, 20 Sep 2023 11:43:58 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.105.nat.ftth.dynamic.t-mobile.pl. [46.205.192.105])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b00401d8810c8bsm2669643wmi.15.2023.09.20.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:43:57 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] vhci: Check whether vhci open setup succeeded
Date:   Wed, 20 Sep 2023 20:43:13 +0200
Message-Id: <20230920184313.973822-1-arkadiusz.bokowy@gmail.com>
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
 emulator/vhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 7b363009a..355ab6389 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -122,14 +122,16 @@ struct vhci *vhci_open(uint8_t type)
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
+			rsp.pkt_type != HCI_VENDOR_PKT ||
+			rsp.opcode != req.opcode) {
 		close(fd);
 		return NULL;
 	}
-- 
2.39.2

