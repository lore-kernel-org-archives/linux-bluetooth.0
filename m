Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3836302165
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802001; cv=none; b=mP660JOXsvNg3QgWrj4LdyW2oFyHMpCYb3r01q0VX+66JHGP0gRfnteDfU3fQORkI88g7KK9PPKhHWzhM+/b37UIk/gpArhYvJPQfQ7f21GgEcLu15B4oJ/yFTEKpbOyPBJwOym+fgqUQeefQUr3RRiZCnGBNeN9I6a5MwBxrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802001; c=relaxed/simple;
	bh=TD+CuGcIvDaPimwKINOlRGTuQL15w3mnDjMjl0/s8nw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXd9L0n9Pf8Zmg4mvKzqdYQDwbAovmgICf+JOWxpDM/+4V7rEiY3H8h2lEFKRjyZ1RcQrWhReTPGvcWp4E889iNbiUPjxti9hZY90b3OAnoF05E8Ib66xFSR3qqGKtytpCUI9JBnlvFt2YelOKu7fnmJXOl2juRf7oMsnA7CZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g35BF0H9; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g35BF0H9"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56641b5a471so2098306e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801998; x=1770406798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhTVuwCX6gbfp2NtwUfGwE0PiEoOY84bpBrCc/ARsVU=;
        b=g35BF0H94TfMcX8zylBdx9qxXDKu01N8yg0xpacKXkmkjNaNdaqAt605hi6cZ8jmjz
         mamRaMkqbha08A829GMSGhssyggqbhtAj+xeT1kz7auhCv++7drjWzEGzOXrAWJ3JXGN
         UpWcofz/GFqRxRHWbY+ZgHnlzgvnWMKCDHOjr00HorbxGFhKGnfEMwZ/0JaDrKoy5ea1
         X+FiTVWKFTOJ+IEKNrLVOATbh+fb+WhQf1uaMSv9uJFj3cjOfgIgM/f1NiN8g0Sq5zAy
         BgDd8R6qPCSxc7gLPrPEDh+NdFh1N0/aGNkhNWzETJF2+2CEdC2nV5/qzeDVllEdg7lm
         wC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801998; x=1770406798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhTVuwCX6gbfp2NtwUfGwE0PiEoOY84bpBrCc/ARsVU=;
        b=ooX3Tk6HpVr6lvEJTPBRUnOG3WqU5vgIU9L5uVIfVCK6wzLZwGYzhZRX4/C0ahXj2P
         iKpZIuNEGD8f1b4AB/oQmcRvVhGzZi1dhNcMpwau6sVwggQi5EThQ3iIvd0vHp+AZoJc
         y+e+G8+qmLqtCSNUVgpailkQi+bhIV7uPJW40shDFMU1gqM4UpAQveErQB5sbcvd2aIj
         7BK9ZyuBVAPrumAplbbTs63sL1NsPFfXT7DiE5DTlT9E12nD5uS/HW5Fcafokhp7R63O
         xa+OjzK7YJ3n8CosI0sr6tSI/9RXbs8jKSZ/u96UIsYz/EgsUTnAEUXOoW/5P06SJOHM
         JYNQ==
X-Gm-Message-State: AOJu0Ywtx3ytaPLC/mmCp0KopHtGIo2WLMEXRZ3diZMvJKkyrZejINx2
	nFxo1CFXNUL4jq1WvMuqqFYhKP8s+Egzsq0Ww78S4yOsf3Lk0fK97FQZjJy5oA==
X-Gm-Gg: AZuq6aLgdoPhu7pubRJTFVyY6+1Kd6BxfdzsvshjWbOjrjAl/ftP33KTME6rUSMJi/h
	Dkef19M3PH9Ux+m4KytkJCSqUZzYgW2M+LBPGo6Ex63T6ACo5RaVuwVbfIIVT/UpcdqcB7Edc0q
	zf28i28nGheqUnSYEUeyNxFY8KHQIS++InF/VQqrY9aEShlc3kM/Awn+FbPLrV0nKymGGKB9hC9
	4sGXhuX6/lcdHAhBjGmOaKU1emEUliSRjLGTW/0mEiUR7lmfO8YWTSC/KdIjg191FW7lxPlOyeL
	DqUdTFonl1QoeMsFYYYOOLV5nE7djkYv7fxNVUy9ezHPewaAIarFYROLE+/eqaYnqy5eRP/XxAt
	P1JgO6JqWpRRj2D/Nn6n54anIw4rvTr4e3OPXawa9ih2digrOVCbqjw1OTWyvmd69l1Na9uFtNp
	POUEJBCst49wD2mZylakZlBQukBpRWrJS4/v5yJD8nC78R9EbGra29mG92ICeIfKf5Di709CJUH
	MjsgA==
X-Received: by 2002:a05:6122:221b:b0:563:6d01:a514 with SMTP id 71dfb90a1353d-566a0100735mr1522224e0c.17.1769801998552;
        Fri, 30 Jan 2026 11:39:58 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 29/35] doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:11 -0500
Message-ID: <20260130193921.1273263-30-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-advertise and Examples
sections showing corresponding bluetoothctl advertising commands.
---
 doc/org.bluez.LEAdvertisingManager.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.LEAdvertisingManager.rst b/doc/org.bluez.LEAdvertisingManager.rst
index 464a2e5fb726..c7f575f7991a 100644
--- a/doc/org.bluez.LEAdvertisingManager.rst
+++ b/doc/org.bluez.LEAdvertisingManager.rst
@@ -21,6 +21,7 @@ follow the API for LE Advertisement Data described above.
 :Service:	org.bluez
 :Interface:	org.bluez.LEAdvertisingManager1
 :Object path:	/org/bluez/{hci0,hci1,...}
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -52,6 +53,10 @@ Possible errors:
 	Indicates the maximum number of advertisement instances has been
 	reached.
 
+Examples:
+
+:bluetoothctl: > advertise <on/off/type>
+
 void UnregisterAdvertisement(object advertisement)
 ``````````````````````````````````````````````````
 
-- 
2.52.0

