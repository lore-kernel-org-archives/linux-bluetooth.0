Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B02054EE
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700397; cv=none; b=dTtETmfz1cNoNIk6GZ9G/dr9M3kHTiqYCTpO7GQuibH+oX6x4MXMLJcgC7/B8hak+LSQRGZ3clzpjpWFCBMFrCX3uKcL3VMlHfhaKYZR0orchrBwY23D/2akg9c3N8l59O2C3SYNmLpDuNwbBHftI89RcajG40EF+lYDrk6qeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700397; c=relaxed/simple;
	bh=GpUs2bcJqJ2IhE1Vnz28cpoatD09/RXmQv2RoMTma+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n4Ua0j+mzcV+d0s3OYmb5gvHvAHhZrqXGNgXQh4nglGjyrJ9E5KO+cpB8PnjaOrNCjbDYk4MUMIXCf5vihJ/zfx8KLqUJD5/lDobH/22vTeXg6BjyY0VmHfiEzKLRUk5yVnvBeIhPA681cSA8AYETvhN7xEKPXDxCV2LeHDN/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndhreWK8; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndhreWK8"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-518957b0533so1803607e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738700392; x=1739305192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qER69FhfXielK1AIObDvfGXm21mbnYK4d/3azbQiScU=;
        b=ndhreWK8NGlfJVufbDB45UOfv8mWXcNLWSv/seOqgqaJEC5mPGoO6LeBb7fXUgKQ3W
         n7cZZ1A/Kw4XWJVeHhQS/xBvdkKiqNowv9qbgPdxdEObdkV1CYOfb/zaoSEg4EcIU9tg
         o1hkHorY1fuRJMl5Iv+8H0hqVo1py3sHtZRghqsWEu9STb412gK9GkUw0oDgxF3IznD/
         WOPO9lg8vYy3IrPAW6G8h1AwiI2ETsC8vD+OlzxlvvEow0IwUoF+NvZnq56uAPwK0QO3
         RRaROSWVODSq9vyumfopXvg2rMNzFem8xKN+mN40nWfkQvYeHiD93vEAGrZge3WwFcBO
         S0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738700392; x=1739305192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qER69FhfXielK1AIObDvfGXm21mbnYK4d/3azbQiScU=;
        b=lytiX6Scphw7c+wnOFd3W0BBQiBsGOWVA2Aug59GUM5t4s0G775XocXAuVBTFOsaK/
         z+PFhteCRzD/+i10CDktxu6PU/erFIdeAAdV6n2w/5dSnPLX/dbS4AH/64yZBKCNYuRc
         XpR3o3uehvLjyKEpvu0hw+gm3zeAKqXI0TefP5yh8si53TsDIlz63HhuLDerhfdLBvvv
         t41w3lN1NdFOE9H+aOJq+3tL4GiRCEAtm7kP+6QU+HHfWjt5DDexRL/IJeyNvyQDRE/R
         aaPnC3B4rCIcgHqEDX5poKhBlw20GqVVZiF8pRJW5EzJJZC4s7eONCPnUp9tXUWvAjYh
         VS6Q==
X-Gm-Message-State: AOJu0YyjYGXGokINuK88L5EwT6yT/6pxj3Pf7Rfwv55USWYl6Ru272a2
	Nnn8jBf5B7Zus6M46d6ipzA14F3RbE+611pBptR3iHVsIRzi4XadzmvGBh/I8FM=
X-Gm-Gg: ASbGncvyJpfDGStIsoCVebFuIqGm2ysQn0BAh7WKd/08FoO3Z79EABv/kgoDPfBWxOV
	Zs7F9JkNxVxsyd7f7iMLJ1BnjDucnnu+IpkMDO4QOkUsD+nEAugy1geDyKv62xECG4t9VuCoDhh
	Xjq8eDQD4rhBzbQz8bAW1/qnMY2VfNRUoZk/6YEgpFMpNXE6rGvAzddhPb3W9jMnLZgHfDLhoki
	oP7WToHaGw6Jx3+u/P6XkY1t5fiJ+3G/F8JjQPNaSFH6xzv+2SR0WX/0+oIyz3lYHmxNejFgKHB
	TcZ4rEvshFK+O+enMUV1MU2om1sWj0cD7ZGBknl2QpdFK91gwnbddkv88+J9cig=
X-Google-Smtp-Source: AGHT+IENLH+zcxvY5A1N0FUX4SZK5i9DeISOG+vwynG7LqyTys0LYqrszCq0S4MASlNmwBmc1itTsg==
X-Received: by 2002:a05:6122:4f92:b0:51b:8949:c996 with SMTP id 71dfb90a1353d-51f0c4e50b8mr414366e0c.9.1738700391859;
        Tue, 04 Feb 2025 12:19:51 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1be873csm1602232e0c.10.2025.02.04.12.19.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 12:19:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] build: Enable -Wstringop-overflow and -D_FORTIFY_SOURCE=3
Date: Tue,  4 Feb 2025 15:19:47 -0500
Message-ID: <20250204201948.2883452-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables -Wstringop-overflow compiler warnings:

  'Warn for calls to string manipulation functions such as "memcpy" and
  "strcpy" that are determined to overflow the destination buffer.'

Along with -D_FORTIFY_SOURCE=3 so the errors like the following can be
captured:

In function ‘read’,
    inlined from ‘serial_read_callback’ at emulator/serial.c:90:8:
/usr/include/bits/unistd.h:32:10: error: ‘__read_alias’ specified size between 18446744073709490177 and 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overflow=]
   32 |   return __glibc_fortify (read, __nbytes, sizeof (char),
      |          ^~~~~~~~~~~~~~~
---
 acinclude.m4 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index 4b73a5bfc38f..9f2dc302e7bc 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -61,9 +61,11 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wcast-align"
 		with_cflags="$with_cflags -Wswitch-enum"
 		with_cflags="$with_cflags -Wformat -Wformat-security"
+		with_cflags="$with_cflags -Wstringop-overflow"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
 		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
 		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
-- 
2.48.1

