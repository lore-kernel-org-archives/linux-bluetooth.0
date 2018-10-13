Return-Path: <SRS0=S/77=MZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881BC28CF8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Oct 2018 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0784820895
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Oct 2018 12:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krB7mHuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0784820895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeJMT7D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Oct 2018 15:59:03 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38312 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeJMT7C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Oct 2018 15:59:02 -0400
Received: by mail-wr1-f50.google.com with SMTP id a13-v6so16158368wrt.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Oct 2018 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Yk3gRThcZ6BXk72paBG/+DLgsuu7QYcWKHDc3TyafZ0=;
        b=krB7mHuC82yisTyrX5I63MZ7Kdxq6mGNZpanj/rAnmOpR5WRm7swVGhWpcpSkyUJbS
         qQWn9B3SE5sHowFywYqTT0Nqg4MmEpdOCY/Z0JURnmoOSKmI4nw1TGArtlrlpIZ0WBKe
         r4jpTZKhXbABJawVZRwD/dOO/x9KOGdckfCvk4BVPYd7iusDGFHCBF6JlUQTTdQp1ThG
         +hEuxWRYdm53kXseA5vx5FkafJH0+i+MEjshAPWvqEwtVty4mxfuQW+yuSuznEpsRUJR
         omZ3mY4UruBuMQ2+BhuGDqw1plZIzY+MRxGg1dqW0m4dt9uZuJFg0UGKJoLN81Rf5pfB
         vSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Yk3gRThcZ6BXk72paBG/+DLgsuu7QYcWKHDc3TyafZ0=;
        b=mZiMPsB38X7erwo1uZMZavHgbI3UOXymKeiBeG015xzRL+W+88iVZDZFuzVaw0qEaZ
         j3N5qMEfuYYwCb3wkcglRnfOzEGXvXGyQ4PG+MShTG96OMRZVsS+UvhwyDkj18nqpcK/
         Sd68c9Wpr1KOWw6TZigBj4DdgnbT4phxKqOtS/KqMth/V64Uq402X5S7HNLcI1jQqC3S
         YMsZNOdLlFTbbgdFnYg0a2zV07lcQ7WeFtS5OPYfgN43Bl8HGRKyoTj2+UXWmd4ga2nG
         9itnDWSp2cCRQeu0gVegDAPEzHThNzGUbQFk5mPDIJ20pf6mQ/RWouIH0s1fpw1IFVQc
         Lmng==
X-Gm-Message-State: ABuFfojcQKndcGaVgDjoPmyHNk2GETQkpRNq/hCjC7Jn8UFisiJhpKLg
        HVXW6wJXqU7M/osYN/8/RZzB+sLVjkg=
X-Google-Smtp-Source: ACcGV604hw9Ix1vRmpR2CroOqC/IU+If9SejosLd5SUf363N9Qpz6kombPe1/xFU+bpIXGw6Mp8ybA==
X-Received: by 2002:adf:a447:: with SMTP id e7-v6mr8358116wra.190.1539433324981;
        Sat, 13 Oct 2018 05:22:04 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id e5-v6sm880134wru.88.2018.10.13.05.22.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 05:22:04 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: How to handle multiple firmwares for 0x2209 device?
Message-Id: <66BFD900-C235-4CAE-A2B2-52F975A54992@gmail.com>
Date:   Sat, 13 Oct 2018 16:22:02 +0400
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Khadas VIM(1) SBC uses an AMPAK AP6212 module with device ID 0x2209; =
resulting in BCM43430A1 firmware being loaded (as per current code) =
instead of BCM43438A1 which is needed for the BT module to work. The =
following patch is required:

--- a/drivers/bluetooth/btbcm.c	2018-07-09 00:34:02.000000000 +0100
+++ b/drivers/bluetooth/btbcm.c	2018-07-12 11:38:12.323462430 +0100
@@ -326,7 +326,7 @@ static const struct bcm_subver_table bcm
	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
-	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
+	{ 0x2209, "BCM43438A1"  },	/* 001.002.009 */
	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
	{ }

Is BCM43438A1 simply a newer version of firmware that could be used by =
all devices (and the above patch can be submitted to effect the change) =
.. or is something more complicated required?

BCM43438A1 firmware: =
(https://github.com/chewitt/brcmfmac_sdio-firmware-aml)

[    9.447310] Bluetooth: hci0: BCM: chip id 94
[    9.449226] Bluetooth: hci0: BCM: features 0x2e
[    9.471969] Bluetooth: hci0: BCM43430A1
[    9.471983] Bluetooth: hci0: BCM43438A1 (001.002.009) build 0000
[   12.946499] Bluetooth: hci0: BCM43438A1 (001.002.009) build 0106

hci0:	Type: Primary  Bus: UART
	BD Address: CC:B8:A8:B5:9F:87  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING=20
	RX bytes:2265 acl:0 sco:0 events:216 errors:0
	TX bytes:36326 acl:0 sco:0 commands:214 errors:0
	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH SNIFF=20
	Link mode: SLAVE ACCEPT=20
	Name: 'LibreELEC'
	Class: 0x0c0000
	Service Classes: Rendering, Capturing
	Device Class: Miscellaneous,=20
	HCI Version: 4.0 (0x6)  Revision: 0x6a
	LMP Version: 4.0 (0x6)  Subversion: 0x2209
	Manufacturer: Broadcom Corporation (15)

Christian=
