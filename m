Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BC22256B
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056135; cv=none; b=KuFXmYKvUfCwF10mKE8av26osUg9NNFWl2YCxe6jura3JVMBRpEU1yZjmcTLBSpx2ko6KBZp5E5mpBC46wzMHpX/hqZLjw+TRfothFJUzSxyWKBfBGu/ILbTtoB2ThhpSbmwTf6s3q8eKKEGhoBXCgLdLgFI0eXAlfBP+NcwphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056135; c=relaxed/simple;
	bh=uC48BAZV9MIxRvv3VxLtVMt5VvXf6ft0znTnLtPyF68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpLNP0Li8VJtfwvmQhj6hyI5+UszeHJ/qlsKRrOMEQDxSrOvuubM8+jTkgW9+TnXeKO+qcRYgezTf+qv9OAY3MBmdUWuSYMLVkw94qDTgz+1f2Q1bLsCVkXLrFpP+wa+7SOTtIDZbx/G+indSCEW17sPMK4Fcdt01DGbutRNewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrAWlhZS; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrAWlhZS"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523de538206so2093514e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056131; x=1744660931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OZLlrWa7L5CG5xOe2MiHYUBjgPPcQVx6/Z5PyjIXFw=;
        b=RrAWlhZSMrD7lMlL4GY7w5GWGHT6qKtQRGmP0CaSHBrsjiIX3nRPNb+MgVgEPwzdX0
         34qFehsFgmP3x+Jw5p8ouBr14pKqeurWOPZwg9b+JsB2XA+YbodC7tHom80f9jBDogc5
         0pw/LoW3KGPiqxbNOW21LT4VnHHpUZB7hS3xkWL0/rpR1sGHWs2gLyBaUk1qSTkb4mU+
         N9CukAPjS3UteR/hcZ8kcdx/uKbkd6rdrn5zYyckPXnmsXpNQaL44J7Xx/k0o/UgKBEb
         0BAjNDRsqD12WLJSnUAJEYeFjM9k7UBqpmleuACu217Y2rYGegMM17JQZAtGbqFbFoEb
         D4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056131; x=1744660931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OZLlrWa7L5CG5xOe2MiHYUBjgPPcQVx6/Z5PyjIXFw=;
        b=Ijfz6LphqEuRlE9SZRu25jztp2tFsPIhS2xMSnSJZfKz/1qVBMpNwZtA+f6ycfJMj6
         DzFiSVHTzH2AeeBapqLAeayqUeb92jgjVMXePkMSzrHhEsCdIqKkCQFKXgDKOmGefPpQ
         vGi6bvJNLylE1Llkisms85HSebFIMKH0DrwNMXm1SpxS24/FVx43l8OAMHlSOR8gRAbZ
         d9i9xoosV4pLdFPyNIYSAjtJNSlcomc9rqR8R3coDaiJyfKUwnUL5xWcBQ5ciROIgFfj
         /gN59faBT/a8b/RLa4BS3aUnrVOooLa2n3KEa0Vtr90D66lrWZcAXIU9jlO39YC7gbMO
         ylSg==
X-Gm-Message-State: AOJu0Yyi5fKUgjzWhz+dODVaViNJFsvs3w6689OLV0rkaalKG24m+xpG
	CsVGVpfxMSEteRsmZrAjh7lh/nZwyWq1r/8/PEioalQpmxD4ZPHryE0MqhQR
X-Gm-Gg: ASbGncuOrWQrYD95Qf5oNftSpAF8/+xpPMNFX0oY7DhaSfutZPcPFBg5PUtVMHGe5fH
	p1rqtmaYgpkA7Op57U7tu/01lOpqUyQi+KC5bI1naERaQt+AAjna9h5MIeYkkVktnk2GIvAqQ9r
	ligblWNEY4q9T5eAGrNuPRSeE6P8RNKUf7Fh7XTRalTJJd1rxWlcA/l9YKFTC8MLvY8ydUx0u5I
	0amXraamd7eRvvH4ZJN2WeQKsKCkhI5avh17pPuyucmH2Ufqs7A0B6qseovP+0YKMF/Gj9lPHDq
	gpxzFyf5qH7FaPCq1cUpwaTiqbmhk2JFCYSwr74nmp9q+N91MJ/UxoNExhqTIlRz7bkUAL3kjW/
	vW3Vcd0KGdGLrOg==
X-Google-Smtp-Source: AGHT+IHhTVm/DgFjQVeuiY4laf1cyVpA97J/r9F2C3+bFVERGobofFbCpdRdaj+oPkDcl6um6eplNg==
X-Received: by 2002:a05:6122:d9d:b0:518:865e:d177 with SMTP id 71dfb90a1353d-52764582927mr11267078e0c.9.1744056130880;
        Mon, 07 Apr 2025 13:02:10 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.02.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:02:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 15/15] test-bap: Introduce USR/STR tests for LC3
Date: Mon,  7 Apr 2025 16:01:21 -0400
Message-ID: <20250407200124.881534-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Unicast Server Streaming – 1 Stream, 1 CIS – LC3

Test Purpose:
Verify that a Unicast Server IUT can stream LC3-encoded audio data over one
unicast Audio Stream to/from a Unicast Client.

Pass verdict:
If the IUT is in the Audio Source role, the IUT sends SDUs with a zero or
more length, using the LC3 Media Packet format (defined in [3] Section 4.2).
If the IUT is in the Audio Sink role, the IUT receives SDUs with a zero or
more length, using the LC3 Media Packet format (defined in [3] Section 4.2)

Test Summary
------------
BAP/USR/STR/BV-001-C [USR, AC 2, LC3 8_1_1]          Passed
BAP/USR/STR/BV-002-C [USR, AC 10, LC3 8_1_1]         Passed
BAP/USR/STR/BV-003-C [USR, AC 2, LC3 8_2_1]          Passed
BAP/USR/STR/BV-004-C [USR, AC 10, LC3 8_2_1]         Passed
BAP/USR/STR/BV-005-C [USR, AC 2, LC3 16_1_1]         Passed
BAP/USR/STR/BV-006-C [USR, AC 10, LC3 16_1_1]        Passed
BAP/USR/STR/BV-007-C [USR, AC 2, LC3 16_2_1]         Passed
BAP/USR/STR/BV-008-C [USR, AC 10, LC3 16_2_1]        Passed
BAP/USR/STR/BV-009-C [USR, AC 2, LC3 24_1_1]         Passed
BAP/USR/STR/BV-010-C [USR, AC 10, LC3 24_1_1]        Passed
BAP/USR/STR/BV-011-C [USR, AC 2, LC3 24_2_1]         Passed
BAP/USR/STR/BV-012-C [USR, AC 10, LC3 24_2_1]        Passed
BAP/USR/STR/BV-013-C [USR, AC 2, LC3 32_1_1]         Passed
BAP/USR/STR/BV-014-C [USR, AC 10, LC3 32_1_1]        Passed
BAP/USR/STR/BV-015-C [USR, AC 2, LC3 32_2_1]         Passed
BAP/USR/STR/BV-016-C [USR, AC 10, LC3 32_2_1]        Passed
BAP/USR/STR/BV-017-C [USR, AC 2, LC3 441_1_1]        Passed
BAP/USR/STR/BV-018-C [USR, AC 10, LC3 441_1_1]       Passed
BAP/USR/STR/BV-019-C [USR, AC 2, LC3 44_2_1]         Passed
BAP/USR/STR/BV-020-C [USR, AC 10, LC3 44_2_1]        Passed
BAP/USR/STR/BV-021-C [USR, AC 2, LC3 48_1_1]         Passed
BAP/USR/STR/BV-022-C [USR, AC 10, LC3 48_1_1]        Passed
BAP/USR/STR/BV-023-C [USR, AC 2, LC3 48_2_1]         Passed
BAP/USR/STR/BV-024-C [USR, AC 10, LC3 48_2_1]        Passed
BAP/USR/STR/BV-025-C [USR, AC 2, LC3 48_3_1]         Passed
BAP/USR/STR/BV-026-C [USR, AC 10, LC3 48_3_1]        Passed
BAP/USR/STR/BV-027-C [USR, AC 2, LC3 48_4_1]         Passed
BAP/USR/STR/BV-028-C [USR, AC 10, LC3 48_4_1]        Passed
BAP/USR/STR/BV-029-C [USR, AC 2, LC3 48_5_1]         Passed
BAP/USR/STR/BV-030-C [USR, AC 10, LC3 48_5_1]        Passed
BAP/USR/STR/BV-031-C [USR, AC 2, LC3 48_6_1]         Passed
BAP/USR/STR/BV-032-C [USR, AC 10, LC3 48_6_1]        Passed
BAP/USR/STR/BV-033-C [USR, SRC, AC 1, LC3 8_1_1]     Passed
BAP/USR/STR/BV-034-C [USR, SRC, AC 4, LC3 8_1_1]     Passed
BAP/USR/STR/BV-035-C [USR, SRC, AC 1, LC3 8_2_1]     Passed
BAP/USR/STR/BV-036-C [USR, SRC, AC 4, LC3 8_2_1]     Passed
BAP/USR/STR/BV-037-C [USR, SRC, AC 1, LC3 16_1_1]    Passed
BAP/USR/STR/BV-038-C [USR, SRC, AC 4, LC3 16_1_1]    Passed
BAP/USR/STR/BV-039-C [USR, SRC, AC 1, LC3 16_2_1]    Passed
BAP/USR/STR/BV-040-C [USR, SRC, AC 4, LC3 16_2_1]    Passed
BAP/USR/STR/BV-041-C [USR, SRC, AC 1, LC3 24_1_1]    Passed
BAP/USR/STR/BV-042-C [USR, SRC, AC 4, LC3 24_1_1]    Passed
BAP/USR/STR/BV-043-C [USR, SRC, AC 1, LC3 24_2_1]    Passed
BAP/USR/STR/BV-044-C [USR, SRC, AC 4, LC3 24_2_1]    Passed
BAP/USR/STR/BV-045-C [USR, SRC, AC 1, LC3 32_1_1]    Passed
BAP/USR/STR/BV-046-C [USR, SRC, AC 4, LC3 32_1_1]    Passed
BAP/USR/STR/BV-047-C [USR, SRC, AC 1, LC3 32_2_1]    Passed
BAP/USR/STR/BV-048-C [USR, SRC, AC 4, LC3 32_2_1]    Passed
BAP/USR/STR/BV-049-C [USR, SRC, AC 1, LC3 44_1_1]    Passed
BAP/USR/STR/BV-050-C [USR, SRC, AC 4, LC3 44_1_1]    Passed
BAP/USR/STR/BV-051-C [USR, SRC, AC 1, LC3 44_2_1]    Passed
BAP/USR/STR/BV-052-C [USR, SRC, AC 4, LC3 44_2_1]    Passed
BAP/USR/STR/BV-053-C [USR, SRC, AC 1, LC3 48_1_1]    Passed
BAP/USR/STR/BV-054-C [USR, SRC, AC 4, LC3 48_1_1]    Passed
BAP/USR/STR/BV-055-C [USR, SRC, AC 1, LC3 48_2_1]    Passed
BAP/USR/STR/BV-056-C [USR, SRC, AC 4, LC3 48_2_1]    Passed
BAP/USR/STR/BV-057-C [USR, SRC, AC 1, LC3 48_3_1]    Passed
BAP/USR/STR/BV-058-C [USR, SRC, AC 4, LC3 48_3_1]    Passed
BAP/USR/STR/BV-059-C [USR, SRC, AC 1, LC3 48_4_1]    Passed
BAP/USR/STR/BV-060-C [USR, SRC, AC 4, LC3 48_4_1]    Passed
BAP/USR/STR/BV-061-C [USR, SRC, AC 1, LC3 48_5_1]    Passed
BAP/USR/STR/BV-062-C [USR, SRC, AC 4, LC3 48_5_1]    Passed
BAP/USR/STR/BV-063-C [USR, SRC, AC 1, LC3 48_6_1]    Passed
BAP/USR/STR/BV-064-C [USR, SRC, AC 4, LC3 48_6_1]    Passed
BAP/USR/STR/BV-065-C [USR, AC 2, LC3 8_1_2]          Passed
BAP/USR/STR/BV-066-C [USR, AC 10, LC3 8_1_2]         Passed
BAP/USR/STR/BV-067-C [USR, AC 2, LC3 8_2_2]          Passed
BAP/USR/STR/BV-068-C [USR, AC 10, LC3 8_2_2]         Passed
BAP/USR/STR/BV-069-C [USR, AC 2, LC3 16_1_2]         Passed
BAP/USR/STR/BV-070-C [USR, AC 10, LC3 16_1_2]        Passed
BAP/USR/STR/BV-071-C [USR, AC 2, LC3 16_2_2]         Passed
BAP/USR/STR/BV-072-C [USR, AC 10, LC3 16_2_2]        Passed
BAP/USR/STR/BV-073-C [USR, AC 2, LC3 24_1_2]         Passed
BAP/USR/STR/BV-074-C [USR, AC 10, LC3 24_1_2]        Passed
BAP/USR/STR/BV-075-C [USR, AC 2, LC3 24_2_2]         Passed
BAP/USR/STR/BV-076-C [USR, AC 10, LC3 24_2_2]        Passed
BAP/USR/STR/BV-077-C [USR, AC 2, LC3 32_1_2]         Passed
BAP/USR/STR/BV-078-C [USR, AC 10, LC3 32_1_2]        Passed
BAP/USR/STR/BV-079-C [USR, AC 2, LC3 32_2_2]         Passed
BAP/USR/STR/BV-080-C [USR, AC 10, LC3 32_2_2]        Passed
BAP/USR/STR/BV-081-C [USR, AC 2, LC3 44_1_2]         Passed
BAP/USR/STR/BV-082-C [USR, AC 10, LC3 44_1_2]        Passed
BAP/USR/STR/BV-083-C [USR, AC 2, LC3 44_2_2]         Passed
BAP/USR/STR/BV-084-C [USR, AC 10, LC3 44_2_2]        Passed
BAP/USR/STR/BV-085-C [USR, AC 2, LC3 48_1_2]         Passed
BAP/USR/STR/BV-086-C [USR, AC 10, LC3 48_1_2]        Passed
BAP/USR/STR/BV-087-C [USR, AC 2, LC3 48_2_2]         Passed
BAP/USR/STR/BV-088-C [USR, AC 10, LC3 48_2_2]        Passed
BAP/USR/STR/BV-089-C [USR, AC 2, LC3 48_3_2]         Passed
BAP/USR/STR/BV-090-C [USR, AC 10, LC3 48_3_2]        Passed
BAP/USR/STR/BV-091-C [USR, AC 2, LC3 48_4_2]         Passed
BAP/USR/STR/BV-092-C [USR, AC 10, LC3 48_4_2]        Passed
BAP/USR/STR/BV-093-C [USR, AC 2, LC3 48_5_2]         Passed
BAP/USR/STR/BV-094-C [USR, AC 10, LC3 48_5_2]        Passed
BAP/USR/STR/BV-095-C [USR, AC 2, LC3 48_6_2]         Passed
BAP/USR/STR/BV-096-C [USR, AC 10, LC3 48_6_2]        Passed
BAP/USR/STR/BV-097-C [USR, SRC, AC 1, LC3 8_1_2]     Passed
BAP/USR/STR/BV-098-C [USR, SRC, AC 4, LC3 8_1_2]     Passed
BAP/USR/STR/BV-099-C [USR, SRC, AC 1, LC3 8_2_2]     Passed
BAP/USR/STR/BV-100-C [USR, SRC, AC 4, LC3 8_2_2]     Passed
BAP/USR/STR/BV-101-C [USR, SRC, AC 1, LC3 16_1_2]    Passed
BAP/USR/STR/BV-102-C [USR, SRC, AC 4, LC3 16_1_2]    Passed
BAP/USR/STR/BV-103-C [USR, SRC, AC 1, LC3 16_2_2]    Passed
BAP/USR/STR/BV-104-C [USR, SRC, AC 4, LC3 16_2_2]    Passed
BAP/USR/STR/BV-105-C [USR, SRC, AC 1, LC3 24_1_2]    Passed
BAP/USR/STR/BV-106-C [USR, SRC, AC 4, LC3 24_1_2]    Passed
BAP/USR/STR/BV-107-C [USR, SRC, AC 1, LC3 24_2_2]    Passed
BAP/USR/STR/BV-108-C [USR, SRC, AC 4, LC3 24_2_2]    Passed
BAP/USR/STR/BV-109-C [USR, SRC, AC 1, LC3 32_1_2]    Passed
BAP/USR/STR/BV-110-C [USR, SRC, AC 4, LC3 32_1_2]    Passed
BAP/USR/STR/BV-111-C [USR, SRC, AC 1, LC3 32_2_2]    Passed
BAP/USR/STR/BV-112-C [USR, SRC, AC 4, LC3 32_2_2]    Passed
BAP/USR/STR/BV-113-C [USR, SRC, AC 1, LC3 44_1_2]    Passed
BAP/USR/STR/BV-114-C [USR, SRC, AC 4, LC3 44_1_2]    Passed
BAP/USR/STR/BV-115-C [USR, SRC, AC 1, LC3 44_2_2]    Passed
BAP/USR/STR/BV-116-C [USR, SRC, AC 4, LC3 44_2_2]    Passed
BAP/USR/STR/BV-117-C [USR, SRC, AC 1, LC3 48_1_2]    Passed
BAP/USR/STR/BV-118-C [USR, SRC, AC 4, LC3 48_1_2]    Passed
BAP/USR/STR/BV-119-C [USR, SRC, AC 1, LC3 48_2_2]    Passed
BAP/USR/STR/BV-120-C [USR, SRC, AC 4, LC3 48_2_2]    Passed
BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_3_2]    Passed
BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_3_2]    Passed
BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_4_2]    Passed
BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_4_2]    Passed
BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_5_2]    Passed
BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_5_2]    Passed
BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_6_2]    Passed
BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_6_2]    Passed
Total: 128, Passed: 128 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 440 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 429 insertions(+), 11 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9a07bd8f53e7..62c797a19164 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1150,6 +1150,14 @@ static void test_ucl_disc(void)
 						DISC_SRC_ASE_LC3);
 }
 
+static void server_state_changed(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	if (new_state == BT_BAP_STREAM_STATE_ENABLING)
+		bt_bap_stream_start(stream, NULL, NULL);
+}
+
 static void bap_attached(struct bt_bap *bap, void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -1160,6 +1168,10 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	data->bap = bap;
 
 	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	if (data->cfg && data->cfg->state == BT_BAP_STREAM_STATE_STREAMING)
+		bt_bap_state_register(data->bap, server_state_changed, NULL,
+						data, NULL);
 }
 
 static void test_server(const void *user_data)
@@ -5581,7 +5593,7 @@ static struct test_config str_src_ac1_8_2_2 = {
 #define STR_SRC_AC1_8_2_2 \
 	STR_SRC_8_2_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_8_2_2 = {
 	.cc = LC3_CONFIG_8_2_AC(2),
@@ -5639,7 +5651,7 @@ static struct test_config str_src_ac1_16_2_2 = {
 #define STR_SRC_AC1_16_2_2 \
 	STR_SRC_16_2_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_16_2_2 = {
 	.cc = LC3_CONFIG_16_2_AC(2),
@@ -5697,7 +5709,7 @@ static struct test_config str_src_ac1_24_2_2 = {
 #define STR_SRC_AC1_24_2_2 \
 	STR_SRC_24_2_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_24_2_2 = {
 	.cc = LC3_CONFIG_24_2_AC(2),
@@ -5755,7 +5767,7 @@ static struct test_config str_src_ac1_32_2_2 = {
 #define STR_SRC_AC1_32_2_2 \
 	STR_SRC_32_2_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_32_2_2 = {
 	.cc = LC3_CONFIG_32_2_AC(2),
@@ -5814,7 +5826,7 @@ static struct test_config str_src_ac1_44_2_2 = {
 #define STR_SRC_AC1_44_2_2 \
 	STR_SRC_44_2_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_44_2_2 = {
 	.cc = LC3_CONFIG_44_2_AC(2),
@@ -5873,7 +5885,7 @@ static struct test_config str_src_ac1_48_2_2 = {
 #define STR_SRC_AC1_48_2_2 \
 	STR_SRC_48_2_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_48_2_2 = {
 	.cc = LC3_CONFIG_48_2_AC(2),
@@ -5932,7 +5944,7 @@ static struct test_config str_src_ac1_48_4_2 = {
 #define STR_SRC_AC1_48_4_2 \
 	STR_SRC_48_4_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_48_4_2 = {
 	.cc = LC3_CONFIG_48_4_AC(2),
@@ -5991,7 +6003,7 @@ static struct test_config str_src_ac1_48_6_2 = {
 #define STR_SRC_AC1_48_6_2 \
 	STR_SRC_48_6_2(1), \
 	SRC_ENABLE, \
-	SNK_START
+	SRC_START
 
 static struct test_config str_src_ac4_48_6_2 = {
 	.cc = LC3_CONFIG_48_6_AC(2),
@@ -6016,7 +6028,7 @@ static struct test_config str_src_ac4_48_6_2 = {
  * more length that contains LC3-encoded data formatted using the LC3 Media
  * Packet format (defined in [3] Section 4.2).
  */
-static void test_str_1_1_1_lc3(void)
+static void test_ucl_str_1_1_1_lc3(void)
 {
 	define_test("BAP/UCL/STR/BV-001-C [UCL, AC 2, LC3 8_1_1]",
 			test_setup, test_client, &str_snk_ac2_8_1_1,
@@ -6396,14 +6408,420 @@ static void test_str_1_1_1_lc3(void)
 	define_test("BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_5_2]",
 			test_setup, test_client, &str_src_ac4_48_5_2,
 			STR_SRC_AC4_48_5_2);
-	define_test("BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_6_2]",
+	define_test("BAP/UCL/STR/BV-123-C [UCL AC 2, LC3 48_6_2]",
 			test_setup, test_client, &str_src_ac1_48_6_2,
 			STR_SRC_AC1_48_6_2);
-	define_test("BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_6_2]",
+	define_test("BAP/UCL/STR/BV-124-C [UCL AC 10, LC3 48_6_2]",
 			test_setup, test_client, &str_src_ac4_48_6_2,
 			STR_SRC_AC4_48_6_2);
 }
 
+/* Unicast Server Streaming – 1 Stream, 1 CIS – LC3
+ *
+ * Test Purpose:
+ * Verify that a Unicast Server IUT can stream LC3-encoded audio data over one
+ * unicast Audio Stream to/from a Unicast Client.
+ *
+ * Pass verdict:
+ * If the IUT is in the Audio Source role, the IUT sends SDUs with a zero or
+ * more length, using the LC3 Media Packet format (defined in [3] Section 4.2).
+ * If the IUT is in the Audio Sink role, the IUT receives SDUs with a zero or
+ * more length, using the LC3 Media Packet format (defined in [3] Section 4.2).
+ */
+static void test_usr_str_1_1_1_lc3(void)
+{
+	define_test("BAP/USR/STR/BV-001-C [USR, AC 2, LC3 8_1_1]",
+			test_setup_server, test_server, &str_snk_ac2_8_1_1,
+			STR_SNK_AC2_8_1_1);
+	define_test("BAP/USR/STR/BV-002-C [USR, AC 10, LC3 8_1_1]",
+			test_setup_server, test_server, &str_snk_ac10_8_1_1,
+			STR_SNK_AC10_8_1_1);
+	define_test("BAP/USR/STR/BV-003-C [USR, AC 2, LC3 8_2_1]",
+			test_setup_server, test_server, &str_snk_ac2_8_2_1,
+			STR_SNK_AC2_8_2_1);
+	define_test("BAP/USR/STR/BV-004-C [USR, AC 10, LC3 8_2_1]",
+			test_setup_server, test_server, &str_snk_ac10_8_2_1,
+			STR_SNK_AC10_8_2_1);
+	define_test("BAP/USR/STR/BV-005-C [USR, AC 2, LC3 16_1_1]",
+			test_setup_server, test_server, &str_snk_ac2_16_1_1,
+			STR_SNK_AC2_16_1_1);
+	define_test("BAP/USR/STR/BV-006-C [USR, AC 10, LC3 16_1_1]",
+			test_setup_server, test_server, &str_snk_ac10_16_1_1,
+			STR_SNK_AC10_16_1_1);
+	define_test("BAP/USR/STR/BV-007-C [USR, AC 2, LC3 16_2_1]",
+			test_setup_server, test_server, &str_snk_ac2_16_2_1,
+			STR_SNK_AC2_16_2_1);
+	define_test("BAP/USR/STR/BV-008-C [USR, AC 10, LC3 16_2_1]",
+			test_setup_server, test_server, &str_snk_ac10_16_2_1,
+			STR_SNK_AC10_16_2_1);
+	define_test("BAP/USR/STR/BV-009-C [USR, AC 2, LC3 24_1_1]",
+			test_setup_server, test_server, &str_snk_ac2_24_1_1,
+			STR_SNK_AC2_24_1_1);
+	define_test("BAP/USR/STR/BV-010-C [USR, AC 10, LC3 24_1_1]",
+			test_setup_server, test_server, &str_snk_ac10_24_1_1,
+			STR_SNK_AC10_24_1_1);
+	define_test("BAP/USR/STR/BV-011-C [USR, AC 2, LC3 24_2_1]",
+			test_setup_server, test_server, &str_snk_ac2_24_2_1,
+			STR_SNK_AC2_24_2_1);
+	define_test("BAP/USR/STR/BV-012-C [USR, AC 10, LC3 24_2_1]",
+			test_setup_server, test_server, &str_snk_ac10_24_2_1,
+			STR_SNK_AC10_24_2_1);
+	define_test("BAP/USR/STR/BV-013-C [USR, AC 2, LC3 32_1_1]",
+			test_setup_server, test_server, &str_snk_ac2_32_1_1,
+			STR_SNK_AC2_32_1_1);
+	define_test("BAP/USR/STR/BV-014-C [USR, AC 10, LC3 32_1_1]",
+			test_setup_server, test_server, &str_snk_ac10_32_1_1,
+			STR_SNK_AC10_32_1_1);
+	define_test("BAP/USR/STR/BV-015-C [USR, AC 2, LC3 32_2_1]",
+			test_setup_server, test_server, &str_snk_ac2_32_2_1,
+			STR_SNK_AC2_32_2_1);
+	define_test("BAP/USR/STR/BV-016-C [USR, AC 10, LC3 32_2_1]",
+			test_setup_server, test_server, &str_snk_ac10_32_2_1,
+			STR_SNK_AC10_32_2_1);
+	define_test("BAP/USR/STR/BV-017-C [USR, AC #1, LC3 441_1_1]",
+			test_setup_server, test_server, &str_snk_ac2_44_1_1,
+			STR_SNK_AC2_44_1_1);
+	define_test("BAP/USR/STR/BV-018-C [USR, AC #4, LC3 441_1_1]",
+			test_setup_server, test_server, &str_snk_ac10_44_1_1,
+			STR_SNK_AC10_44_1_1);
+	define_test("BAP/USR/STR/BV-019-C [USR, AC #1, LC3 44_2_1]",
+			test_setup_server, test_server, &str_snk_ac2_44_2_1,
+			STR_SNK_AC2_44_2_1);
+	define_test("BAP/USR/STR/BV-020-C [USR, AC #4, LC3 44_2_1]",
+			test_setup_server, test_server, &str_snk_ac10_44_2_1,
+			STR_SNK_AC10_44_2_1);
+	define_test("BAP/USR/STR/BV-021-C [USR, AC #1, LC3 48_1_1]",
+			test_setup_server, test_server, &str_snk_ac2_48_1_1,
+			STR_SNK_AC2_48_1_1);
+	define_test("BAP/USR/STR/BV-022-C [USR, AC #4, LC3 48_1_1]",
+			test_setup_server, test_server, &str_snk_ac10_48_1_1,
+			STR_SNK_AC10_48_1_1);
+	define_test("BAP/USR/STR/BV-023-C [USR, AC #1, LC3 48_2_1]",
+			test_setup_server, test_server, &str_snk_ac2_48_2_1,
+			STR_SNK_AC2_48_2_1);
+	define_test("BAP/USR/STR/BV-024-C [USR, AC #4, LC3 48_2_1]",
+			test_setup_server, test_server, &str_snk_ac10_48_2_1,
+			STR_SNK_AC10_48_2_1);
+	define_test("BAP/USR/STR/BV-025-C [USR, AC #1, LC3 48_3_1]",
+			test_setup_server, test_server, &str_snk_ac2_48_3_1,
+			STR_SNK_AC2_48_3_1);
+	define_test("BAP/USR/STR/BV-026-C [USR, AC #4, LC3 48_3_1]",
+			test_setup_server, test_server, &str_snk_ac10_48_3_1,
+			STR_SNK_AC10_48_3_1);
+	define_test("BAP/USR/STR/BV-027-C [USR, AC #1, LC3 48_4_1]",
+			test_setup_server, test_server, &str_snk_ac2_48_4_1,
+			STR_SNK_AC2_48_4_1);
+	define_test("BAP/USR/STR/BV-028-C [USR, AC #4, LC3 48_4_1]",
+			test_setup_server, test_server, &str_snk_ac10_48_4_1,
+			STR_SNK_AC10_48_4_1);
+	define_test("BAP/USR/STR/BV-029-C [USR, AC #1, LC3 48_5_1]",
+			test_setup_server, test_server, &str_snk_ac2_48_5_1,
+			STR_SNK_AC2_48_5_1);
+	define_test("BAP/USR/STR/BV-030-C [USR, AC #4, LC3 48_5_1]",
+			test_setup_server, test_server, &str_snk_ac10_48_5_1,
+			STR_SNK_AC10_48_5_1);
+	define_test("BAP/USR/STR/BV-031-C [USR, AC #1, LC3 48_6_1]",
+			test_setup_server, test_server, &str_snk_ac2_48_6_1,
+			STR_SNK_AC2_48_6_1);
+	define_test("BAP/USR/STR/BV-032-C [USR, AC #4, LC3 48_6_1]",
+			test_setup_server, test_server, &str_snk_ac10_48_6_1,
+			STR_SNK_AC10_48_6_1);
+	define_test("BAP/USR/STR/BV-033-C [USR AC 2, LC3 8_1_1]",
+			test_setup_server, test_server, &str_src_ac1_8_1_1,
+			STR_SRC_AC1_8_1_1);
+	define_test("BAP/USR/STR/BV-034-C [USR AC 10, LC3 8_1_1]",
+			test_setup_server, test_server, &str_src_ac4_8_1_1,
+			STR_SRC_AC4_8_1_1);
+	define_test("BAP/USR/STR/BV-035-C [USR AC 2, LC3 8_2_1]",
+			test_setup_server, test_server, &str_src_ac1_8_2_1,
+			STR_SRC_AC1_8_2_1);
+	define_test("BAP/USR/STR/BV-036-C [USR AC 10, LC3 8_2_1]",
+			test_setup_server, test_server, &str_src_ac4_8_2_1,
+			STR_SRC_AC4_8_2_1);
+	define_test("BAP/USR/STR/BV-037-C [USR AC 2, LC3 16_1_1]",
+			test_setup_server, test_server, &str_src_ac1_16_1_1,
+			STR_SRC_AC1_16_1_1);
+	define_test("BAP/USR/STR/BV-038-C [USR AC 10, LC3 16_1_1]",
+			test_setup_server, test_server, &str_src_ac4_16_1_1,
+			STR_SRC_AC4_16_1_1);
+	define_test("BAP/USR/STR/BV-039-C [USR AC 2, LC3 16_2_1]",
+			test_setup_server, test_server, &str_src_ac1_16_2_1,
+			STR_SRC_AC1_16_2_1);
+	define_test("BAP/USR/STR/BV-040-C [USR AC 10, LC3 16_2_1]",
+			test_setup_server, test_server, &str_src_ac4_16_2_1,
+			STR_SRC_AC4_16_2_1);
+	define_test("BAP/USR/STR/BV-041-C [USR AC 2, LC3 24_1_1]",
+			test_setup_server, test_server, &str_src_ac1_24_1_1,
+			STR_SRC_AC1_24_1_1);
+	define_test("BAP/USR/STR/BV-042-C [USR AC 10, LC3 24_1_1]",
+			test_setup_server, test_server, &str_src_ac4_24_1_1,
+			STR_SRC_AC4_24_1_1);
+	define_test("BAP/USR/STR/BV-043-C [USR AC 2, LC3 24_2_1]",
+			test_setup_server, test_server, &str_src_ac1_24_2_1,
+			STR_SRC_AC1_24_2_1);
+	define_test("BAP/USR/STR/BV-044-C [USR AC 10, LC3 24_2_1]",
+			test_setup_server, test_server, &str_src_ac4_24_2_1,
+			STR_SRC_AC4_24_2_1);
+	define_test("BAP/USR/STR/BV-045-C [USR AC 2, LC3 32_1_1]",
+			test_setup_server, test_server, &str_src_ac1_32_1_1,
+			STR_SRC_AC1_32_1_1);
+	define_test("BAP/USR/STR/BV-046-C [USR AC 10, LC3 32_1_1]",
+			test_setup_server, test_server, &str_src_ac4_32_1_1,
+			STR_SRC_AC4_32_1_1);
+	define_test("BAP/USR/STR/BV-047-C [USR AC 2, LC3 32_2_1]",
+			test_setup_server, test_server, &str_src_ac1_32_2_1,
+			STR_SRC_AC1_32_2_1);
+	define_test("BAP/USR/STR/BV-048-C [USR AC 10, LC3 32_2_1]",
+			test_setup_server, test_server, &str_src_ac4_32_2_1,
+			STR_SRC_AC4_32_2_1);
+	define_test("BAP/USR/STR/BV-049-C [USR AC 2, LC3 44_1_1]",
+			test_setup_server, test_server, &str_src_ac1_44_1_1,
+			STR_SRC_AC1_44_1_1);
+	define_test("BAP/USR/STR/BV-050-C [USR AC 10, LC3 44_1_1]",
+			test_setup_server, test_server, &str_src_ac4_44_1_1,
+			STR_SRC_AC4_44_1_1);
+	define_test("BAP/USR/STR/BV-051-C [USR AC 2, LC3 44_2_1]",
+			test_setup_server, test_server, &str_src_ac1_44_2_1,
+			STR_SRC_AC1_44_2_1);
+	define_test("BAP/USR/STR/BV-052-C [USR AC 10, LC3 44_2_1]",
+			test_setup_server, test_server, &str_src_ac4_44_2_1,
+			STR_SRC_AC4_44_2_1);
+	define_test("BAP/USR/STR/BV-053-C [USR AC 2, LC3 48_1_1]",
+			test_setup_server, test_server, &str_src_ac1_48_1_1,
+			STR_SRC_AC1_48_1_1);
+	define_test("BAP/USR/STR/BV-054-C [USR AC 10, LC3 48_1_1]",
+			test_setup_server, test_server, &str_src_ac4_48_1_1,
+			STR_SRC_AC4_48_1_1);
+	define_test("BAP/USR/STR/BV-055-C [USR AC 2, LC3 48_2_1]",
+			test_setup_server, test_server, &str_src_ac1_48_2_1,
+			STR_SRC_AC1_48_2_1);
+	define_test("BAP/USR/STR/BV-056-C [USR AC 10, LC3 48_2_1]",
+			test_setup_server, test_server, &str_src_ac4_48_2_1,
+			STR_SRC_AC4_48_2_1);
+	define_test("BAP/USR/STR/BV-057-C [USR AC 2, LC3 48_3_1]",
+			test_setup_server, test_server, &str_src_ac1_48_3_1,
+			STR_SRC_AC1_48_3_1);
+	define_test("BAP/USR/STR/BV-058-C [USR AC 10, LC3 48_3_1]",
+			test_setup_server, test_server, &str_src_ac4_48_3_1,
+			STR_SRC_AC4_48_3_1);
+	define_test("BAP/USR/STR/BV-059-C [USR AC 2, LC3 48_4_1]",
+			test_setup_server, test_server, &str_src_ac1_48_4_1,
+			STR_SRC_AC1_48_4_1);
+	define_test("BAP/USR/STR/BV-060-C [USR AC 10, LC3 48_4_1]",
+			test_setup_server, test_server, &str_src_ac4_48_4_1,
+			STR_SRC_AC4_48_4_1);
+	define_test("BAP/USR/STR/BV-061-C [USR AC 2, LC3 48_5_1]",
+			test_setup_server, test_server, &str_src_ac1_48_5_1,
+			STR_SRC_AC1_48_5_1);
+	define_test("BAP/USR/STR/BV-062-C [USR AC 10, LC3 48_5_1]",
+			test_setup_server, test_server, &str_src_ac4_48_5_1,
+			STR_SRC_AC4_48_5_1);
+	define_test("BAP/USR/STR/BV-063-C [USR AC 2, LC3 48_6_1]",
+			test_setup_server, test_server, &str_src_ac1_48_6_1,
+			STR_SRC_AC1_48_6_1);
+	define_test("BAP/USR/STR/BV-064-C [USR AC 10, LC3 48_6_1]",
+			test_setup_server, test_server, &str_src_ac4_48_6_1,
+			STR_SRC_AC4_48_6_1);
+	define_test("BAP/USR/STR/BV-065-C [USR, AC #1, LC3 8_1_2]",
+			test_setup_server, test_server, &str_snk_ac2_8_1_2,
+			STR_SNK_AC2_8_1_2);
+	define_test("BAP/USR/STR/BV-066-C [USR, AC #4, LC3 8_1_2]",
+			test_setup_server, test_server, &str_snk_ac10_8_1_2,
+			STR_SNK_AC10_8_1_2);
+	define_test("BAP/USR/STR/BV-067-C [USR, AC #1, LC3 8_2_2]",
+			test_setup_server, test_server, &str_snk_ac2_8_2_2,
+			STR_SNK_AC2_8_2_2);
+	define_test("BAP/USR/STR/BV-068-C [USR, AC #4, LC3 8_2_2]",
+			test_setup_server, test_server, &str_snk_ac10_8_2_2,
+			STR_SNK_AC10_8_2_2);
+	define_test("BAP/USR/STR/BV-069-C [USR, AC #1, LC3 16_1_2]",
+			test_setup_server, test_server, &str_snk_ac2_16_1_2,
+			STR_SNK_AC2_16_1_2);
+	define_test("BAP/USR/STR/BV-070-C [USR, AC #4, LC3 16_1_2]",
+			test_setup_server, test_server, &str_snk_ac10_16_1_2,
+			STR_SNK_AC10_16_1_2);
+	define_test("BAP/USR/STR/BV-071-C [USR, AC #1, LC3 16_2_2]",
+			test_setup_server, test_server, &str_snk_ac2_16_2_2,
+			STR_SNK_AC2_16_2_2);
+	define_test("BAP/USR/STR/BV-072-C [USR, AC #4, LC3 16_2_2]",
+			test_setup_server, test_server, &str_snk_ac10_16_2_2,
+			STR_SNK_AC10_16_2_2);
+	define_test("BAP/USR/STR/BV-073-C [USR, AC #1, LC3 24_1_2]",
+			test_setup_server, test_server, &str_snk_ac2_24_1_2,
+			STR_SNK_AC2_24_1_2);
+	define_test("BAP/USR/STR/BV-074-C [USR, AC #4, LC3 24_1_2]",
+			test_setup_server, test_server, &str_snk_ac10_24_1_2,
+			STR_SNK_AC10_24_1_2);
+	define_test("BAP/USR/STR/BV-075-C [USR, AC #1, LC3 24_2_2]",
+			test_setup_server, test_server, &str_snk_ac2_24_2_2,
+			STR_SNK_AC2_24_2_2);
+	define_test("BAP/USR/STR/BV-076-C [USR, AC #4, LC3 24_2_2]",
+			test_setup_server, test_server, &str_snk_ac10_24_2_2,
+			STR_SNK_AC10_24_2_2);
+	define_test("BAP/USR/STR/BV-077-C [USR, AC #1, LC3 32_1_2]",
+			test_setup_server, test_server, &str_snk_ac2_32_1_2,
+			STR_SNK_AC2_32_1_2);
+	define_test("BAP/USR/STR/BV-078-C [USR, AC #4, LC3 32_1_2]",
+			test_setup_server, test_server, &str_snk_ac10_32_1_2,
+			STR_SNK_AC10_32_1_2);
+	define_test("BAP/USR/STR/BV-079-C [USR, AC #1, LC3 32_2_2]",
+			test_setup_server, test_server, &str_snk_ac2_32_2_2,
+			STR_SNK_AC2_32_2_2);
+	define_test("BAP/USR/STR/BV-080-C [USR, AC #4, LC3 32_2_2]",
+			test_setup_server, test_server, &str_snk_ac10_32_2_2,
+			STR_SNK_AC10_32_2_2);
+	define_test("BAP/USR/STR/BV-081-C [USR, AC #1, LC3 44_1_2]",
+			test_setup_server, test_server, &str_snk_ac2_44_1_2,
+			STR_SNK_AC2_44_1_2);
+	define_test("BAP/USR/STR/BV-082-C [USR, AC #4, LC3 44_1_2]",
+			test_setup_server, test_server, &str_snk_ac10_44_1_2,
+			STR_SNK_AC10_44_1_2);
+	define_test("BAP/USR/STR/BV-083-C [USR, AC #1, LC3 44_2_2]",
+			test_setup_server, test_server, &str_snk_ac2_44_2_2,
+			STR_SNK_AC2_44_2_2);
+	define_test("BAP/USR/STR/BV-084-C [USR, AC #4, LC3 44_2_2]",
+			test_setup_server, test_server, &str_snk_ac10_44_2_2,
+			STR_SNK_AC10_44_2_2);
+	define_test("BAP/USR/STR/BV-085-C [USR, AC #1, LC3 48_1_2]",
+			test_setup_server, test_server, &str_snk_ac2_48_1_2,
+			STR_SNK_AC2_48_1_2);
+	define_test("BAP/USR/STR/BV-086-C [USR, AC #4, LC3 48_1_2]",
+			test_setup_server, test_server, &str_snk_ac10_48_1_2,
+			STR_SNK_AC10_48_1_2);
+	define_test("BAP/USR/STR/BV-087-C [USR, AC #1, LC3 48_2_2]",
+			test_setup_server, test_server, &str_snk_ac2_48_2_2,
+			STR_SNK_AC2_48_2_2);
+	define_test("BAP/USR/STR/BV-088-C [USR, AC #4, LC3 48_2_2]",
+			test_setup_server, test_server, &str_snk_ac10_48_2_2,
+			STR_SNK_AC10_48_2_2);
+	define_test("BAP/USR/STR/BV-089-C [USR, AC #1, LC3 48_3_2]",
+			test_setup_server, test_server, &str_snk_ac2_48_3_2,
+			STR_SNK_AC2_48_3_2);
+	define_test("BAP/USR/STR/BV-090-C [USR, AC #4, LC3 48_3_2]",
+			test_setup_server, test_server, &str_snk_ac10_48_3_2,
+			STR_SNK_AC10_48_3_2);
+	define_test("BAP/USR/STR/BV-091-C [USR, AC #1, LC3 48_4_2]",
+			test_setup_server, test_server, &str_snk_ac2_48_4_2,
+			STR_SNK_AC2_48_4_2);
+	define_test("BAP/USR/STR/BV-092-C [USR, AC #4, LC3 48_4_2]",
+			test_setup_server, test_server, &str_snk_ac10_48_4_2,
+			STR_SNK_AC10_48_4_2);
+	define_test("BAP/USR/STR/BV-093-C [USR, AC #1, LC3 48_5_2]",
+			test_setup_server, test_server, &str_snk_ac2_48_5_2,
+			STR_SNK_AC2_48_5_2);
+	define_test("BAP/USR/STR/BV-094-C [USR, AC #4, LC3 48_5_2]",
+			test_setup_server, test_server, &str_snk_ac10_48_5_2,
+			STR_SNK_AC10_48_5_2);
+	define_test("BAP/USR/STR/BV-095-C [USR, AC #1, LC3 48_6_2]",
+			test_setup_server, test_server, &str_snk_ac2_48_6_2,
+			STR_SNK_AC2_48_6_2);
+	define_test("BAP/USR/STR/BV-096-C [USR, AC #4, LC3 48_6_2]",
+			test_setup_server, test_server, &str_snk_ac10_48_6_2,
+			STR_SNK_AC10_48_6_2);
+	define_test("BAP/USR/STR/BV-097-C [USR AC 2, LC3 8_1_2]",
+			test_setup_server, test_server, &str_src_ac1_8_1_2,
+			STR_SRC_AC1_8_1_2);
+	define_test("BAP/USR/STR/BV-098-C [USR AC 10, LC3 8_1_2]",
+			test_setup_server, test_server, &str_src_ac4_8_1_2,
+			STR_SRC_AC4_8_1_2);
+	define_test("BAP/USR/STR/BV-099-C [USR AC 2, LC3 8_2_2]",
+			test_setup_server, test_server, &str_src_ac1_8_2_2,
+			STR_SRC_AC1_8_2_2);
+	define_test("BAP/USR/STR/BV-100-C [USR AC 10, LC3 8_2_2]",
+			test_setup_server, test_server, &str_src_ac4_8_2_2,
+			STR_SRC_AC4_8_2_2);
+	define_test("BAP/USR/STR/BV-101-C [USR AC 2, LC3 16_1_2]",
+			test_setup_server, test_server, &str_src_ac1_16_1_2,
+			STR_SRC_AC1_16_1_2);
+	define_test("BAP/USR/STR/BV-102-C [USR AC 10, LC3 16_1_2]",
+			test_setup_server, test_server, &str_src_ac4_16_1_2,
+			STR_SRC_AC4_16_1_2);
+	define_test("BAP/USR/STR/BV-103-C [USR AC 2, LC3 16_2_2]",
+			test_setup_server, test_server, &str_src_ac1_16_2_2,
+			STR_SRC_AC1_16_2_2);
+	define_test("BAP/USR/STR/BV-104-C [USR AC 10, LC3 16_2_2]",
+			test_setup_server, test_server, &str_src_ac4_16_2_2,
+			STR_SRC_AC4_16_2_2);
+	define_test("BAP/USR/STR/BV-105-C [USR AC 2, LC3 24_1_2]",
+			test_setup_server, test_server, &str_src_ac1_24_1_2,
+			STR_SRC_AC1_24_1_2);
+	define_test("BAP/USR/STR/BV-106-C [USR AC 10, LC3 24_1_2]",
+			test_setup_server, test_server, &str_src_ac4_24_1_2,
+			STR_SRC_AC4_24_1_2);
+	define_test("BAP/USR/STR/BV-107-C [USR AC 2, LC3 24_2_2]",
+			test_setup_server, test_server, &str_src_ac1_24_2_2,
+			STR_SRC_AC1_24_2_2);
+	define_test("BAP/USR/STR/BV-108-C [USR AC 10, LC3 24_2_2]",
+			test_setup_server, test_server, &str_src_ac4_24_2_2,
+			STR_SRC_AC4_24_2_2);
+	define_test("BAP/USR/STR/BV-109-C [USR AC 2, LC3 32_1_2]",
+			test_setup_server, test_server, &str_src_ac1_32_1_2,
+			STR_SRC_AC1_32_1_2);
+	define_test("BAP/USR/STR/BV-110-C [USR AC 10, LC3 32_1_2]",
+			test_setup_server, test_server, &str_src_ac4_32_1_2,
+			STR_SRC_AC4_32_1_2);
+	define_test("BAP/USR/STR/BV-111-C [USR AC 2, LC3 32_2_2]",
+			test_setup_server, test_server, &str_src_ac1_32_2_2,
+			STR_SRC_AC1_32_2_2);
+	define_test("BAP/USR/STR/BV-112-C [USR AC 10, LC3 32_2_2]",
+			test_setup_server, test_server, &str_src_ac4_32_2_2,
+			STR_SRC_AC4_32_2_2);
+	define_test("BAP/USR/STR/BV-113-C [USR AC 2, LC3 44_1_2]",
+			test_setup_server, test_server, &str_src_ac1_44_1_2,
+			STR_SRC_AC1_44_1_2);
+	define_test("BAP/USR/STR/BV-114-C [USR AC 10, LC3 44_1_2]",
+			test_setup_server, test_server, &str_src_ac4_44_1_2,
+			STR_SRC_AC4_44_1_2);
+	define_test("BAP/USR/STR/BV-115-C [USR AC 2, LC3 44_2_2]",
+			test_setup_server, test_server, &str_src_ac1_44_2_2,
+			STR_SRC_AC1_44_2_2);
+	define_test("BAP/USR/STR/BV-116-C [USR AC 10, LC3 44_2_2]",
+			test_setup_server, test_server, &str_src_ac4_44_2_2,
+			STR_SRC_AC4_44_2_2);
+	define_test("BAP/USR/STR/BV-117-C [USR AC 2, LC3 48_1_2]",
+			test_setup_server, test_server, &str_src_ac1_48_1_2,
+			STR_SRC_AC1_48_1_2);
+	define_test("BAP/USR/STR/BV-118-C [USR AC 10, LC3 48_1_2]",
+			test_setup_server, test_server, &str_src_ac4_48_1_2,
+			STR_SRC_AC4_48_1_2);
+	define_test("BAP/USR/STR/BV-119-C [USR AC 2, LC3 48_2_2]",
+			test_setup_server, test_server, &str_src_ac1_48_2_2,
+			STR_SRC_AC1_48_2_2);
+	define_test("BAP/USR/STR/BV-120-C [USR AC 10, LC3 48_2_2]",
+			test_setup_server, test_server, &str_src_ac4_48_2_2,
+			STR_SRC_AC4_48_2_2);
+	define_test("BAP/USR/STR/BV-121-C [USR AC 1, LC3 48_3_2]",
+			test_setup_server, test_server, &str_src_ac1_48_3_2,
+			STR_SRC_AC1_48_3_2);
+	define_test("BAP/USR/STR/BV-122-C [USR AC 4, LC3 48_3_2]",
+			test_setup_server, test_server, &str_src_ac4_48_3_2,
+			STR_SRC_AC4_48_3_2);
+	define_test("BAP/USR/STR/BV-123-C [USR AC 1, LC3 48_4_2]",
+			test_setup_server, test_server, &str_src_ac1_48_4_2,
+			STR_SRC_AC1_48_4_2);
+	define_test("BAP/USR/STR/BV-124-C [USR AC 4, LC3 48_4_2]",
+			test_setup_server, test_server, &str_src_ac4_48_4_2,
+			STR_SRC_AC4_48_4_2);
+	define_test("BAP/USR/STR/BV-121-C [USR AC 1, LC3 48_5_2]",
+			test_setup_server, test_server, &str_src_ac1_48_5_2,
+			STR_SRC_AC1_48_5_2);
+	define_test("BAP/USR/STR/BV-122-C [USR AC 4, LC3 48_5_2]",
+			test_setup_server, test_server, &str_src_ac4_48_5_2,
+			STR_SRC_AC4_48_5_2);
+	define_test("BAP/USR/STR/BV-123-C [USR AC 1, LC3 48_6_2]",
+			test_setup_server, test_server, &str_src_ac1_48_6_2,
+			STR_SRC_AC1_48_6_2);
+	define_test("BAP/USR/STR/BV-124-C [USR AC 4, LC3 48_6_2]",
+			test_setup_server, test_server, &str_src_ac4_48_6_2,
+			STR_SRC_AC4_48_6_2);
+}
+
+static void test_str_1_1_1_lc3(void)
+{
+	test_ucl_str_1_1_1_lc3();
+	test_usr_str_1_1_1_lc3();
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
-- 
2.49.0

