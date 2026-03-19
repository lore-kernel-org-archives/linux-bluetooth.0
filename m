Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B130E0FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929682; cv=none; b=shJtYfuWgQOCnIY0QhEK/atEaJRsyw7IRjNvjeZZpSb/f5VhUA4kl7905tHYfqjYm93faJqPMfK2gwzEpRflU+pbQPckgMOXnffEFw3p9ZvNc0piTxSa68vXhhGilDm8SZcC4ESpHig6Z8HpF0klNKfNownmozXC4UdnM2A7H34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929682; c=relaxed/simple;
	bh=lq7TDBQzGVBpIOEJvgezB3UQxZDzSP6Rt/1MgD9lT2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXZsQxQ5SqjEFxTPfRNRPuEzn5MSGoTs+UC3LBaZMq/UimstFxej19o+XwviKdVLzOezswWXvORInFUJhzTUkOIyB5NfjS7V2PUZwCHmcqdon/swy3ueT4K4BdrmnpiVnOkVuxeVCkzyfJGxxaqX6k7iW6h1dZHlcCE1Zs/iCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl; spf=pass smtp.mailfrom=xesxen.nl; dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b=XLAJqDF4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b="XLAJqDF4"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b97c44417ffso106241066b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xesxen.nl; s=google; t=1773929679; x=1774534479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Od/fZavLR0eVv3dllpIAAXpohUMlCquPzwgENtl5ZfA=;
        b=XLAJqDF46p894pmxaCF6k606/xnAxPRg58lac+cBS5+GPL0vG4yJ58aw17KBQ9FxtW
         xSovWxkuYVKW5Ta6iXMFuaK09Y5lJUWL0ddgcNRk6saLpFjVM4tBrFdYYznqeNEy2vLH
         v/lhYwMLwoh+3UtY4pErWVh0HWiR8aVKK794U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929679; x=1774534479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od/fZavLR0eVv3dllpIAAXpohUMlCquPzwgENtl5ZfA=;
        b=bJZkGdaOJ5GqM/QCXTLvMvIqExSeNGZWa4KZjnElNAKvmLu8KEkmVer7a08g1k6gMF
         xzG9CwYPkbeUc/CpF9JAuJnHUarayQDeeKa1t3l59KjPWQ5IxhS1rfihW3gb2wokKh6t
         yd3QBBTpQp35MmsziJzZghfn95LlF2xsn/EYyIIuwmHslKIhpM1yr0TbHBnPz5X2MJ/s
         TqfDq6Aupsi0ZdWMO5E82FahzpGGdYm9+4oKXk8DKzqZw0RAe8zK/3L7UQH16SlZ9yso
         y00iHnytMbW7KYVu0WMKl3QMxE5Q2ayu6NHJif2ihFdzeI1EEqRcCpQwluSaRHF5jd95
         mKvw==
X-Gm-Message-State: AOJu0Yw8WHpTDwT+jvYAdius3JddsGh3yM3PmzBmqGk7V1eJbJhPOYhB
	a9VdHVjhEZtuVns2QBX0HLndeYYVraSaPoILdnJeIDdOVJQI7gWfGVGlXlxeS4FBOp+8Tu70FmK
	xRf6pZNE=
X-Gm-Gg: ATEYQzwbcZwLfS15IkQG+zsPE0lyKt3/IexYlnF/sDTgVe0D4zUEwUC0uq24s6GDpGP
	854jy3DA1WmBY7rgwEZQNZsz0rAOBYCrauPNOwk5zvJgTsOA92AlFRCwnDVOSGlj232D83w5jSE
	nKgQPnSkcMl/Dn7imNe15ti6JYzlvYKW7HSpNvtfaK1TnhgxQVcy1sVk67NMio1189QXhakC/OV
	AkOvpUeT3/5gTiHl6ZnQHuX0kPAbjS08XqtGpK239gPrT3OCSZv8ru0XgcNNjtXjJ3uV2F4L5bk
	98krjcq6zNNj4U68rkgDU5a6290gZq6HKvXvZDnnvqayoTEA8SamlDQwneielIhJQRZ+nu9Qstq
	SYChu6Rht7RgVWihYsSQk4/HfSntohuQnyPaOeql63ZzyHITHYQEcfUDsSwVJmME3ezweDf4FSK
	szmKJVD3jvZgot
X-Received: by 2002:a17:906:6b1b:b0:b97:1d24:bfdb with SMTP id a640c23a62f3a-b97f4a8395bmr393248166b.47.1773929678858;
        Thu, 19 Mar 2026 07:14:38 -0700 (PDT)
Received: from tomoyo ([2a10:3781:4903:0:eca5:f23c:3275:af25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3ccsm443100466b.59.2026.03.19.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:14:38 -0700 (PDT)
From: Wouter <wouter@xesxen.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Subject: [PATCH BlueZ v2 0/1] shared/shell: Fix SIGSEGV on invalid input
Date: Thu, 19 Mar 2026 15:14:34 +0100
Message-ID: <20260319141435.83060-1-wouter@xesxen.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have updated the patch according to feedback received earlier today.
The valgrind input has been attached as a commit message, and checks are
now applied further down the callstack rather than at the source.

--

In `bluetoothctl` when entering a space followed by a tab the CLI
crashes with a segfault. This patch fixes the user input handling.

Wouter (1):
  shared/shell: Fix SIGSEGV on invalid input

 src/shared/shell.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.53.0

