Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41521FC7D2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056092; cv=none; b=Bo0Ml/Bk5KEa5kbql+kUOrvXfHeYU3MCQGCsPuYOxWaVMkESpPfrxsjIeGwuZ41ZzMNqe8r2YG34XmR2AIwLyDG+KHC84ZVRMNmZvBDT6JMDIkXspL7x/3R0TBcKlcRDKSOGJxaVPsVxJfHSsZBhYasTG+Gf6Fy+0Sd6p+QHC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056092; c=relaxed/simple;
	bh=zWZ6p8R4jez6q12BaMj/AT4w3jl/enGrRPTVY5VoCgk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ssD/LXQMJ2rksvVbAm9KsgCYWKTg6kcocZBQGPpS8ORd8DLOxrEAJKvIWeCbxqu/ElalVB9vZurPnaqTEPMBCkh30eT3vKhzOkUvQLoRfV4Ow9ThNLfvTweA/AAp8l/PPZ5svAUieQHDBGLvROhCPuRbeZJat4ARnPyUCswhlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1hFiKJC; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1hFiKJC"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5259327a937so1998957e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056088; x=1744660888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlDopfAohP86dtoPcypXUy/Vu+dbIpTjCkWvcVRTdb0=;
        b=S1hFiKJChQ1EjN+CAXdRO8t9SyzkrwUQER6aL6GqNUiS3/LyvkJYIMJK5Rm/KNu5C1
         pKWsU4seNAKgpZDn+KVULhehSNQQVb1QXzh5j6SoE1dVIGQtvu8qkSoh+lTt58U5ozKO
         S0phMmJWRbHLY8QdQBF1Z0HVcSoLt+klL+Di4D1R/ZheqaXK57AM4s+aOloDe24hHYVu
         UT2pKbs0pe/easUU2B7eennyR33hT55KeGEhJenhEswELXcmbGqDKsM9Hr08KAPA0lwf
         0RcYKDPYkmqxJFHdZSA6Ae1X83voc9dtI6esindOAzkXJ6H82lRpU2IGEm09xX+4/u83
         mTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056088; x=1744660888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlDopfAohP86dtoPcypXUy/Vu+dbIpTjCkWvcVRTdb0=;
        b=SPlCH+3/qGYs1rDzBENxaHOb9jSDiSudd+WQ/wPGmgSmkQUfli5fj3+qR52Dl2RCro
         vWJqv0gECby2Hkb4y/grciFbzWiWpg3c0w3hz0X+qdbB6yBdhii4mXxzEVSBUTLfzcY8
         NeUQv2Cf1dQzh9uESmLXWJ2rks2fTKAuUhjuBXE2teFPPCazjUs/ZoTihIqXUTCDq+8E
         u4NuaPEmOsxt2auv9Cez6FvJB1aJstmO5Rr5gHQZUdt+7uMbd2WsVFtpDE8MY6Nb0bf7
         QLUc9nh7ybL/na60OJwLXmj4Kizwice5npGUifLbq3cd740EgZv8UwrZDvmRCauZ6vDJ
         KbDg==
X-Gm-Message-State: AOJu0Yy3SKtgReCBDTNjFdrLkl32/s8wIAyiYdo9wpx84mhlnKX6A/f7
	2uIrbaSijoPzOeNrz8jg8beaxGMw9uBbg67rG+UcJUUmqwJmBAYA75JHSeUf
X-Gm-Gg: ASbGnct8dMDf99alle0H5z4AheNO/55HcLg763Br+QnImglu6s5BjpNE1vEk0iNtEFQ
	JXQBaR0WCw5ufjDbhqR0oq5910VBlGGF5H8V9NXRM+Lzt99oRHnq0XYJi4tKTkNm5fUh8PmDzaz
	RvonEmf3HhN0GdFV8MAISBtJH1n248sZ7R2H6iLLksTTry829VFFbR+01AcEKilu1nmXeUtZNT0
	CRuwKEqEiFBKIHxw3TnjwQUU6CoIUMm8Fjwv3VT2t056LSLnL12fNs/kAEH3xhqOKpIVccon7fS
	T5OIYZqyWkJTUxs5WtOYbdABqwba0el6Pl5Fl3uHp98rWO+odiGGyk0Lv3iUAvZ8dy6GYRrJYN2
	aXHoUY8+c5Lihzjx9V9JWtaJA
X-Google-Smtp-Source: AGHT+IGWGbcRh48lCsxq73IW7Zz9gk/dsP/kWArinhAFR1ti6eD9X9v3sxEXWvOfhCWAkVaL1xoOfw==
X-Received: by 2002:a05:6122:2a11:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-52772ee3144mr7462348e0c.2.1744056088105;
        Mon, 07 Apr 2025 13:01:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 00/15] BAP Server test cases
Date: Mon,  7 Apr 2025 16:01:06 -0400
Message-ID: <20250407200124.881534-1-luiz.dentz@gmail.com>
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
BAP/USR/STR/BV-001-C [USR, AC 2, LC3 8_1_1]
BAP/USR/STR/BV-002-C [USR, AC 10, LC3 8_1_1]
BAP/USR/STR/BV-003-C [USR, AC 2, LC3 8_2_1]
BAP/USR/STR/BV-004-C [USR, AC 10, LC3 8_2_1]
BAP/USR/STR/BV-005-C [USR, AC 2, LC3 16_1_1]
BAP/USR/STR/BV-006-C [USR, AC 10, LC3 16_1_1]
BAP/USR/STR/BV-007-C [USR, AC 2, LC3 16_2_1]
BAP/USR/STR/BV-008-C [USR, AC 10, LC3 16_2_1]
BAP/USR/STR/BV-009-C [USR, AC 2, LC3 24_1_1]
BAP/USR/STR/BV-010-C [USR, AC 10, LC3 24_1_1]
BAP/USR/STR/BV-011-C [USR, AC 2, LC3 24_2_1]
BAP/USR/STR/BV-012-C [USR, AC 10, LC3 24_2_1]
BAP/USR/STR/BV-013-C [USR, AC 2, LC3 32_1_1]
BAP/USR/STR/BV-014-C [USR, AC 10, LC3 32_1_1]
BAP/USR/STR/BV-015-C [USR, AC 2, LC3 32_2_1]
BAP/USR/STR/BV-016-C [USR, AC 10, LC3 32_2_1]
BAP/USR/STR/BV-017-C [USR, AC 2, LC3 441_1_1]
BAP/USR/STR/BV-018-C [USR, AC 10, LC3 441_1_1]
BAP/USR/STR/BV-019-C [USR, AC 2, LC3 44_2_1]
BAP/USR/STR/BV-020-C [USR, AC 10, LC3 44_2_1]
BAP/USR/STR/BV-021-C [USR, AC 2, LC3 48_1_1]
BAP/USR/STR/BV-022-C [USR, AC 10, LC3 48_1_1]
BAP/USR/STR/BV-023-C [USR, AC 2, LC3 48_2_1]
BAP/USR/STR/BV-024-C [USR, AC 10, LC3 48_2_1]
BAP/USR/STR/BV-025-C [USR, AC 2, LC3 48_3_1]
BAP/USR/STR/BV-026-C [USR, AC 10, LC3 48_3_1]
BAP/USR/STR/BV-027-C [USR, AC 2, LC3 48_4_1]
BAP/USR/STR/BV-028-C [USR, AC 10, LC3 48_4_1]
BAP/USR/STR/BV-029-C [USR, AC 2, LC3 48_5_1]
BAP/USR/STR/BV-030-C [USR, AC 10, LC3 48_5_1]
BAP/USR/STR/BV-031-C [USR, AC 2, LC3 48_6_1]
BAP/USR/STR/BV-032-C [USR, AC 10, LC3 48_6_1]
BAP/USR/STR/BV-033-C [USR, SRC, AC 1, LC3 8_1_1]
BAP/USR/STR/BV-034-C [USR, SRC, AC 4, LC3 8_1_1]
BAP/USR/STR/BV-035-C [USR, SRC, AC 1, LC3 8_2_1]
BAP/USR/STR/BV-036-C [USR, SRC, AC 4, LC3 8_2_1]
BAP/USR/STR/BV-037-C [USR, SRC, AC 1, LC3 16_1_1]
BAP/USR/STR/BV-038-C [USR, SRC, AC 4, LC3 16_1_1]
BAP/USR/STR/BV-039-C [USR, SRC, AC 1, LC3 16_2_1]
BAP/USR/STR/BV-040-C [USR, SRC, AC 4, LC3 16_2_1]
BAP/USR/STR/BV-041-C [USR, SRC, AC 1, LC3 24_1_1]
BAP/USR/STR/BV-042-C [USR, SRC, AC 4, LC3 24_1_1]
BAP/USR/STR/BV-043-C [USR, SRC, AC 1, LC3 24_2_1]
BAP/USR/STR/BV-044-C [USR, SRC, AC 4, LC3 24_2_1]
BAP/USR/STR/BV-045-C [USR, SRC, AC 1, LC3 32_1_1]
BAP/USR/STR/BV-046-C [USR, SRC, AC 4, LC3 32_1_1]
BAP/USR/STR/BV-047-C [USR, SRC, AC 1, LC3 32_2_1]
BAP/USR/STR/BV-048-C [USR, SRC, AC 4, LC3 32_2_1]
BAP/USR/STR/BV-049-C [USR, SRC, AC 1, LC3 44_1_1]
BAP/USR/STR/BV-050-C [USR, SRC, AC 4, LC3 44_1_1]
BAP/USR/STR/BV-051-C [USR, SRC, AC 1, LC3 44_2_1]
BAP/USR/STR/BV-052-C [USR, SRC, AC 4, LC3 44_2_1]
BAP/USR/STR/BV-053-C [USR, SRC, AC 1, LC3 48_1_1]
BAP/USR/STR/BV-054-C [USR, SRC, AC 4, LC3 48_1_1]
BAP/USR/STR/BV-055-C [USR, SRC, AC 1, LC3 48_2_1]
BAP/USR/STR/BV-056-C [USR, SRC, AC 4, LC3 48_2_1]
BAP/USR/STR/BV-057-C [USR, SRC, AC 1, LC3 48_3_1]
BAP/USR/STR/BV-058-C [USR, SRC, AC 4, LC3 48_3_1]
BAP/USR/STR/BV-059-C [USR, SRC, AC 1, LC3 48_4_1]
BAP/USR/STR/BV-060-C [USR, SRC, AC 4, LC3 48_4_1]
BAP/USR/STR/BV-061-C [USR, SRC, AC 1, LC3 48_5_1]
BAP/USR/STR/BV-062-C [USR, SRC, AC 4, LC3 48_5_1]
BAP/USR/STR/BV-063-C [USR, SRC, AC 1, LC3 48_6_1]
BAP/USR/STR/BV-064-C [USR, SRC, AC 4, LC3 48_6_1]
BAP/USR/STR/BV-065-C [USR, AC 2, LC3 8_1_2]
BAP/USR/STR/BV-066-C [USR, AC 10, LC3 8_1_2]
BAP/USR/STR/BV-067-C [USR, AC 2, LC3 8_2_2]
BAP/USR/STR/BV-068-C [USR, AC 10, LC3 8_2_2]
BAP/USR/STR/BV-069-C [USR, AC 2, LC3 16_1_2]
BAP/USR/STR/BV-070-C [USR, AC 10, LC3 16_1_2]
BAP/USR/STR/BV-071-C [USR, AC 2, LC3 16_2_2]
BAP/USR/STR/BV-072-C [USR, AC 10, LC3 16_2_2]
BAP/USR/STR/BV-073-C [USR, AC 2, LC3 24_1_2]
BAP/USR/STR/BV-074-C [USR, AC 10, LC3 24_1_2]
BAP/USR/STR/BV-075-C [USR, AC 2, LC3 24_2_2]
BAP/USR/STR/BV-076-C [USR, AC 10, LC3 24_2_2]
BAP/USR/STR/BV-077-C [USR, AC 2, LC3 32_1_2]
BAP/USR/STR/BV-078-C [USR, AC 10, LC3 32_1_2]
BAP/USR/STR/BV-079-C [USR, AC 2, LC3 32_2_2]
BAP/USR/STR/BV-080-C [USR, AC 10, LC3 32_2_2]
BAP/USR/STR/BV-081-C [USR, AC 2, LC3 44_1_2]
BAP/USR/STR/BV-082-C [USR, AC 10, LC3 44_1_2]
BAP/USR/STR/BV-083-C [USR, AC 2, LC3 44_2_2]
BAP/USR/STR/BV-084-C [USR, AC 10, LC3 44_2_2]
BAP/USR/STR/BV-085-C [USR, AC 2, LC3 48_1_2]
BAP/USR/STR/BV-086-C [USR, AC 10, LC3 48_1_2]
BAP/USR/STR/BV-087-C [USR, AC 2, LC3 48_2_2]
BAP/USR/STR/BV-088-C [USR, AC 10, LC3 48_2_2]
BAP/USR/STR/BV-089-C [USR, AC 2, LC3 48_3_2]
BAP/USR/STR/BV-090-C [USR, AC 10, LC3 48_3_2]
BAP/USR/STR/BV-091-C [USR, AC 2, LC3 48_4_2]
BAP/USR/STR/BV-092-C [USR, AC 10, LC3 48_4_2]
BAP/USR/STR/BV-093-C [USR, AC 2, LC3 48_5_2]
BAP/USR/STR/BV-094-C [USR, AC 10, LC3 48_5_2]
BAP/USR/STR/BV-095-C [USR, AC 2, LC3 48_6_2]
BAP/USR/STR/BV-096-C [USR, AC 10, LC3 48_6_2]
BAP/USR/STR/BV-097-C [USR, SRC, AC 1, LC3 8_1_2]
BAP/USR/STR/BV-098-C [USR, SRC, AC 4, LC3 8_1_2]
BAP/USR/STR/BV-099-C [USR, SRC, AC 1, LC3 8_2_2]
BAP/USR/STR/BV-100-C [USR, SRC, AC 4, LC3 8_2_2]
BAP/USR/STR/BV-101-C [USR, SRC, AC 1, LC3 16_1_2]
BAP/USR/STR/BV-102-C [USR, SRC, AC 4, LC3 16_1_2]
BAP/USR/STR/BV-103-C [USR, SRC, AC 1, LC3 16_2_2]
BAP/USR/STR/BV-104-C [USR, SRC, AC 4, LC3 16_2_2]
BAP/USR/STR/BV-105-C [USR, SRC, AC 1, LC3 24_1_2]
BAP/USR/STR/BV-106-C [USR, SRC, AC 4, LC3 24_1_2]
BAP/USR/STR/BV-107-C [USR, SRC, AC 1, LC3 24_2_2]
BAP/USR/STR/BV-108-C [USR, SRC, AC 4, LC3 24_2_2]
BAP/USR/STR/BV-109-C [USR, SRC, AC 1, LC3 32_1_2]
BAP/USR/STR/BV-110-C [USR, SRC, AC 4, LC3 32_1_2]
BAP/USR/STR/BV-111-C [USR, SRC, AC 1, LC3 32_2_2]
BAP/USR/STR/BV-112-C [USR, SRC, AC 4, LC3 32_2_2]
BAP/USR/STR/BV-113-C [USR, SRC, AC 1, LC3 44_1_2]
BAP/USR/STR/BV-114-C [USR, SRC, AC 4, LC3 44_1_2]
BAP/USR/STR/BV-115-C [USR, SRC, AC 1, LC3 44_2_2]
BAP/USR/STR/BV-116-C [USR, SRC, AC 4, LC3 44_2_2]
BAP/USR/STR/BV-117-C [USR, SRC, AC 1, LC3 48_1_2]
BAP/USR/STR/BV-118-C [USR, SRC, AC 4, LC3 48_1_2]
BAP/USR/STR/BV-119-C [USR, SRC, AC 1, LC3 48_2_2]
BAP/USR/STR/BV-120-C [USR, SRC, AC 4, LC3 48_2_2]
BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_3_2]
BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_3_2]
BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_4_2]
BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_4_2]
BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_5_2]
BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_5_2]
BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_6_2]
BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_6_2]

Luiz Augusto von Dentz (15):
  test-bap: Introduce DISC tests for LC3
  test-bap: Introduce USR/SCC tests for LC3
  test-bap: Introduce USR/SCC - VS tests for LC3
  test-bap: Introduce USR/SCC QoS tests for LC3
  test-bap: Introduce USR/SCC QoS tests for VS
  test-bap: Introduce USR/SCC Enable tests for LC3
  test-bap: Introduce USR/SCC Enable tests for LC3
  shared/bap: Fix not always sending Releasing state
  shared/bap: Fix not notifying idle state
  test-bap: Introduce USR/SCC Release tests for LC3
  shared/bap: Fix not sending ASE Notication in case of Metadata update
  test-bap: Introduce USR/SCC Metadata tests for LC3
  shared/bap: Fix notifying with the wrong state
  shared/tester: Fix not detecting NULL packets
  test-bap: Introduce USR/STR tests for LC3

 src/shared/bap.c    |   55 +-
 src/shared/lc3.h    |    2 +-
 src/shared/tester.c |    3 +
 unit/test-bap.c     | 1468 ++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 1407 insertions(+), 121 deletions(-)

-- 
2.49.0

