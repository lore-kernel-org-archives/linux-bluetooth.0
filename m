Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718B49641
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470668; cv=none; b=M2bsHsM8O9j+QX6J9O2ymSD2IZy0jiI/EmVMzWJbGHRPOIpyhnGgbpEALSHrDkgdEez9S7iNAEtMNpjGOAeg73RWMA5J5qMr6X46PCNsvz4FRP9Rd1SCNo1ENsWk5+TXEXQEHpZjdWlmPhdY+BeyMmj1I7QKoEU57KNs4gw5680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470668; c=relaxed/simple;
	bh=HtKdF4kx2xozLT8iB8BNpJfFF548fMV5UnsN3tiz85k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6jzEuuxVVy1NZu0k4wFdfXus5FmsTGdsMLk9c3wSZ/YpPwkJ33wcAulEPLAhMiX5O8VlVXgLvlklMkWRTpAgAd70wkU6/ESGebdx97aNSMTjqGWEEpoBIGfhRiEpFDBKJLw94aXYLrY/JjfBr2HtYopBJw/UltChc/yqY+X4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=o6oVLvFF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="o6oVLvFF"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401c52000fso5519935e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737470662; x=1738075462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqEBy0LsaXfAOX0nqZGI/AeJfDkQw2v8JOqvZ+VKql0=;
        b=o6oVLvFF98ZC2hzGGhPLPJek2DWypCjs6Xlg2UGTHTPSi0XN0iSWIg2rjkgmj3r5VL
         rw/bkaE3EngfJf6+9D14I6ObQyqCpMQkGwLFxqxoFBaRcGsSRR0MOOiKr3jaiu7QAhw+
         4QalfnIHmW0tB6IHIq/e/s0LaHKgeVgjiF+ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470662; x=1738075462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqEBy0LsaXfAOX0nqZGI/AeJfDkQw2v8JOqvZ+VKql0=;
        b=URISnaoEIWHNiPIQfm5jrBNch4/jPaBlDcppVA1PrQ0FwwqpFioGsFpnmBQyC+ZDJn
         9prPH+ZUoXKUEBtljXdNKNxJzzs1T+a5ZnOL2FFWxiLX4njgApJmMWO/WDA3OEZsqG2S
         o/CLDuZGJorWU7BjYYLErIx8qy549Wsbdr23dv8UGlkYlZRs/ve30r78+vQ6Rh357X6S
         Hsp35jWWPaodevXi1Vt9blwS8n6+YbW7+oCIHceUkKRmkdEU30ogz/oeVtzAQsAYFN2k
         DfK3EiEWyzNx24FN4DGXqcUDV3RAsbV8C9Xlgftrg6MT1MzLW0EEsYXnT79mOX+GVxHC
         7VLw==
X-Gm-Message-State: AOJu0YwgFNNeJ7C/NIpW0DjrUFbZdU5Tz6yfqE/g36FnsMywmnbeprh1
	xYTwfOevledr6PpJmidncH6QmGZ7SzL9ikgeqJLIlZWXM1gJz5rB8vf6ZL/0gsEbyBYy/19RVV4
	=
X-Gm-Gg: ASbGncsvc4tIHTAHZy/1qhnnAwe2vBY3ZeBMVQrJ/hkoSXi65+zsMwgxaT4u7cO/97m
	H5AdBN8e5TQjVkUQQw51NdZyWLhTduw8CtYJhes6g1OVPFp0dgDtg9V307x8r4ll9jiceQhd97l
	gX9Y8yf+RCIm5u2bHFWz/787rYhoqDghb5JS1r+fxk49Umv9qXS/Z5xeFoMyI2PcxZsesDxjFlY
	B926b+FhAXj/wsfIMuzSS/QHnrgrG5ZYdE6MZ0zujy7z4JU4LFbviE2z4eaXDPQrW0wt5NErJYK
	dyKO6JGuvxjcSmYmkJrt+KRh1a3JyuivQSDlwRGOGDB/
X-Google-Smtp-Source: AGHT+IHx2E73Urdug7JztYM0hJZGHlcQipUapne1ztgnqT1lNlYL3BkroGVb8fq+yCQdpAGTPxrR+w==
X-Received: by 2002:ac2:5de4:0:b0:542:2990:5d61 with SMTP id 2adb3069b0e04-5439c2539a3mr4165007e87.25.1737470662310;
        Tue, 21 Jan 2025 06:44:22 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af733fdsm1866237e87.174.2025.01.21.06.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:22 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v3 0/5] connect VCP profile to MediaTransport volume
Date: Tue, 21 Jan 2025 15:43:59 +0100
Message-Id: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm already resubmitting, fixing the problems found by test bot.
Sorry for spam.

Michal Dzik (5):
  shared/vcp: add API to control volume on VCP client
  audio: connect VCP profile client to MediaTransport
  shared/vcp: fix memory & connection management
  audio: fix VCP connection management
  shared/vcp: control volume when acting as a server

 Makefile.plugins           |   2 +-
 profiles/audio/transport.c |  37 ++++++--
 profiles/audio/vcp.c       |  73 ++++++++++++++--
 profiles/audio/vcp.h       |  12 +++
 src/shared/vcp.c           | 169 ++++++++++++++++++++++++++++++++++---
 src/shared/vcp.h           |   7 ++
 6 files changed, 274 insertions(+), 26 deletions(-)
 create mode 100644 profiles/audio/vcp.h

-- 
2.34.1

