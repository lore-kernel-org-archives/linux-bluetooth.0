Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815851F4624
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332076; cv=none; b=Ck7/Sqgrn8cL/0FEeb3Xc/ASc8Ad5P+7JKbz6hGB1Fy1AorpEFiJcGcKbaiE4ez6NNPWgr/LQg2eE8qhxhdcQAAMFdkcbrFsNv0qJLJ9oRS4FQ49zRSgjCrFwgtwC6ty6m+HEY08URUCmomfaiNVkBjA/QWQ4FRVat/yGMROrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332076; c=relaxed/simple;
	bh=8inumT2GzLnLF6ATSYii0P0+BsCxZazCz1tzjBacIdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUyYuJjo7FvdpUVhbSAIOtnR0cicSOccCZXs5mJB9LAto/kfklMBGEedwmJC/02fYi95dRg07uBlux6eg9ML7WVc+Edsd81nY8IveSVY8QEHRh4B7/qJ1o7LAEaxfoxoR6d7jmJ93QbHwf0DP+UIphiOQOpw5gkaKUVRhEdUIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IGdmhQuU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IGdmhQuU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375e72473so1888538f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1748332072; x=1748936872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRignQG26Y8syh2NX5Cw/ROaM7UDkzL0aqEqvQ0ZPb4=;
        b=IGdmhQuUqWtqr8aJZUEWGsmzNHT9qC1OPRehOW9dHxHGGppc+/J+5TxIsDj6tdf19o
         7WhMFIfa3iLLoP2DHgRdnu/y1x5PveV6c5p/r6aUSVJ4kaX1JqsQQBRCRkG/5nc068SS
         7B36Xt6Qcz+xUQDgQSH5ghfeO4l4RnlDwHYDkiDmg6hehX3iAwlK8Qpq65uTmcNbv+rj
         dro/UOwpHcVRm5iFU1qHnHyhGZZFOpvId58DUR10ypkNkZ339JEWYN5hXsCxUYiElm/g
         gbFFvDAPVdT3y1RHFql2O94XKMdwnI5dMykCWlvMxn2H4k3DlAEPHDDOFBYERRtisO0d
         VBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332072; x=1748936872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRignQG26Y8syh2NX5Cw/ROaM7UDkzL0aqEqvQ0ZPb4=;
        b=uMYI/OY2OIWk77dC/XTT9pgvwJEhfGRkxl6YNJ74PEnsnhvvwOlnK//L2zsHoZDlzk
         qCkKSHkc9if7eQhTnE3QGlSKOvlB1EFKHL9xbsCTT2FE6EVD+o4ro32GUuEsTAeXVL9g
         5QM2uF+cOj7il7EPHGhedbEWWl1pvfDypTfxwLjw5SDzq3dWma90HpvQtvdsNyzuMzZY
         tyng1zkxo8Uz1GWw94lv4gxwTkpgQGwAZAkYRS1lx6EnFM5xMCIpme6ZFs15sElZRDHB
         k5TO9fmIh8tcp3Izr5vwqu1xonWEgqSuvTyBcnLcYbjpJ1reSjiV0c+xnmsznuwJMAwR
         EsOw==
X-Forwarded-Encrypted: i=1; AJvYcCUTYj0rTcV3CW50FVFio73D3T+XqSimPjWJBwZ6Q7renRdky4HAKpXS3hVlq59dID5ww7XHnsqWrcMdKn8EOAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHzMbL0WVIbZpEbDxn11e35fKOe6bWuBubdIOgVSpQuolFUtb
	Vxd8p6oaSAWbKDg6x5lGt6c0VObQH2xG0b+XtdCMSZR+kiV5eXBxCRcXENiTYWGvpjA=
X-Gm-Gg: ASbGnctv3CFlTGGFhrcCuNhbXiHpzGND/T+7xtytnfn3h9mPHmH1Ddu3N1BIUaDE+m3
	06Fwi1xUKMBgctxiRT5N16n1SWeuOt8eD8IFPnfow4ErgJqdkNdTpwtgUoLphy1XHXxQpXHy59x
	X3k70VMBXNmoHL0ufvVHiUKZzBFGqnkxffM9BHqlVzCnuvJvGPXpO2QP2JLLytq2zFQ1XA08svp
	OnujuEW+K66JkFkdkG7uMLfmRK9n+8kSRSkaE6VofZJSLfqHYjPrQIyPcnWeX3+wgwTVnTahOAQ
	4Z2FTljCTONliCZ34WDHqTlQXdrDXd5T+TZBxf1ZGCXZOWlabxs=
X-Google-Smtp-Source: AGHT+IGsoZw2nAtnHF/LZfbLWN76/RtG8pfqU0DqC0oaErakHj1u3x87Kp6fGEtqLxyX4EMwo4KKWw==
X-Received: by 2002:a05:6000:188f:b0:3a3:6f1a:b8f9 with SMTP id ffacd0b85a97d-3a4cb443a5bmr8364347f8f.15.1748332071512;
        Tue, 27 May 2025 00:47:51 -0700 (PDT)
Received: from brgl-build.home ([2a01:cb1d:dc:7e00:a230:a0af:b6be:8a46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f3ce483bsm257422165e9.33.2025.05.27.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 00:47:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Hsin-chen Chuang <chharry@google.com>,
	Balakrishna Godavarthi <bgodavar@qti.qualcomm.com>,
	Jiating Wang <jiatingw@qti.qualcomm.com>,
	Vincent Chuang <vincentch@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: move the SoC type check to the right place
Date: Tue, 27 May 2025 09:47:37 +0200
Message-ID: <20250527074737.21641-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit 3d05fc82237a ("Bluetooth: qca: set power_ctrl_enabled on NULL
returned by gpiod_get_optional()") accidentally changed the prevous
behavior where power control would be disabled without the BT_EN GPIO
only on QCA_WCN6750 and QCA_WCN6855 while also getting the error check
wrong. We should treat every IS_ERR() return value from
devm_gpiod_get_optional() as a reason to bail-out while we should only
set power_ctrl_enabled to false on the two models mentioned above. While
at it: use dev_err_probe() to save a LOC.

Cc: stable@vger.kernel.org
Fixes: 3d05fc82237a ("Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e00590ba24fdb..a2dc39c005f4f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2415,14 +2415,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR(qcadev->bt_en) &&
-		    (data->soc_type == QCA_WCN6750 ||
-		     data->soc_type == QCA_WCN6855)) {
-			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			return PTR_ERR(qcadev->bt_en);
-		}
+		if (IS_ERR(qcadev->bt_en))
+			return dev_err_probe(&serdev->dev,
+					     PTR_ERR(qcadev->bt_en),
+					     "failed to acquire BT_EN gpio\n");
 
-		if (!qcadev->bt_en)
+		if (!qcadev->bt_en &&
+		    (data->soc_type == QCA_WCN6750 ||
+		     data->soc_type == QCA_WCN6855))
 			power_ctrl_enabled = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
-- 
2.48.1

