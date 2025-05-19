Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8AA278E75
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664416; cv=none; b=bOGYFUpnsGCp6cJgLfqXDecjDMxziFj6k0FH7RFRvRXY3n9llUDLBLqNGNCJGstsZCKj/GXFFHr52D9oEXxz0p3YZBKSqxAhrFjqw9L6/RC4pkVvUa0/ww8ZV8LdrT0m7BLVVw6/wzJDaDTuHT44a61n/N9vlP1Kk+SYGB7nv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664416; c=relaxed/simple;
	bh=6HAVFzjMzosnApOB9XbUDyHCrvoV3OEzW/NB0QM1kL8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AIm1KvikHFqJQ7pkYoH7wxOKL2+Xego5penkUoYiqf7QBv0JvezwCz9bZUZ9uU/d+DVQbQgIX8TRwW/FD+gmoqaMGSPCVgspjKAEmdE0jRBsgJ4YPi5HYgZlukCSJWMZmwVO2dk7B55gUcZ+BTjHC1YhgUH8G4q6quefp2tiXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5K3C2hI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5K3C2hI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8a70fe146so70300396d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664413; x=1748269213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdBwdG9fyBg3A4oY67SPOnKUiV5FDeW3orz93Qwp9As=;
        b=N5K3C2hIFAaaKw+8UNABLMedEAvwIPeBAwYPRDkfH4RB1kT/U9BPZKzFNhsLp/h2YA
         m4I7YNeyrya20aWODmb4TJ/69vaIhY+UoNwcLM1Wf0eDtjZSt/xV3gmUepGaP0DSIAsM
         ahLloNxBJGF5lTFXQG5yqfd1rVp/kJjsz68WjedQ0I6xeEEGJSCWJoqqEXtJ6W5F4Osb
         HLJ/iP57C2PfdL2NzuVlsDZT2SpaaB3zOzspeu3zqVQSOXZr1jEzq2kEU5i1oFXG+dqR
         8NFOcH5ezp8GXYy7A9EGx/unl3DbYIg65R8/4WZtNDt1kGrnkmP9qyqvTiW9TfoBdys+
         2Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664413; x=1748269213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdBwdG9fyBg3A4oY67SPOnKUiV5FDeW3orz93Qwp9As=;
        b=vfhKzKaclznwKA2Cy6Tov3uhrwCZ11E4QNZJwhDWhfqvhujItHboONwoNBU91wtFR6
         nnIzQJSpcr4F4rBbfUM49o3n3VutVSgKiMLcFXc43leUZpQgHLnJ5Q7Rga05gD7613j3
         6IuYLi4qT2IeRi/ThWqRRNV0lMKB6/Y+gwgG0+ewgVE768jMJKtzAojFQFqMIsmxpIFz
         fcfUWYBVHHHY6eT7K7Iwqig0kcTIykGFjBXAvv45VoNGIlP74R/mHcsFqJEgJP5T7sgE
         c2RDLLo4deRxqRXSmX9YzogfXmOIxmFx9PnxJqs7c5Ft4LjGq+SrEEMxlN5jsLM4NcpN
         Lpiw==
X-Gm-Message-State: AOJu0Yx6VK6LD4e7rUEkFDwd2WYxR3rCVuFIzcXHVeoUluQt8QW8zc9I
	5yIfWnsCjCI/5Htzginlli1YPzJhlCHvvzZ2FKdF+ED1gPggb90OyxOAMwILh0/+Pb4=
X-Gm-Gg: ASbGncudIydMP1A0ysMTtnMah3Dnee8n1G8bXdkAVBye3pX7i5Uof2EJRwyjUnd8KEW
	F4oEsR0CdzFZpZyzmkLEt87+sA8UPzw7hnWC49dnEGXp7mrmbPpFyldLvS3Lsvg3xPEqLW5kN4G
	4dETf8eC47eBUSXswO+WgVyf3CPOYR36slUjRL1JHkKki2SpJwZv4KZHye7Mui7hHsq0yXs3cXY
	k3S8aR++5OJ05HDVNcvVyvYOm/KD7row/08malgp0KVkA89JJbQxcjbpJ0VH6yiW/8ltzbqvqHo
	s2djqr1yD9oeu0x5PZQUSbpVvZHsszjMp6JXZhOXyeEH4NiptjNasbUaKCRXF7pHDYrIyH5cM3i
	YNR1ibIC7gt1wSxKBaV6D
X-Google-Smtp-Source: AGHT+IHu4v3bwehuCrb6g8Yqh3XeJPvTETEKyvwMAQNz8ikia8FOtHKMMrsvQai5CHkbW6ai1Vd1gQ==
X-Received: by 2002:a05:6214:402:b0:6f2:c7b0:3b16 with SMTP id 6a1803df08f44-6f8b2c32addmr199206356d6.6.1747664412613;
        Mon, 19 May 2025 07:20:12 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec225c02sm5840249241.28.2025.05.19.07.20.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:20:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client: Fix crashing command info
Date: Mon, 19 May 2025 10:20:09 -0400
Message-ID: <20250519142009.2493740-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If command info is called without any parameters, and without connecting
any device, it will call find_set which doesn't check argc and argv are
actually valid.

Fixes: https://github.com/bluez/bluez/issues/1251
---
 client/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/main.c b/client/main.c
index 36a7446d52c1..5d53a7be11e4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1641,6 +1641,9 @@ static struct GDBusProxy *find_set(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return NULL;
 
+	if (argc < 2 || !strlen(argv[1]))
+		return NULL;
+
 	proxy = find_proxies_by_path(default_ctrl->sets, argv[1]);
 	if (!proxy) {
 		bt_shell_printf("DeviceSet %s not available\n", argv[1]);
-- 
2.49.0

