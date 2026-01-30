Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5E3542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810584; cv=none; b=u5lu6wCf+8SQm3VVHwU1Ey+CU6g/kTe4jOk6JK51Am+0Ktu1RgeFXB+qD1AHYz66X0ZG82vSkIGiNs0l6v4E7o5qJN0XUCttOpGtPwhQ/0OMNNXQfJ9s0W/oB/OaSaeVF0J9Hs5WKMKU4ZOgRrrxW6Atwljgoi944mI6xSA0GcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810584; c=relaxed/simple;
	bh=2xahQCYEAK31jKna2E/00bEjRQkYM36H6E/pKOVLxfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLQZhINjThLZ0WoikHAx3X8mTBwjH908nEgS/vcp9IhGE3rfE3ocbtaaxAZ+r0bfS9AmeOlPvi1XqbPAr3HvhI7jnnn2sFAM8ptNu9PeEC6juHUtLflFNxAUtAvBTuCJCY9b6N4EWjQ1EkG9a0dKC1xPwxUaseMQ6SfN73dYjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0UpwI+6; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0UpwI+6"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5f53021703aso845681137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810582; x=1770415382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTWxGSeQ5fQ1ZA7puYa2CwLbvLHzcPPUflto3Oq+s9k=;
        b=b0UpwI+6Fmauk7mil3kohXwbRo7rk+LsKyIj2DHpzw/j0b31C6YKGg3Oz6wUi+cKZ6
         w4YVBN6c7F9mJGbM0oAqpSQKLbAPKe/MJXoFGsu06MDJV/1fomRqiwiBNDrFrZIRjk5O
         BxG+RzPoV2dTRw9GxmGl6k73xy3mhvsmMz2uyryqP01nr6P506a954zX0mnSmvBedJM3
         xv91PfJpK0u/rnKH9Fuzv9lnzYDhmhVmUUvAhsircgLEdX25522J19JmmF+2n4ti21NA
         4iL4aYpdIlusPQVytfScMmI4A4j23qr7Bpp2c9U1eW/RsdW2Nq9Dp59sleoK/P0YUjUr
         AN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810582; x=1770415382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTWxGSeQ5fQ1ZA7puYa2CwLbvLHzcPPUflto3Oq+s9k=;
        b=uVAIZ5+WxQ8NVZCKrQdV1nR8zz5F7QlCBwgksKuWrldmsbDNnwkMFOITZ/8RzJPlLA
         uDpoHtreP2tBItx6M2bk1uUfMOuVWsLrT56TAXxVpmx3SO+ceBDLeDOGZKCrhEQWYEdi
         p30tp7Tdppkp/elb5n+ZOSwJHJOLuHS3VR5QakYK6ETsg3csnZfSqj3AS3FnIijaiFQn
         h8xud3tvnwslPOICkfkxoSupQSxvIFURtG83Szr+qJr2BMcuwE2uzL8+ov5ESh/+qHUU
         nyRjwNPrtS+PKd+euCuqIru4b/jmBud1Iyy7cLGn2XBH1QSy9LpSJuI813XBtCg+RD5M
         pgeQ==
X-Gm-Message-State: AOJu0YynmY8TMzbjk1Is35Mi+JfgnkcuRDdJAUgMt15RuW/YVpSlk3XW
	ht409fS+vZtHQd0M1gz82HlJnTFUWDSuCuQD2w8rUlhANqocUngMzkF/VAGZwg==
X-Gm-Gg: AZuq6aKAjdoOCdVnLo1Ot0Wq2mJafMBk3cgnfRBwQk4o2CTqRrXQDQkx4uvg36hULNP
	/BYypNwRsWC41TMgHL3GfBGLcFEwUrWRQyF11QCNVL4Jh3PpLjI00pUpd/rv8U6HFwYyAiHAO7v
	90duaRoVXqXkOJvV/UwcsvOstjhGhsGudHAdSQG25/Cfyz0iobTON9wtYT2Zr721JvwmW+jSOtt
	SYIC/5SRR5K9JLskrtV46viWz04uvdIEglb6QVOKq/8fl3K4eUlZRZrCDwkCC1bmJ9cBzsuFTO3
	92tfJFwjfhAkvdD6vym4VVPrgJijdWLEGnTyoVyfbNNBt8tCWKBm4mp9diScB7MWRrlNwViw7iD
	GSPZYN95PY0bXBJm1NyIPTv2w/FSrHqwfd+Z9QldlqhPGHbQbNUVqayrr8KdpUU5Wo8MMxMyBx5
	roEkI4dgCJiWG8WyZ1wwi5IcRQDVz2vloN7A/Mxnv3fQq3qUmMyB0FCVWvHmL1jdcHUxj8zoseP
	8dscg==
X-Received: by 2002:a05:6102:94c:b0:5f5:3a9a:7db0 with SMTP id ada2fe7eead31-5f8e26c2b97mr1350654137.41.1769810582365;
        Fri, 30 Jan 2026 14:03:02 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 18/37] doc/org.bluez.AdminPolicyStatus: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:09 -0500
Message-ID: <20260130220229.1346261-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-admin for this interface
which exposes properties read by admin policy commands.
---
 doc/org.bluez.AdminPolicyStatus.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.AdminPolicyStatus.rst b/doc/org.bluez.AdminPolicyStatus.rst
index 18008a2b07af..702e020aa601 100644
--- a/doc/org.bluez.AdminPolicyStatus.rst
+++ b/doc/org.bluez.AdminPolicyStatus.rst
@@ -26,6 +26,7 @@ Adapter
 :Service:	org.bluez
 :Interface:	org.bluez.AdminPolicyStatus1 [experimental]
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-admin(1)**
 
 Device
 ------
-- 
2.52.0

