Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346529;
	b=JIqVhQlgy4DXU/WvxrARvL6aFAHA8YqHxHVW46WbgyRe80HQFYqOV82BMnPY/aO5DOFD
	 34LLB0POU99ZGHV6Sn/dvBsb1+9Bo703yvKCfoHpDgvoMQvEnyqUZZrQrdo30H5BC3Km0
	 15HXjxzOVq4RMVuFv9THaBjuYmQx7kOyakkG6/XOxMefpToNjjW43Wa+OJa4QJE2aKOPR
	 yXb+xXBRGEUZdTeRTTt6K3qYWO31Hmo8fOotzzdm8qRZkUtf1C1o4zcMQLMfKBJq0gkiR
	 /mIukSURTl+tJ54DUlPSiD/B1ASn7FdORoY6yjmozY9/gtpo7B/c5Q81RFXmLAGe13A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cHJQ7+JRkzigh+NPjSZyQxt24QtEMhkbRahl8jifTck=;
	b=zq1oyxKFXRBotQ3AivSPedPaZXw07blqL97Ut1WmSV9vB1bUdwLsjW7Nq+6x1E8tvl/b
	 vDgV/BVjNGDGcVdxnyXEHx4tT5HoyUf3jB0LtB4bvbCUQQpgjLKaLfVw9rH9KCIFTFpw7
	 QnXEk0SKrxGI7WNs41usOZDn1h8Xv0gZ8y5UCODAwIIC3wFDjbtEdz7hWzgWrVidSOoUv
	 eXlPO893QwseN77fkLYTZcHhCZkeodO2U4pWmCM1FSpS/wvVSTGdyFMAtkXVWrkoD9xf2
	 yoj+XrFtMvLyJ2kFwcO5BgXckmbkTW8d5BwJfOh/PXT//+M76smIRq2W6XvJhhv9pTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNk88YG6;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E82606A33A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E82606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNk88YG6
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso901234e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346528; x=1794951328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHJQ7+JRkzigh+NPjSZyQxt24QtEMhkbRahl8jifTck=;
        b=rNk88YG66QFausGPQgu5+tgCqFnlJmvzEMOynZrekgUZFDa5+76lN+MHXycw6pNHbD
         xpBgF1J3ZwRndJy/qn5cLldqZmb4mCqhF2BVED00jzeiNKUKKmsfnaHls8pHu6WU3pIk
         i532/3UlLqz5Mj5Ejufb+kppGcRqbYgOsUl3x26CW4eXRlNFIa2W9xeeO6i6wuPgyMhO
         KgHiJzFI49egYOylFF9xuInkYG3w4bmOzLScBZdssODSBF8niniFjOPE/PZShMJspqba
         jB7jWAilr4xCHGirSmRjnwbSepez/mJl/5GDm9eyJVt02anISVrWpJcX2lmORdnUtKbs
         Zl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346528; x=1794951328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cHJQ7+JRkzigh+NPjSZyQxt24QtEMhkbRahl8jifTck=;
        b=UaZtSUpxW/NDATerlQ2kNOo05E/xjfW/Tul5OWV0bRguPKGh6Qlw3AQU6PJ9RcM5d1
         D348rYcd3eeuMXv72/zSzsO1H0LKVw0/wlPCBMgHOD7iXhKHZlv2Mgjiw2viKPwaJazh
         mfKhbQJ/3y9hZlhZN5TVeKqWI6Eo2D0yMeyiCv9CyVO7OJ54wfWB0NdS94H7cMibf+5A
         q2ovfNcFGTYKlGI6SE7C5PSbKe2PJPyOM8VB88Sb0EaOrdEULLSxdb8lPmF+TXlMd9da
         8J0IVMqxUgWkwWPED3+r8X3X3Au9CFM7BiAsw7EGQURieZNb/4tDXEibWvmq341W7f9B
         tAAQ==
X-Gm-Message-State: APuU4Z/+v6ZS8v2MUMLXVcj9ITYd+GBx1RNv7xntOKWNtBdmM4f40tP7
	hAgf2C6kvZKZie0ABBo20B4l+uPiBvH6euqjvOuk4ljSW9asH/hitwGv3jR3iA==
X-Gm-Gg: AYBFou0zUw3INNbLYvd3fCm61Hm7bX1mrL/+VejLfF1PUpCM+Y+CVs/M4MvbRsPsbpB
	/sX5lz2m3ftc8pLe8DA90qM+zV5I3Yv2/4ha0qauOZ03Hv1FWG8VooHZkGLShLX4UGIMLlY4dp3
	zgEeVR4wMDBZlRbVWprAUSR1MJJA1xWX/HhaG+Bn+5Qzz1U5qalXMSa47x352N1dI/xA/GbFxPn
	gmg2FwNHFGRouGd7/FTYseTRKATzf755xPVjlua3G04iaNMKlVrxR4V+WSYR36m0fnBOcYSJKrR
	+QIlN9lgXO1LAJFKYkcYDOSzQ7DUT2FttvVPXZPFIsyHMwgVau3MoP5e7z2+uiTjIzmc4XzBHeH
	bTGh4QQZOhyTjJsacOaSlcFIZb3uXmDUpRB09MC7wy1RDAmly2xCMOV5y+1wfY4B0k/A0zOTY46
	bAU6VsmIwtueuq0E2nxrKjdboKrPn+SSKl8W+AZhisZ/ioZtkhUXaTCwQIKVuWpLQVCfnUGtluw
	UHKzN+UIgIT0tuVS87r7eMdi9UttHOGVpwJkANaYIigUi8ietAfQNOjWxrlIX52PuRoVQ2fjuVj
	Yzk8Fa1cijRxWA5RbjHmr+3EwFUOoAGAy6Qfty85mVow76Zh2PxU+U5k4/zTX63iZKoPTWTi2G8
	H4hshgOXR5QZWPSbc379FDD+PA/hP1pFy8+/omg4Qp8dD3oHKfBEQmOrU+DAbKnPHHUlqFu2VhJ
	CJHVboBqsaZ6jblMxmBVNz3wFZ
X-Received: by 2002:a05:6122:d25:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5ee1c3e566dmr86949e0c.4.1794346527689;
        Tue, 10 Nov 2026 13:35:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c614572sm2482189e0c.17.2026.11.10.13.35.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:35:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/5] shared: Use util_iov helpers in gatt-db, hog, asha and micp
Date: Tue, 10 Nov 2026 16:35:20 -0500
Message-ID: <20261110213525.2942339-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This continues the conversion of the GATT code in src/shared to the
util_iov_pull_* and util_iov_push_* helpers, so that the bounds check is
part of the access, now for gatt-db and the HoG, ASHA and MICP profiles.

The conversions are meant to be behavior preserving and are covered by
the existing unit tests (test-gatt, test-hog, test-micp). The existing
code already checked the lengths in the HoG and ASHA readers, so no new
tests were added for them.

The one bug found is in micp: a Mute State notification with no value
made micp_mute_state_notify read a byte past the value. It is fixed, but
there is no test for it since the scripted test-micp client flow does
not deliver a notification to that handler, so it could not be
reproduced.

bap, rap and the remaining profiles will follow in separate series.

Luiz Augusto von Dentz (5):
  shared/gatt-db: Use util_iov helpers to build and parse values
  shared/hog: Use util_iov helpers to parse characteristic values
  shared/asha: Use util_iov helpers to parse characteristic values
  shared/micp: Fix reading Mute State from an empty notification
  shared/micp: Use util_iov_pull_mem instead of a local helper

 src/shared/asha.c    |  52 +++++++----
 src/shared/gatt-db.c | 201 +++++++++++++++++++++++++------------------
 src/shared/hog.c     |  62 +++++++------
 src/shared/micp.c    |  28 +++---
 4 files changed, 199 insertions(+), 144 deletions(-)

-- 
2.56.0

