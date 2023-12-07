Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BTbq9mDE"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E7910CE
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 01:12:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so7363375e9.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701940332; x=1702545132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8Iep3f8IbW9XJUviPCyqs/DBfreAlewexDEpMRvmDo=;
        b=BTbq9mDEYAiL+96ZzZApuWxeAFQS2d2PpPPZocNBP0JD1fGNZctkJM+Qj8Hep/dnbz
         Lc8KXrR9os6zyQ9D991DGCHLU/XwG+OIcguXabvTEjJLRYgmeCbsBG7QlNdyPVRnOE27
         sJuWfLTZZs7uuS8Qw6RvsLx84MhJfKXfqferDtHQIxvX/eB/3pQNlWdBpcmQqCtarYFL
         JCawR9jdlfgBc1WrKTXzPWrbgyv3HUe3/eWi8pjsoLf23NGGRTMSUDFP981F9tdEppAr
         6XITsS241i+2TXYOM+k8lcuFj9h8PVgd1ZbaXtwr4ywbdBb/Wahceqh3zfMIA7aFTxQt
         GmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940332; x=1702545132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8Iep3f8IbW9XJUviPCyqs/DBfreAlewexDEpMRvmDo=;
        b=kUctMOXtx70S/LCEifu1qCflQ5fdTLh624TU202Wxa2GNgB8wkJEIKZnRQ2WF11DNA
         rJhtMgrkxgUBQ56PfzV/Iz7kUMP7ScS5slifOA2UoQFfTnh3FswHo7zu2yyCb1aZhsNA
         KPaGmus2xWIgzxr4nNJ5jRRdnfYKYkECz38N50EWZQA27eKh2Rex3qKybpIsMjh5PDz0
         JkVQHBMKqxgwf9LloJ8lcXq/xxBhHbUITttGWkxuZSErk1eTfxKFWhyf4xP8p3bMzxNo
         L+PCcywwx+Zng/tDuAinF8Bo1bdUhdP6R8PR0UdFKHwAOv32UHwP6VX+JOGvcwXNfERO
         MFnw==
X-Gm-Message-State: AOJu0YwVcHhBUQGfp9CZqR96Bye2oL9o+Fm2j1PVaS7E6QeWhvPVWWhg
	ohEDDfOledsg7+NkdcwU71L1Hw==
X-Google-Smtp-Source: AGHT+IH20Zn1uTIOUuW+48Vx0oVF0nDTgMGZyFOdUjShve7iw+aZCG1zm/jU7hRgv5pnJr3guxbQ8Q==
X-Received: by 2002:a05:600c:3b1f:b0:40b:2a18:f1be with SMTP id m31-20020a05600c3b1f00b0040b2a18f1bemr1427841wms.1.1701940332105;
        Thu, 07 Dec 2023 01:12:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:de32:8b0f:dc9a:4dce])
        by smtp.gmail.com with ESMTPSA id y3-20020adff6c3000000b0033334c3acb6sm896009wrp.98.2023.12.07.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:12:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: net: bluetooth: qualcomm: add regulators for QCA6390
Date: Thu,  7 Dec 2023 10:12:01 +0100
Message-Id: <20231207091202.19231-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091202.19231-1-brgl@bgdev.pl>
References: <20231207091202.19231-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add regulator properties for QCA6390 that are missing from the bindings
and enforce required properties for this model as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/bluetooth/qualcomm-bluetooth.yaml     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index ba8205f88e5f..861663f280eb 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -65,12 +65,21 @@ properties:
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
+  vddpmu-supply:
+    description: VDD_PMU supply regulator handle
+
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
+  vddrfa0p9-supply:
+    description: VDD_RFA_0P9 supply regulator handle
+
+  vddrfa1p3-supply:
+    description: VDD_RFA1P3 supply regulator handle
+
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
 
@@ -180,6 +189,21 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p9-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qca6390-bt
+    then:
+      required:
+        - enable-gpios
+        - vddio-supply
+        - vddpmu-supply
+        - vddaon-supply
+        - vddrfa0p9-supply
+        - vddrfa1p3-supply
+        - vddrfa1p9-supply
 
 examples:
   - |
-- 
2.40.1

