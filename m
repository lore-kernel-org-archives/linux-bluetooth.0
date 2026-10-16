Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB939280A
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116654; cv=none; b=Iyvhq6Jj9ov8Mv8P1aqd/aKxq3JaeO8YfruSSq6yzCKbm++kmSl0sHnMHDb35o93P2Ii+iSOtLHJ1k+Mlx09FesHz+wmOfQRZu4jRRsCC3rNRblZp256IRlxFGqe/Ix6mm7+UWSg0HExesctoyR94sxxRyVBgHwrjY/CHp4Y/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116654; c=relaxed/simple;
	bh=Zc1KZBlT+3PtjTuluFVY7wJcEB53Glf0TXffmrReo4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AO0GSE4UANi6DS3nm7haMjYcnfve9AUpXeQvrbI3JaSiWXAxml2d9ACGaQAbJ83zDwMUUXizqZc2d6QYxarHd/4vOklyPhR/DRhRQ6qO8tIPYgyGUjhOlj1O0yuMCi2Y8v0QbbgSJpM0NkXMhNj+dIJilTA/tVkTKeic5phdHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=KMVjoYoe; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="KMVjoYoe"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so1954212eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116652; x=1792721452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zc1KZBlT+3PtjTuluFVY7wJcEB53Glf0TXffmrReo4A=;
        b=KMVjoYoeQyigM+VZH6XAcg5wqw8j9cioBMRrldBW5lGSfcFuIKXKuiZz5wte/dOngr
         b6WBk7jt32ibmKmqP2HUTh5zN9iI2uWYhSTj071OHXaL5YyGaropb5pjQlgb/tZgOMjC
         5BcNhIW/qFxUFhxkw4SnUU40ki6lxxqhEPH/iZhyQYQ8K0J7k4QkbX8/GjBHQWZnXFPP
         1h4ZBy4j7LfqRPQYv5McGmeBGM0clCh6GM3Wx3g+f7XO6vKaJoYHS5Vl/vwxKekHKlbp
         hy/+FCRTe3zmyqepvwn50W2L0EDOCRU4QDUP8/4Gs6plfbZ3+TxxhNsOBuOXWKudlz4w
         n97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116652; x=1792721452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zc1KZBlT+3PtjTuluFVY7wJcEB53Glf0TXffmrReo4A=;
        b=d2kZGHzk9h+IczASbv6WAqAuGd4ODgi9qG4SWxKPbbt/DKP+drHEmTG59o3QpkQqhL
         sfVgRRfok+Qyon7eu3feMI+oVRfjVP+9bjhCxT0Qimy5YPro07ATj9FIHvOhPGpwCqvf
         ZGCtjrsuNU2zXJ5IUAYS/2PpnQrLhwwkngi6gMFlHIakprXHkn2jUwvyCiF6V9MrQbzS
         OIvqPfyrL1iMIFjO+8E9zsFkN9oTHR80d8jmm5CQVuKVuK/9cvrmMWSr1tXcAeh+kSNg
         oV3cHCCVby1cn1WYFP9txEf9J8v9gqjRYNXnGy+TyOvlU4G7sL7ZXdvRl6ilgNkJQBj7
         McQA==
X-Forwarded-Encrypted: i=1; AKwUvBzFl+2Ew9zyDSwD0i1duD6A4aSzdLXemaeXyVGg8YINEMy9mmpUDUfyBZQ4OoLNOcbEAOIs3uIHEZ05xeUgchg=@vger.kernel.org
X-Gm-Message-State: AFq9FYInyUsD7WCql+In8VNLg1hRNvTJxPUz9r0DNEcPDhKqNl9TFm+h
	wqV6zeD9DN35aNECqRz7s6AgogtixRfHVXDnVcb6h4omnyhQ1UsQja6x1S/w7HJYypc=
X-Gm-Gg: AYBFou2hiDfMJjnKdmfVPL4Rt2XRQ/Oim95qEk2Y97Bg8Xw5mZaMB4602yrYIr4WjtY
	ZnegumvKrRbyPz/l5t4SItxSCJrajecC+33hWan6LmGp13Lm6645rmRX0vLzblkBkCS5l6FscA/
	DD12OX1lKEriV2G2Q1JHOTjELHnAzBppjAd87i50XRd/2cO1oOXKt1pVwPTtO+aGN0sHzBtsYez
	a5+GyzE2b4unV4gPqTZhQC8ZRNKZAA5vtgvgRHwobWdgFN/N7wLuJT6IZZucF+ezqVyPmmUA55X
	Zd2h4gsv5uGj0RI1QukJq2547ms62iZb6gG8oMU8b4pLkT18cCTYaNJ44xWHjGVNtaiDneEVsrE
	2pDzw6ddyGEux6BI3hePjX98tWDCZ1IRlPuu8b4G4Msjy8j+0AqUayHxmOYbKSOQF/77hT7u4Hz
	kIpnp0OJN1zHbgQy4BM38g/rHkGEMCqBBlNW3eylAeZ5BjUKI7mgQoc5H9z7YerCpvLnFfUpBki
	LQlt2MNKDI0TB4ha+qd/7ejFvZ0XOHZwpcRsACmtWg1JqDIuEr8MY3HU5n2JgBuR1KI8g==
X-Received: by 2002:a05:7301:103:b0:35d:f7f4:bc1c with SMTP id 5a478bee46e88-35df7f4bd83mr8817165eec.6.1792116652320;
        Thu, 15 Oct 2026 19:10:52 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm2638280eec.28.2026.10.15.19.10.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:10:51 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: halves@igalia.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	ngocthang2710.1999@gmail.com
Subject: [PATCH 6.6.y 0/2] CVE-2026-63974, CVE-2026-98297: backport fix series
Date: Thu, 15 Oct 2026 22:10:45 -0400
Message-ID: <20261016021047.16461-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2026-63974, CVE-2026-98297 to
6.6.y.

Apply the patches in this order:
1. Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close (fix)
2. Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained (fix)

Patch 1 marks the workqueue as draining during device close and waits for
earlier RCU-protected producers before draining it.

Patch 2 makes ACL, SCO and ISO transmit scheduling check that drain flag
under RCU, preventing new tx_work from being queued during close. The code
changes in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
