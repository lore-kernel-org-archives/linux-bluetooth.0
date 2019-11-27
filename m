Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD43C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 22:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BDB2166E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 22:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGcWFCb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfK0WpQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:45:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44974 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfK0WpP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 17:45:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so10545712plb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 14:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63jmzggHofWJgr5L+GFqxa+EPIblRXoAkXungwth2fI=;
        b=MGcWFCb0G0DykTImRQeb3TawUcMhqC9QSHIXhHlJYWD5JI749HJpVBWgXqg7daoiGA
         T7es9mluxMthSbpztiGoHaZthnsvDRErI7+DezwQi2RYIRCd9s2MHGxiEPnJ6zw1uwkb
         EndGbT1feeUF49ynd1MIXRupi0HFXWNJ3BgJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63jmzggHofWJgr5L+GFqxa+EPIblRXoAkXungwth2fI=;
        b=gKvJJocBJedUKxxNdMXNXEuCP5fgyJYzNyvhl5OIu5deaIlCr8OYqIvSWdE/1XV3zV
         pUolE83SroxfW9cTowvI5UOwpN/QS4Ag5PMiMyV0s/Nk6nrPwr1Y79b/5RCpcLCjR9s3
         8FUEqsmpoy4Bt4R2eYj1XY/tNBk61lfZf7nfngv0Wa03fpy/IfuqxMo6cP4d4Ukq0t+Z
         BwoMb65QLZ+zDCzA3nBzGTAWdM8uLMLC75E4c7ygQZOZLrvTQ30xASVGxlEXavIbWiGn
         y3xTrjlSCQOGeaIqkoVfYZi/v9EBn/TsvhBKuLVmnZAPPmvl3mieGBjh7Q4HSsmV9+N9
         MyLw==
X-Gm-Message-State: APjAAAVYwEVrdhv7oMtOB75KPWIGW3QhZ79MMuleV0OiP6KRzJPMqeA/
        1PvV6nQSQCV2KEI3HvN/FLamOw==
X-Google-Smtp-Source: APXvYqxkiaNpRSKYO8TFXuDbKEa4C6rhv9HChTpAPsUa4ZwUsN9Kt+fIhYQ8z4o9sPgZF5ZN+rFnRQ==
X-Received: by 2002:a17:90a:b38c:: with SMTP id e12mr8827391pjr.89.1574894713609;
        Wed, 27 Nov 2019 14:45:13 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id g18sm17756714pfr.165.2019.11.27.14.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 14:45:13 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH] dt-bindings: net: bluetooth: Minor fix in broadcom-bluetooth
Date:   Wed, 27 Nov 2019 14:45:09 -0800
Message-Id: <20191127224509.3341-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The example for brcm,bt-pcm-int-params should be a bytestring and all
values need to be two hex characters.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index b02a53275c98..b5eadee4a9a7 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -47,6 +47,6 @@ Example:
        bluetooth {
                compatible = "brcm,bcm43438-bt";
                max-speed = <921600>;
-               brcm,bt-pcm-int-params = [1 2 0 1 1];
+               brcm,bt-pcm-int-params = [01 02 00 01 01];
        };
 };
-- 
2.24.0.432.g9d3f5f5b63-goog

