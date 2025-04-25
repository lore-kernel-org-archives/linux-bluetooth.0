Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B521660D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609041; cv=none; b=DGE5zA9m2oD3ww+1uMMWmV+GTl0LVAIpgbskKiZq8Y/qHLGKhLJ1/KXyF5mb2Tq/3CPUA+Hc0VEjrRprLh9tcxAyupxznDL+RLnLkbj0a4h+QvDylRpwtlEm3lhseQ3jTdWv0OnPO3Mi89Rgy4twoANHmGjnBU6yWaphDNGG9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609041; c=relaxed/simple;
	bh=bHam3Q3+jElp8fCkLomlcfEPt3kJAMIJOK2axlN3350=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rj/FYz+cXMK7oUZmwG0yKkvUB4Fo2x9WYTusRYRKxHirStMXrDFweY36Sc8/xeyHhJhWEGlqLJL50izFtamLSaZJ19nUf5633jnetU9mIgZ0u5UHvyz2Wi+Kltlg49RvGCgsA4C93HiykNjRQJkREEm1Is37eXPGsGTt0Svbzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO/NxpT2; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO/NxpT2"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52413efd0d3so1034495e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609038; x=1746213838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIDuHC8h9cMc7qwARTO7Z+Zuc2xY4Zk+wLulRs/SGVs=;
        b=dO/NxpT2xt2BRs3chYRhicJs3fXTRAFsWNrdJ81TV2wAIIQPEwiiuY0+V2GX4S3IPG
         wfK9fFVuHtotozzBVBoIcA7nornpgX7EHqsuIGkkLpw/Sep4UbbtcqTsw9s0m0r8ymME
         wJy08rPSWYdEoJ0AEcjt+eWORQ3qvgdLLmXcbhov6N1Jiha6VZ3lpR42BqN9NB39Z0Fh
         n2JEOnNuvYnOCbOQ8nw1tMwhG9KJfxihNOsc7iIZRItWz8NaKOOQrGsW1b5c/p4nKRTI
         /AKmzpW6zIFZ+E1dH8p4lfYc+zBQR36y8ZsnvjXqXZJzZ4ppZy46GCnCOaJDEglKgMZf
         rk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609038; x=1746213838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIDuHC8h9cMc7qwARTO7Z+Zuc2xY4Zk+wLulRs/SGVs=;
        b=iBWQSG/pu5Eog59SRIlkINQV1/Rly1fS06VjSvVpMYRcXn2AcgD/dKtxo5HGbmtUew
         BcERIlpwSTzWe8Z6EaQorR+9K9kASyyWOhTAbw5mQPDUaberat7IlG4aF/wSZ/Hmt/VK
         77IFVRF1XeBEBPjrQkdpw8SWRq8c6N3WM5PnPRTA93+BSRCFEz2L72/OV29PWkImca7D
         R5J0GNVpbVqovIFlIp9+T+1PBt7SQDIdHsyKxDgYU99zanqpj5roRqVx/4YC2T2pMtw1
         ifI3w9iizLO/FOp7LVGongfu1zWayY1HOcc2VaGIBdFhwr/+o4Q7FgdXuK8/DtgOF3T2
         uJnQ==
X-Gm-Message-State: AOJu0YxBXzqMySem1rUc+z+KEt8TrEvKCZerdsnCp5JCvHVFsoVYJ4No
	76HwjPIzzUf6mCy1S0lxw79Kb35ayqyZp3cuC3EUjRFo1GGWmLfUH1zK93lRCK0=
X-Gm-Gg: ASbGncvpC/x/XK9YPBTXhYzr+4Q4Q9S/I1TsSsu9goHRVzwKw4JJTmSKItxtsbyRRnf
	V+7NIvF2F3NYkKUy3HV5wyNny+WGyd9VfNzsieVN6aaE6VP6HV+J/JoD+LNytEdD2mjRXVHs6L+
	HNkmwtfjRh40sMTmGqtvW5voGh6UXx5jTCtilwdy//VdyxxQiBetexlZrUzS4RbgqdEKE8OIdwE
	SGVncAGbaBFz2rJ9fHwM9Yp+scbYFDRVBkEmdhawS0hmof6CWGCse+mtESgaZJKRmKKVbSTRBjr
	1VtdjwCihQlKtt85Ct/iIDJiByOV8687+SKF0DF6pP6cKnSpo/INnTSUldRtVxy0W8ZHuFLQmMm
	ijHQm1DvMdg==
X-Google-Smtp-Source: AGHT+IEquuilzuWQSbrFfHD1h8EIesJsWsMonarD++vyyQU3WHhTY18C2b0/xxo31ixnxrRtlPeRVA==
X-Received: by 2002:a05:6122:179a:b0:524:2fe2:46ba with SMTP id 71dfb90a1353d-52a97172bbcmr573402e0c.11.1745609037632;
        Fri, 25 Apr 2025 12:23:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a79f5f71esm780939e0c.14.2025.04.25.12.23.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:23:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-04-25
Date: Fri, 25 Apr 2025 15:23:55 -0400
Message-ID: <20250425192355.1578678-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 49ba1ca2e0cc6d2eb0667172f1144c8b85907971:

  Merge branch 'mlx5-misc-fixes-2025-04-23' (2025-04-24 18:20:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-25

for you to fetch changes up to 3908feb1bd7f319a10e18d84369a48163264cc7d:

  Bluetooth: L2CAP: copy RX timestamp to new fragments (2025-04-25 15:03:19 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btmtksdio: Check function enabled before doing close
 - btmtksdio: Do close if SDIO card removed without close
 - btusb: avoid NULL pointer dereference in skb_dequeue()
 - btintel_pcie: Avoid redundant buffer allocation
 - btintel_pcie: Add additional to checks to clear TX/RX paths
 - hci_conn: Fix not setting conn_timeout for Broadcast Receiver
 - hci_conn: Fix not setting timeout for BIG Create Sync

----------------------------------------------------------------
Chris Lu (2):
      Bluetooth: btmtksdio: Check function enabled before doing close
      Bluetooth: btmtksdio: Do close if SDIO card removed without close

En-Wei Wu (1):
      Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()

Kiran K (2):
      Bluetooth: btintel_pcie: Avoid redundant buffer allocation
      Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
      Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync

Pauli Virtanen (1):
      Bluetooth: L2CAP: copy RX timestamp to new fragments

 drivers/bluetooth/btintel_pcie.c |  57 ++++++------
 drivers/bluetooth/btmtksdio.c    |  12 ++-
 drivers/bluetooth/btusb.c        | 101 ++++++++++++++++------
 include/net/bluetooth/hci.h      |   4 +-
 include/net/bluetooth/hci_core.h |  20 ++---
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_conn.c         | 181 ++-------------------------------------
 net/bluetooth/hci_event.c        |  15 +---
 net/bluetooth/hci_sync.c         | 150 ++++++++++++++++++++++++++++++--
 net/bluetooth/iso.c              |  26 +++---
 net/bluetooth/l2cap_core.c       |   3 +
 11 files changed, 300 insertions(+), 272 deletions(-)
