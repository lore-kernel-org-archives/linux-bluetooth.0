Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702057;
	b=ODKXkDp81Z2ZABkceDXrNxGym+TxYB/kj0LDCsYGXIAoRdKjDRppEF6ULG5r3sHNmU8g
	 KE37ON4zM9hH/+q0HHKfeehtQ0lnds3g7jnEwK4ZjbyJBTj/1Fh91YZ4F6FgHe/37ZfQD
	 LAW9Z8nwUV/DSX7WNJfTSuX8GCwkEo7ik7SpJZGqj8P/9C2kv1gmdxa4arq4ce8Y3RjN6
	 PLPq/b+nJtGSQj5ZSAdK2wKI1QLPeBRsTH/pvdXFNJhcnSiG/Tvoitz4ZaADYaGyVDJN7
	 6Ps9+zqOrLkWJjWhBMYwVWq/BH3LwJ/Y1t5vG/1SRap11KvkK9rZk7L9UpWJLTrAOYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pH9/sCYOcncqpCcoeB54AhMetbhpo6QSkADAh3kN1rE=;
	b=hu6WWA/tdHICtgIpNaS/RySK52GNxNQ+k89LlFBuO8y8OtR2ZvXeQcdvX0D4ttmG0udI
	 VvfNOJ7HAQNPPGay/RRClB7mVB95GlbZbBMlPlxuFZh6hvsIDDrBTbQ1De+y+A6k7cWNC
	 x2Znvb2N9a4AT1+T0visLUrFvMoge/i6L+TyXM64KX6AjoVO1f2q1/P/YpNqigY0AxgUk
	 KC24Z69eyHfHgj7uog6T5WWc4eA91AD6A+RkszP9Ve+Y4GvzEvPz0ejx8krB0bC+2INhb
	 tECsAT91f89wxN7QJjEBYu+PoO0XtPJzpi6weJbUkutMefqI1W4KCt4zi8Yt+cdt3vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVjJkjmf;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560C6072BD2
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 10:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5560C6072BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVjJkjmf
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba328513b9so3754258e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702055; x=1794306855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pH9/sCYOcncqpCcoeB54AhMetbhpo6QSkADAh3kN1rE=;
        b=dVjJkjmfckn0xkYGr9D08aPnZHTdUkDJJlNwNbv2DGseYMYkUSZBk1LO6CtdWrO0s/
         csi4SHazGVyUD5wO0D05jSCqqOmaIdw2ih1q9GLjr5i3qt7fVAxlUi+LK/B54zsJgXON
         ee1gGBQDZZqSwot1JxLe/BhCO143mR4F7B0O/4JdJDnR3pUpAfAyrFrzUqXiiZp08V55
         qrNqtgz/yLLxXE5lkDQo0LCoYNYqFCHbk/VAxN8AWkI+9hDZrhXNkn4rqpqRcCkHYL9P
         g0BlW3eODpQp96QNgVAevJAfvIi8TVUBIKAE/d4rhWoOYCAv55aQMEz4Cx8jEXyb/4eX
         W+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702055; x=1794306855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pH9/sCYOcncqpCcoeB54AhMetbhpo6QSkADAh3kN1rE=;
        b=R7Fb8BFPpyf5/QAP2ACgB7euhp83kPv78gZj9u0P3UmgzBnKo5yTtm+FGLAfjmOZXT
         drbuCtw3rxts8Hkt26SNQBZA1Wb6bEtyhpQFIBtZtQdPFROTjs64rZ1n3jjQ+1z0ASkO
         GHvBDk9J/2KzWZRuWp+bkN4e6JMZK/YOy8juykbD9kEBI6R/0FNt0+gxuq2h9/PYYHSB
         bP6v41oXsGXS6jUxhkallJwKdcGelH9TlED8/dLsS73i/q2hEVokOs4p5K8zMM0dYGv/
         abJAQI9O/hrOk2qJ9mf2vXUuj49ZfwkcYYu6S4jMHTg9Coe5ox+QIDMPfganFtW05i2E
         yYkg==
X-Forwarded-Encrypted: i=1; AKwUvBwjhCF/QqK58M/yNaWT0XlyvZAJvN4fRCgv7fSp40KRSqhJJtgKRp8KgWn8XsUpfQigOWtx4xPABxIA8P/9o8w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dOU+Ja6e8Of9F8hgkG2OZmUObIy9MKHSkyvmSa0zpi7GJ4Fsr
	FGTrIGf3j6g6BpnoWwLUQHiwcrkvj7mA8cQDR/8XwYHBc1ehUDa4V0A2
X-Gm-Gg: AYBFou2kUKakm7/kw/6zUP6+f4L3CxSS+c3lD6u6NXUbJV/H+o1pBQLVomyBBJCq2dp
	q2tGZe8TZOBKsD6XpkBm9qzdazLVDrjQRH92StmGzClluHDSIx+J4WDmQfi+EZ0qUnfQ3ihNaEH
	BEQLyWIaAO8gEBXF4Vo4tHpdE2wKnIwXjISWUefJAxrLb5YazPpn3Nt5yjPX2+RcRb85TmNWjBI
	FKXQr/TludQhdhX9yH52vBUxLHp7dfrNUaiqox2dv6NcinKpyPrseS0KJcGsCXR7sF0AjoVXwLS
	U9gCIFq5cci7wsUWnv87a18BBu/ULxY9nmPwwqsx7tWL4YWsGlm73XK6zfpAu726AptW6EKfCnV
	B6nGrV4TePfosvIVDUZ/w7JuG+TTWSqCfwXmHyqrQ4uhqewgkq+L1qBwaRgRExsQ51bbbopwf1e
	N9BGvMmDFqkOM4CbRdFU3oDm5KtN5zCIg0NJ/MA455Sdlcghtz5GCS++WtEielFi72hOD2G5O/h
	Pf2n4xH0F37aU4Nd/A7JV1gVu30vsLWBFjI3aefRNZoyEGr40RMWADE0NLy9mi8G+JG40F+Z+8s
	l1CduChQgOh0y0C58Ot83qv0PA/9Cf6+hzrQqxtUMthlbLiOXL3Z5K5ofabRlE9aoI7uRS6BE6s
	kVw==
X-Received: by 2002:a05:6512:15a0:b0:5bf:b93d:a75a with SMTP id 2adb3069b0e04-5bfd957985dmr4108363e87.12.1793702055494;
        Tue, 03 Nov 2026 02:34:15 -0800 (PST)
Received: from valor-verifone.verifone.com (balticom-242-238.balticom.lv. [83.99.242.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04edd72sm2074917e87.1.2026.11.03.02.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:34:14 -0800 (PST)
From: Stanislavs Nilovs <valorcool@gmail.com>
To: brgl@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3950
Date: Tue,  3 Nov 2026 12:34:14 +0200
Message-ID: <20261103103414.803861-1-valorcool@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added WCN3950 module to the switch-case to disable SoC debug packets.

Fixes: 590deccf4c06 ("Bluetooth: hci_qca: Disable SoC debug logging for WCN3991")
Signed-off-by: Stanislavs Nilovs <valorcool@gmail.com>
---
 drivers/bluetooth/btqca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 002307000d3c..60735b70d89a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -943,6 +943,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	switch (soc_type) {
 	case QCA_QCA2066:
 	case QCA_QCA6390:
+	case QCA_WCN3950:
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
-- 
2.53.0

