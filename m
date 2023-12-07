Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CQ5OKXtB"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEAE10E3
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 01:12:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so3741465e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 01:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701940331; x=1702545131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNLG30CN2zegE/M7jl95INA4rCvQrv07QBb0d7Gkeww=;
        b=CQ5OKXtBgoLI7WRNq+gepaxQthGmLKGMx/xDCrEKKseT6EmHhNOF1vEOQLq2E9WTOP
         MKu0hz6n9mKExAoQ4PqKoFynIwUdWJg9vgrMA1WUn2566fcgBFrPPbZLVFSE7QVdaCGw
         DASzFHMY05UvH7Bh0+qnv50ZQoX1ec4Dy0evFsX4GfltgaC3ZNfrHgDV16GLJgLyN4DD
         kuhEpFoXt4Btqsl9kroFcOhC6mZxdNJj7VUgC3g+Fi3Jx/WJj962PuljGcoXuzufHJgb
         +wlD9p5igrvKvDmiFS8dNvnsqlF20MoeYZ34bP9c5keQsE9xvV+GFyXHdtC7+p+zjvXk
         HG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940331; x=1702545131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNLG30CN2zegE/M7jl95INA4rCvQrv07QBb0d7Gkeww=;
        b=bQZ3e2HjXxuKN7bBRAdCEzext3cpjfSrT30orvdyNZ3Fihta82uOP0bBDzk8clZZa6
         hNqZ6I3P5McUnzMK7C5HCLaFuX1ia/KLQNhBnTF19bEEwdYOR3tIUYcQaNzAo0BYUcEq
         fXswhE9CaiqQrIKjK1r9jpvCeAEc7Hf2s7QXLUJoXq4XnJCHC6Xl6o/ySZYtNH5TI3PY
         lhvqAQtSQmYsJDs1uvQ/IoifAgZGu98N/aAI5RmuuoQH7iazqaHF7T39loo77wWdjx5P
         dBLRRhgMC8CzriF5t3DPRFMSl2RNRiDd9SI9CczEjWlC5FznM2pViZpEHBfp5+ebdmaA
         hDxw==
X-Gm-Message-State: AOJu0YyDaW9uMU5B9rTkdNYq8M9iO4yGOwyT+/GbcJme0yPVt7LFiwiM
	4V3vnnXHlq+1W7lYDTGM1EYPig==
X-Google-Smtp-Source: AGHT+IErPK+hX/Ij8xcH1pt2rolGWBmbdJU42c/YHeF/TrT7Ywo/oD5Kt5AujnyiPUZWxwdSbkeY5w==
X-Received: by 2002:a05:600c:3553:b0:40b:27b4:b4eb with SMTP id i19-20020a05600c355300b0040b27b4b4ebmr2418920wmq.4.1701940330981;
        Thu, 07 Dec 2023 01:12:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:de32:8b0f:dc9a:4dce])
        by smtp.gmail.com with ESMTPSA id y3-20020adff6c3000000b0033334c3acb6sm896009wrp.98.2023.12.07.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:12:10 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: net: bluetooth: qualcomm: fix a typo
Date: Thu,  7 Dec 2023 10:12:00 +0100
Message-Id: <20231207091202.19231-2-brgl@bgdev.pl>
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

Spell supply correctly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..ba8205f88e5f 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -69,7 +69,7 @@ properties:
     description: VDD_RFA_CMN supply regulator handle
 
   vddrfa0p8-supply:
-    description: VDD_RFA_0P8 suppply regulator handle
+    description: VDD_RFA_0P8 supply regulator handle
 
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
-- 
2.40.1

