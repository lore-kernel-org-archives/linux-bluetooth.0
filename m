Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00237287503
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802985; cv=none; b=LOokY3XnQ+UaCeTA0pzzkUA5i1OSByNU47Jkg3WWrSGWVqLCYMhvd9066VK6THCV3Om7rH5nhlu4CHPYxWwZgzfInaHOhxJ+Fzfh7iftaI8ld47x2fAhojUvy7Jn0eny30mpt2Chd9R1LTF0meQSjbuAKXgYTHCa/W13pp/enCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802985; c=relaxed/simple;
	bh=ZC8qywAb5wUPd/dT4KKQQMNCDpbgFhSGDyVHeQ8tB2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N4fKXdOFJ8pctIHGiLRD6e0e8Q98Stc0XMKTxO3x/naybNQtZG1tN3ewXMNWeD8u68JnUYnTgxwcrwzik0M1cJAYw4Ki9NXtYi4CWck38owX6ehI4T4YssPjP/LwVNm4tyzo1AswC+BhEKvuQYw+rEmZ6WShcUChG9TCnKR16fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml6I2ETU; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml6I2ETU"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso1699965e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776802983; x=1777407783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqjjG8j3aWfOd3L1wdTuABMpquoRUK/ubQz0VxxInVo=;
        b=ml6I2ETU+MKVWbJSXSzCTgA6r84gJ2bqRTTmlUmUWveH3VsmXlkScTaIM8WUvb4TDS
         98R27Orm357xHm/a/4/opSJ6ZIq2cHDNFb5vjA0XB8U6Xw01VLfQKGEqfQuS9tJRYBta
         os0pBSE6s00x+xJXHvQzmIPVavLJwlZFpYZQ4j7wIj0hSZei6ZmO9I7B3i3RMcRVzFRf
         fi2XCcctWv2IArPfpr7zqkiCHEFaRLwiTiRmjep6lL+05JsQOSvttLjtFzATc4eNCCEl
         P0DoEnfxGYr6/W3VerXLyYkwUBeR6pf1kw5lMkQNUESpPQRMlCT3zNWDO1UaHiDvQ31q
         1QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802983; x=1777407783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqjjG8j3aWfOd3L1wdTuABMpquoRUK/ubQz0VxxInVo=;
        b=JAnNIZas2SPEMfXsrPZVNmCxtp7DImEVjxgFFF5Htyp689SD1l5auYJbMsUnww2uBT
         hsLYQ0aE4Zzf6UXQgheaRC81XM5rgY7m3X2WieUWrzN+P8wZg1GtboWcijgyLhW7kUsx
         X4vR4MTsW1oBCBFArKa14NwfukVqA4RVJfs3ubGRHQRNgpetEFb4iHeyMjuKAGJJ6Nwk
         0IgJ9yG9xRwcjL540b4dYPol7ZaNKjphLDdTCDHvM/ILVUyrM26KD4vUMAd/ktszbofF
         QobbvC4EnO/KGfpwaBb+1QZRuWWoNtb56tMPniw+bSfVI/jcKvKm4iKudp5p1NYgC5NF
         k+mg==
X-Gm-Message-State: AOJu0YxQXJBt2sJiIIYxXnJ9zDkTQIu6y1ukO/mnGh/jsx79RB7+DIax
	th12GfCJXZiivjxx5uziLLvYstQMIFrNe720pcmCSd42EfS9R8ffePnxM1zFeIH7G2Q=
X-Gm-Gg: AeBDiet8fOerfCX3qFwfjLqce8KL/b82eSMexUeMuNG73Almk2CceDae4dZfCT7woXt
	Rb0qZC0g7+eGwVZIEXw+FHk3isi8FDBrVU8+MU7VjUHneD+7AgYo7YjHZjQ63X+QvUKrflQpacB
	wzVMEHTUVNx39DqFFbZ7NmiGKu1aqlqESlH2HXxaiX1hXoGqFZfrMJ0hkXenlOZQv4p2G6jywqi
	Xi5y0xkneREgTyhKVfKsgc72Mb1/VInSVxqZ0jGAgx48SdovJP1fc8/SMbhPaTH7nZHl8Wv6TLT
	N/SZ527VlYh+qne9qSbECq/05o/qFil5HZKSLGsyZ0pjcqhKChR0nR2OwuqIbMouNhxtcVTVfRN
	EyRKc0TfOgz5d36apvUkRxiAJ/V2DmTXfVPjUE+wSEkQUxzhhPYa/PLYgU5YAbhWkmjBTyOy4lU
	pm4u2CaVvgqcvQoNaMj7wJxcywuAgqecsFQOpwqhOkZQTqbLTs6HO0eJnz63oRO8Qw5HW/mYcuY
	FXU5hDaEyfJA2t4jjJ4G3hEnF5g
X-Received: by 2002:a05:6122:8c17:b0:56e:f071:d4da with SMTP id 71dfb90a1353d-56fa59dc653mr8807183e0c.12.1776802982657;
        Tue, 21 Apr 2026 13:23:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890937da7sm6555873241.1.2026.04.21.13.23.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:23:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input: Fix checking LE bonding on HIDP
Date: Tue, 21 Apr 2026 16:22:53 -0400
Message-ID: <20260421202253.1957689-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HIDP is classic only, LE uses HOG, so there is no point in checking the
bonding with the address type which in case the device supports
dual-mode will map to LE random/public address.

Fixes: https://github.com/bluez/bluez/issues/2034
---
 profiles/input/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6bdc5ee3aaf3..0ee6988c4e90 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -127,8 +127,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
 static bool input_device_bonded(struct input_device *idev)
 {
-	return device_is_bonded(idev->device,
-				btd_device_get_bdaddr_type(idev->device));
+	return device_is_bonded(idev->device, BDADDR_BREDR);
 }
 
 static void input_device_free(struct input_device *idev)
-- 
2.53.0

