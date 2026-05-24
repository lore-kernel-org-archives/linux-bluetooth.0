Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5CA41C71
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779660870; cv=none; b=XfefGt6Rf4aL3zfgwq7k8gzplITyIJDTbij9qZbD4qSXuobvWqsXzmPuULPiI/FcZ1J3P/74hcT4YgaLgxt9+EyBxDZeVyyHKBNjUswc2huJvG6BqtF8vq2FoSElQTvhLL4Kh+IgpyTD0/cOrNI8e7sdidFSYK80CBhBBcHLnk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779660870; c=relaxed/simple;
	bh=TWQMSqMH7Bhl9p5skfDEIGNi76s50s1DADBtuFSSeOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzjt4a1cOfjuWZRbcdausK9BnyxXdEA1z1W7XwqX7ZCquSkclA0LdokhUbqRRsHeg2NVxrn4jzlii+h0kexZnk83BLtc0ubMC1qg/JFnjuPKS+HkB9BJbDy6PgB7qyvLYSCviY8zTBPpZgNkAxIlr5eE1123UNAA9fYw9hUydYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmioOkYq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmioOkYq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso33889625e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779660867; x=1780265667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gujVrznHhAF5HoPkTQ0GziZNAG24fZgcmsr7ZNSs9w=;
        b=JmioOkYqpIVYewGKJV/DXqQEGVhHTgTwkDxVHZUqab3vrR/4aRRxKn1tWkD6dvAAku
         6GhnFCu1P+OhI1L9xQEOZ+SWOTzoEL3RKcadBQQquR3RMLrOn/n0V8VVNMPfqq7LdHRZ
         Yo4DKNLLM3+uGXTRNoyyZXTk+rocTCGhGJ4fnrV6e9haaadYPvXdTdk7i1UrsVbcJQym
         iEAGipjhaOHNLbc6f1EP2fOC8uzXL969TnguksS/+f5+vnKiEIVYSCNyi9nfqHQYzzZP
         7oEvAJXtnbs27Uz1/SeOyfvAcXvb93MjtS+RDSqgVnY0KNHeBasy+2+eHaYJikGS2nTT
         BNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779660867; x=1780265667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gujVrznHhAF5HoPkTQ0GziZNAG24fZgcmsr7ZNSs9w=;
        b=sqOi94KgGBORIGTFAEXpft/MDMGwlKcEdrPFEmhQCltS75bu1FFw00ZzarBA/5Dqf4
         x3fVONfHXFubWpSaEIEy/E9csNr7bQ+aBJ6PF4ErfLVgmMrpCkO5k9FVZU4p4HoJr4gL
         Rxm9x1ycF2h7V7euLU+C/ngO8xpx8NI6RDh6Wk7R0RLKwPA9WRto6YUtT7/evFmCNpjD
         hVSBas9N5QVma9KlXPXMg6QXIJMWeXTeadjMnyKpN5o29QPtDz9O3095wpcNL5b29jwq
         dqz6qS8+ZYwpDic/xHxL+OWNYIHBIyh+TTWQM+r3wFKtAssUcZJSZ27flzT217tdxfrj
         u7hA==
X-Gm-Message-State: AOJu0Yy4JV284XolP2QFTTVWTGc6oPyltDvSJw3+bvBM4aVrOXdbq1mH
	UzcMtYkIfSrnPXcTCh+WHsgLuqA8BzFN29s4joQpzDzp5Cpa1dHivJV48DAML/qNyvg=
X-Gm-Gg: Acq92OESVwaCxAC6aQItrHXfMSgc78X3lMDJiDGSzS74HyRx6tWQVDkUdUbB6R/fXBE
	tFrHAhMOG5KoQ1+zcmJGR/u+ko4PBoNpP1iWIhcCUlhxdJ/s3iJOcmvYa1KQd1IKiIr2pFCYlbR
	u5j3hpssyKHj39aKNJE6hm4Fxz5kisopenCrO5HLCG59lBjykEIfMg3d/rbvNiqojKkPRc1LG8i
	I3B/bKL+wAdtDWUTanvT8N0tUIcswk+GYW2/5GOAINe+QD5zxaA6uo2GL2dB3THqoEGnsG+pOAH
	KlrYcbfY1Xc+IGNM7DK5WcXL4DmZTAFbLOXfXjxQoOKBfqYpQciwWPTNXShQVXfTEyaz7i5XNFM
	z6buekkLwjveD1E5DI6c+vcenuxdRoN8KKC7inLqxOwzIUQS6gcPDH5QSHjGHElbxtTBIImy/P8
	kAiVTJlZ3uCIDuBWu85lxrTLYQemzmbAGL1YzkDIL/8T7HC8xahg==
X-Received: by 2002:a05:600c:c16a:b0:490:6237:5200 with SMTP id 5b1f17b1804b1-49062375334mr42481955e9.10.1779660867041;
        Sun, 24 May 2026 15:14:27 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b1ab3sm232036415e9.14.2026.05.24.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 15:14:26 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ 0/1] Add configurable default LE PHY policy
Date: Mon, 25 May 2026 00:14:20 +0200
Message-ID: <20260524221421.258593-1-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds an opt-in bluetoothd configuration for the adapter's
default LE PHY policy.

It is motivated by a reproduced AX210 controller failure with a
Frostbay BLE device. In that setup, LE discovery fails unless the
adapter is limited to LE 1M TX/RX. A btmon trace shows the peer
returning a valid ATT Exchange MTU Response, but the controller/kernel
path reports it with the wrong ACL packet boundary flag, which leaves
service resolution incomplete.

Rather than adding a peer-specific quirk, this patch exposes a
generic [LE] DefaultPHYs setting in main.conf and applies it through
the existing mgmt PHY configuration interface.

The setting is adapter-wide, so it affects LE scanning and connection
establishment initiated through bluetoothd, including desktop clients
such as GNOME. Only configurable LE PHY bits are changed, and
mandatory controller-selected PHYs are preserved.

This may also be relevant to unresolved Intel-controller LE
interoperability reports such as BlueZ issues #1193 and #1557, but
those have not been re-tested with this patch and are not claimed as
fixed here.

Tarjei Bitustøyl (1):
  adapter: Add configurable default LE PHYs

 src/adapter.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 61 +++++++++++++++++++++++++++++++++++++++++
 src/main.conf |  8 ++++++
 4 files changed, 147 insertions(+)

-- 
2.43.0

