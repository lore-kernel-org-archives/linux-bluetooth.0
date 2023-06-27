Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3390EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 08:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjF0IQS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjF0IQL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 04:16:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948671FDE
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:16:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a1f2so22506905e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687853765; x=1690445765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBoMZAyHEkAWU0CE189A2jr8gUmpNWkaE6+xGeLfDF4=;
        b=Yz9BXgpvC+GyS7iZQyg5K6XTEo+jnZrWsPU3qVDuoG+XBlJ8F/eJUBihp4UUFmrB77
         0TLStj/5nVAogk4kL/clff7iGx+qFPoiPPA3d+Q3tha7eT7SrfgBDdh46oH6wm6zjlnh
         FEZ8FgoGOTUX8VctQjbqK2sp5XRIosU/Jy5tztZb/IK8wxGAssHYm2hNwceGGvMzs9Qk
         y1gXiQ/xHTrnp/o0P1NUFptaQLWlzx6bGC3qHGlyiDcQJvEAz9a2srpi+gLka+Bh0yGg
         ra+6BKPMIDsMsrcx7AHZYEUjQ0ylmhWaSeeJRcH1mzaeHYXstEIQm8Mgrsd1EamBSigJ
         W3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853765; x=1690445765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBoMZAyHEkAWU0CE189A2jr8gUmpNWkaE6+xGeLfDF4=;
        b=BpKs+irZbDUtHQDI0s8M1gyIHPFNjRcafkg72XdLPAZ4O6cAcIPFSAf19JX1pEnbQs
         1yypMH8LjhJGH9yvJVPwMB63P737icfHZgeVe+AmKyT8yrvwU+0x01aksHljGsFqobRz
         6Sizw05yXVlrmVeB9k4NLJhd5kHsr9S6vvb5hsE2+INPQXC5ZTBtJUpcSbrASPlODXla
         T+xr8LGDn9A58DULAGuUTEe67gKsGoUc+3Dp+lIzJHNxgJNUwMwnlCeZNroGeRLGF4w4
         DiVJpqvVimcIQnDdz1edRbaZPnPRw6YSj4j8AtF8O4aKGNVCIr1dzdD5o+8pfLkC99NM
         qLSw==
X-Gm-Message-State: AC+VfDxGkKYs5lC34k4wR4yLfMY4pDa9sSIIdKFoh6IB9mcNzRJ0elYC
        wWRXi+wfEjiPSv9pmR4y2rZIWw==
X-Google-Smtp-Source: ACHHUZ4DFNqmo2aQnB4I6sKufTwkM5YboBNEvezXu7VMoppt7X/epVYUyKScKtV66nAnMAlGfEmqyw==
X-Received: by 2002:a05:600c:3797:b0:3fa:c3e8:900c with SMTP id o23-20020a05600c379700b003fac3e8900cmr2950381wmr.11.1687853765035;
        Tue, 27 Jun 2023 01:16:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm3922480wmi.46.2023.06.27.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:16:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 27 Jun 2023 10:15:54 +0200
Subject: [PATCH v2 1/5] dt-bindings: net: bluetooth: qualcomm: document
 WCN7850 chipset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v2-1-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IG7+Rqs45O/Q5WGe4R9nxFHceIDdqu9aByz0IVFtTNA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkmprAFIaMsSwutV8rGK5QDuOtyBVopDcIZtcqF0pe
 lJXgXJGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJqawAAKCRB33NvayMhJ0VtlEA
 DBJVsd5GpzARyBt0wF+eQ6sMxHciyBS+kaansD/XfhvxtNVDYo+x/kylDZZjJWgtIwuuamL8JqaLgo
 azCiIimNvoBD5kQvgaxu7xVEOzvfYmAkthOXh3GX2yPaMK3IDTm6fieNtCFDAFsNtQLPQeG8x2qXjK
 qniM4VBxUe20+aL8bLami1qYU0jDQUYh3EDjo21m+OahHW1ZmULBMN7pFu7aQSPyFc9PO+vp3WwXAv
 NgN3s7z+g9+5sRldyA76OYRZXA3uQ8lh+etuDzzAf35z/X1+vKaTt5Lw1DQvC2TZXBjN7YDYJhZAuK
 geu5LR6fumFtD9xO2vQBY2R8WhKP7plVJEQDcpxvt/rMP2+vA4Nmoasrs16EeiExDjAa+XB0FBRugx
 XSCQOxxGsIREpKg2N+N1tw2LqC3pDwcz3cB2w6BnQg13dKxH8U/btILBXFFU9gsMH4NX/uuPA5mGg8
 Dj11ZhmBkJLXf+tJcavHPiDSbriUgC795ZOhxlnzOEioOJ/FbPhDXvHT3XMfsK5bq5MuzSwdGO+L1n
 e+EvJN0ofRtLLwGHtU1HBj4LP8FIYq6x63xyhWBvv2J/C6uV+08OBaEivropU1jkOltjdTpYhGLTOX
 w0fPlihIidTb1Vm8dHs7qmboca0HcJe+3oNAvb6yqu231HauCMXC8dhD9AAA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Document the WCN7850 Bluetooth chipset.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 68f78b90d23a..906a377d1616 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -24,6 +24,7 @@ properties:
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
+      - qcom,wcn7850-bt
 
   enable-gpios:
     maxItems: 1
@@ -53,6 +54,9 @@ properties:
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
+  vdddig-supply:
+    description: VDD_DIG supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -68,6 +72,9 @@ properties:
   vddrfa1p2-supply:
     description: VDD_RFA_1P2 supply regulator handle
 
+  vddrfa1p9-supply:
+    description: VDD_RFA_1P9 supply regulator handle
+
   vddrfa2p2-supply:
     description: VDD_RFA_2P2 supply regulator handle
 
@@ -150,6 +157,22 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p7-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn7850-bt
+    then:
+      required:
+        - enable-gpios
+        - swctrl-gpios
+        - vddio-supply
+        - vddaon-supply
+        - vdddig-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p9-supply
 
 examples:
   - |

-- 
2.34.1

