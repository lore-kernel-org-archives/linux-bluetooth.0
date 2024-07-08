Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DE6F316
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431585; cv=none; b=outLsFyLtXtcYmfyC+61vfwp9Oaqb7kEgm4FsyTQWnqeJ52NEM389/wI1jhhFVskFPCoHaASxZgYh4Vc4sej1g5ADsbEwhJimOv4MbgfSl9O09O9c5+1v1uAIA2hKU7W/xK57zFPjg0cwJXSyidM+kdTpxHxa6XUJHgpGUHc7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431585; c=relaxed/simple;
	bh=2TidE6nfTMps1G4Dq88WlZnsAHwB1gZ+MIIFB5e+tDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhyBNWxnsUhFz9/eBajO2aUm3AmX32uExZHSU8iNBIq0Dc538FAZ33S2desibLs+eabGFTdgJy/98vhRjACVTSX44JLkZFUielBDLyv6TmMGBP4YOTqUF3hr6krpajYjSbeHg/Ea2hw6tqEvqBEAQ4FGavFispQUFQdnEm8CaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=095hDrtr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="095hDrtr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36796a9b636so2610853f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720431582; x=1721036382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJiGPNVUfOymkghi+UnfRWIeLnwAQWonrs19sal1xMU=;
        b=095hDrtr2NnUW46xvbf6X/UcXB724XPYLy1e/kBw7ykeR2CsHo695NqPk3ZNQftrBt
         oMTl5iH+kuMGQ6FB0gjq/y/Gddvxj08BhQ53oexQtQ/8bCDi/eDUCkEV20CqoYyccSpF
         0GDf+tgAqH69ZNr15k/TBqgnOp/mv4IyNPTEZA9bQHwdzBzLbj0FBQBsyWv5k4js4ept
         s1ENhnl2gfZBR4NLo3Md1ND238z9XszZV4dUHjN8bonAsokAvp4/BwtQjENU//JkN9ok
         KRPbjeFQG/de6Q1orIgS0oR80BEWg0O4zm3lP6PkTqVke/CdOhq0HhNrwwPLV3kT56eC
         tkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431582; x=1721036382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJiGPNVUfOymkghi+UnfRWIeLnwAQWonrs19sal1xMU=;
        b=E5V3vuYhsCkqc1JPHpyEJNyJbKvaqe3HWVqusPiTLqvLaBB4Xcc46LdamQwx7KdyaJ
         qaQUEYKc1GfTBh0/zSwR4sUy5raNrikK4VvfrlccQivO2T3Y1NAUu3BeFW8Uv+Y7U/eT
         1TA6Wuj1uqu3/OgaGqV2hoMC+KF22F7D7bH6bONsL916L4gtAWuq5a+Daa7lyPEL1Uwo
         471p6vkOoVj0qiJbqFWZCt9RmbIHAUDSc4yTdNOtE40j93FLpS5R5hQ+ufu9OfQiP6fP
         iXFzXB+MA5d425v3IWEqI4MGbPVXX6Jvtx6/7kKfK9YjuOmDQ22wPusFVTuINE75cVW9
         qNgg==
X-Gm-Message-State: AOJu0Yzv7Haiks6NzDm6qaRpknj7b+XlaCEzkQLFwikCH1ZT3E7itpwM
	0pyyXaUjH8LwKRQo1f9WEQ7cATW7MB5fliicyCrScTUdXP1sLZEKi0aXpfHUowU=
X-Google-Smtp-Source: AGHT+IFgrWWSoD1+87OSxs66tYydZHTpasqcgDslDFClrupbk7yVqgHDuTN/EzVRxeH5TsGO4CG0ng==
X-Received: by 2002:a5d:47a4:0:b0:367:992f:6037 with SMTP id ffacd0b85a97d-3679dd292f3mr10424712f8f.16.1720431582633;
        Mon, 08 Jul 2024 02:39:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm15457779f8f.104.2024.07.08.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:39:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 08 Jul 2024 11:39:25 +0200
Subject: [PATCH v2 2/6] Bluetooth: hci_qca: schedule a devm action for
 disabling the clock
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-hci_qca_refactor-v2-2-b6e83b3d1ca5@linaro.org>
References: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
In-Reply-To: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=meA9lGcLLH4Zog4sSGjK0zP4eT7Ynd0BKP2Y0SHgP1I=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmi7PZpeBgr/4oZaVp4asoGG9xLd4a8v/pMN586
 sYE8V1LT2OJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZouz2QAKCRARpy6gFHHX
 ct4xD/9UnnjJjkXfnYUt1+RV2pOqiDY6cBzAGmc5bHh6YEJTqpp4H5lo03qvWKjVhOK3N/+B/M5
 6E++q3uI6g3g1cR6oBAts5wHfy+rXIlNnFzgG+pa0Zejc3e601gjn+z2CcfhhFVK1ylrEi/RI/R
 CTrMRHkNa2sxeBL//EAdW8bjrscygKtWzfiCUYxP2eWA15YHEU79qNN5LA+cuHkOnHQ+pPSiyjI
 eVr1SI2jCLqRSQ77jZHy9YNsR9soe6IIXrTRIH6W1dhe+Rwz1pq/Hme5KPl7d7QD3NDu1LMfCH3
 lijYj+w26SSjK78YoWkLIXtmAOCcDJY6dZOwtHWwBA0Xt6NI6aE7uJue04/yOO9hi6FVi76kPvZ
 zReb6asY5gyfLInuXZUyhI2yE+13hg0eCqjkV+dWOJSNEMB37i1aCVM81rhrqaMKgNMENqGLYtF
 qhrDZ/nsQ0VApPO9iZfaZN6pufEGbgVowxbDYENTiGpULnoBw9m38/PDL5s0kT1ot263wSIyeWf
 vwFG1QWMY50WdB7qRvQSmat5cE6g73s3i2tUAvWoXctYDWQc14uYYJgCUnUTuyVIwhcg/Bs2dqF
 y7eqluAW8peVEsaOXHLAej9B17Gvf6f1AHJaYTf4KuUu9Io8tYL8vSD81kmrh48/II+fzBwjrT3
 FKSmA6bzaqaOE/w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for unduplicating the hci_uart registration code,
schedule a devres action for disabling the SUSCLK rather than doing it
manually.

We cannot really use devm_clk_get_enabled() as we also set the rate
before enabling the clock. While this should in theory work, I don't
want to risk breaking existing users. One solution for the future is to
add devm_clk_get_enabled_with_rate() to the clock framework.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bc6a49ba26f9..a34c663e337c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2295,6 +2295,13 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+static void qca_clk_disable_unprepare(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2434,10 +2441,15 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (err)
 			return err;
 
+		err = devm_add_action_or_reset(&serdev->dev,
+					       qca_clk_disable_unprepare,
+					       qcadev->susclk);
+		if (err)
+			return err;
+
 		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 		if (err) {
 			BT_ERR("Rome serdev registration failed");
-			clk_disable_unprepare(qcadev->susclk);
 			return err;
 		}
 	}
@@ -2477,15 +2489,9 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (power->vregs_on) {
+		if (power->vregs_on)
 			qca_power_shutdown(&qcadev->serdev_hu);
-			break;
-		}
-		fallthrough;
-
 	default:
-		if (qcadev->susclk)
-			clk_disable_unprepare(qcadev->susclk);
 	}
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);

-- 
2.43.0

