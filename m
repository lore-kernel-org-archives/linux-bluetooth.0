Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913A222591
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795606; cv=none; b=TOw0z7Rw7Kk3Xw8ObighAgk4FJKH7v8lqxesjr2Gq7K+LvnupTSmofA6mp9cfsNSCPJtfHvJaBn3bef3WaXRn16OXltvwAl1zMMCKEegUwIi3wLetTDFBCsPb496tcil3qSjyePYCRY7dQawx4TKmmtZqc+vp4LvI+22+bPA47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795606; c=relaxed/simple;
	bh=qu2+7en1MTfFhzFKEyOl79Q7+9S7ZoCYD0xwqhu6i60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJf/bVHgmpjh4fO5qD6CLDTc6G3j4fM/ece/pq+8FJ6VqRKvWjz9CKrsIYbYhdcetaI2QQFce3jeAGE20rbq9SwPZGd5y76ccR2kCpBzPblqJY0+4HYpJeft1BsgEKO2D4FLg2gaDPjF3om8UcaRfM0rEdir3cbH4hELyiQtkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heoN1vUu; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heoN1vUu"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5259327a937so1002868e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795602; x=1744400402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NFp74zq6eJ5XIQD3GYATPSPTgPSr8Io3W+b8wdQztk=;
        b=heoN1vUueSG7sv7rvtpynR9kf9vLk2aI4gqwpUOTzD1CiwQBKW82m9hv9ycAPwwZaN
         DzbXjBe9cR04Cx33cJxqzgcEw8XN2hGrTinDmYUydi8+/+jRDp5AY5wAcIR4u/MkL9wL
         DzQMaqa3EwVlycBooFEGQJl6rPIBsYV7hKOR+08O5aCpt0LUWGGplkfXjeXMxm3UIe/x
         s2OH8Fw8/M0sqt2vyay4sZxClQi7S1U760ZduqCAt4fdhkmd7yXy7XilGrvL8qqesFlG
         pG3kQr87ltqviWTh+rjVi/nK7V6CDuLo8NgGN1Z/AAAKci820uvGV716b/gQoKnYo+Lh
         Z6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795602; x=1744400402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NFp74zq6eJ5XIQD3GYATPSPTgPSr8Io3W+b8wdQztk=;
        b=bv4jM1ZOUgzYqSYMq9FWcrdhYcBVvacJ7rQ4Xsg24dkfQKC9BSFBWe/iAgCW5k2Egv
         C9MJNRvADo6d1gNB/6ZVc6Ew9IuLDLFuFvoA9+eaw92+PP+m6wKJ2RN2Cq/lh8UtNPk8
         mSaOo238LyVdbERmYG0qRMi+1dldIZfbqA8J62WNBoTRlgOMoHNTvQ4Chiil96FDVrTn
         nbdndeLGD4f/WhJJkXqorwNT6Lh2iYeshlrK0L+uRsO4wBPrugQalzM0+IWEfunZOH7s
         34VJtB4g6LE6lunqGXLCYelOtQgMjyxAZ92j4A3K3ZOa21nvoctOyyeeP9SPsSwz1iu0
         VmeQ==
X-Gm-Message-State: AOJu0YzPVaU+zzmUkUfDTiYqxisKFiBG86j/CogwjvIosWTNvsxjK0tg
	F2WcHI1CP2SQdbAxIEn/6sR3rW2VyfipItkusxt4ARqHTuNu+Lfgl7dob17kZhs=
X-Gm-Gg: ASbGncuLmogI3r85cOogjapbloRxEs/Q9ZNVw3v5eYo8lROrjIkqXOPKIyebfZ7wA/f
	ufgdMc0+yHPjJpGh1W+LbCBf+VsrVNEqOLmmJZnyXro7K/zozRB+PmgAgdQ8lCTWLUq3knqNa+l
	Y66TWYpTGVswFiGSpCjuXnyFqFGQCujW3C8J+UVUjaxtJFULyMydf9nJISo+egeNt0FAvAqL2HU
	YzmSHBb3grVtYLbotcty7hY3c3jX8df+LUBTMXKzlLVycu+AEcwwy+9lozwJCpjs2P0xzO/x6RV
	Hd9Wy/D0iF7fU2gLOCRkWiLNtuWW9XsSL/jR2K5Du3mFl06RGQbkKUBhTQ4VYgjvEY3PovBs8Jh
	uw3HuhWlT+yQwPA==
X-Google-Smtp-Source: AGHT+IE6zTaFGqYLbE5TPYD4y6RT1uB7YDbLNiWG8iB/+EmAoHjXYQnF7fOVoOpxcrZ9D5vq+XDbGQ==
X-Received: by 2002:a05:6102:512b:b0:4c1:a049:27c7 with SMTP id ada2fe7eead31-4c863692cbbmr769367137.13.1743795602230;
        Fri, 04 Apr 2025 12:40:02 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/11] BAP Server test cases
Date: Fri,  4 Apr 2025 15:39:38 -0400
Message-ID: <20250404193959.359008-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the following BAP Server test cases, and required fixes, from
the testing specification:

BAP/USR/DISC/BV-01-C
BAP/USR/DISC/BV-02-C
BAP/USR/DISC/BV-06-C
BAP/USR/DISC/BV-07-C
BAP/USR/DISC/BV-03-C
BAP/USR/DISC/BV-04-C
BAP/USR/DISC/BV-05-C
BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1]
BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2]
BAP/USR/SCC/BV-003-C [USR SNK Config Codec, LC3 16_1]
BAP/USR/SCC/BV-004-C [USR SNK Config Codec, LC3 16_2]
BAP/USR/SCC/BV-005-C [USR SNK Config Codec, LC3 24_1]
BAP/USR/SCC/BV-006-C [USR SNK Config Codec, LC3 24_2]
BAP/USR/SCC/BV-007-C [USR SNK Config Codec, LC3 32_1]
BAP/USR/SCC/BV-008-C [USR SNK Config Codec, LC3 32_2]
BAP/USR/SCC/BV-009-C [USR SNK Config Codec, LC3 44.1_1]
BAP/USR/SCC/BV-010-C [USR SNK Config Codec, LC3 44.1_2]
BAP/USR/SCC/BV-011-C [USR SNK Config Codec, LC3 48_1]
BAP/USR/SCC/BV-012-C [USR SNK Config Codec, LC3 48_2]
BAP/USR/SCC/BV-013-C [USR SNK Config Codec, LC3 48_3]
BAP/USR/SCC/BV-014-C [USR SNK Config Codec, LC3 48_4]
BAP/USR/SCC/BV-015-C [USR SNK Config Codec, LC3 48_5]
BAP/USR/SCC/BV-016-C [USR SNK Config Codec, LC3 48_6]
BAP/USR/SCC/BV-017-C [USR SRC Config Codec, LC3 8_1]
BAP/USR/SCC/BV-018-C [USR SRC Config Codec, LC3 8_2]
BAP/USR/SCC/BV-019-C [USR SRC Config Codec, LC3 16_1]
BAP/USR/SCC/BV-020-C [USR SRC Config Codec, LC3 16_2]
BAP/USR/SCC/BV-021-C [USR SRC Config Codec, LC3 24_1]
BAP/USR/SCC/BV-022-C [USR SRC Config Codec, LC3 24_2]
BAP/USR/SCC/BV-023-C [USR SRC Config Codec, LC3 32_1]
BAP/USR/SCC/BV-024-C [USR SRC Config Codec, LC3 32_2]
BAP/USR/SCC/BV-025-C [USR SRC Config Codec, LC3 44.1_1]
BAP/USR/SCC/BV-026-C [USR SRC Config Codec, LC3 44.1_2]
BAP/USR/SCC/BV-027-C [USR SRC Config Codec, LC3 48_1]
BAP/USR/SCC/BV-028-C [USR SRC Config Codec, LC3 48_2]
BAP/USR/SCC/BV-029-C [USR SRC Config Codec, LC3 48_3]
BAP/USR/SCC/BV-030-C [USR SRC Config Codec, LC3 48_4]
BAP/USR/SCC/BV-031-C [USR SRC Config Codec, LC3 48_5]
BAP/USR/SCC/BV-032-C [USR SRC Config Codec, LC3 48_6]
BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]
BAP/USR/SCC/BV-034-C [USR SRC Config Codec, VS]
BAP/USR/SCC/BV-069-C [USR SNK Config QoS, LC3 8_1_1]
BAP/USR/SCC/BV-070-C [USR SNK Config QoS, LC3 8_2_1]
BAP/USR/SCC/BV-071-C [USR SNK Config QoS, LC3 16_1_1]
BAP/USR/SCC/BV-072-C [USR SNK Config QoS, LC3 16_2_1]
BAP/USR/SCC/BV-073-C [USR SNK Config QoS, LC3 24_1_1]
BAP/USR/SCC/BV-074-C [USR SNK Config QoS, LC3 24_2_1]
BAP/USR/SCC/BV-075-C [USR SNK Config QoS, LC3 32_1_1]
BAP/USR/SCC/BV-076-C [USR SNK Config QoS, LC3 32_2_1]
BAP/USR/SCC/BV-077-C [USR SNK Config QoS, LC3 44.1_1_1]
BAP/USR/SCC/BV-078-C [USR SNK Config QoS, LC3 44.1_2_1]
BAP/USR/SCC/BV-079-C [USR SNK Config QoS, LC3 48_1_1]
BAP/USR/SCC/BV-080-C [USR SNK Config QoS, LC3 48_2_1]
BAP/USR/SCC/BV-081-C [USR SNK Config QoS, LC3 48_3_1]
BAP/USR/SCC/BV-082-C [USR SNK Config QoS, LC3 48_4_1]
BAP/USR/SCC/BV-083-C [USR SNK Config QoS, LC3 48_5_1]
BAP/USR/SCC/BV-084-C [USR SNK Config QoS, LC3 48_6_1]
BAP/USR/SCC/BV-085-C [USR SRC Config QoS, LC3 8_1_1]
BAP/USR/SCC/BV-086-C [USR SRC Config QoS, LC3 8_2_1]
BAP/USR/SCC/BV-087-C [USR SRC Config QoS, LC3 16_1_1]
BAP/USR/SCC/BV-088-C [USR SRC Config QoS, LC3 16_2_1]
BAP/USR/SCC/BV-089-C [USR SRC Config QoS, LC3 24_1_1]
BAP/USR/SCC/BV-090-C [USR SRC Config QoS, LC3 24_2_1]
BAP/USR/SCC/BV-091-C [USR SRC Config QoS, LC3 32_1_1]
BAP/USR/SCC/BV-092-C [USR SRC Config QoS, LC3 32_2_1]
BAP/USR/SCC/BV-093-C [USR SRC Config QoS, LC3 44.1_1_1]
BAP/USR/SCC/BV-094-C [USR SRC Config QoS, LC3 44.1_2_1]
BAP/USR/SCC/BV-095-C [USR SRC Config QoS, LC3 48_1_1]
BAP/USR/SCC/BV-096-C [USR SRC Config QoS, LC3 48_2_1]
BAP/USR/SCC/BV-097-C [USR SRC Config QoS, LC3 48_3_1]
BAP/USR/SCC/BV-098-C [USR SRC Config QoS, LC3 48_4_1]
BAP/USR/SCC/BV-099-C [USR SRC Config QoS, LC3 48_5_1]
BAP/USR/SCC/BV-100-C [USR SRC Config QoS, LC3 48_6_1]
BAP/USR/SCC/BV-101-C [USR SNK Config QoS, LC3 8_1_2]
BAP/USR/SCC/BV-102-C [USR SNK Config QoS, LC3 8_2_2]
BAP/USR/SCC/BV-103-C [USR SNK Config QoS, LC3 16_1_2]
BAP/USR/SCC/BV-104-C [USR SNK Config QoS, LC3 16_2_2]
BAP/USR/SCC/BV-105-C [USR SNK Config QoS, LC3 24_1_2]
BAP/USR/SCC/BV-106-C [USR SNK Config QoS, LC3 24_2_2]
BAP/USR/SCC/BV-107-C [USR SNK Config QoS, LC3 32_1_2]
BAP/USR/SCC/BV-108-C [USR SNK Config QoS, LC3 32_2_2]
BAP/USR/SCC/BV-109-C [USR SNK Config QoS, LC3 44.1_1_2]
BAP/USR/SCC/BV-110-C [USR SNK Config QoS, LC3 44.1_2_2]
BAP/USR/SCC/BV-111-C [USR SNK Config QoS, LC3 48_1_2]
BAP/USR/SCC/BV-112-C [USR SNK Config QoS, LC3 48_2_2]
BAP/USR/SCC/BV-113-C [USR SNK Config QoS, LC3 48_3_2]
BAP/USR/SCC/BV-114-C [USR SNK Config QoS, LC3 48_4_2]
BAP/USR/SCC/BV-115-C [USR SNK Config QoS, LC3 48_5_2]
BAP/USR/SCC/BV-116-C [USR SNK Config QoS, LC3 48_6_2]
BAP/USR/SCC/BV-117-C [USR SRC Config QoS, LC3 8_1_2]
BAP/USR/SCC/BV-118-C [USR SRC Config QoS, LC3 8_2_2]
BAP/USR/SCC/BV-119-C [USR SRC Config QoS, LC3 16_1_2]
BAP/USR/SCC/BV-120-C [USR SRC Config QoS, LC3 16_2_2]
BAP/USR/SCC/BV-121-C [USR SRC Config QoS, LC3 24_1_2]
BAP/USR/SCC/BV-122-C [USR SRC Config QoS, LC3 24_2_2]
BAP/USR/SCC/BV-123-C [USR SRC Config QoS, LC3 32_1_2]
BAP/USR/SCC/BV-124-C [USR SRC Config QoS, LC3 32_2_2]
BAP/USR/SCC/BV-125-C [USR SRC Config QoS, LC3 44.1_1_2]
BAP/USR/SCC/BV-126-C [USR SRC Config QoS, LC3 44.1_2_2]
BAP/USR/SCC/BV-127-C [USR SRC Config QoS, LC3 48_1_2]
BAP/USR/SCC/BV-128-C [USR SRC Config QoS, LC3 48_2_2]
BAP/USR/SCC/BV-129-C [USR SRC Config QoS, LC3 48_3_2]
BAP/USR/SCC/BV-130-C [USR SRC Config QoS, LC3 48_4_2]
BAP/USR/SCC/BV-131-C [USR SRC Config QoS, LC3 48_5_2]
BAP/USR/SCC/BV-132-C [USR SRC Config QoS, LC3 48_6_2]
BAP/USR/SCC/BV-133-C [USR SNK Config QoS, VS]
BAP/USR/SCC/BV-134-C [USR SRC Config QoS, VS]
BAP/USR/SCC/BV-135-C [USR SNK Enable]
BAP/USR/SCC/BV-136-C [UCL SRC Enable]
BAP/USR/SCC/BV-137-C [USR SRC Disable in Enabling State]
BAP/USR/SCC/BV-138-C [USR SNK Disable in Enabling or Streaming state]
BAP/USR/SCC/BV-139-C [USR SRC Disable in Streaming State]
BAP/USR/SCC/BV-143-C [USR SRC Release in Codec Configured state]
BAP/USR/SCC/BV-144-C [USR SNK Release in Codec Configured state]
BAP/USR/SCC/BV-145-C [USR SRC Release in QoS Configured state]
BAP/USR/SCC/BV-146-C [USR SNK Release in QoS Configured state]
BAP/USR/SCC/BV-147-C [USR SRC Release in Enabling state]
BAP/USR/SCC/BV-148-C [USR SNK Release in Enabling or Streaming state]
BAP/USR/SCC/BV-149-C [USR SRC Release in Streaming state]
BAP/USR/SCC/BV-150-C [USR SRC Release in Disabling state]
BAP/USR/SCC/BV-161-C [USR SRC Update Metadata in Enabling State]
BAP/USR/SCC/BV-162-C [USR SNK Update Metadata in Enabling or Streaming state]
BAP/USR/SCC/BV-163-C [USR SRC Update Metadata in Streaming State]

Luiz Augusto von Dentz (11):
  test-bap: Introduce DISC tests for LC3
  test-bap: Introduce USR/SCC tests for LC3
  test-bap: Introduce USR/SCC - VS tests for LC3
  test-bap: Introduce USR/SCC QoS tests for LC3
  test-bap: Introduce USR/SCC QoS tests for VS
  test-bap: Introduce USR/SCC Enable tests for LC3
  test-bap: Introduce USR/SCC Enable tests for LC3
  shared/bap: Fix not always sending Releasing state
  test-bap: Introduce USR/SCC Release tests for LC3
  shared/bap: Fix not sending ASE Notication in case of Metadata update
  test-bap: Introduce USR/SCC Metadata tests for LC3

 src/shared/bap.c |   31 +-
 src/shared/lc3.h |    2 +-
 unit/test-bap.c  | 1028 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 956 insertions(+), 105 deletions(-)

-- 
2.49.0

