Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917002;
	b=4DZDFxauEHihkrGqX7RpMXUNqGG5klgI0STTJmrMSQyQ77xL9jj2llcykRNh/PzKFkfV
	 w/2M+3gPdEdJFn2Epvfc3ssx3pDYWzaaHMbx7eg7ipgxEaY0YVmKqwo8us6kxHDlA9ubo
	 RKlVe+0AbxBEkg5UnX52eRAcop4FEwIvz5FMFHwEhsqSV3VIdjr7dNNqfmvocKEpFx0P6
	 tVMIuUPAyKow2kj+zex0Ob87UU29ytlKHvS364YmCXOM6gMTWO3h1vBTXywZnmGPXg2U+
	 iBkZ0ztX/8U29Ztmq5vY2FzkAhGCBvr10B84+BD7i1pN0uDUtdKIrFTw9PX8XObp8MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UKUuE6ns46vymWuUjfQsYQ/A5aiCHooJhzw5zAMacp4=;
	b=0kZSZsX3PGRFYE8Ak3XvMwgaVWEINPIGEK/P72RtDnU5YVXFdk0Nu6oC5lTqDS7glInD
	 lP7fbzC0qapuLr2/OGIBGY+Iy5YijySlDDgFDX3QMSQXGzLvZUrr1lzejw0eNxpdHV6XX
	 KW1vWgF+geh/JnEBtsF/ui9L6uh2sRtDQ4dRn4EsU3gnpjFALDlLEUsOJu4U9bNEGiLMh
	 zl2H5Eqe3Ex6CNGWmfchA8t0P4has5tOQxYAGk7VoZjbH41XAmkNIQLndPEZBiB8u6bh+
	 iMTWyhZj9wio793r0xMxzeTx1iy2wLcw5tLkJkvjk9BqXfU3Y9987cwPfOGA6kVp9eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIiHauu9;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2637606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2637606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIiHauu9
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99911ead46dso1105094241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917000; x=1794521800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UKUuE6ns46vymWuUjfQsYQ/A5aiCHooJhzw5zAMacp4=;
        b=hIiHauu9YJqmUduaMMaz4fEZoek6BVDZNrm/92NMCp9D5cG93rO3hw1LsN2VTAvqW0
         I15T3nBGWZ+eGTZpamZ+MVB7g+QFYGuXy3GqRNanjD4/LdmuD6TcfLIdB5HlDYg0Wx2R
         mARoLaEDuZLMlmhjOyr0T3m4pTAcAa0dmWfo9FBdOev6QZTSZj8FB8OIhIA1c2dA3RgM
         Qj2ajhW71Tbyd8wr0PtzYyv9lFEMlWLspq0C/vBAVrvegcKZ4vBWn60cCEL0RFh/3Pxd
         vA7LnMGoms9Nb00FE07B0AkzCahAK2yAkbOSQtFKHF1UDfZ+rueOWkTbZttVbKgL78Ym
         1dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917000; x=1794521800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UKUuE6ns46vymWuUjfQsYQ/A5aiCHooJhzw5zAMacp4=;
        b=vbYI5ROMz8yTTEGuaAToUqisEB2/XO+zHiPDxiqVMzn8MzHlYfzeykScG8fMuXo2cn
         aGCrwg/J+M3uxe1PT0u0wKVMUulv1w5/zmDVj+A+oic/V4WoLsMQqlm9367zp5slaXHs
         QBXuex2cOW7sYvhXLnRCM0V0+g9CBC20RlDRE+gBxPj8m5ZWQYtkdFN2FvwseCE+Q70V
         yhGuSk7ycwKhooxvTo59pvot2tuTqlHUvuVqAbmShp7Lmisr4HS4ndeeo4GgX6hosbo0
         oacHnKWKKOJEroyEHU5V3SS7q5M6QlKzNlLx5A6NcrtwrE8nmGIaKpjCPug3tjcy81xd
         Zs2Q==
X-Gm-Message-State: APuU4Z/JEGp3UTL9pKTZZomgsXv5fQUzLoPFKh49tVlBl0WtF1ZCrZdg
	rub8gok/7DLG0Nk4FfttezpMfTXOq/zqXxnfSEJVWqdzyf+7J1xmdG8Vk1YmHg==
X-Gm-Gg: AYBFou3AUrfohox3Y241RQ7+fGs9CVaw4uNpSGpsW9iSGqMmzsExuiXZMoau6h3/GwG
	JOE94VQADTCHj2qAW17qFSANOpc8Gw6uQxO2jcNZWymVYeGw/PdbTRd3V0wAMYWsNpheNdzdrK2
	arVr1jG25qqzyXHZN1bITMFaf9HvX2RaaOTX99qv290lqnSB2NNIYpUqQKybvuWa5sUldQqofDA
	WCcEX0LyWSB4AC6KJVPQQwvc5TomJR7jeYprfZzXVBXBzRz0yJR8/acndhkeiM9kYZUfeFWDbUZ
	93P9bS2YVLfHudacKFUJF/RsUX2ghvk16cuzX1/ofknZ9U1af7Ki0l7KlkgkukHLwXeXxXYF4QY
	wrXToPyPMF2trmb5ZJrxzGnP/vMObGrPcBF8x5oO+dGefrs8uN4k/0eFs1rV4Vo1467E3iy34cF
	fZqO4eF4f1TPv02IQ9Y6BL4ET4K7UI6d+lRE53akU4ZFcE8ExzWnnOsHsQ9KATB3IKGjKeFg8JY
	QfNoGSNb15ic+7SKJlg9JL/Wf4xRHpp15ld9wZKbk6kryiEk4e6R+lx2yoZHF9CyXuWxdTLEIfv
	siyycWwCfZGYY5yEfYcPuEgYQwyPk+sEvblwrInhuvpl5is2uzkrPhMO7t0YQnnbfs1krN4Xqim
	LWKPzIrwgfXd9a6EDM7hnqxyOgRjkq8lactt6BJjE9/GB3JtC9n73j69sPVI6j7kU1+DGYROhkO
	XwMvA=
X-Received: by 2002:a05:6102:c51:b0:7cc:3246:3095 with SMTP id ada2fe7eead31-7d2a1676209mr756919137.34.1793917000346;
        Thu, 05 Nov 2026 14:16:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/8] Fix handling of malformed GATT PDUs
Date: Thu,  5 Nov 2026 17:16:30 -0500
Message-ID: <20261105221638.2332398-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes several places where GATT PDUs received from the peer are
used without proper validation:

 - Read By Type responses with an invalid Attribute Data Length could
   cause a division by zero and out-of-bounds reads during discovery.
 - Notifications and indications shorter than a handle wrapped the
   value length to 65534, passing data past the received buffer to the
   registered handlers.
 - Read Multiple Variable Length opcodes were missing from the ATT
   tables, so the server never responded to the request, and the
   client response parser did not advance past each value.
 - Database Hash and Extended Properties values were read without
   checking their length.

The Read By Type, notification and Read Multiple Variable Length fixes
come with unit tests reproducing the problem.

Luiz Augusto von Dentz (8):
  shared/gatt: Validate Read By Type responses
  unit/test-gatt: Add malformed Read By Type response tests
  shared/gatt-client: Fix handling of short notifications
  unit/test-gatt: Add short notification test
  shared/att: Add Read Multiple Variable Length opcodes
  shared/gatt-client: Fix parsing Read Multiple Variable Length response
  shared/gatt-client: Check value lengths before reading them
  unit/test-gatt: Add Read Multiple Variable Length tests

 src/shared/att.c          |   3 +
 src/shared/gatt-client.c  |  23 +++-
 src/shared/gatt-helpers.c |   7 +-
 unit/test-gatt.c          | 258 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 278 insertions(+), 13 deletions(-)

-- 
2.56.0

