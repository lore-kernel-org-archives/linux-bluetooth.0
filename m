Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01D386559
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466609; cv=none; b=EjwOGjYjXiSMoNVdSLE+guTk77bPUXdBiOC79W9qhWzQmye9hOYaIiycNv5xNQJd0UjktBlCUBvJlQjhaKjm5O+0gB39CIr9XhC31XecQDTJV2c6SXKwGreLFC2IdLdSTec9FMBqcLZrrzj7D6Zh2kjxz7YSw0nEsWe8eadn7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466609; c=relaxed/simple;
	bh=E3GPDi7CNP+th552Hlzw1BotX76rI9Km2ltLNwp55SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2HF+1wYK1J5yQPXLd8iMTgC6iAtKYg/lNZfLf1yKBlKWbV1zZcST2utZgWpm9Yo3tTsPvsW9Z/DQJHbRw27zNE18yeJJ4/jsSszvM4uWfyBgl6sHzwvVOJcOV1ctUxUDvVdX62gYZscnNXGfa80u2JQtbBMwIVqKugRCbaZY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=v6gWLCtq; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="v6gWLCtq"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-150f88d22aeso2761463c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791466607; x=1792071407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YamARzc6vckoW0oFjFynDLUf2X9ftylsqdnTIoOf5Qw=;
        b=v6gWLCtqmmKYeESwKp+G3LGRe0UrLDSfNsak3CqlUQBELfixvLLaB56xJ8erRCNwAG
         KCBeZv9dvsJWQ6Jju8tMDPYOYjWc3VWFJeKxk8oHf7ZowzHNqdwXdYv1ahBptA8fBY2q
         HKZyoyd08tyPaQI8H1E+krRfVmKL4D7Am72eNqb4morPx+78Yxz73lMv7crpLAtZr9O8
         flv9geLWIdTE46mac01PTJEaHbukZ8pS4r8YN2F3/ZsfVpqSNrPmSzjPB8VznL7X/E5B
         +a7iCLTILhM3fa0bNFrPl7uOQpHSPTy3wRUy06OA9lIVjAeBEUP1S5X059NhiOp6Fte2
         XTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466607; x=1792071407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YamARzc6vckoW0oFjFynDLUf2X9ftylsqdnTIoOf5Qw=;
        b=peP1A9FnIdgSf9RoxhssVzyVmYAX0coKcUbUw0s4K9brOSSA1TY3tVB1e37UBAdVhE
         mdoMsDVzXH0DggsAs/ZmRYFXRZmknRqY1FsIFgf8Eib7Nc0L8iYGpHwRGedMfGcPgz6Y
         Q9aLcAYw8glDTenxD9ssYotEjYoH/P+NETIPevtOphN55lSOhoYW0OypkmtXLYFbB5yz
         xB2w3mrKlNG7DFRpu6vQDQ5PKjc0nLUy63j8HmCZbw82l/8XiqmeJ18BCksmU5IXpjnc
         ZURZCwnqioRt7ytfGHTVXMDyn5K3Af5M0R9BJkrhj02fbM1kIuMDtSalfzBiyRx/l4Ld
         SO9w==
X-Gm-Message-State: AFuF++kokBmmNJwIsq0jHuW1pNXZSDc+g0OCgY6NZU9pkFw6FBAWXf1U
	DRei6g1Tfi9kqA1jiqIzhTMPYaPf+O66WFuex2DUkd0Empe5a0KkDQAws09B5aknE1lR4oPHRlP
	kL0tN
X-Gm-Gg: AYBFou3WOZ0uQTwPKcTocDokDuTna3uImqea40j1fwFbS5tOyKDXbIgkO67cxOajDXq
	rKvfi8CMlmzf5NnXQOGKy9rojcf19hdRSDYpXhk7ogh7dWNyLCnYcDCvNlA32IG8Mm+cb0Y05+H
	m8Hq3fZUFcUc/qYHZ8nbV9Rs9waVVp29EmoYa5YR/3iIPuZZnTQ3mesi5eY7vNwgTWo/o7uoWnB
	uR6kkMZMHE/yADc+jCHljzBemKe2MMivxy/B4fBHgWwTpf4YgMgLRx5czih7WaWyClDFtHC7CXt
	MSj/z7/1ZP+94IFvgwGvC2+CFdBP4B39X9vU3ibCzJZiFICgtgG8D+OOExBHe4unQvrxtJNjjHl
	8ir7qwD2Y3xv4fzOO5t5RRb+oxABetzQiLmejzJx+5TzjbIh11x+b2IaiYCPaKhcgkgaA092yLk
	qa1QiW4drdp8YXIgr0oqw6JwKrY5FpgynX6ehlj8y69UZisJ1Mf7fj0C6DT2G6kP+G8UIrFyoWG
	evkWQZxwkmSKt+c4XYwjEY8jqYAxD9BsUBT0gouqBTqZtxDISwPsuQXQSAys0yCq8elce70LyYk
	n4g5DpcqdGveTEwB3DHOW0qiGyEESqpH8F0xQp9/
X-Received: by 2002:a05:701b:2204:b0:166:4b44:66e9 with SMTP id a92af1059eb24-1664b4467b2mr2657128c88.32.1791466606334;
        Thu, 08 Oct 2026 06:36:46 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16168f62a5esm15220725c88.14.2026.10.08.06.36.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 06:36:45 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/3] Add Role property to org.bluez.Device
Date: Thu,  8 Oct 2026 06:36:31 -0700
Message-ID: <20261008133634.30362-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applications acting as a peripheral, or in both roles, cannot tell
from org.bluez.Device1 whether a connected device is a central that
connected to the adapter or a peripheral the adapter connected to.
When several applications share the adapter, a device object can
appear because of any of them, so the order of events does not answer
it either.

bluetoothd already knows: the kernel flags connections the adapter
initiated in the Device Connected event, and bluetoothd keeps that per
bearer and uses it, e.g. to decide whether to discover the remote GATT
database. This series exposes it as a Role property, "central" or
"peripheral", present only while the device is connected over LE, and
prints it in bluetoothctl info.

It is limited to LE since an LE connection keeps its roles for its
lifetime, while BR/EDR roles can switch and the switch is not reported
to bluetoothd. It describes the link only, not GATT client and server
roles, and nothing is stored. Other stacks report the same per
connection, e.g. Zephyr's bt_conn_info role and NimBLE's
ble_gap_conn_desc role.

Tested with two btvirt controllers, where the advertising side reports
the other as "central" and the connecting side reports it as
"peripheral", and with a real adapter connecting to an nRF52840. The
property goes away when the connection does.

Kevin Dewald (3):
  org.bluez.Device: Add Role property
  device: Add Role property
  client: Print Role in info

 client/main.c            |  1 +
 doc/org.bluez.Device.rst | 20 ++++++++++++++++++++
 src/device.c             | 31 +++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

-- 
2.54.0 (Apple Git-157)

