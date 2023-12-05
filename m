Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jWKEf0Ve"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC198113
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 03:09:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so54500135e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 03:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701774552; x=1702379352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEX8g9ws8pSAca/CRdznAgAd77RiybUJhIDkQ8ekvP4=;
        b=jWKEf0VeXDkMSYAdZy1IKtXAT0G3ERckDws1B66P7aBJaQW8NSj5myftgwYuV4JetS
         aaObN9fFWVJnWpoHgI0pGLz2IN9gvYeSLuAfZGL7xaJNC0jwspPftZ3yDDU1WymFm4WK
         vcDYN+BMgTw0vwcxZ08d2EYBvVHrq/QDbAu6uF+OeGynKJQyHQMfWfZWO0phRg5j2vCL
         phf5EiRfwexzAqzKT+aFGulJaRMWsvMJT17+ek8xXW4tUyr6NFE2ZA+NqljowmuSgztq
         AldNhrI2a1eOGbcyOWBeOXnDQn0aY5pZprcboAzrPfTO6VsHu+3WVeck8K8yjRPsBrxO
         LTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774552; x=1702379352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEX8g9ws8pSAca/CRdznAgAd77RiybUJhIDkQ8ekvP4=;
        b=sBmEm3PBy7HBzOf+ZMztjw07sSZgJilXkon0rmU78VH0aRA0ZN023Hnxn54+/n04TT
         DQBsHl9mTHZUYC2q8s8dtezAr4qevi8tmcTx8jL7hOWNum+zaeoxckjoDOZqIJIVlcuN
         Ll+0XzzoI29WAZc7CYNWaVa6suwPBYbS2ukEd57f9Px6zTgG/TQQgrUO7/5aJ3pHLEQ8
         C8coP79FU30V+4ecMVwB0NDyhmIHlZclIGFFsHwdrOXTg5yxWApch3qWMs/753PrSsIA
         XDvXgnFYlwUz6JBHVTYL6RxSoI1WpaCZanPQuGmiJoDgVZmkbE7eNmYGRyEwifw4CwCV
         1xug==
X-Gm-Message-State: AOJu0YzgQTvhglZ60BAJM60NoRAMl4w2H7DURqCrTKNOnYfm1X3kg51S
	vqfP7K6bg0eW27JkHNzhwRVR6A==
X-Google-Smtp-Source: AGHT+IFsmkGKbKmqRWIAo7hIqZj481lJ2ZLH43Zbo45JEUbbEWAXMQs+nOh6tadL86/0jGr3nEynVQ==
X-Received: by 2002:a05:600c:4506:b0:40b:37ef:3671 with SMTP id t6-20020a05600c450600b0040b37ef3671mr4501417wmo.38.1701774552298;
        Tue, 05 Dec 2023 03:09:12 -0800 (PST)
Received: from brgl-build.home ([2a01:cb1d:334:ac00:2efb:ffdf:fa22:d5ee])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0040b45282f88sm21798166wmq.36.2023.12.05.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:09:11 -0800 (PST)
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
Subject: [PATCH 1/2] Bluetooth: qca: add regulators for QCA6390
Date: Tue,  5 Dec 2023 12:09:02 +0100
Message-Id: <20231205110903.68898-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add regulators for the QCA6390 module present on the Qualcomm RB5 board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 35f74f209d1f..7f25931a946e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2044,7 +2044,15 @@ static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
 
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
-	.num_vregs = 0,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 20000 },
+		{ "vddaon", 100000 },
+		{ "vddpmu", 1250000 },
+		{ "vddrfa1", 200000 },
+		{ "vddrfa2", 400000 },
+		{ "vddrfa3", 400000 },
+	},
+	.num_vregs = 6,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
-- 
2.40.1

