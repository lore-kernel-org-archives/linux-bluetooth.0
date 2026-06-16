Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E542DFE0
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608369; cv=none; b=oKNVw5TkDlTZYaz5fIi6aE7qvW5nnjkO0i/w4kh5QtTe3u3l4ipn+EX7wjLKaZVVn0TeycfNQypb3rJCZb10agB5zpXxe4VLOYD/1tBhVseb1I9F3kB/RiNBDxKhiOUJ8JQDWiQ2ol7QM9v4nrYoUOx9fRsbmMP6sANSjzKtrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608369; c=relaxed/simple;
	bh=NVj8lbteHXh5JVB7mWhqe9AMboZt32iPu0AGrrjU7ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWk9qdWaZEJkLEF6nNJ+nZjDEsUINsJGxXNKTLLO1sZJv2IgsErF7bLZrjPKR2W5PzMvOmio6LGzOnFjocBPS/ZAJcwTOPN8fTgOaCBE8Y/ypc2y8PNnI1qUVZYy+YXRUn+9GfPg+crIpGnOybXmzr53CSbQiCCEamBBS3Na5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxfM/TNt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxfM/TNt"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842358aaf36so1716383b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 04:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781608368; x=1782213168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DsaDqBODBOe0uQd4CZKQhSELJgMWAA7Q260cUecRjlk=;
        b=VxfM/TNtru0sraxqF+DrMiKRxqX8fMENhmYT9w44o/73bJerXs8hPKgxOtYHdJmTm7
         vIpc/Uhjd0VEgaNXxez1cQHYTHgGieoppQub+yI0vdRItYMeLwpQW6tP1ZMYKoQ7PyAz
         rzI9CdMuLW9GJyhFt1GRjZc1xiFc9140QY5mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608368; x=1782213168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsaDqBODBOe0uQd4CZKQhSELJgMWAA7Q260cUecRjlk=;
        b=rCySc4+S9r+Zn6RJ41vJ0j84Mw4y6GdgqCXDWCib8Pjy/ecMC8+WkmE+TB3ZGWyUW5
         vJeV3J51I41/YqyWibUL31qFW+DmCcpJOXzYkguvGu2TwrVR6YvHYgP8fmeEHpVKM3Gg
         9XaTk7ZDyn7xbycSZBswbLn8ufZMgN3/GAYxSSUs+UPV6oPnypJx0CBuiZip2S//Y+Ji
         /+TLaj9+2dS1PStSNzUEv3t90v0VRVUUMarfYYBpuWkcAigg6qkx8GV59E+26MTpp76h
         t/Vheg8D84nLIK2OMiWMCmFPEHJs9zLvL1u4B3NzRkaUXLFxvBxJaTVbt55gR9tjGwto
         Zrnw==
X-Forwarded-Encrypted: i=1; AFNElJ8Y1o+sixqIfc4mqYPC5LiOTtgJJ2z50MDRSqwfdB3moWatGC3fl9fFZ7cUbY5tnePI4HAQEkdslTO0zs8kvHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdX99m8/LBE+Nwx0cEeHgCLJ05o1QdvcOS1bZSf80Qz7LL0czV
	heHY2wJOsqAi8ds3HgUFkfnLTHoSZR4zh1Ur1zgIOOI6lE4upWYP1emsUHtHt5vPgg==
X-Gm-Gg: Acq92OEyEpQOrVn5udlYuzE7OYqaQZC9Y71NH15OhPoR+DKe1PCEdFRxEqdnFXYfDrI
	vNFy7hVkWRd5gNWyNcmJ/4FN7HewFOmUhaYa6DTKz1L9Mrq2ui97rQlMuYhdvG/xqcQZ9phiOOJ
	mWwltyiEMYBbvvHK6lY72OoMXyJJTJhhcGwu8Uoo3asV5uWx2xrXJcCmMATFII2i6m/Yn4uh/L0
	OC+yu48Z3VeShXGfvA/BPKb2Byt3Oe4VP+74xkCXjwYCKREhuAMQHmAXwISvCKZnz5YFgLYQeuZ
	wp4QU+q3pI0e6Ci+Ty6YJs5QGAM0040uiViywnRJH9vcqWWq5vILnVdL5V+ZlISuxUhEvK9ige4
	P99ykV6Gg+xz4mqzopcX8fhlGfAJi/eN28LKUKYOd0oqlkyMA/9FF1fVRjY95C7+h8mUId61Saa
	vBTWP3MblGomhKJ097WsD7y3jHK0uyZIPM4/iksKy3Jf7INIzNTkMJdFv8V6IUP/QpXy2eTMo/o
	NAwmzaVRAKi4mxomFzIgp8=
X-Received: by 2002:a05:6a00:3691:b0:842:4af4:3099 with SMTP id d2e1a72fcca58-844e1998f75mr15786071b3a.20.1781608367732;
        Tue, 16 Jun 2026 04:12:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm12906321b3a.59.2026.06.16.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:12:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 0/3] Bluetooth: btmtksdio: teardown fixes
Date: Tue, 16 Jun 2026 20:12:05 +0900
Message-ID: <20260616111224.152140-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of teardown fixes.

We noticed a number of cases when btmtk close/teardown would hung:

     INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
     __cancel_work_timer+0x3f4/0x460
     cancel_work_sync+0x1c/0x2c
     btmtksdio_flush+0x2c/0x40
     hci_dev_open_sync+0x10c4/0x2190
     [..]

There are several issues with the teardown (close/reset) code
in the driver.  First, the btmtksdio_txrx_work() potentially
can spin forever (infinite loop).  Second, close/flush can
deadlock when run concurrently with btmtksdio_txrx_work().

v1 -> v2:
- added two more patches (deadlock fix, interrupts re-enabling
  enhancement)

Sergey Senozhatsky (3):
  Bluetooth: btmtksdio: correct btmtksdio_txrx_work() loop timeout check
  Bluetooth: btmtksdio: test for bug IO errors in btmtksdio_txrx_work()
  Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock
    scope

 drivers/bluetooth/btmtksdio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog

