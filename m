Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB833B6C6
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513451; cv=none; b=IaB6SEPJyncYqQJiydIG/0EEU6P13GGXeo3svxjx6xHpnWJRjnWmv5Uzt9sBvvRByCwJOtG6N6oAT2Rx/HuiMGbH1eoBQgsy1RnWuQ7kkI4VOqwcWoQcpxgz5bgczBfF5INkPBnkOk1aXlH2pXDTpUFH7xESEvvBJ5BYkhDlcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513451; c=relaxed/simple;
	bh=YpsWlNFNBg/4Id9go1E+Clt5i5Gx+7170N3irG89ufc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNkcgk+drC4VLenD0uAcSoaVgRmJmw14hwvsSSMM8+xwnUGhY0hEUtZ4RdxRC7HHVIgHIhYOegR0i6aE6SaKy8zqRuUNx17Px0b0SrvxJZfLWSsgLAWeB+fQ3RoCJcJ6aJ8YrzZx25vd9W0LPsY8E9ExSks1f3x5a/Oh/eyLDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNN9z8T6; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNN9z8T6"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5a1490272bfso717935e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780513449; x=1781118249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0VMDCJ/VX3lt5554CvmCcoXieL4NIt7nQPGTtZji5A=;
        b=VNN9z8T69shM16765GpFw15cGLvJOgY+Sps4rPRHZQ+YhD3FQq6pvUmWlJdbDZZEUA
         wpa2qqJZn9lxp4eLFJV1Xa2kzVjJM0ZhgiBX63nmcuZnokaG5ssBe5eGjKlbZZ8aFH/W
         cmyve2G59zgKkjrPZvyDbX1VcicH/v3T6SmlCNjHb8wr588dkvbJX7Jk6c4PVjvb0SGM
         J/nmzysog86E6mvvhDDk/pkgv+qopU1dSIyQpvpxx7wbiQ67o5LjNv1vPt6g68jigzwJ
         HA7Su4aKak37dH5mMGXteez2qn5+xqqdWoqMReUpDU53vfTAhmt9xdyDgO+hWRQe19Sb
         lZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513449; x=1781118249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H0VMDCJ/VX3lt5554CvmCcoXieL4NIt7nQPGTtZji5A=;
        b=WnMr4O3mal3/aur3OEjtk0kAUZED+59Y/9g69AU1ck5YP8udGqqe1Tpu093r1y4rd6
         D4Us/GjrfS/Xx9H7ZaAD4pIAm38YTuT6Q6MPYWwkmiUv4wPrkTsFZt8neiyeRXJA5MNG
         Inb9RirebVoZE0jMk/UcYxdTZ6tEtziluKt3m79fUGSYimi96cz6dtMwKkTdf0c2G3XR
         htFxAbVx3EZ2ydXapa9vFEKmF38IMfelXxUXuiWEBVL07mt++DzY/bQylvK66o2OqIHo
         5U5uqlVFuyf+CPgT4QovvmOoJV6J886avoLtxabYHij04XDZqeWXe88Tolua4mmpXvMK
         B20A==
X-Gm-Message-State: AOJu0YzuDj8MF4Y2VdGo7SNX67PT3F4i9Oy/+QdcefNMSnDvXZbNDb/c
	B2YQmqJqtFIpVv8nuUHZLS0aJKHdO57e992J8MqQbBh9G6ZsrG9vdAH7xV0Aqy98
X-Gm-Gg: Acq92OGW0EXcg7ghavYB2lTcQCZGYcume9NOzHezGDUVTGx5xVFEREghpzqfFS35RAt
	qmMZuZul/lRduoz0oZjdXHrPbCtvg6abSTz3wsq1nLbcbjlgzI5Xp0kV8cuoJNwGPSovdLfyzcb
	y17YqgraOQXlcL/EW6+MPe8TtUEY1PA7xUyTr6vJ8OP4EVsakQ21C+UkBgJXRkRaNF4GqAT/QgI
	9yF3iMKOtDL3y8p9szHPAyqnlLpxxsIjVyTh2JSxltZg6QBu28lHSLP7GHbC9QYoqIF1b7Py64J
	VVQ3uwWpp33sTAue6cC98JKDYKdKR/OrrEBLh6MM5Ic8EpBCLxJA59iLeGXiYEbqtyv8DWLy/a3
	pYGDULR19uu/z2fBhZ/KlUKPSc+hqzL18D+nqwBDuuWIHi72xMDtAf+z70E96QxXwGBcMSu4bo3
	LrOnhdT8d/K1E9PtK0SDDkbtenVfKfECtlFO/wOxwUx4rNA7mQkHO/vxfjE/RCa/UGU6OKsM8WB
	FfNqMnSYjjMFSOJJ0bZ/fWJiwCymtO9qy6y4ng=
X-Received: by 2002:a05:6122:8110:b0:59e:cd12:24c0 with SMTP id 71dfb90a1353d-5a96f7cc00amr333025e0c.8.1780513449449;
        Wed, 03 Jun 2026 12:04:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d777996csm3181483e0c.7.2026.06.03.12.04.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:04:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] doc/bluetoothctl-mgmt: Update ltks command documentation
Date: Wed,  3 Jun 2026 15:03:58 -0400
Message-ID: <20260603190358.425835-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603190358.425835-1-luiz.dentz@gmail.com>
References: <20260603190358.425835-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the new options for the ltks command including address type,
key type, central flag, encryption size, EDIV, random number and key
value parameters.
---
 doc/bluetoothctl-mgmt.rst | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/doc/bluetoothctl-mgmt.rst b/doc/bluetoothctl-mgmt.rst
index 646c2dcb4365..da04f9c225b3 100644
--- a/doc/bluetoothctl-mgmt.rst
+++ b/doc/bluetoothctl-mgmt.rst
@@ -509,11 +509,24 @@ Load Link Keys
 ltks
 ----
 
-Load Long Term Keys
+Load Long Term Keys. Note that loading keys replaces all previously loaded
+keys, so loading a single entry invalidates all previously loaded keys.
 
-:Usage: **> ltks**
-:Example Load stored LE long term keys:
+:Usage: **> ltks [-a addr_type] [-t key_type] [-c central] [-e enc_size] [-d ediv] [-r rand] [-k key] [address]**
+:[-a addr_type]: Address type (1=LE Public, 2=LE Random). Default: 1 (LE Public)
+:[-t key_type]: Key type (0=Unauthenticated, 1=Authenticated). Default: 0 (Unauthenticated)
+:[-c central]: Central flag (0 or 1). Default: 0
+:[-e enc_size]: Encryption key size (7-16). Default: 0
+:[-d ediv]: Encrypted Diversifier (16-bit value). Default: 0x0000
+:[-r rand]: Random number (64-bit value). Default: 0x0000000000000000
+:[-k key]: 128-bit key as 32 hex characters. Default: all zeros
+:[address]: Bluetooth address of the peer device
+:Example Clear all long term keys:
 	| **> ltks**
+:Example Load an authenticated LTK for a specific device:
+	| **> ltks -t 1 -c 1 -e 16 -d 0x1234 -r 0xABCD -k 0123456789abcdef0123456789abcdef 00:11:22:33:44:55**
+:Example Load an LTK with LE Random address type:
+	| **> ltks -a 2 -t 0 -c 1 -e 16 -d 0 -r 0 -k 0123456789abcdef0123456789abcdef AA:BB:CC:DD:EE:FF**
 
 irks
 ----
-- 
2.54.0

