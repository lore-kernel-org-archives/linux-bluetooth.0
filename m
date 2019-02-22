Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30D5C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBD520645
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kdgcnXo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfBVWyC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:54:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBVWyB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 17:54:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so1734867pfo.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Feb 2019 14:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jlndPxQUS25hD9X2O4zRB1zQ3dpXmFXtGTcX4KnwLs=;
        b=kdgcnXo+2UIcDSAXEEH4ZIov+JUKtDmDozAF9KDySDlmZXkQTluivbn8LWt8MXA4xh
         zfxxg0Li/vmlGvvQL78B02EII9ZA5UlpanaSR5QS5xqGpDCqI33gOk9Rm+weQdrxyqN1
         MTce9RIG1Et5FSOp/Sa4Vsgw/UDw/BWmM9lMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jlndPxQUS25hD9X2O4zRB1zQ3dpXmFXtGTcX4KnwLs=;
        b=rTZNbVwpREjFk+XmEABxtbasArG2UpnILI1GeTJlQXLHXWoJkhe9ntxsYyAoy1jFNB
         HnJv5FIvfzLvtjqDTtgztrly/8jTNzamo9IW8e/EhvrRNRAInTA42TwPXmFkn+wpBgQ3
         5wg8QZ59CizlcPt1IxA/0JOvjJzwwRh1DY7o4mV3fHpCw24yJYv39IOPTbe5Fq5x+mDV
         p7LRdCx3MEyWRVQFSbGpecPklWDeYSk8ngb3N6QMyXpqtu/an2ujJrJbn41bVDYLZwQs
         lhwlTNRoA+m5fKXQ/RVdKz4PF+Yf6czZrE2SNtWHHrySgvB1gdiGXV5/E5jmmISa76Ts
         dZxw==
X-Gm-Message-State: AHQUAubPSnmp0DVTnbp8YwhPPobl/l9bkGaEY+Jh6RXCHbMXaejawSLa
        ZZcSbW4ufkXqLB+8a+1XCfnyaQ==
X-Google-Smtp-Source: AHgI3IYmtjOMl5JYGgzo3C3QvB9fgUiwrmYezKxFimhE/1NEAza4tKyF1EFKbnwYIKl3Ue9Ox73niw==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr6211511pga.325.1550876040944;
        Fri, 22 Feb 2019 14:54:00 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id g185sm3994995pfc.174.2019.02.22.14.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:54:00 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Date:   Fri, 22 Feb 2019 14:53:44 -0800
Message-Id: <20190222225345.69084-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222225345.69084-1-briannorris@chromium.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are two USB PID/VID variations I've seen for this chip, and I want
to utilize the 'interrupts' property defined here already.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v2:
 * drop leading zeroes from VID
---
 Documentation/devicetree/bindings/net/btusb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 37d67926dd6d..b1ad6ee68e90 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -9,6 +9,9 @@ Required properties:
 		 (more may be added later) are:
 
 		  "usb1286,204e" (Marvell 8997)
+		  "usbcf3,e300" (Qualcomm QCA6174A)
+		  "usb4ca,301a" (Qualcomm QCA6174A (Lite-On))
+
 
 Also, vendors that use btusb may have device additional properties, e.g:
 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
-- 
2.21.0.rc0.258.g878e2cd30e-goog

