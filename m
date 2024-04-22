Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122114F9D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790850; cv=none; b=oZoA+XrxnWUd2VrrFqAbzJTa3o+WTXWBsgYHYywVETu8BQfgm+OwQ5K3baM8kEoK4Zug2z4GIMNJ21sX4iKuewVwsWANkDMxXvgJIpMXg7rJYNGuhoSnmvAlsmw059jtF2ScLQwhenE30Hl1oRtt3YJLDJ4aVS2GKPBckDNP1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790850; c=relaxed/simple;
	bh=Yq/JhB+Lrc/miD6DiFv71QXBz/idDrjXRkpufPo8K/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=so7z3mki5zTq9yf+UB3iMmPWEIG310y8yoOA04likbmDWlRqcsiObVHMhgTr8S/uE4k8ADHp78xs4wFmLHXH4aZDixQWQwaFwhcAWZW2paqUC+2Q04KE27FRLIkOHvhsnqkkuejDW9qiFzQtA5Y08vLAjXGdu8gHxi57tqPqIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=j3+JlENr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="j3+JlENr"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34af8b880e8so695697f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713790846; x=1714395646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/gyfw9gI/bmdg08KWcL093IxCvqzBUYKqsRkm5VLSU=;
        b=j3+JlENrWQ9AxArq5CDU3nd1hhHgrjJxbST4FXGDSSRF/dU4hrG0UCWqJE5IYDZq/E
         p3I4U+1LvG6k9x8rZMgRIfRQR97TIdsxOJ/eycM6sM6rgiIhcQ3op27v4Q5xaznYYQAQ
         vWX6pVCE3Ut96QVJjUxlSzKxalJCID9dcW308kDbPCWyNmy4ryeQA3PM/NTXmr13w09p
         93zaxWrkdTLdtG4QNNOkP5JH3BM9VxaxzstkeWN25XL2ThBySI7Mg4U7AVack4w6qzIs
         LcQgD10LnboAduLMiBzYNA/3bMKJvLDAllEPZNS8U3SF3HKtQMJ9azEZqNtQjH+fSfSX
         cOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790846; x=1714395646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/gyfw9gI/bmdg08KWcL093IxCvqzBUYKqsRkm5VLSU=;
        b=KPbWcsL5FD6HB6454giycaWrb0dOqv6+rs4281qJJ8FlN5iYLV++YISRbwYAKX4xT2
         JTb80mWYi7aiJnTCURXsGjUStvzOn2jOvbkFUrMlGF2CHOOaDnxlF+XwNYRmDzFt5NrK
         KYik34dTHJkKFwLo5rpifsi6A3anqnA2VaM7z1hULHHNf0hoWQJo8nJIhlBR2LJ8UrP7
         ISttlnyGDGV8OJ7kS/4ZZJ/VYdoKuVoNBEYiMIo8M7DD8cJPALEX9Y+3Nim4IMA0upJx
         ujlUQBfDs3ojL/Uo33Mff+jx65jZ/7jj/owuVd239TNI7/UsVJrzmqm0/nyx1+uEd59B
         0sNw==
X-Gm-Message-State: AOJu0YzuGrMtJ8vOV5CGNJ7IVr9kSodsT8ntw/G6yjaxzcOjPJAZrA6j
	IqXsDiPLzZt3pPQo8diHZ0OZ8m9m4XOmQRba2fkkC+I/BRgV2NNfEAicPIJ5PRxRF6nmlAupHRJ
	t
X-Google-Smtp-Source: AGHT+IGr4KfXdTc9P+tUqOlPT1oTTntEG1xJ+qUnk/c9fCN4nizt5pKj5b0MOuQknSB8WsQfCV29lA==
X-Received: by 2002:adf:ef07:0:b0:33e:c91b:9083 with SMTP id e7-20020adfef07000000b0033ec91b9083mr8231244wro.16.1713790846220;
        Mon, 22 Apr 2024 06:00:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6981:a121:4529:6e42])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4d50000000b0034a9b75e272sm6761942wru.45.2024.04.22.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:00:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wren Turkal <wt@penguintechs.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
Date: Mon, 22 Apr 2024 15:00:36 +0200
Message-Id: <20240422130036.31856-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Any return value from gpiod_get_optional() other than a pointer to a
GPIO descriptor or a NULL-pointer is an error and the driver should
abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
power_ctrl_enabled on NULL-pointer returned by
devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.

Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..739248c6d6b9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2327,9 +2327,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			power_ctrl_enabled = false;
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
-- 
2.40.1

