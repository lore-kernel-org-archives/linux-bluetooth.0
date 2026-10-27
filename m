Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121569;
	b=jLmaOCfzXVGThLml/BtoPgj+rddqNxkm1XMlYxFoEBoSXuDfdfJKbEFOAZdhSRGjooQU
	 BaVZeEQabfOEtUfy1NGB++/MUcxK5l+zAt4z5C7zTAFLrML6CTzjH3l6/vXNJQeXobQDn
	 Z+TCw5hJu2ckSy82YGVpwSyEf/uwCd9ZIt3yfT90JloEe5u9dtej2kBrBmGhxWmP68YpO
	 ne1t7sa/XlqvWXQF8ekmjio7GqWcbKeiqzkcq0fEk/2CQ6XhQJLQawTPR7VRzOLUJQT0Q
	 rlCJRU5U+JSGYtq/j2GB1mOKVCO+bXV9/RZ6Ot57p4BPkFQOc81D3erFd4Nlab0+SnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XVJ4J9prwSFN5KR5YuESJwDdyD6GrgOqoqS4skYwJjk=;
	b=C5wPtzH9deluOPxi9mSqYcebeaTdLP6LB7de+TToeyvOYOtBr4QgdlYXt2/lmL5uVfDz
	 2ZzGC7vLaBiELbjCecOyMcWvwhLF/J9P4DCynd5R2samc2pWvkPOLjcnYHDovR5/2ueeV
	 PkboMZALpbRwISluNrekENei2eUkp+k3M8BGBut646pxFr9lQv/72Q08UMvwxNhgkUxWU
	 o7pU4kthoOJkMW5y+NLDpd3WLKGK0uZxA3suLq6Art4zRuYUeTRGVUx27GJ0NExnLrEY/
	 YmbAJMu7hbFBTRGcL9vwAMI+aHgB4XWrZgFezlRHs8rQHmCzC9FktxoiPoQRjwrKW6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=UVu8HBLb;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C78606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C78606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=UVu8HBLb
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-156cbe59622so57435c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793121568; x=1793726368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVJ4J9prwSFN5KR5YuESJwDdyD6GrgOqoqS4skYwJjk=;
        b=UVu8HBLbWJ5zJxD9LWZT+JmwcA53gfO3Xo6o2q6bkEuNYg7ZM3O2IkkTjmyGJfannV
         Y2b29XQE++bJde3cc7AEat1EiHUwupxMpHaYXYMaZqO4279nOwxUshrrEUHk/Ay+i7cr
         GgPX14UQpOr+hwBCi3+KLyoe2tR1fl0Z+T9ZmpbWAlOmJOF3EghJVVw6HHOq0eGsApJ7
         6xhBfDT1PL3xU/aOb/J/bNpcAerVtORrfelJrmOqP/25ejplm5RVsPQ0aMeEoG7bmEGE
         GVXAuspe+WuTMhHyAJ2d+SLjrYj1BDXR6QH4gMT7Q5/vvRDIgx++Vthbqp9f+pEvkTxH
         LueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121568; x=1793726368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVJ4J9prwSFN5KR5YuESJwDdyD6GrgOqoqS4skYwJjk=;
        b=bigcq1CkSTloXi0GsK7JrAt6ZBxvc5K72Nwr/s64jR2+jZh7yNsrHgI9BzuPBTWQI8
         wUfeosVgc1sT4Dk69k0DyeltnaNTDgrd/Yj0BhSx7HMz5XDXLVKsEWPekft9u3A8+j40
         mswmUt+SyPMQGp2+25IyNbfpm7kdhrWckluHKATU1NcuiToIvzFylfrxN5PbLwt3imtO
         jwfOATy2UxbuHQmb3XHYVT5NGZuG0mZWgLWazzhMYbP4vAYK6COn1F7vsl7/7iEFYp+q
         DNDNtghhLo0EyR87hQEsnfOybTuYNUuZbvCxRBa3/yPPvVLox1S7PPM9ui0n0nSMosOy
         QBcw==
X-Gm-Message-State: AFq9FYLoMEvRQHxx4WFVthu9cQCEP5Ii9UjaHE+dDaIRzgI/6ndZb1JU
	bXtfyNrms0Rl1jllo/o94fUN4V+fySUOzM8EfbeijUBZ5YLtqKRhFyB7xN73K3Qn9P1LixfG7bJ
	xti91K+ewiQ==
X-Gm-Gg: AYBFou1Ba/s6c7m4c/SB7ecw7urZtPQqhJX1RiacbzxdUU6XAMnewarL5T5ZyVAR47f
	y+KaYbvJrSCRscXCKRBI70AZO7PfHMeJ3juL871t65BM8+4KZSZhA9c8o2o7nOkgbUzrFvii6In
	YSaMxsHiMx3pF2ClVGnGw9fsM3QI41Z2+U+JHl0mz4031SiMXNbLfNPRbwSCG+/udOQ6EXt49iD
	4WOLwejR3LINVsZTkYI+kgqpyjIx589nP9aGCbxbgdOba85X6xZpe5xRWWVSkfs4JNSwrWe9WiR
	3ZfBCotznhs0MlzB/oI29r+Dq4INtDubWY8fbdiGI8wCWR3Lh63CTY2MLz4943hAY3KzykuExzV
	gTd3BV3VeKW42F3CZ4IR05MTyPdWJ2owivbC0drsGvNNY1O03yAcc4dbRecdRfcSIXhUzAhy4DJ
	M1RsYIOQy0SZqecuhDjdOUBXSAtn9MLXK2SmPmh5MhlGoPI6BRW9HTEQllTmT0ZsfOs0VG32aJ6
	ubZ9ULC3miatnUP9OfsG2E1bX3askqGp7lFrUR4PFWsUcbsJ8aMQcG6mrRhUXSiZWBe/DJrSgCX
	dhYIOzfbi4iDpR1vEkOzApR4zi8CTxooth56QbJpvrx6gtqT6Vd32c9c3H1pQbfuuKBSKUyZSuu
	KnKWheR4a76PqY5YGNvwJMg==
X-Received: by 2002:a05:7022:f519:b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1a49eaad10dmr2840748c88.45.1793121567560;
        Tue, 27 Oct 2026 10:19:27 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm34440562c88.15.2026.10.27.10.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 10:19:27 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/2] adapter: Fix Discovering staying true when stopping fails
Date: Tue, 27 Oct 2026 10:19:21 -0700
Message-ID: <20261027171923.82919-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

When the Stop Discovery bluetoothd sends for the last discovery client
fails, stop_discovery_complete() removes the client but leaves
Discovering true. The next StartDiscovery with the same filter then
returns success without starting a discovery, as reported in
bluez/bluez#2547 and, before it, #807.

The first patch treats Rejected as stopped: the kernel returns it when
the discovery already ended, or another mgmt client stopped it, just
before the command was processed. The second clears Discovering when
the kernel reports the discovery as stopped with no client left, which
covers the other failures, such as the scan disable timing out. That
needs the kernel to leave the stopping state after a failed stop, which
"Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery",
posted separately, does.

I reproduced both with functional tests that hold the emulated
controller by stopping btvirt with SIGSTOP. In the first, a second mgmt
client stops the discovery before bluetoothd does, so the kernel
rejects bluetoothd's stop; in the second, the controller stays held
until the kernel times out the scan disable. Without its patch, the
first fails with InProgress from StopDiscovery and the second with
Discovering staying true (3 of 3 runs each); with them both pass (5 of
5 each, the second on bluetooth-next with the kernel fix). I can send
the tests as well if you want them.

make check passes, and so do the functional tests that use discovery.

Kevin Dewald (2):
  adapter: Fix Discovering staying true after a rejected stop
  adapter: Fix Discovering staying true after a failed stop

 src/adapter.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


base-commit: b0bf49270d445da0852851f393cd67a0a1e5f05e
-- 
2.54.0 (Apple Git-157)

