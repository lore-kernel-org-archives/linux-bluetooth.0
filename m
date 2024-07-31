Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D9168B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439267; cv=none; b=LIKlfvanayvkn+BUXMhsX+dZllNXgRkMGhZSrkxOECIz/89qD7LWPQkvVdVz5ZJTJ+0axAV67OBnYNrnVgkx3RNn4d0NzT8ZnyoSvsuEpK+7QUAVys/5gU2IpZKu9x7qnK+5g0owOsTF1JTfXPk2P9CqA8q2hv1JSHUf4gMGvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439267; c=relaxed/simple;
	bh=+SbEPfgpH/hFpT3PraiDHygVL8HF/LfftQ6Q2/alDBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=txh10MaTzYzJjM0ZSwZ05+JhiNiFtuoXE6RzM5q9WVLDedqZIA1L5xjfxPmX0gPeFnTnYpVcC6AbAWevG7/ZfAqoMZJPVH+9lXhxZN/goKoSVCQfdi/DlvLaXNOxW2CLFkekFHUzCZ1H7gNAML+NkQcHLvJDLwKkgp4EZGI6nbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pjHYquub; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pjHYquub"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso75517181fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722439261; x=1723044061; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCiWYkROgI93lDUlu4n/pJ2oJ0YJVxVSXcd616C/MpE=;
        b=pjHYquubKRl3L86ysoDJEzOsGOVdRJT8ADRT2JrB23OvcOJ/jlHVW40mAm1rsUtnam
         CoyS5i6/q5APK+nbB4B1nrW7QxD/h3fGcug5EGDeZ5QwRyW7st4YP7x6bkcc18VJHq2P
         tOVf3cUtbbCIVqNehCZZsjjgyq8MzYOJ7v6N1E6N5r0gnSAv0cacskg65t2TaRu67mzt
         0nAB0e96HVOqeghifkgPfpHmdO+vL6b7v/sNmZI9yCMF1p/l6eaERK+0x6dlKO8TrDBk
         o7tWScWHDdsEjV4WhI/iBvQr1rO1AeEIKp4K/qEL+CnE+HTfIygYN59bqwGHxjnpdmKC
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439261; x=1723044061;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCiWYkROgI93lDUlu4n/pJ2oJ0YJVxVSXcd616C/MpE=;
        b=gqBAb2V4TKYuS7Iy5JAIh5wYYC3QQxpbIlBcTYjnlpXZ22SKHew68QiSIO34uc/9ij
         JBmpnNHa1Mrfg7iYAbtPe0oYllieGV+g6Fi8Rse0BN4l2sQmNweW9xkloKdJzqHVtWiv
         1A5+d07/Xi7MKBqoRFh2sJzAfRByHDBZ9Ai7derCWtJN+bsguURroNcvVWW2aUmosT7L
         QMCmnx9VtTpO1ofSe45TpDZcHsHrS87C1Gk+RcuMopF9wZo0Qnmhv72WGCScCtI1oWcW
         djxSbe+CaMVWyUOIFZgI4C5vbMPgNKcdJWPoFJB5szwmExJnbFOQoUnQfLCSznzVCcnz
         HXCg==
X-Forwarded-Encrypted: i=1; AJvYcCWsQsxPJhdBKYUIsqOz9xH41uXTNydW25Z+JXs9ACjjhfJyhnd+A9Lv7cAZQXwpAuMVIuS5oauoV3CxtthFHuybqGZdbAFlKY7puAwoCr35
X-Gm-Message-State: AOJu0YzEdzX5l0iH6So7jeD0MhzTK8NrxHBffCg2i5sdpeNztunw9Cql
	RgVGIQz7vDCZ5cV8aAPoHWBje5k342gUk8yjd74mJWUx/S3nf8K+xoY7ZPe5OGI=
X-Google-Smtp-Source: AGHT+IG7CJt6t5qJCHyGKp/mo0NxzGfDkWvMcEe7uZh6E+y4pDooAoq7eQ5eZ+XU3qjbqC+bGpxAvg==
X-Received: by 2002:a2e:b059:0:b0:2ef:2685:177d with SMTP id 38308e7fff4ca-2f12ecd5249mr94676691fa.20.1722439261120;
        Wed, 31 Jul 2024 08:21:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8addd6sm24752925e9.20.2024.07.31.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:21:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
Date: Wed, 31 Jul 2024 17:20:47 +0200
Message-Id: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9WqmYC/x3LTQqAIBBA4avIrBP8CZSuEiGiU87GSiEC8e5Jy
 4/Ha1CxEFZYWIOCD1U684CcGITk84Gc4jAooWZhtOQpkLuDdzu9WLlF4y1G7aPVMJ6r4B/Gsm6
 9f49zeyVfAAAA
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Wren Turkal <wt@penguintechs.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=796;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+SbEPfgpH/hFpT3PraiDHygVL8HF/LfftQ6Q2/alDBI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqlZXE4Md+7XSIQbpcxIMM18fw5OanFFl7W4Tu
 1Ja4wiNyteJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqpWVwAKCRARpy6gFHHX
 csM3EAC7cQyjytCwjdWldEJKGVoDSHCh78bW0xAi4x69G03mNNhTXSljpnkfoCK5KUIuGEc4WKM
 ZJm5OaAssDLTyT7HhoEll/HqTLFbNk+Hkhrx5iTfVMIuOQAQqxNYbbtZE2JcASImLgvuoOXkzA2
 FwPJsDUBlw0ekxOgjiTlk7j2ZVI2fOdxHgBt5IfuphGOiPJoVHSraxwBs0j2cjqOL6A9sk6navq
 uN4++kvBJ0+1DwQvovnfI3YykF3tGGp9hl1OAY4En2RZxfXUxUlLfgzyBSjEYHnlUbxLTlBzztq
 NkuQ8BIA4m9udC0IHADa1meXRQN1OWFVEjV4cxGAEMGQiDo78m4K1svlSz0CD42POLon43SEUql
 E/54JvHDpCQHQOMxg0O5XZ7KJAK5MtfmrEQmXOk95JLabA0bKd7W0Ns6OcNY/Bkr/kvuuKNC7Ks
 hDqSEd2VMevjHDb55ZtvfZeOniMczJGQR5wrprYi7jmfwVhsWIrKB5HDOvW62MDLT8eTNNxfcUT
 4I3Vj31Yd9lItxLAnn3aiStZZqlE+rR/q3rHp0A4XKZMveAKEXpX2kEPJDfQ+NsNqeJuOaV3T2y
 9qc9+pmdMfHxzR81tXhE6lXli6fkUKP+MAoVOjnIQbXgVEWvgg3t5o4cP193K45ev/sBXAmhdkx
 /BSCgVyhvXdJtYQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here are the fixes for regressions reported by Wren and Dmitry. I could
reproduce the crash on db820c and so I was able to test it but patch 2/3
could use a Tested-by from Wren on QCA6390.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
      Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
      Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown

 drivers/bluetooth/hci_qca.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)
---
base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
change-id: 20240731-hci_qca_fixes-8e7a8ed3ad83

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

