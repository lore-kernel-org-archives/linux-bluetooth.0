Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737815;
	b=bsQi/cU9PR5R/S9njIUXD4kuSYe6Qd31Hd9YfQjuvbpamtoNphrJjpd3n1RdquAKgR/0
	 nRF3E0CbyDNKYjHuu6P1LvnHyG7cJkVLaDALE7CzZcOPY11/o2f9FP2FeoMzhoVqIGNMi
	 se3IG1Pt7DX97c+f3R/ovWlrnyjmePvFFXpkbdWOPtlmg2XGns3jY8s17zk89rp8odqm3
	 k7cfNVNqftQiXLOsJfbiWpeb9U074JnNfg++85P5xgGNqQTJlpqNZ4BlMhK5Der7HdRaG
	 VLo1145cz6FoXlibrIAifz8GjjUbXu34psxgxiRDZXitTUj3SErCjNF/eVLY1nTGAQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S3RSkq8wTlQn98rbIQ1UWEWBzZqk9n3zxoCybs6JeVY=;
	b=q+yAvqm1z6vhHXapsGQ/HQTYmrbOzv/xQOLi4mcC5qnbDupY7L+rhjfMk9BiS6LzB5A/
	 c53HGhtEkzQjV5+/5c8Nrr8cIMANOFD51ZqkNNvwKEbiek/c3dZyhHee+ip1XzUhgvizs
	 CVftUpnKoyk1ClE16gFuPaF1SojcMr74f6g5TKRQ/URy6/r7bqVdQI1HYF8Yru9xE1hDC
	 g6c8r61qZ95DIsj0Ft8t1xUBjg6g1SwJJOyHAxTk7joOTq6pu6Q8etG/RSbQ9xOlPlcfM
	 3IpIh0u+1kdS6QemR+x2Kq/oxBdBDLrt9AuFJJ92MXeYQ7BJxcf+yKfbaKM2AQy+tcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLmRbdK6;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40114606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40114606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLmRbdK6
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso3147633137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737814; x=1794342614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3RSkq8wTlQn98rbIQ1UWEWBzZqk9n3zxoCybs6JeVY=;
        b=WLmRbdK68HDDFGd3utPqUsV7p/ks/6ogdO0zsQ9qPF2ebRkdgXvoP1b+kRjEJRDtRI
         g9AYK8qdJrkpPQPPPcWXnOLXnoshEpiCuul6uaM5Jx0GIWISQI+O3Zs8y5oV3j9/qqcP
         l4dh0m94KN7+ghE7dQbblzcOzQkij++u2Ljx4/5AX7WQTKovcvtxEj+nN85wt38U0p8g
         ILYLV83OymFTxK/WyLmbKLYdJdq+2F36IrO0ZxxcrPoFleYy0JlZyztZKbQOtexoqCbM
         URhU8d86kH5/L9ihDN7KaI4DBfHPa2rTtBNIZSa1bFg9+0N0XMmhoar5ponAA0WoPW7f
         w7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737814; x=1794342614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S3RSkq8wTlQn98rbIQ1UWEWBzZqk9n3zxoCybs6JeVY=;
        b=CnFdfyP3kcbafxAngYmHQ0cMWIV9DG67XmzhE9D0EEXGkW6XKT46xKOsxjgkm6izs4
         A4YlSD0bN2ps3gg9lwXfhkGwJ0hvBeHPbPRNlLFPYSuBDsW4eooISSjpeCYfyEJmscI1
         JtSCFvV9GyfqWDgGDIWEeFLzVfb3rO6y4GOWCMwLe+9sW7ao2BjZExLoV/q3WYsT2gz5
         AUXkzYYhj6AhMtbw8xDrUGgVTUisRWHNV6ojWjjoEVmbsGGuiAH/34P+3rDxvQ4oyaj9
         11eaGBosCm3yjKYzY14Vb2ay0CPL4USgWCm73BnCuEct95S8u3Aqif6n7X5QDYb5/qph
         xRNA==
X-Gm-Message-State: APuU4Z9fCo+YpFnxiqO8pUnESMCITa2dIT1eR0rGRocE4dgxtLipmAvS
	KumgcODmpckYsTqG3RQ+G4wPD8y90/2Ifcsr4ro/60rCol3IxZU3sUFycPf4Pw==
X-Gm-Gg: AYBFou289sW8lPrG+Vb1C2CxwgeddbkCKSMD6JgwTtbMfQVq0/NTmVA7SmT9GL7qd/P
	edMSOuY+UUCjO0NJ1pdgCsexTvPEkWRuac2/bFCqTpybNE70yM8Vz2oom/oZubEYFgI2uu05ZYz
	Kn4t6v9YDHoxUI2Y36yng8XyI4wCZM6vVT5HiOAf4o7aOTRTWOoyzhsuk6dJ6njRvrWmYMYMPqG
	Jkh0pWJ6JdTfOqqfs+mkcfaplYEbGnICgfJ13Oky/5tEfBYF5RONhrMiB7cKtWcV2JiO+AP1YXL
	+SvmwkhVMoxVR8aMAMSZqKvZNJtY8GdTisw4kfQ12pBw4dSBjCWYm4rwTI+BD43yxRH+R4rRnsN
	xVXTfstYFHJg5ENiqWyjYB8oK4wMI+ZkbGdO8/4LngIBG8YU3OxsKc+njiax2hVVuNpn8LDE1ih
	a0Ic5Pbtpwl6wJj2Xbrj2EUnY2YqP/WW2lU12HwDos5acRi+z8v5sLf+uG9MOcloQ8xjaBI6BD8
	ZbnQbnzGDzBYs/e4XQFLGRjzh4BiRMzEOy7r/S9AOk00E82VXH9AUIMEGX4HCQKWX9wJcyzBSPN
	Fwr1lT0oJOsfpr0YB7w7Uck7XGICsOgOOjTcCnn1y3nsxKtD8gFvtr89TujQJaFRYCEjxJE3stf
	ikUsJ3llIuSj+DUcGwhBxsFFXyPBDefQ8b9iIY0CoCc/jHC8LpuLHoXagZiZ6d2/cbPyj8itb6m
	WHfMiC
X-Received: by 2002:a05:6102:e0c:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d07276121fmr5756218137.33.1793737814151;
        Tue, 03 Nov 2026 12:30:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/7] BAP ASE state handling enhancements
Date: Tue,  3 Nov 2026 15:30:02 -0500
Message-ID: <20261103203011.3904290-1-luiz.dentz@gmail.com>
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

The ASCS server deferred the ASE state notifications by 10 ms after the
ASE Control Point notification, while the client completed requests on
the CP notification alone, so it could act on a stale ASE state, e.g.
failing MediaTransport1.Acquire right after Release, whenever the
notifications were not received together.

This is fixed on both sides: the server now defers the ASE state
notifications until idle, so they are sent in the same mainloop cycle
as the CP notification and can be aggregated into the same Notify
Multiple PDU, and the client waits for the ASE state before completing
requests, also making cancelling or detaching a stream which is part of
a grouped request only affect its own request.

For testing, the tester gains markers for PDUs that can be exchanged in
alternative ways, which unit/test-bap uses to run every unicast test a
second time with Notify Multiple, both as client and server, using the
same test data.

Luiz Augusto von Dentz (7):
  shared/bap: Defer ASE state notifications until idle
  shared/bap: Wait for ASE state before completing requests
  unit/test-bap: Add tests for cancelling grouped Enable
  unit/test-bap: Add Notify Multiple test
  shared/tester: Add support for alternative PDUs
  unit/test-bap: Expect the ASE state following Releasing
  unit/test-bap: Run unicast tests with Notify Multiple

 src/shared/bap.c    | 456 ++++++++++++++++++++++++++++++++++++++++----
 src/shared/tester.c |  74 +++++++
 src/shared/tester.h |  13 ++
 unit/test-bap.c     | 421 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 900 insertions(+), 64 deletions(-)

-- 
2.56.0

