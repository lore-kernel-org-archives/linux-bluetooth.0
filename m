Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C5381C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258331; cv=none; b=YLgH5WdytSmTVb3N8p47XhR4RQTwkmFZeDvCAv660bDScg9Mice6TwQ8Arfser2/M86U87ziQobNoCqcwaRTzz6rucm51m0I5FRf8e+p5kVQaaCxujNT21MH40G2TqNwgRxd8lIaR8uUmcEVhCmgJCcRp+YCcad8CqrX6d3O+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258331; c=relaxed/simple;
	bh=HfwFbWNaiNRg8TyHYnd3L0KeFcsIMwGZDXWebHcn3SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXuhq7RWI7pv3f+c+kMyQJM2D1tTbLV0dfu3EHt0uXe3nxauIvf9v3TNlWS8FqhX3irpSqOfvggQ/DcIBnyoCP50+0U2959QDsGrEy74TFL5JpDEOzo7ONzmz+Zry1AobzvT2I2FtiNLDTSNU+wIsCOFKQJjMwriIQXFBZ7b6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2ansTsJZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2ansTsJZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421d32fda86so52274845e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719258328; x=1719863128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHNCUGtS2GKKPWqaEddKMqmnF0GyncsWrVdaPJ8EJoM=;
        b=2ansTsJZAmrRCKMiVrPhX7rTZBtv5X8QCTIDSfpMdUzS1v5uFuO6xNAfrJaiRTmVnA
         HEhFaSN5ZcK9bkPi3MRoWYxB4I4m/+mkIdtr4aXMlFb+mJAjbgip+W7z0uFF48U1FFw7
         N7Hw57tPM4BvrjDkeLVXmDLYKjoHYOR8ApwQOM5W3bagejl4lammBj6gtqAItLyyRwHr
         7oiwNUuk69UY6QxkFuT8g5XEL1EGT7KSSJi25H43FEUZ2JqUNsd878qBMw8mCeCm5s7X
         p6mPOltCSWCzEerrT1oydGZjaUIhzvMuJ34U5MWwN8ztgcpSrMulGj14Z3k0IzDA8VE6
         jAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258328; x=1719863128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHNCUGtS2GKKPWqaEddKMqmnF0GyncsWrVdaPJ8EJoM=;
        b=OSsAEOGTE18+3s2EUNmB0UuVn2b3DgMqawLxWn5Rt59SoRuiLIz10faxbEBZu/xWi9
         P7skf7AXd7WUiIN6uv8tux5KfBO9M3aQzyK3ncAON/sPDmHEYIfRrZaL2VtrmkoKAXHU
         WyxZKm6gDvzKP+gjHWlcYaxi8DoqrPuECqFwgSokCWAk/Vy+HcStRy6Imfovb5yo5Fa7
         WYJTrP4P6wxynT601r7+qcDxW/m0oEXNdQ4VNbmb24TLHfpm0Jv0NjxgAnMxPL3IYq0o
         bg4ei+SogEiAkDW/PgY0qFhKBzPxBM38kKzMqs/6KBWoV2pZWJAsEBkH+YhFTZdw4jQ1
         EyTQ==
X-Gm-Message-State: AOJu0Yw86MLYDcBUq92ZBgiT1QDT6AKsO0KYJd/MauC8b2+BdNFX3WS4
	aOZ84Znr5296xBpE2rvBMnOYq3dR+JnKm2P4g1X5cGnFWHWIvrVl0fqFsYbwyZU=
X-Google-Smtp-Source: AGHT+IHHn6x1AxgTsnp5UO9F48QMyqsVVY2g6fOphzXTLGr96mHa6mvLaKWJAyIwfqC6JKPXW8LTFA==
X-Received: by 2002:a05:600c:791:b0:422:683b:df31 with SMTP id 5b1f17b1804b1-4248cc1792emr46281025e9.7.1719258328100;
        Mon, 24 Jun 2024 12:45:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b80e:a46a:7fb3:4e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42480bcab9bsm154626745e9.11.2024.06.24.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:45:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
Date: Mon, 24 Jun 2024 21:45:18 +0200
Message-ID: <20240624194518.37458-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We unnecessarily fallthrough the case for QCA6390 when initializing the
device and hit the condition where - due to the lack of the enable-gpio
- we disable power management despite using the power sequencer. We don't
need to look for clocks on this model so it makes more sense to just
register the hci device and break the switch.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2b31f3dc33a9..bc6a49ba26f9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2402,7 +2402,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 							   "bluetooth");
 		if (IS_ERR(qcadev->bt_power->pwrseq))
 			return PTR_ERR(qcadev->bt_power->pwrseq);
-		fallthrough;
+
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err) {
+			BT_ERR("qca6390 serdev registration failed");
+			return err;
+		}
+		break;
 
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
-- 
2.43.0

