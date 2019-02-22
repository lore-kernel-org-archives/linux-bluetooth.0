Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B3FC4360F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24232077B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfnqGPOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfBVAeO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:34:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVAeM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Feb 2019 19:34:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so249079pgl.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Feb 2019 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBVnoqXuO6HFOZ085kg+BDnfHXIhy9OmFMZxP4tCxpw=;
        b=EfnqGPOXB+Uhq1/DNgFMPxIVt3T3GMCie9YVOIrnCRIlVx3XOSiSvyj2HCPFtVOlQP
         1mh9XqgjQnMQTy3kMk4IR4CbmdabuKi3QUub2B4kB9rowmtLAYzKjXJLn8Oqx7b0AYyE
         yMntsAzKhhAdRDaEuFyxnJQ8w8oN/QDj0rXqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBVnoqXuO6HFOZ085kg+BDnfHXIhy9OmFMZxP4tCxpw=;
        b=pQRhcwRG354EeVLR0/ipQeTwVP1ChyPaVZJb+xqyAg+hHMun6pBBq1NR10xPems+5W
         Fuy8kNfu1pqmapSzePv1La9l3FujMNmIEUdMX3QCm3P8UF6O9wo5dpq0omWuB464tJvA
         ooKeeJG/PkDca599TVlLPmDYuyN7B8dqDNfthBHRgvQhvCax6KuEeDlyvXALTOvQ9qYp
         fRTBa6XWuw7eT12nLxG1Fxhgjvhlnp/tFMwNQkuwhQ/mZLS8H7+wSkVwBiGidRinzqAk
         0oWfNgI5N10tLhrBaeJJw6ADdnFkj3jqiHOwSi98nX9NdDNzeyzWcZkQriGKk3zvXi4U
         v+ng==
X-Gm-Message-State: AHQUAuZOJ8dc3UJkSW8rJVkMmilrHi/d6MLG/XKFjFrw0W0EyWwRITm8
        olfNpFNizr8vKcMYAoJO6gzB7Q==
X-Google-Smtp-Source: AHgI3IbGOJeo1tMct7+tFWXD7jLSXbSNtxVZdnkGfxrjSW81ok1QIOiXQPjcBYhWfdhBjDo0Ual3WA==
X-Received: by 2002:a62:7086:: with SMTP id l128mr1333899pfc.68.1550795652021;
        Thu, 21 Feb 2019 16:34:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id c3sm269830pfg.53.2019.02.21.16.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:34:11 -0800 (PST)
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
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Date:   Thu, 21 Feb 2019 16:34:02 -0800
Message-Id: <20190222003403.128243-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222003403.128243-1-briannorris@chromium.org>
References: <20190222003403.128243-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are two USB PID/VID variations I've seen for this chip, and I want
to utilize the 'interrupts' property defined here already.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/net/btusb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 37d67926dd6d..43c96c3380a6 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -9,6 +9,9 @@ Required properties:
 		 (more may be added later) are:
 
 		  "usb1286,204e" (Marvell 8997)
+		  "usb0cf3,e300" (Qualcomm QCA6174A)
+		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
+
 
 Also, vendors that use btusb may have device additional properties, e.g:
 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
-- 
2.21.0.rc0.258.g878e2cd30e-goog

