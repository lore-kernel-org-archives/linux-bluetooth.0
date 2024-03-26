Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C26CDD9
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470408; cv=none; b=UvSv+wmMoGBHy+9NRrBlhOxQnD/4PH588T/mcGkAubWI4ktMA9062ZGnM2Rnrymav2BPbE6wGNXZW4ccpoBoJOKvsRNawMmp2J7Hrp5bS6i3Y0XmVSf9EEfI9rmYnz3v83H5j8BMZMrBLFyRCF2KKLHAHIV36Oeqq3WkoHCrzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470408; c=relaxed/simple;
	bh=webspxOA/u6u3QNP3nqrQpRn8ISwU7Z91ZYFrkfXyvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZRTta1NYu8U2sQjEQ9rkA5NjiMYizmG0HC/xuC77enVzPicVFiyuoVUeUUwO+tQdKL3wyvaLj8E37AKVDaeiDJyahRwUcpSkmMH31EafA7KCllUXUy+qMgDO2Joc9kJLlFDkgsVeh35ID6T+wOI4bCnZCMji3uxPp3xc2NwkSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8RPlA2+; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8RPlA2+"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e101b8fed9so979858241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711470405; x=1712075205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEAF3A8m05rv0jBI1u3aH9jwFP4DdhRk4k2kk5uVb80=;
        b=F8RPlA2+TIT0j1jDlcUjv96dNSboKb6K/eHTEd4YC68/Y/Lzi9ui8rQuJ0BAux2BXj
         GpgaPk0QZtKzhDiktyQ/cDvjL5nbO2GSEUkD7oZc0SaVG0tmlYJypxlSgjV7WO/FxaSc
         2y+hBLnMBQTIqI6pi/fRusR03qkR5Z+YO2TbydQBC9jSTGJTWPUXneRwoWCt2+buCu28
         eXL5e2nkuxn82hl6nfOZ3KuHooICizGNyqXJI0ArbA5lHHLERG+Hk9Q6zTjYQ5jkhMvE
         30x6cq97uyYFvne18KJAwDxJSaBI32HVoAFMSINfNKYdSOFYTydlCRjrk9x9zJfs4NAt
         ZVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470405; x=1712075205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEAF3A8m05rv0jBI1u3aH9jwFP4DdhRk4k2kk5uVb80=;
        b=BZHxIwk5r5MfQ8abBAwa4avgdZAz0tFe99lqhsid/398wAzLpdEorEBoErq3pEupFl
         2Q0ncSsg6A42DzKBVEC7LNEoam50nDd8JTjo0QNAo3dacomdRX8eOV/zRZp8FSIpz7kc
         RVaK29ygxOmXFvwzVremxaSMkCz1ipvKdbCR05BPtiNbX57D8P5DJ+/0x3PhEyulYLCt
         lkPWw5qEZLcNdvh5vn/+6Vx8iL8UTpqpwUQn2omvaXTJa14UPkEAfE6JA80N5ZtDhLSw
         KuX0/a8+CPGeWYjhAx7M/IpEn+mu4vMv8+5pR8zJAx6ZN+vxizr72Qm4YX67pBCit0Wr
         rEoQ==
X-Gm-Message-State: AOJu0Yx/a1zF0fNotdDt/AJuw0hD9eFntu/Noc/WU/qu+CGVFS0wNJsm
	YGZ/uhfE5eNA/P75+8mig6O6Y4TzJu7kNX29aa9/2X5YwQOznUqUezF5C7JB
X-Google-Smtp-Source: AGHT+IG8J1/UWz9zSgHezIVKoMObl1KUK/i+fBs4RzLXn5ne7+kKlx6m+IVLUgfW5ymAHpt20p3G/Q==
X-Received: by 2002:a67:c410:0:b0:476:de63:c6de with SMTP id c16-20020a67c410000000b00476de63c6demr1872945vsk.24.1711470404198;
        Tue, 26 Mar 2024 09:26:44 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id r25-20020a67ea59000000b0046d2de55f2csm1321497vso.15.2024.03.26.09.26.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:26:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
Date: Tue, 26 Mar 2024 12:26:42 -0400
Message-ID: <20240326162642.1459442-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Consider certain values (0x00) as unset and load proper default if
an application has not set them properly.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c8793e57f4b5..d24148ea883c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1451,8 +1451,8 @@ static bool check_ucast_qos(struct bt_iso_qos *qos)
 
 static bool check_bcast_qos(struct bt_iso_qos *qos)
 {
-	if (qos->bcast.sync_factor == 0x00)
-		return false;
+	if (!qos->bcast.sync_factor)
+		qos->bcast.sync_factor = 0x01;
 
 	if (qos->bcast.packing > 0x01)
 		return false;
@@ -1475,6 +1475,9 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 	if (qos->bcast.skip > 0x01f3)
 		return false;
 
+	if (!qos->bcast.sync_timeout)
+		qos->bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+
 	if (qos->bcast.sync_timeout < 0x000a || qos->bcast.sync_timeout > 0x4000)
 		return false;
 
@@ -1484,6 +1487,9 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 	if (qos->bcast.mse > 0x1f)
 		return false;
 
+	if (!qos->bcast.timeout)
+		qos->bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+
 	if (qos->bcast.timeout < 0x000a || qos->bcast.timeout > 0x4000)
 		return false;
 
-- 
2.43.0

