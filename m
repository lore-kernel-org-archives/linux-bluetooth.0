Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B31C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Mar 2023 23:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCZXiY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Mar 2023 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjCZXiU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Mar 2023 19:38:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D34ED6
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Mar 2023 16:38:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so523940otd.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Mar 2023 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679873896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ76nHN8M0ZiVoHm0Euw0qHTeLSoiFoZdMJCuKUGiYk=;
        b=EjDyV+MaIAxYS604JCZXVJ4L5q1IT4a9dGC4uZSg9fnQ7oS4QxWRPKLEG87YguBnMB
         /84j9uLvLcHSLYLF7CYmvn+A8mawXKiOMvrW0gFdr1Oufix6/iOQ7VY7vL820Q6Ly1Pi
         VCUaso4KkCS5PvoiEGLHAZRzmt2kZ1swXXPp7nlWgF3RkamL0Imk3ewiTpfx+2paSBS+
         mXGwozx6R1qq8w9PdRH8e4U7Xwax93+DTi2CefDt8UXxx/c9E5vp7Gllc51KP9+Ge4G8
         Ulvnc050MyYSj8hzBCVajLc7R3YkDRWQU9h++6PCQoVROuhVX0WwpE0RkeYHipNbUjdi
         hrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679873896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ76nHN8M0ZiVoHm0Euw0qHTeLSoiFoZdMJCuKUGiYk=;
        b=IrD+TXqN/n9znKEMLwps/4VIoiPO4bu3e/cZqQVFE/u5tOB90XqdRJQQc8Ufe/r0vl
         vTmOl873su2g2k8wINhMPS+1WnzuHQuAetRSh29zXAjT7h5aDMwkLivnSQGOKXlK5o4L
         Nh0pl6WYch/OamXObx/TVyDKZR80kjBiIpib3lMNKZ+yvw1aaMG873V+V1vqx3DbmoUT
         2n0VIoH+N1miaVFIVLImrREvxjC+v7aGR/IsjKJWPbcn0BIpi53m4hff9MZPYY+LMjSl
         fxu6XH/XwsJWcxiRa1rOrdoZmmT8sDTfW+6lp7fofgjauz2dGVq5PPyxer3evg2r1+Od
         3nrw==
X-Gm-Message-State: AO0yUKVIw2GiFPxE2sW5kRuK3MaGre/eWe1hD8iHwPyED5bjufcF/PzP
        fYsGHRD8RZFMYkDxLTVU3fQs+A==
X-Google-Smtp-Source: AK7set/poyocwSjgt4kFmjnW3pwZ5Iz24rXbve9Gc7DkkI7MBDBzCetTHn68sqVw9KftHtElyH/98w==
X-Received: by 2002:a9d:367:0:b0:68d:3fc8:7c11 with SMTP id 94-20020a9d0367000000b0068d3fc87c11mr8372498otv.12.1679873895825;
        Sun, 26 Mar 2023 16:38:15 -0700 (PDT)
Received: from localhost ([2600:1700:eb1:c450::35])
        by smtp.gmail.com with ESMTPSA id f25-20020a9d7b59000000b0069fb87285fdsm3710394oto.59.2023.03.26.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 16:38:15 -0700 (PDT)
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
Subject: [PATCH v8 1/4] dt-bindings: net: Add WCN6855 Bluetooth
Date:   Sun, 26 Mar 2023 18:38:09 -0500
Message-Id: <20230326233812.28058-2-steev@kali.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230326233812.28058-1-steev@kali.org>
References: <20230326233812.28058-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add bindings for the QTI WCN6855 chipset.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
Changes since v7:
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
2.39.2

