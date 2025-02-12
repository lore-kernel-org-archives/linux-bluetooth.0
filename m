Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E982557C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368379; cv=none; b=g5qrDC96zetN3QQsJMUjCChJcBXCcYoQ0WPAjSgvTsk+nnla/DsTO/E7UhwRZusMyoNaQhEz7avaZWRwzdYGmsMJhGeG2ULcAPiDiLJ1lWNZLf7aNW/Wx47ibBkjboO8Asn3NjD0Liv21oAg5rMhpN9lp2UL53+H1FNO4SWNiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368379; c=relaxed/simple;
	bh=tbIX3S4X5GkceDSqbkwtmfR4ZtWze+U8rGdMFDFSyy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLhbnW0jY52ExhYvSMWqdrmLoRSaEyQ0FabLOIeQkJTuXZq0pnit8li3UGp5gJ7erfD9UyUKIbbgclEOUxrJ6MO72tvGi89dhGHSpIsL4Or7IR31y+nSMchchcY49goxAc/TOo23iwOxgPGv+U5Lser4TCi3GkJwnJXfI/TKjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKqwb2Fa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKqwb2Fa"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5deae16ab51so1521399a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368375; x=1739973175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYGo/bEB2uDStepJ0jKx+iF8uJTswY4rtjzzGBu1SMo=;
        b=fKqwb2Fau2XYqGpc3b43pNAoPZhgTXf/qAYIigcJkdG0ku3J+WLvmJj0Oo2/QYjs/z
         xW1Ar6x+baezbvWdUMHKRwCTFPZOsa3eUEey+X+2YVLc4amVyOzvlfeIE5L6T+GAuSuT
         o6w51t/lHcCx6l1GuaTXnDCzv/WtHyLJfVQrO9qVGuu87AVsXxxAhgsrUOcUAZN/Ytce
         +Afbv1jLzN5zzBhrwV5vQaZKQtMW3P0WMF19P6CzBvce+QoAo0pg916BUBMeE13SGQbE
         KhTLnQ+4xejZcmzT6lylzilmqigrTS3huQfqXrBCj5fVwm2a83gRPoveXG8SFSbgpyGL
         y3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368375; x=1739973175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYGo/bEB2uDStepJ0jKx+iF8uJTswY4rtjzzGBu1SMo=;
        b=WmbfV48HwObZ+ZFFOnOinNGwhhKS4XEXMrmL+cmmRw9CM/7XAniWjCg5KMTcg1z2T5
         PW/Qqp7efsM/UrdQw9heyJH/SyhCtZo2cbn3hNUMj+fskg/peRzLE1Nnh9SWkqq4IZpc
         vLXF/SLpo4fdNDomRTqNZb+Xo7YUAMPzngFxWduGpk+J1xI43QnKMcOYegG+bpacnb4a
         Kh/LmOYefB9NsGjcvt2V+CwGiXhgoD0my/j9/T45VxFQcxMzCjfWsyPodlBz0GwFAa/E
         lX+gOh1zHnR0OOXu0UDK+jdBRRcELPAIfV2n8hg92xXjL6TnKNNW/c1xJi/mzssFelQ+
         Gp4Q==
X-Gm-Message-State: AOJu0Yw026CLw4SU9oSFJhOyEj5/W+e1LOINskyWf8oeW1p7bfna37JU
	1Fj89Altd0ffu4oum3VVeUqJYHmXEj75sDYzkvPUEbELpxmAJ7ITxP2MKsKI
X-Gm-Gg: ASbGncvE18FELcVU0eUHNHKM3zS6Lv/c63j5ZWl5ty7YqKL892TJQK6ycxDPzwQ1QfF
	s6TAhKThIsunRm3lrJCL58Zh1Oj0qdseFHqBpqslIda6uUiTedGARUWfq6/P4kvrySyoER1GiuU
	KJCWxOC7ZDo0qdCttMQ4JJWT3GbxljewHdiWIQXk7WrMzHqspCz8Y7Hn19p9EXhMOLuS6w//Bot
	uBWwEINRfndcU18Nz2LReGkvGgcmHpMkH/Aj48b212OpCcOVFij15z6+BUJFj5MATkGdPI+DOGa
	rDfaI2j2EGXZqTsiRbvkEPeKPE/tayEM73kq7lpW05iKkWMVPjlBWdYX05ksMS6/unWVZgnVHqK
	Z2K+PWVICHSU=
X-Google-Smtp-Source: AGHT+IHHkxXTdRMU7hrUc1Kt7J5ZiWqowPgbRE5mS9gMZcsIPH0EF0JXe9XIRuyr2BvFyIhkwCgN6w==
X-Received: by 2002:a05:6402:51cf:b0:5dc:796f:fc86 with SMTP id 4fb4d7f45d1cf-5deadd9d31cmr8073260a12.16.1739368374450;
        Wed, 12 Feb 2025 05:52:54 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm1169870166b.102.2025.02.12.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:52:54 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 4/4] test-runner: Use host CPU when starting VM
Date: Wed, 12 Feb 2025 14:52:09 +0100
Message-Id: <20250212135209.129361-4-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
References: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running test-runner on Ubuntu 24.04 with mainline kernel compiled
from Ubuntu default configuration with applied tester.config options,
the QEMU is not able to start the test-runner application due to illegal
instruction. Passing '-cpu host' fixes that issue.

> $ tools/test-runner -k linux/arch/x86/boot/bzImage -- tools/mgmt-tester
> Using QEMU binary /usr/bin/qemu-system-x86_64
> Using kernel image [...]/linux/arch/x86/boot/bzImage
> Found support for Virtual Machine eXtensions
> [...]
> [    0.000000] Linux version 6.14.0-rc2+ (gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0 [...]
> [...]
> Running command tools/mgmt-tester
> New process 74 created
> Illegal instruction
> Process 74 exited with status 132
> [    0.881239] reboot: Restarting system
> [    0.881431] reboot: machine restart

Potential caveat:

In case when the KVM is not available on the host, the QEMU will not
start with the warning:
CPU model 'host' requires KVM or HVF
---
 tools/test-runner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1fc95d33f..48e114174 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -211,6 +211,7 @@ static char *const qemu_argv[] = {
 	"-monitor", "none",
 	"-display", "none",
 	"-machine", "type=q35,accel=kvm:tcg",
+	"-cpu", "host",
 	"-m", "256M",
 	"-net", "none",
 	"-no-reboot",
-- 
2.43.0

