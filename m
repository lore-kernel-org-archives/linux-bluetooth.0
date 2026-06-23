Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248B3D525B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215421; cv=none; b=aF2tpJg7pJv+ujz2oxStDTB8xf4keh0e6wSYMJX1EQKcI/J+U5D54Sj7fWsZ01radp+fKjljvCCrQW/TFW/Zy83rq75iu4JGvBNk79qQ9g9hGewLVp3ed57PuZn4KqKrianzzyp/9l0EJYwjZf+QTPlo+vBnUMufefOcDwyFflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215421; c=relaxed/simple;
	bh=oI0KuffAA+8x15OOEZoPj6tKHW2NuHFMUq7CH+SGxoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ww3I2KafvTNiyzIkOZ9zwUG9F5ASGwmNpgi95SCESL5RL06F0jageKBrqu/ox4aHyCSQtW0B1QzmQxRzWNBuQ/pdjCYIddWxYaH9YWZBJSPoRnjKdSohTb/QBiCc/eWlwX++cZj8NOmBBIjGemo5K3wPknCx9ABEqHKEG0Pb0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1PgRUCg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1PgRUCg"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bed19623d6eso790640866b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782215418; x=1782820218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zwRgFZ4zvNpw9/glOYY5J1sB2MWzBUbSkl5SBwRQXk=;
        b=b1PgRUCgvJLnknofeA0iIbEeMYL9ArhjsEM9Ax/r3bcwKiRSlpEKRY9n/3XvxjU9wl
         N4fy8YjQPX/zWGR0y8IQ0bdtbWx9FDsQYqiX8VrW9HELoFT+TPbgMCP+g1L//Cd8k/gj
         Ev1LA3MZBg8lXvZCiPuM5Tn6XyIIAr9xNn9B5idUcsW1gCvleFMQ4aml/XtbDic4EKUj
         O7Uvz75NQ/JU6Oec/ctTw5mrBixcq+1RNdUBnZv5X/4Fw2ROCLO2kCEiFrPqOltlRwQb
         /3fmDreqF11JCRP+VGFhLoUB0RgrMxrEUccXVZgwgoOmRp2/sEeaJf0I7tCmxkWtZek1
         0P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215418; x=1782820218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zwRgFZ4zvNpw9/glOYY5J1sB2MWzBUbSkl5SBwRQXk=;
        b=aoir51TERC6A2FLavJCKEsYZWUzlDTZMAcTpQTL7jDFD41TeeylB3c/eeItAhdA1fm
         T2eZ/mFV1RxKOC8YtFFjLaodgkVoiUBIOoFwqcScfDNBUn+5ht++KgYxzkqLPwokRu7A
         yqtXinjuoo/kMccn9pcpc7oaqFGj8sUKMdaYDuJLMp5NLdr687uORlae8Qq9yVUqmjRr
         IYOObLIKBzdbY8E3oEzAf61xMG0xy1jGOXInN41aHNhAywFDgHP1lPq0u9Q6d0I1RBoa
         7HVOJqSXAG4I/DB1ShTLO0sysTbRvDludq84TH4d/ANrQyWqwPRDklyL+6SlD7/5sCaS
         o9bQ==
X-Gm-Message-State: AOJu0YyUdQIk7gpoAJ6rnX4VW4340Z2Onf85lyoBU4MUU7eIxBs2AR+3
	P7xNel+ApvkEj6E6dKeN04DrO/c3IdS09/ryXzE/MwGIPgdGNxb23MNY50QZ71RJdaKp60TV
X-Gm-Gg: AfdE7clplKQy4rvpQZSpOnF4xxRshOIB+RoJrPaCUxs9oTT3m8uSnyESYVTnijvSDwA
	dJgau8mScS1gQgEp+GMRvkg6AG14KjgL3C8X3heRrdTYFLSaH38hG9LVdf0NNKVzeTNeZBgqmd7
	3o9CO2kTDs78YHxfPq45yfNXvApB4Om8rzQcGu7ok3Jh5xcoYAgzwCiA9OsQeyfXUEQZjnyxy+8
	UBc/yz3L+/CX0viPzYIQioLtUH31RmPV6oY0EUXQIYrILXwvkUNnEdjxIFfTr1tTRYUO/HSWQ7c
	dzDmq11P/u1T7v5QkTjwK3fTRepIFQv7jQMEynR9mFZg8sUJHpgYu3kmvDhxAm10TG6/jE/3mo2
	GC4ySRyciC8IbhLoH2Z9UIaln9Ebvz7RE8ecfGyWFKFSk3zCpiJGTQ7GhquLnNS3Rp4uAQGfkSn
	yBRd9dEoi0sTkYARQ=
X-Received: by 2002:a17:907:a394:b0:c10:1041:65a4 with SMTP id a640c23a62f3a-c1080b8e977mr126431266b.42.1782215417780;
        Tue, 23 Jun 2026 04:50:17 -0700 (PDT)
Received: from KonecFunkcii ([121.127.33.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c61610bacsm514808766b.58.2026.06.23.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:50:17 -0700 (PDT)
From: monesss315 <monesss315@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Gustavo Evgucci <monesss315@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add IMC Networks MT7922 device 0x13d3:0x3625
Date: Tue, 23 Jun 2026 14:49:37 +0300
Message-ID: <20260623114937.6385-1-monesss315@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Evgucci <monesss315@gmail.com>

The IMC Networks MT7922 Bluetooth adapter with USB ID 13d3:3625 is not
recognized as a MediaTek device because it is missing from the btusb
device ID table. As a result, btmtk firmware loading is never triggered
and the HCI reset command times out with -ETIMEDOUT.

Add the device with BTUSB_MEDIATEK | BTUSB_WIDEBAND_SPEECH flags,
consistent with the neighboring 13d3:3627, 13d3:3628 and 13d3:3630
entries which use the same chip.

Tested on: MediaTek MT7922 (Wi-Fi 6E combo card, IMC Networks BT USB
interface), kernel 7.0.11-arch1-1.

Signed-off-by: Gustavo Evgucci <monesss315@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -755,6 +755,8 @@ static const struct usb_device_id btusb_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3613), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3625), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3627), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3628), .driver_info = BTUSB_MEDIATEK |
-- 
2.x.x
