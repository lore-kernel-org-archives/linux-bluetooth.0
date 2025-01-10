Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7421146A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520642; cv=none; b=eL3OInnyW+o1DxUWE557lzMmEwcFmGU+3pxtAEY6eh1Js8UMjYM1e6Nccs+m/z7T2OrfO/oF8yKSK9Hxa71XfZOKDLOipn8B5ZF068DcxPR5tCPQcBba+a+A2SuvMPRwJigZEbxHiyLc+0RM9WLgCnXQ+csxHWzkv7D1M1QJgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520642; c=relaxed/simple;
	bh=XaEtybCCbE9jprU/ss9lT4PMav/3LvFa1CEdevg+BM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y1AW15Bz6gy7Z5QQ8/cU1FbX1watrw/t3VJi9qhSaUBdhaIYKENQFcB/yOmDDa77DJo2W9SAN02zAZeHEwmIVxAWqD+ZtEHYR0zFysd9Vxiqlt7FC3mG01ECMy2XArgoIPUjlD+GylW2f9/NmWOMk8QBEBEG+KNXlPpvNil8M7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Ef/BUWQL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Ef/BUWQL"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so3076861a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1736520637; x=1737125437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3P5G62+eqZRT5yX6k+7mO0HMYNoJHZkjpdNPDnXNiE=;
        b=Ef/BUWQLEK3WCCaMCkInkxLgm9VF0as6RbZJMveu/4nBXGperxwzyw2Bqf6uB6V+hs
         LgU+eSMnTKqL2BsDkHOh79Y/mT61PLni0LyBKcWYD6U86So3QcJ159R0rngRxyEm1dZF
         CRaScHh3pEU8tiV88Vyi7i1yFIgN5yCAbiy0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520637; x=1737125437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3P5G62+eqZRT5yX6k+7mO0HMYNoJHZkjpdNPDnXNiE=;
        b=GGBuxP/+vK4Ubyza4ntGDALKT7dWVSNXVxAqwHWwhF6dPROUghk1M/sDBTQbZjHkVo
         wdasvsXCegAam6RarUvGRF5mdfmnEctXW+AzRJnBw4Hirfeaa/JfMBTbklD6X/MQUsCd
         ZBwHgBAEn705VuNjReeUwL9o8bgGj1Z95E92cu0LPKzpHRIlnEytTfGrKqDCCTAnsyVV
         atgCD2/Q2cR/r3YrQp8hDGcjlKlIuZ0S6enPRbgq8DeRWs8OWB4c16HiKk2tVKQDmZlv
         T0GkcBZd6s4ZeVcE6o+U0g4DnBzQZyM/kA5MciHSH7Dn5kMJ9o12vDBtLfSLmcNdKG5n
         o54Q==
X-Gm-Message-State: AOJu0Yz5dHaWuwt+UjPb0SBu4B/WFxtDG/SG4Q07yJbf/1aWmZDcF2wW
	qh+xvsj/aXP3m5sX16biku2HKyhpnhhE5oWkXg9pwFBY5N8mWaj4v3nb2nkGZ/sRA/LHecusQMA
	=
X-Gm-Gg: ASbGnctfu9fUhYSELTHa3OBoWVWYlR0/nJknwUd0bbYc8XcQU859ZZ9Az65tFwTR9op
	D2m2n8V/p3nZMESzFPjHvvEirda2pCXt8sxTkzS49TNXdo4oUO3JpJ2PqlENJP2fTmXA9gJl4kQ
	VlYluS9EhQxd93pl2wgu+dr8FU4tRyRZhXbVY/d5kd6Txrox+2GWulBiAw8MtDUBytVdqUXBPKb
	0WcUentWG7FWZlPW2N9zdd+ILxPqtGmLfpJsE5WQ/TNLiEoF/y+po1V8ffahZb2tgVFG2fdC7el
	+L7WYGCfyMxmUVD3HkEBQBK4sNgY8lE=
X-Google-Smtp-Source: AGHT+IGTEe4C7Y8hmLakXujlo7ywRkGxkoePdIgBL4ZbtJ8v/eJRS4FyhWnz3OtpvfQzFo3bnPUELw==
X-Received: by 2002:a05:6402:51cf:b0:5d3:bc1d:e56d with SMTP id 4fb4d7f45d1cf-5d972e70310mr9306745a12.31.1736520636758;
        Fri, 10 Jan 2025 06:50:36 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm1679331a12.21.2025.01.10.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:50:36 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 0/3] connect VCP profile to MediaTransport volume
Date: Fri, 10 Jan 2025 15:50:16 +0100
Message-Id: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCP profile was already implemented, but there was no way to control it over
dbus interface. Now it is connected to MediaTransport volume property for BAP
transport.

Michal Dzik (3):
  vcp: connect VCP profile client to MediaTransport
  vcp: fix memory & connection management
  vcp: allow volume control when acting as a server

 profiles/audio/transport.c |  37 ++++++---
 profiles/audio/vcp.c       |  62 ++++++++++++--
 profiles/audio/vcp.h       |  12 +++
 src/shared/vcp.c           | 162 +++++++++++++++++++++++++++++++++++--
 src/shared/vcp.h           |   7 ++
 5 files changed, 260 insertions(+), 20 deletions(-)
 create mode 100644 profiles/audio/vcp.h

-- 
2.34.1

