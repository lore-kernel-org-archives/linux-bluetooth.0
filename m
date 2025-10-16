Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24021B3937
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648467; cv=none; b=RB7RwM6qeJXKzaLaDJH8FED8nKFjz+Eq5H5di3uzNbceWSGDz69MEvlpnFag9COclSyda/+1WRtM5C5zbJ5sZSawYKW0yZGK7PE+8BuqPabVCv7mozKrU0rKC7uKn5/z6CB6kbvz1JQ9msOYVsztiZRtP+kIylDzPkdxhvWtYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648467; c=relaxed/simple;
	bh=JQRRvvEQ3dzudaVG05JW1ndfVeZyqZYmXtlZk+kH4V4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy2NyX6z5Ul+IAU7BBwknThAetV7pHMffTKIkLAdZ5ZxZRiuH4MIZLu0v6AqH+6R6T4my991PqbrOaN4aZr4aMdxUo7u+nCXbUQK0LUZXJ17+rtru2txlR1AfRkGqauX5jKTKxjhsGi0P0oLW/wDj5jl4kWPQwArBeNlzEIbgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnOq467D; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnOq467D"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54c0a10990fso433791e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648460; x=1761253260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAeZexvgxbuGlShGJ6CUEk+YNlLf2q9zrfNxFRwCm2E=;
        b=mnOq467DTaLj0/2yU8XOFn0O9Aa8rsD2czBlovwSaSx+5dK3iGS0GVNhW6ByYYAt4J
         pLvKjY5XBrV7lQrN0Q3s16JaRZfkT3SCTwMbpBv4cNc7Ksw5YyFzKifyRMmML/Wb73ZS
         NvExUDhjV2BBDJ4A6tRPeGQFVlivfvlhaNygULtIRKtSor+EEqDLILuPMc2QeD8o3Psz
         5Bbt8bLx6yhPkY7KMFU7YzLJdjgSjI4OVQGLstOkum1BEAvZwq2796Jcq8x+XZ2+eK1Q
         YZ6c60zwGpnCSjOZeKGNJ8FaTDF1fhGhefdN4/+9FjuASf7mC5c0KpioZt8+IAi9beBC
         CTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648460; x=1761253260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAeZexvgxbuGlShGJ6CUEk+YNlLf2q9zrfNxFRwCm2E=;
        b=WMC+kkvoAYr/z8tJxI8VBHb79Mqq2y54POzfsdO5ElWQEFgoHiLqSA9RjL+XI+IiJ2
         LP41JsJjhOuPbpfSTTfbbQj7U+jrmMsSjEqUMSrrPL+08laR/CRmupfZlu2SowLg0bU5
         C9UcfBO+yBy5OpCvf/bfiyRvfA+oWZLH36jD0yKhgXR2n9QvDbVGLr7ZVz5vzCLmdIn+
         Ji14kfxoWwkFhsO0EUntq30zH5C3U+HbZH+X8RcN5+6rOKkNBVXVxuNCqEenOWawWnXa
         LUM1dRb9anDUqinS6XcTws/h6jL3eZf6ax8dWIGD90mdJMJMNHVa1tVEgnU8g5EruGvH
         rdvg==
X-Gm-Message-State: AOJu0YxVwEcy/uwUPfojAn2DKYtcvOx7Rlnlp9edAw6SrXjTG9RlUxDo
	SqskYE3OnfoeEleam1FA4I5Gig04dNVgdbIenPuJl7nkhL47eYeZBFO/5RO8F51C
X-Gm-Gg: ASbGncvGbWdYkBNoIfC626Lor/TlmeO0KM/9H3aclZ1FRkFOM7uytp+TflJY2ygwa1I
	NQcyRcSmhuQogVTp3Es9UFUuShc2BsLieVQdh+n5WOIKKyXBe8ZG6vR78NA1JJukIOThmwdlkW8
	JWsLwhZR8nBaZKT97GT40Q+8/s60wHyl+yNMLgrVBBstoT71FUaczMbusiq14/Cgbgi+9cMTob7
	9Rt3KLEV7p/5bJqVJt2yVzaA5SspPiqi/rEUg4axFCL9R8i1YG8EgrjPAYhPYFitGb3AF4ZmcQ2
	Jj2g1AglciaZWZdao5TVPBtAx479apnHLafYA2WGntCUKKKbu0AhslYFMZzSHottbt1mMN32gof
	43Nz+/ilZCVwRVhIIUkn9t9IMPoUgpWSpLeNMpWkSDhfgZKdKwb/kx+alMJK68YMXUOMR0kLR62
	iAvus=
X-Google-Smtp-Source: AGHT+IEL8SEFRi0V9acAsO9mZoJ6lyeKns/htqwNk3yM/26aTDlhFXNIMBiqJArBf0+u1+7XWkq+DA==
X-Received: by 2002:a05:6122:65a4:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-5564ef828d9mr722198e0c.13.1760648459852;
        Thu, 16 Oct 2025 14:00:59 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 13/13] client: Add script for testing Broadcast Delegator
Date: Thu, 16 Oct 2025 17:00:19 -0400
Message-ID: <20251016210019.191878-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a script for testing Broadcast Delagator role.
---
 client/scripts/broadcast-delegator.bt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 client/scripts/broadcast-delegator.bt

diff --git a/client/scripts/broadcast-delegator.bt b/client/scripts/broadcast-delegator.bt
new file mode 100644
index 000000000000..e42db7335c24
--- /dev/null
+++ b/client/scripts/broadcast-delegator.bt
@@ -0,0 +1,9 @@
+power on
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+transport.select auto
+transport.acquire auto
+advertise on
-- 
2.51.0

