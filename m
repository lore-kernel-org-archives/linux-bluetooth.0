Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6B2AD04
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854797; cv=none; b=BgjnomU3OFNYR0eqKYYVFj/rf8g/h/Yfgmo0sicE+bR2Z5Dz3C0ZO4oXnOEGwnNQZsVKo45CZe0xSKZqLWYyeC+ieZQEtgYH2e68jWiOyBtKL8yrW+EBDhctCDUKPDnq9700FzDeUl2iK6ih9j7QJzYVvtvD9ZKjhiLycsitiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854797; c=relaxed/simple;
	bh=dg4kN87Keho+/h/KIBcQBT852kn8XKudU1Is1zZBM3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gjcwxKzunAUZmuOCDSOkWwWF7Usj3n47xCaif50ZFE/BZZRC96hNGnrgjdxHgFSP548zoyl5Qcr8XzxV0Qoejy4FywQfL7M/Ozz59pfu0FvfnNc1jNRDrn0XKD7s6NdkK3f+NgS6mJZcHsGvCl86t1rcriWFhrplF1441ROP7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0kh+MD6; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0kh+MD6"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-52934f4fb23so4927579e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745854793; x=1746459593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8xARpUhAdxHyOYjMWOPNECZiI4w5ZhP36J6Ott8Qt0=;
        b=O0kh+MD61M9N7YuHK5cnPeXa7gueN9kF3nnNNE5Qxgk+nvocG6NUyAE0Jh+hJkutdT
         rQruY/DEhVORHaNC+8W4x4MAlOoOuQfuaISf6oNAXXvpZt8jCDmOU+9hOICVmbQ5VGBu
         qOEcq954Mb69Y6ddjC7XTwM7KuvninDc2NRcvOtPk6nYF8U+PTq3KQ6Ghe0w/MRvCv9X
         Bi3PCXgsGp4r4fAAveP+QXF3en5D2hLMfh2NxAJ+amgqc01ryJG4eIDnMqzThkLNjaTL
         XhZ9pIyIna5TeC3XvQe4DAZvmmfBaMEpYBhhGc6V/PGcjULLShcWNIf0AiA6u83URHOF
         DSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745854793; x=1746459593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8xARpUhAdxHyOYjMWOPNECZiI4w5ZhP36J6Ott8Qt0=;
        b=C0AqeFoz016owv4pn3iaYCK5Lrn2DymhiLM4TxU/OTPekAp+nLBjvbOtDYzJlhKiIc
         tjbhX+WBNwchrjTKvajl7HjgRoZpe7Y6irXJesXmocuIdNxL46V46fS6SnPRI1XezC56
         H4blVB7ocMHdE1fDmWbsKcAinB8w7YFpNfdn0CC5IFtt4hr+sabI4UDzbYK6hBwP9Jgz
         wC1ZidEBCsV8mRZS5yvRCyqzzNwX4F8QGgS/fGVhqOpRouxGH29ArrIqvOa+LxSgEOfU
         uCP2NDvERWKjLUrmUwzntdZgKqH7NPb271ux+3vHFEhMGHC80Untz48AMqs0WP7GOe72
         PDzA==
X-Gm-Message-State: AOJu0YxS84HUulWLQq45L97ES5Qs3pwgwBSogiYSWa+ILWxF9/obqEoT
	837HWa9lo7oqoiOLo5r1DSoxq4h0CMesCeY83sXS5P33/1PcVNqhvGqHjxsh0K4=
X-Gm-Gg: ASbGncvVFc2U0MuUExjPCfTds9oebIIWg8uPLZECjoXzSlBuwXjsXzW4Z4mHCdQK2Zu
	cs2MS7YzBCH0JiGDX0UquHbKyVtNM8EB14i0y0Z55h5VgA0w/Z1LzkqSE+qczD8zuxOdEyEKtui
	hozhGbI2tR4XYocksiXLBN3cqBFdQ8EKK6C5jquiDH7TzfU9vXPlvxQV4d9P7OzPSjDWwQpO4a3
	tosMCZR4Sn6uU/rRxVAlrbyc3gaPvJepmB3i/MvHmZ0xLm3wdbiBz7ySK3SUmWVP4qGnExYl2q7
	KYgEjC1OPAm6vGsmp/RI3WhRSABULapkKyF628xDhxAf/JUs0fVeWgIWuECa5R4Xd2uEc1YBOab
	IbvqXcNB0pJ7xTpgDy2/j
X-Google-Smtp-Source: AGHT+IEIUTYoGsk4bnpaZZ+Ad53BhrKoLEeTyoPfngKpK6+JiOtuB24fKQk4kQP6uaQTgUcBQN7XLw==
X-Received: by 2002:a05:6122:daa:b0:520:9688:d1bb with SMTP id 71dfb90a1353d-52a89d28789mr8527645e0c.2.1745854792859;
        Mon, 28 Apr 2025 08:39:52 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a9923ce11sm958896e0c.12.2025.04.28.08.39.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:39:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] main: Fix scanning alert no. 21
Date: Mon, 28 Apr 2025 11:39:50 -0400
Message-ID: <20250428153950.1942867-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Comparison of narrow type with wide type in loop condition
Comparison between of type uint16_t and of wider type size_t.

In a loop condition, comparison of a value of a narrow type with a value
of a wide type may result in unexpected behavior if the wider value is
sufficiently large (or small). This is because the narrower value may
overflow. This can lead to an infinite loop.
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 6a682e9b921f..3c51a0092425 100644
--- a/src/main.c
+++ b/src/main.c
@@ -501,7 +501,7 @@ static void parse_mode_config(GKeyFile *config, const char *group,
 				const struct config_param *params,
 				size_t params_len)
 {
-	uint16_t i;
+	size_t i;
 
 	if (!config)
 		return;
-- 
2.49.0

