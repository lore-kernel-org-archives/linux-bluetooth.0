Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052017C7BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280250; cv=none; b=MsymFJdIW3fHyPyRkSN7K0A3uOE1iN7EOP0mWbjAdqyiuQOXHeqZgHdzOlBDms90NNFR7NlRBeZbtRmlxC/ZutiNQ7/M5s3M6/cUzCqH4nnw8VEcdcDrx8j6HkFF+eRb3nCvmyrQ2sW77myrGG1e+vCnu03ajXsG1HDqi+vgSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280250; c=relaxed/simple;
	bh=5cLHH69JJDhOiZb/fBtbVOyASTGvXu6KKQLE3TDOJWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0PsAMzSgwUq/Gsu5mbbHuXU6uWdeqLRU9VAZuEMew/UikVdhnLItk6bj6ROqMbBUGzLXkCM188NuBfY1oOj0MlDnUMcC6PemO28T9Mgzq7rbKNO0LnWHFsqinfVbFKJxgNBCro+qzG2Nq8EucYQ8xUR+Udyjp3xTD67JWd2rLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JmlFguGD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmlFguGD"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-713edc53429so151296b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724280248; x=1724885048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqryzH7j3wvqpBXhrLGUt8KpB52GpjP5213AXHE2etM=;
        b=JmlFguGDuqKT3oWwE7Su3z1wZ273p+Q1qZXq7u6aXIAu1XsOYnIbS9pY+erp0Eb2Ex
         t+iem3nv6i1h2YD+8P0H3SKPnq6hhBvb3xUm+74jaFIrPzx67Qh5tZc8Zwsn7bgoOOhs
         q0jB+DEmVvxNINQvFp6dylrAiR/lgK93ojB5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724280248; x=1724885048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqryzH7j3wvqpBXhrLGUt8KpB52GpjP5213AXHE2etM=;
        b=f8We2DsrXsH05UZyRg3ZEw/j9rvmr0d6872C9TKjmqY3hHBKvWUgN2CR029ph0dZ4i
         /QXy26a979Xd/G2d2HVox4eah2ajJQnGw+QA10C9EZfveElRfnA0g3C9OfBwBY57hfvA
         c0GMa03g6rh2HtULYV65DbHVCbUGZE2tjLN88TGDm4U9yZd+RelG696tG2ZWqsOqmM8e
         wsxKiFOstWsYTmbE6s40XSAmlaLHSJrlZTwbDadrKFncAdRh4oSaEqkIXMHWEywkRW4D
         R43svNtNGr594z563WVO3Dj9plMpYC3XrBj8l2YqSgtA2hyfxKu3rZFkGHv3NKC06jjK
         9usg==
X-Forwarded-Encrypted: i=1; AJvYcCVNq7887BnaXEP2W+rmgyFtJDstDYrqy4poYX5gHt7+YWDdVnyLRuF1dvXs3jMKRZA3EjkBMDzZnS1AjR6Q2gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fEk7RoILvqOchscl+X9gmM5amH3otJRigC5eWSEWmQ4XabNb
	3JyPx8Zz6dXiBMky8ZFomRoLPwgvC368otIAz3KcK7E5hNtcRiXidZKFLMpyZg==
X-Google-Smtp-Source: AGHT+IFwM9rn2lURI25CT0hrSuglfVOUBVyVM6H/oqBUlv0bJmvcoH/Gcz2c+LGeDKE/N6Yy88qgHg==
X-Received: by 2002:a05:6300:41:b0:1c4:8da5:21a4 with SMTP id adf61e73a8af0-1cad81a7279mr5139868637.41.1724280247846;
        Wed, 21 Aug 2024 15:44:07 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8b27:65e9:2bb6:ed40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a10sm157368b3a.108.2024.08.21.15.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:44:07 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sai Teja Aluvala <quic_saluvala@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [REPOST PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
Date: Wed, 21 Aug 2024 15:43:40 -0700
Message-ID: <20240821154339.REPOST.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems in the field, we are seeing this sometimes in the kernel logs:
  Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95

This means that _something_ decided that it wanted to get a memdump
but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).

The cleanup code in qca_controller_memdump() when we get back an error
from hci_devcd_init() undoes most things but forgets to clear
QCA_IBS_DISABLED. One side effect of this is that, during the next
suspend, qca_suspend() will always get a timeout.

Let's fix it so that we clear the bit.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 45adc1560d94..efce3846d5fc 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1091,6 +1091,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
 				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
-- 
2.46.0.184.g6999bdac58-goog

