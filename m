Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527115;
	b=QOX9kIecc4vz2k6XGu+N0rk1hbaZ3uohJ/O2UMt3hJVUXb9tV5LoRufS4fG6oBcZfOHo
	 j/Rxi32DACFZMmM1JsdU4C7F33J2KivXgFc4pygTmk7BBC36YvYhsJoEHewaYuITdN/qv
	 nkvuhog3+CvZKo7lSGUz1zA93nko2G6VqYkPG55NMQdTDAW6IPA23NhwCOyQU/EhBUTpV
	 F6goUkfkhEg3VWS2UmlS4ws3GiNM0d8gzlnIbg6n/IQF3LumcOZTPXaDWEo01xJptu/E+
	 KJSTM7dxnHdm7gmLxp1vlJHBjCRHiuXsl4I6cXl2vJZBDFLW5LwKM//oo9vXwSQcGBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sRmFPcUPUdqrcbC1ZXCGrGKNgcf62X2sZJFNcGCiyZc=;
	b=Td7XmGYG+mYVXR8CVX0aoIXb0VTzyIfd+E9GbnmIRMN+Bok21ruLxi6LH6nQ195IIvdM
	 Cayylia0qNr3v8Sx3Wz84+F+EYhgSFheD0y18QOGc+vEHEAZCal4AOI/mmX0Lh0YdIjhY
	 yqKUz51g1U4IOY7bDr56Z7aTa3yBVkdoVqp/OYMQyh2lWRio1EFTyPc0Tu61i3GyF2Cx/
	 0O2KfROFgPnKR+q8toAgg1PbM+wdgYb7vr/CAJ9arqoGKBtezCqem/EnTF14ZDYi6Ey3o
	 OI/So0gBq+KL/pG15Gd4BJ9yjDDBx7HCUpfFq2t9H6dWvaJS2xWKqsrKx150uoDdYEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=1BKkU2V+;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B0606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87B0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=1BKkU2V+
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so41239555e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795527113; x=1796131913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sRmFPcUPUdqrcbC1ZXCGrGKNgcf62X2sZJFNcGCiyZc=;
        b=1BKkU2V+f82O4IRslyIKp16TPBeefkmE+f/SgAZeBWPYpQ1tCehgnn1cGiL0R6AUwg
         96poU9sdk9wNX+dCkO7KFu3A+LYNL/oci5pMjzli9kkrLsNq7WRVygQ8qOMFnHDhN0so
         0CxcFFcVJTIbPE0kzc6iFbn47nNJm7oCZSQd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527113; x=1796131913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRmFPcUPUdqrcbC1ZXCGrGKNgcf62X2sZJFNcGCiyZc=;
        b=m1CMk6NN8U61gp8k3VG+kuKhhndLR1pimgxfIpD7TvTobMSzPse+TdEvZRFDEZhi5w
         uzsb6zjg3b1nOvhwtn4guKDpUQe21Ev1bLiAbFgL/dj6HW/xq0a8UVcrpa5lI15J0p0g
         WTMSlGUywHFDpIXx1E2HkNGZt2DqGfZNF5uIS/MoA8ubkiOHa5sJbBmI1oCh5m986xZ3
         tGTO09+iR2bQrRpyVR+2PACox+bynM/GBY7vAALtjHGi0eSJRmYmyeyulJEbXZzchdkY
         xf/91A5UGrK8J7Hf+YzCTwA3tme0H4LHLkuSHJiOgE2+ZSuCAD5bCz+u9q17FCn2WxYv
         ujbA==
X-Gm-Message-State: APuU4Z/iEmeuXh/o4et8Zyv8wTr8mX6dCHGQqibQtvdeoC52B5p+Vz51
	Ednnq8xyovYRfdbPxz4yOLLlhsBMdoq3Mlj51Ravec+1Z2BQegbMnnIPN3uGPctCXTgD0TmdWJf
	JgBDy
X-Gm-Gg: AZFdTZcD/VPCF3H0elEltRbRHID4bxTP7sK9+oC8QS+cEw7JbN0+7GjNPWaiHh03o79
	AlKb6mqY/vnbwbMGTzB75SlqYP/QrlNfreHBf2mOwuVO8gj+WYM+1pp8KlBxtXkX3yfVsVHhF4G
	YXE3GieI2MJCGXCWbTY20LPnIXcihuudnp0GUJmrG/OC0Erzo1aBE7Ge/4H0ndGnJ4CopkqWjFb
	qaQRXLHc64hKz2q2qm5RUvsztorRRi1xuttf3tHeCFegtvA4CyXAJFTWAXkWFBGg5t1aIVSQlaF
	phiZGQISjJ0UwOsG8YkRZDfKL2rwkgi5hsucd0lsdHaMnM5hLIwEVvket6eV88eG7C+6SeIpimU
	Y7dAweifOOfLUtnuRYQluaWH0Iw7a5UBTMJt5UwtlJrAYAkK0MVxJ2CKV+ougRT3sBPlwOVWd9R
	qtAPsEcBAsSXBK6nT1ogclg9RApTBCFsQQ1tXQT3Frj99LKQdpmf0kEuuj/whC88kTOsTAqTXXX
	/z76RMkdkOlzsXe48I5qMoyRv0qIy3YtZCLW+0ws9bRoCjE7Hc1xZf5+xVIMiFjTYjBkFox1m4z
	gJBzHOE17r73i3Fp1Sqw/cz7gUFT7KjpOu9O7yzL0X1p4nfzEA==
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr299873055e9.13.1795527113179;
        Tue, 24 Nov 2026 05:31:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm224045315e9.0.2026.11.24.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:31:52 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: Allow ServiceData with no data
Date: Tue, 24 Nov 2026 14:31:48 +0100
Message-ID: <20261124133148.3959415-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

A ServiceData entry with an empty value is rejected and the whole
advertisement fails to register, as the byte type is checked on the
first element of the array, which an empty array does not have. A
Service Data AD with only the UUID is valid, and a Scan Delegator
advertises the BASS UUID like that.

Check the element type of the array instead.

Steps to reproduce:

  [bluetoothctl]> advertise.service 0x184f
  [bluetoothctl]> advertise on
  Failed to register advertisement: org.bluez.Error.Failed

Fixes: 758dae03725e ("core/advertising: Fix not parsing data properly")
Assisted-by: Claude:claude-opus-5-5
---
 src/advertising.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d07068c6c..3a1d9a6b7 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -489,11 +489,11 @@ static bool parse_service_data(DBusMessageIter *iter, struct bt_ad *ad)
 		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
 			goto fail;
 
-		dbus_message_iter_recurse(&value, &array);
-
-		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+		if (dbus_message_iter_get_element_type(&value) !=
+							DBUS_TYPE_BYTE)
 			goto fail;
 
+		dbus_message_iter_recurse(&value, &array);
 		dbus_message_iter_get_fixed_array(&array, &service_data, &len);
 
 		DBG("Adding ServiceData for %s", uuid_str);

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

