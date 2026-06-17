Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483513B52FB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678756; cv=none; b=mlYPkEalNs+gCeoF+CGOt6nq5TiSXyMQt91/Dp2sg3PYpyEYj5m7duARtLfVkWg8kBqiud+O4hXNyyWoXX+cSZLo3bogouWXN3RyR8/qlCFAlaKx2AGQwhfNzcPaEnoBD7vvshjYYvXYLab56sfm34aTkO20naKkh5DbuBX6VZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678756; c=relaxed/simple;
	bh=zGhc16N5jFeOR7KwmI7H5VPYEA3cBIQAncRqcnvfLaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkazTcUDzL8zdj9D7utT9EuaNKP15JmXwbCPdnkN75j9V6t+v0NvcTYt+fwLtBtXOPgCDC/h0x2q412Wfe9Majsy3O9Unhk6c4NMWhOpNG+Y29wLTvz17grnCe/vcOeGweGxEVQKj1U788nv1dvhyTJvOUPlYx9BUU8apKy0nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XrZzgHbU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrZzgHbU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso3421356a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781678754; x=1782283554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dzR6Vpdm4bVAwBr1gBJ6e+KALKJtf+O4NR+UNIBATg=;
        b=XrZzgHbUlMBDKpON024f3tAE37ZyE2I5sgx8y3sd/9YaRAOmzaVE/mfYSOgsiyuaGL
         4DXQOhD7dlef51QhG7aVxKIsYBtvAjKW6Q8fT6/tgiYvjTkaZnNOcX9XrI10PnqjPqj7
         XzyPIXvCGYu5NqaBI4qDBWJ6ALajk38k2hRbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678754; x=1782283554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dzR6Vpdm4bVAwBr1gBJ6e+KALKJtf+O4NR+UNIBATg=;
        b=lYSnMhan0HEVIdplp1TxfKib78iKP5D8aOJ9RJseRs5ybWZrWzr0uVer8OqGfGhQQy
         tLy2Yz9pg63PJW1K3nYjmsUo7RKth0kYaftVTT271boVONzyyEjNZeeAwpNj91ms7lJ5
         jFPUPj6zL8+kGVMDAsuX9qz05f1kM5wwQ7sj1IcYjsoYR7s9l85rEMl+3x+PuQ++F3io
         rjDhDdPrvLpu/8RSaet6pgL/N6pBoP4/nzNglcnaQZp7cspwP87IWKuP75tc7joKWagB
         k1JpYWyHvKVrircInW5c3jYQ8iOGtdbTt9O/tSzKq/vCElMOhtzqAeQ+W4COKaSkePqI
         HMeg==
X-Forwarded-Encrypted: i=1; AFNElJ/Kq9FGz9C5yYjFB2sO+kQnwbc6I008NYhJ3v3t4oNCH4MKAesC8MqPWrcGXdDvfPGOL4hEz1dGL2JTyE2f8qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8W2m0L57v2nTaKdm84ZZtKLUlEpXb/ArLU3dWYZ6c67MQJXw
	l/CgoxSq/lS3uQr5OemDuAkJ/IYlrNf02gYTjy9h/AY4JUWk/guVa2hvTIkgPuCSFA==
X-Gm-Gg: AfdE7cnzKCitiF8m32rLA2gDfejMmd8MAPkQiCGwvpqyEEAncNA8yPEM1S7uiSFTiDD
	9C4xeSshAtfDhXEz50H9FIc6T3AOsx3NkQ3MNX7aLS9+HCC6Gv5swGEzlRSCqpsLq8tU/lqv5wG
	Ck+Nn5cbFWcijg2nrLAzoFjTQHwPR3UG0Dbil7swonPbpQqPXxVPv3x/G62xnnmcIHkbAYeZkhj
	JrbI5FB+KkBxvqELirSO9fwZkH1JxgGSOsOQN4QICkEoXrpks1liqSa9h/qBbrReBr9GhoUm0/M
	QmIGdeDxpmJS6Rl0+Kt1CZy1RkiVn1Jjb8XvHSrg5sWb4+VbE9TTp6jhMlaKKIwjpfD+uFxKArA
	xId/9Y+DTopuxYujn/tTeYuql5Bz1xB7k+mPUHNF/0tYq+6i7Gwnmw6PGyD4Q06OioV1QNMlbBT
	LV2YmEPVWUn/T9/uIolQMrXEjqHUzkXMkZ8nZIKcDCt/zhzgfjDBk6hVqehtqKxmLdC7U233Mkr
	PM=
X-Received: by 2002:a17:902:e78d:b0:2c4:358:db32 with SMTP id d9443c01a7336-2c6bc0c6dd7mr24581365ad.13.1781678753662;
        Tue, 16 Jun 2026 23:45:53 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6af931f19sm24365675ad.74.2026.06.16.23.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:45:53 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Bluetooth: btmtksdio: teardown fixes
Date: Wed, 17 Jun 2026 15:45:30 +0900
Message-ID: <20260617064543.574704-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes several teardown issues:

     INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
     __cancel_work_timer+0x3f4/0x460
     cancel_work_sync+0x1c/0x2c
     btmtksdio_flush+0x2c/0x40
     hci_dev_open_sync+0x10c4/0x2190
     [..]

close/flush can deadlock when run concurrently with btmtksdio_txrx_work().
In addition btmtksdio_txrx_work() re-enables interrupts regardless of
close/flush being executed on another CPU.

v2 -> v3:
- dropped infinite btmtksdio_txrx_work() loop fix (already merged)

Sergey Senozhatsky (2):
  Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
  Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock
    scope

 drivers/bluetooth/btmtksdio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog

