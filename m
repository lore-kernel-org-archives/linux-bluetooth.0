Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231916;
	b=nCk24aFPYEfMsZAPeEK7ZJ3OapyrHKyWV8kjomxoRDvokjix5U3hoh8LXBOilyH+ilVs
	 cTCgUPx8hul160n2dETBkEeLAfVoL/6aK5niwyqnbwq5O/uJidoRtirtpaXBNvLbpGBU4
	 1bGPXUarhkzFpTb1Z6HoqrbjNV0gp0KiLorn7jXYYNUZLxJdTwlSWsASYWkE7Afn/pU3Q
	 B8wPbgS/u/KjD5BWpOtdC3CNLa5aJtDozSjqEwXGOsmyM+uWQPvdsLNW87VmSKZ7ajYhu
	 1O1pyzu2e8/0/vsot3B9qBJwQFXgpVhAwvJvBfzzXTMh7qBYP7YIJwcgTcFAVi0vABA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yK3YzNJOcaQryEkHMlVlkCljfMMPLk0sVjUD9ogarBQ=;
	b=gqgMoubtihN2ixV1+2q10UbfPVRF5WhOup7OdOvwlw2fHcTE7HLpr2+C557mmQmcCoiN
	 K3jCAGr2QeE7+dF7E4/vnNUezEhPA3dtqdE1siugGRHOg0vue0EVGqGeBlhNdteUkVSHI
	 Jmdhgis8CPR0hgwjX56/MdOE659DnFtl2VQGD4+ggWXQJf/nnvdHgchCaJx3z+TlojxCE
	 Yjzy54Pld9aZMD6DGkFjUmhX9MrK3CONpasaLswEmXpXJ5dVh1X0Go4xdH/QEF88cZodE
	 dsmh2NnWX1Hrl5D1zh7vMWCU3CB7qPhcB4ZHFLU5DSnoPsMQN6FKcVX0sXx5RvLYBWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZzIGECD;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0755606A6A7
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 03:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0755606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZzIGECD
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2bf046d7fso882856137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 19:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795231913; x=1795836713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yK3YzNJOcaQryEkHMlVlkCljfMMPLk0sVjUD9ogarBQ=;
        b=SZzIGECDB24BDr48Lq/DjCuCBiOjqqQLs9gJuSzllplJD4NmV2JWE0ts6vzT1LVMJE
         r3UGfmH/6yR77poN1fWHsTjI4CMOEswcDAgdUurIRyqy+PTz1OeXhM3TO0UZ+0p3R4tX
         VmH0vSP/ooe7OxMaPTKDOT6pWPhBzS27SyVsz+XwKD7lDRE62ggAyJdqLNas+3k6wZ6z
         ihvZis5sidfj4HpHL3QdAuDqq7p9J37oGpDtNQudkkmXpl1Dn0EnpKJoJ7xGdSrXuF20
         0xDdj1vl0SsA0WhhqycD7zJgh0cVJprYM8jp1q6DR3AydKaOKB7X5XUpQ/wjycwBK7tS
         gSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795231913; x=1795836713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yK3YzNJOcaQryEkHMlVlkCljfMMPLk0sVjUD9ogarBQ=;
        b=0I0k3S3pMRZKpqL44qxL9XXO1LChzbxzwegJM65C5+x9qGyLy4RGCPe7BnJtx+t6Tu
         xxMfw1uEpSguQ/UK/uNsybNY6T8JO5gowlZ23r+4xTte+p5GtCKonpWSBoe7vCnfPheK
         Cp0eVV+NC2KeT3Qq8AdvGbX0Uzai5MUJQOnEz1fWti/aXVOxupYDVInqsfrS9NheD/pa
         BKz2nvlkd89+3yjeX9rlVoQ/MDX8scWmX/opMOVRaKbAT/oneLbpO4BxESYBfOtinth8
         8/lUcpdeJiKvmNazZZnfolB92b5OWWTMRY3QtQnM9eCfG9wLA3ZyoduhDcVSqBPlPryX
         bDGw==
X-Gm-Message-State: APuU4Z/uhh4ztOZe2im2QUy6+SaxcL597y1z/f4f+muuzQOKkvPDuHDM
	qFJK19hFB0HgUwoCrtZEgZD2kyUxMr9ejSqhWZEkxSzxlKz3skSCcR4yCgOjaKD6GQg=
X-Gm-Gg: AZFdTZc2marEx8NVhYI5yOIhXDGxQIiPB95Wsx4h3JgY0+oPz0lwRGcYK4xTsqLy5D0
	zg01blJ1ZXyF78eownV9UVSYxhzLqIw3i9A1N44CgnD0ALlHLsjUaksH0RZVu/vIoJcMfeyJmgb
	zULHvuGrzA246ZiYOigiIqZgUgv6/8+SQnVlzxy8rdsH1XDqgpCbfMfJy5pQJt+3e4XyJwka1HN
	JnDHrxZndrLf6zGX61c24HC65SM5UQpIW1plRmvEQLgo5A6z9KUoEZM/neyJZnP9XiCiX2YZdd8
	7XpEoH1dvb077WDqiOIvZjoIdJL5+BrhwoCVlBfskiXTrhlHGPEhJM2vR9LrwM0dmLA3pn7F1dr
	94LbbyxGzZm6Dv1W9fhgc+q9aw1hAZSjT34YslXfqMYLc3lLkBNiN2zmQPm0iZoEsvj/C7FiDM4
	T8yeZXRaD+zvMBRIvW+CAgfcGdJoX/q3yFmfIJiaEsR5bwUWxJs3vHx+gLIitB6diMfo0K8Eiw8
	5Nn3yVvvO4BgPFHpGhNxa4LHbuLcetfeadpeyuaZM0yfkeXMk5GC3F6mfpogMynnfOoJN7J255D
	oB6TMqi6EJjQOdJ9bY0xbud5/WTBoUzq
X-Received: by 2002:a05:6102:f97:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d7396157a3mr2140380137.36.1795231912793;
        Fri, 20 Nov 2026 19:31:52 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f3d7bcsm4871081137.4.2026.11.20.19.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 19:31:52 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: fix bonded LE peripheral reconnect completion and holds
Date: Sat, 21 Nov 2026 00:31:02 -0300
Message-ID: <20261121033104.441146-1-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
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

These patches fix two consecutive failures observed when a Windows
central reconnects to a Linux LE HID peripheral using an existing bond.

Patch 1 prevents an asynchronous command reply from completing a different
synchronous request that is still waiting for its terminal event. Once
that is fixed, patch 2 prevents encryption confirmation from consuming the
hold owned by asynchronous LE feature discovery.

The series is based on bluetooth-next:
  029d11a1a6e4c414eb87ed965ed6bc09f36322ee
Both patches also apply to mainline:
  5f22fb20497f4983094131f00a734362300d22d2

I tested the series on Linux 7.3.5 built from kernel.org sources and on
the Arch Linux ZEN variant, using an Intel AX210 peripheral and BlueZ
5.88. On ZEN, I observed successful operation during a session whose
process duration was 3h13m11s. I also tested application restart, Windows
Bluetooth off/on, Windows suspend/resume, and concurrent physical mouse
and Bluetooth audio use on ZEN; these scenarios worked successfully.

On the kernel.org stable build with this series applied, repeated
application restarts also reconnected successfully. An HCI/ftrace capture
confirmed that feature completion leaves the ATT hold at one and that
explicit test teardown releases the last hold. The same capture contains
48 outgoing ATT test notifications.

On selected files from the stated bluetooth-next base, extracted-function
checks pass 121 dispatcher and 30 lifetime assertions with GCC and Clang,
including an ASan/UBSan run. Unpatched negative controls fail 13 dispatcher
assertions and 20 lifetime assertions. Dependencies are modeled; these
checks do not replace a full-kernel concurrency test. Full kernels were
built and booted for 7.3.5. A full GCC build of the stated bluetooth-next
base with both patches also completed successfully (kernel and modules,
including Rust and Bluetooth module BTF), using a configuration derived
from the running kernel.org stable 7.3.5 build. That upstream build has not been
installed or booted.

Separate unresolved observation: after suspending the Linux peripheral,
the application and bond survive, but advertising is not re-enabled in
the captured interval. Restarting the application re-enables advertising
and permits reconnection. Its relationship to these patches has not been
established. This series does not claim to fix suspend/resume.

OpenAI Codex was used to assist with the analysis, patch preparation and
tests. No raw radio captures or pairing keys are attached. A sanitized
trace summary is available separately.

Andrei A. Bykov

---
Andrei A. Bykov (2):
  Bluetooth: hci_event: keep event waiters pending on unrelated replies
  Bluetooth: hci_core: keep the LE feature hold until completion

 include/net/bluetooth/hci_core.h |  4 +++-
 net/bluetooth/hci_event.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

base-commit: 029d11a1a6e4c414eb87ed965ed6bc09f36322ee
