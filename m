Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1090C6379F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Feb 2023 02:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjBICJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjBICJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 21:09:24 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1E91A970
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 18:09:20 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g18so522926qtb.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIypt+WJR6vATpFn1aHucJU2sV9ncXyGiHkb7V566WM=;
        b=VHNZeKLwQDQ/eaYcn57X3IMN//R0pwb46fuEh6UdQ+9Fz3AbnSgjUVCwbRfH8LzBUy
         fcaslPPBvVBK0+u3Q8NsvaeioRCWYIzECAwQOhQgMbDPnsg2D0ov9dwWaoB2sLvvFkCe
         WhxY1vGx4EIc1aQecGuUn8rs7VD0EI4Yz6hEthxHLcrJYbpRb+6IqI/qVrEp9vSLFTDx
         fg/kjJYWqNyg0T06ZsNXNNA1AYUbO47ervi707QjZPAOkM3jXkU828N89+HgqrGQQAwj
         SgDTqpx2XXYiOEbFXitaqv3L0Ledx5oJcMe3fLvwp53s6HlSooKUuxLP1oYhP1cTtND8
         twEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIypt+WJR6vATpFn1aHucJU2sV9ncXyGiHkb7V566WM=;
        b=BkQQsQy40TUAswdDZaaCJ0eTYGQTI33ycTkrVUzI0T3yWuh1ntBOgo4WrP0dCBKcDO
         F2Uho2Ji4g1rKE+N4fYOVdn1SXvZXXrMAIGDSulljLTeeDsysFfzuBvvwACsXJs0Iv9A
         LDWJ5sbTjID9/JNs6cCw1keZ78S1pPtcLMAYEM7d+kLqcSuPkZY23GPGGZnWWr4RTV2p
         VyllOK6dGpRcmFW1VaMaiLnUbBABZtIRkfM1Uek5mhMSKDb+6Zscb0hL4//HGLy+vfzB
         HaLX2wMCC1jIA27m1pUfLSTDT1PSjvdGSAB7Ww725ZrcezWFyZThZKu8uDnoeXZ8WbC2
         1Nug==
X-Gm-Message-State: AO0yUKXFMn+UHb4CrAQfzb/yCgBfGC0mNHO6/fvoMJRystri7GGGkGY7
        xBjdEDAPH/Zv5g6Os9gIo1Zhog==
X-Google-Smtp-Source: AK7set8Px4/Z7X7uWmjjepGWM/XhrUYQ9EFwyBj5n1UifquTO/qmYtLuqyPRhQkYesxV7pEnPSGERw==
X-Received: by 2002:a05:622a:651:b0:3b6:3a7a:d3c8 with SMTP id a17-20020a05622a065100b003b63a7ad3c8mr14909987qtb.17.1675908560006;
        Wed, 08 Feb 2023 18:09:20 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id d64-20020a37b443000000b0071f0d0aaef7sm367930qkf.80.2023.02.08.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:09:19 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: net: Add WCN6855 Bluetooth
Date:   Wed,  8 Feb 2023 20:09:13 -0600
Message-Id: <20230209020916.6475-2-steev@kali.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209020916.6475-1-steev@kali.org>
References: <20230209020916.6475-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add bindings for the QTI WCN6855 chipset.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v4:
 * None
 .../net/bluetooth/qualcomm-bluetooth.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index a6a6b0e4df7a..68f78b90d23a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,wcn3998-bt
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
+      - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1
@@ -133,6 +134,22 @@ allOf:
         - vddrfa1p7-supply
         - vddrfa1p2-supply
         - vddasd-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn6855-bt
+    then:
+      required:
+        - enable-gpios
+        - swctrl-gpios
+        - vddio-supply
+        - vddbtcxmx-supply
+        - vddrfacmn-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
 
 examples:
   - |
-- 
2.39.1

