Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A715F402
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527541; cv=none; b=cylq3ai5KAm01nCCsYVUo21/vYWfa7GvtPfE6v3u4iZxEPOAnFaR61qFzZea0pZ6AnKVrRJgo5EHJz43W4wuhyF+rzr0D9f+rrpZ3HEBngpV2+ntKZeJBkEVEakWd3GmZbeKDyG4NKtU7fwGcFQ0GaxT14V+zZPQvTvgy7qlijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527541; c=relaxed/simple;
	bh=fKKLkr+JeqinumE1YtXHxd2euSzwPdFaYrOFYxNDGqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mrq8y+Aun4eDuOHsicifkFZHgKf+y7W75CLktOBTsY+dfDggQigrdIOVTxzDOJ++Cfp66Afpr7Bmg3z+AazOf5a2wXpia+4rIegTGN6tdQt3/9UhM/LWQ10yoeHtylpGtP9b2qW6MK3hk11ehsXCGkuqsisJO4zUQ+G6mw7kFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UGWkdo85; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UGWkdo85"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso50062151fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720527538; x=1721132338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZVrjmNGGBCCMCXFviIdtIer4Cn8tsfjub2doZVrX+Y=;
        b=UGWkdo85+0/Jeonj3B+o2l0wanLywgyLFn4sZWqptzqWfqEasuFOISpsl58MDkF/6N
         deMBnSUDMa/cG+ireSYUJYhwSL+yTP0gYxLqZCA9hzaF9zUQno4sovM1IVWf0M17A1sf
         cdNmf16ywgrvJXhLDcqXAd0UMBt8PbfMUnpoFsIqkSv5TCtlCYbm8kabldFuF10xM/le
         tGQzz3nO5N+winCupgws6SdcT0j+PstuwO5MbraMbkGRBCwFqx4MJ0ZLsEvu1+3epBwh
         FeM1moM0Fc//NBVsB68BFOwHPUbX8tRth0ZHUScE2ZW2EwF7OdNjdcbdBuaa7L2qph5r
         nWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720527538; x=1721132338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZVrjmNGGBCCMCXFviIdtIer4Cn8tsfjub2doZVrX+Y=;
        b=ZZTxDO96/Ew4IPXPvegyNZ8jpZv/HDfbLFS9gr4co+stD7l2Lp/61pu17kVWPbbDce
         Vl9kfWRHxTokuP/QJdQ/k3LR3PmEQR42l7y1Cwh6wtFAefsNi+Ouh2CP+//+4f17rzCv
         LP/xEWd+OhHMgTKQqkMrCrbtQKam9aDziQ6D6ZGkAfTBXhz2vV+FCi5Qq01Sw245oFWT
         QA2De257n0sxituUab9HsdcrWE+uYqiQJLeyAW4B7yX7EUJbKyl7pNCXLZPqj7rBhOAQ
         5TfvRnDaXndz+OEV2QREd5nltXStX35QZai5qOXwgMGiFoIXNBQg7I1biDdsyHUVM4Kb
         ZBIg==
X-Gm-Message-State: AOJu0YzXkMwU28Vma+n5YLjk+mD+g2fiWrefizVFdtLXx2ZiDQNEFEAz
	pgtI83cmwHq/fytt57guO412IbTCWJjJcyBEHe2FurRcHbjF5YsjgJapOfkWUOsIYMhisx235/9
	s
X-Google-Smtp-Source: AGHT+IFOts3kO/kRl4Vg8ht7+BIzuGt0kiz+L5oGFHcPm8hSOHQB67arubWmmqViaIrpqwWbbETLmQ==
X-Received: by 2002:a2e:9658:0:b0:2ec:53ad:464 with SMTP id 38308e7fff4ca-2eeb3188da9mr16193051fa.34.1720527537713;
        Tue, 09 Jul 2024 05:18:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c270:70c:8581:7be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06d3sm2390574f8f.75.2024.07.09.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:18:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Jul 2024 14:18:35 +0200
Subject: [PATCH v3 4/6] Bluetooth: hci_qca: make pwrseq calls the default
 if available
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-hci_qca_refactor-v3-4-5f48ca001fed@linaro.org>
References: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
In-Reply-To: <20240709-hci_qca_refactor-v3-0-5f48ca001fed@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=V3NY7NBJypJyF2JMEhpTMoPCP5bbgAiNu2TzfuDFAg8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmjSqpcQ12F1TszzlZdwYLvTHfPdhTnAld6v4rc
 DN5tqUQ6YCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZo0qqQAKCRARpy6gFHHX
 ckyED/wIybH6hpkzZFKbl0q3vxvZ3VnoAs96R0N4WIPUgLuvx/hnB1ox3Wii3PAe7KHPbljb7DF
 EXZjpMXFidPcnIcBWNpET7MuTeX5Ul4tn5znNUOfpQje59H3grwUz2AdVzUGM7gkFCWOpR7Mawt
 2SpmA1O8GSJj/7O2489IYGnIHWaAqV4jomC/WwpLk3MJEZUT7HTw2d92OLGPSxud6E3LkhvaBfU
 8Z9pZoWQg6bp5uRXGwtCNZdUGenZAdwP/ulFsMIhFw2rlZFTg2858VDRHAomFrtzw1TBiwKUYet
 tJXXZYhGNrkoGpOndZ/2mhEYT8AsQC169TPdgrVFtM0QB8j+3JL2JACzTkbX78Hku5aSfhOSKCp
 9oy1vCKvXDKWI7EqnNjYQECgrHKrHFmzQQieggHGgimLZ/wBuUrkhrVz8DKV05e4iDjaH9aoq0B
 ullX1M/nvbJIudVKo9VhSFHqDjuefsmx+RK/mX49jvbCdMyw/BskVQXG5yh3EhSDEBbU5OasBWc
 qkVOGsYMyrxAARJuy09m6Dmh9+cEIDVf9AxVLZCzL9GXG7bx+9ajzkLSGo66t9gjGMfPKYw41J2
 PdFvKHLD4xEoz3T9j7vSj/C1qYlP9dM3A/qSKGOi7TaDvmfLrA+jVqidao14mqkzmwyUXo4S+Xn
 YePqrLq5XpCytVw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If the device has a power sequencing handle, use it first. Otherwise
fall back to whatever code already exists.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9d2b50c8fc93..49588072589e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1718,6 +1718,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 * off the voltage regulator.
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
+
 	if (!qcadev->bt_power->vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
@@ -1800,18 +1801,8 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		ret = qca_regulator_init(hu);
-		break;
-
 	case QCA_QCA6390:
-		qcadev = serdev_device_get_drvdata(hu->serdev);
-		ret = pwrseq_power_on(qcadev->bt_power->pwrseq);
-		if (ret)
-			return ret;
-
-		ret = qca_port_reopen(hu);
-		if (ret)
-			return ret;
+		ret = qca_regulator_init(hu);
 		break;
 
 	default:
@@ -2149,6 +2140,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	unsigned long flags;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	bool sw_ctrl_state;
+	struct qca_power *power;
 
 	/* From this point we go into power off state. But serial port is
 	 * still open, stop queueing the IBS data and flush all the buffered
@@ -2166,6 +2158,13 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
+	power = qcadev->bt_power;
+
+	if (power->pwrseq) {
+		pwrseq_power_off(power->pwrseq);
+		set_bit(QCA_BT_OFF, &qca->flags);
+		return;
+        }
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2227,6 +2226,9 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 	struct qca_power *power = qcadev->bt_power;
 	int ret;
 
+	if (power->pwrseq)
+		return pwrseq_power_on(power->pwrseq);
+
 	/* Already enabled */
 	if (power->vregs_on)
 		return 0;

-- 
2.43.0

