Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F61A9B23
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938358; cv=none; b=lCEwdg/UqyrcQt6ufXH48AZW4arLnAnUDvjSXOcoe3EzGTSAy/gmHUqotuIcVqMB5Dz8fCVoMB6Eq3yfwE7m5QNCw09wnO3PL9FsKMejSW+AxAOaS3ZhsNwHvidBIEzAnxrq0Q39+dCBrZ7B+rfefzqReHs1zDBgNSsJglUUivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938358; c=relaxed/simple;
	bh=+AyC3e1fW8KY6qy4+9GntZF+B06MTtZLR82pQFu50Lc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TyRRwS5EMntLkXS8y3SXjv7am686Yyxb70EZx9ZMC6XSyHUHY0Ayru9+R9HVYjZh2R8PnuWCcY/8AiiCqxt3kFyOutOaFHWO4ZSzebigrdkR5sGPI2nidrJK0FpWDJg5oB30Xo2QTZnFfdQlB4l+bX9a15IK3YXMtXSWWDe+sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba5lJ4RW; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba5lJ4RW"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d36e41070so2777155241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742938355; x=1743543155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEN3A0/utGOHeccC2IFlEP3eStw7qLuIBFcnPcRcWCk=;
        b=ba5lJ4RWtk1SQO6mnZ2C3VtLbc46S1D5pSmzRtAhWORlu460c6Jkkjo5EqUXTFq/Sr
         2Fv+8S8SS9RYbN0ijxcKxerOPf49AJzCItIqYOWKHYW6ltAq36pciWifeBHw4l62BLUj
         BK/T+qdP1wu8eMNAyZLlzKoSATook0lg2S5OFF42YfxI8VNxmXv9CzG0nylSNwzZRFPh
         mjCgX2za/d1O02Jybk9u03v7xL2DygvuKVzbxLpRDqBbBxx7u07n3tCDM+Pm6vKsgV31
         Nejv6MlcxclgwGIWljdEFM1XLR7kBVDDoU1A34LsS6sqR3xc7TQ1887WVJoMiP6jFwkI
         Q5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938355; x=1743543155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEN3A0/utGOHeccC2IFlEP3eStw7qLuIBFcnPcRcWCk=;
        b=hghoR0IRmqYCwZPyF4g/NiCfW1KR0WaLm/HojUbz4+SWCO/jhZMh16ooekpDBN5igQ
         VXfnVBC+NRDS2LnyXtW7lXy7cLR1bLMykeES2lx8DIcnXGc29X9nRbDNMgjJt7hfZWSf
         MTJ2Q8A8R6qABO8EfZemC+UOsiOtHF/Lg1tSgrrxNO3RsbQF4ZVuAmJY/LIlBhLh4CgM
         t8e3BYt2H+TJoCWxC6GxT4sx8goa0KNml+z0pt/mHWDxhAJzXjfJ7JitWzKrIuCgQchv
         oaGlVqBP414CqxrS94Q/f975LUuhAASFrWRr7PlTCtZFtwNaYRTIpRq4hNKfOsW03U3S
         4Ljg==
X-Gm-Message-State: AOJu0Ywm9jU3Cshk4Q6eQhJDm0MEtKIzhku9q+0kKeZKDY+pEQ1ENAUj
	ueNvQoYddVq+61tZmzufhxkZEx74v7Uk8iDsb1f0cTP+cv3xa6BA7hYpi+lT
X-Gm-Gg: ASbGncviQUgcS8CEr6yHOOv526ijiVeu2M5BQTEDtQbfma4hb8G+T1Z/3kwoYWMl6lx
	iUP3QoMzC/IazFUQz4n+Il2bdT0EakQrSzKZwO7GInQdRhJFwT9V3N4g2muxF6NEU8oYgEn9NFq
	sEbnPmalii3xiUc7IYtMgIi+1akKkCDs3s73jLtrK67/bkumeSlTRjWpo7YCNveP9q1x5ZHwRs2
	EZuS9nPay0MEeRLYvPBgV+0jmbK5M7WxA9pvEcQHMvB7tQJionA0L5nmM6rPojDiMlHip2AKkaf
	VXgPh8GgLmDaarGIncNrM+hj1BPn4iua8jHTzK44kKmxuX+Iw+FELWKHctl0SopMGl4/jmI4EHC
	t6f7lEmW6U/IkFw==
X-Google-Smtp-Source: AGHT+IHo/7h7CKN4viUZgkgSwm86wGOfomzNc/LI/kLXNbrA5gSM6bAAh5R+WvhvuHg5G8pkj6jFPw==
X-Received: by 2002:a05:6102:3f0d:b0:4c4:df56:6a2b with SMTP id ada2fe7eead31-4c50d491ca0mr14485223137.4.1742938354648;
        Tue, 25 Mar 2025 14:32:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc4b7e2sm2123464137.16.2025.03.25.14.32.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:32:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] main: Fix handling of legacy experimental LL Privacy
Date: Tue, 25 Mar 2025 17:32:30 -0400
Message-ID: <20250325213230.2513331-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Legacy experimental LL Privacy was not enabled by default but
CentralAddressResolution is which may cause problems with old
kernels were LL Privacy may not work as expected.

Fixes: https://github.com/bluez/bluez/issues/1138
---
 src/main.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/src/main.c b/src/main.c
index 50346abbb4d1..6a682e9b921f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -715,20 +715,11 @@ static bool match_experimental(const void *data, const void *match_data)
 bool btd_kernel_experimental_enabled(const char *uuid)
 {
 	if (!btd_opts.kernel)
-		goto done;
+		return false;
 
 	if (queue_find(btd_opts.kernel, match_experimental, uuid))
 		return true;
 
-done:
-	/* For backward compatibility set LL Privacy as enabled if
-	 * CentralAddressResolution has been set so old kernel LL Privacy is
-	 * enabled.
-	 */
-	if (!strcmp(uuid, "15c0a148-c273-11ea-b3de-0242ac130004") &&
-			btd_opts.defaults.le.addr_resolution)
-		return true;
-
 	return false;
 }
 
-- 
2.48.1

