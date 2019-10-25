Return-Path: <SRS0=fFFM=YS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C65CA9EBD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBCA21D81
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 21:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOqaIHVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfJYVzB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:55:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38513 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfJYVzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Oct 2019 17:55:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id c13so2477840pfp.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2019 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89m06+xkP6iuCxM34qSVOV2dKIIRXKWy8S7NlrA4pyY=;
        b=dOqaIHVg3QZ2lOLTZxqk8+KqZisI933TPy9NwHt6X67IsFjKJ07OSsZTtGNXnMvfCU
         ii6mzEJjdHl013PciiJ+mojyAEWZJnjpNl8ve/ceTQ2XzD5byKJ301oAqTkQmM8foaDS
         oB0C+5qzR6tUr9kERgkvlCgHbbBhvuy/bLc38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89m06+xkP6iuCxM34qSVOV2dKIIRXKWy8S7NlrA4pyY=;
        b=HfXEzhHS1UwkTMiufMw1b2HuW5WaWMwxNda+zvavwZDFx+FZRvo2b+UCF3u5kcIsuE
         dk43nqHBqA+16XriOx0DJGAoi+/6Zcnew7t3MaDztXskhYEquDpNjh057ZehzwA7M/gU
         G5FWXI8vv+5r9wIz3vombzheDvIKnrnJRYE/7CUhg8dFlDLnrguMBw72j6WUWuM0rhFm
         n6eL8vT7Ww2ZNu2z2Lod/IT0eWRjY9cgRJDIoHdP745iirDig2EKVFn86MUDaYG62HAm
         Qx1l/e2iXtMAWzuahOBZnbv7pVmHIemJvqvDTKibpGN8BNVrfxF0GX/phYpE2fbk83Je
         3lzQ==
X-Gm-Message-State: APjAAAW7RJamvGGygY96AKz3HNvzcUus1/Kxuu6aanwrniAfnP3banH2
        1+3yjQRmqN60u3gHdJ69lPfK4A==
X-Google-Smtp-Source: APXvYqzl0KnFp0QeZi0ICQeTNpCU0pxjq2w6jjf6JCLmPyuwntCGMq7SBLTLQ8U00/IlVqC313JpjQ==
X-Received: by 2002:a63:6585:: with SMTP id z127mr7132514pgb.330.1572040500677;
        Fri, 25 Oct 2019 14:55:00 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y80sm3815110pfc.30.2019.10.25.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:55:00 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] ARM: dts: rockchip: Use hci_bcm driver for bcm43540 on Veyron devices
Date:   Fri, 25 Oct 2019 14:54:25 -0700
Message-Id: <20191025215428.31607-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


This patch series enables using the Broadcom HCI UART driver with the
BCM43540 Wi-Fi + Bluetooth chip. This chip is used on a RK3288 based
board (Veyron) and these changes have been tested on the Minnie variant
of the board (i.e. rk3288-veyron-minnie.dts).



Abhishek Pandit-Subedi (3):
  Bluetooth: hci_bcm: Add compatible string for BCM43540
  dt-bindings: net: broadcom-bluetooth: Add BCM43540 compatible string
  ARM: dts: rockchip: Add brcm bluetooth module on uart0

 .../bindings/net/broadcom-bluetooth.txt       |  1 +
 arch/arm/boot/dts/rk3288-veyron.dtsi          | 31 +++++--------------
 drivers/bluetooth/hci_bcm.c                   |  1 +
 3 files changed, 9 insertions(+), 24 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

