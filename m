Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA225EFBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551609; cv=none; b=b1xcTty4bcby5zTawF5fomyjrNQK+oUrjENh8sMlxGt3gC5kMMeGWDjlMjn71YDXN3V8UNouEBbKpG1l5T9RzvQYs7TmDNL3061k4fm/TXApt9fmPdzopP2kRnnRASZp4CmDItrzaAS+0K8FC4YrNvuUEybG0buBRxBe6uuFUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551609; c=relaxed/simple;
	bh=5Cm0gDbIKYxn4Gl2GodsVLyEunBvWJ7koKsgkm3rMnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mej0Q/0xgYOVa2tBJUbhwKolak5oR1u/z2b6EeRP+GfagUqcxTYOI+bmY0ZHdZ+K4TZSf1j0dcHbXpREL+a8ZBV+TxnkOIN3iaDJi8+fO8i5qgCZ9PIPyXny+mIF8dAtJcQ8Iku1yyz2LnJuFycH5v03UN5l7soD47mfkbeiAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLwjW/4k; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLwjW/4k"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so3416012241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758551606; x=1759156406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1tnpsKtwkYd1Y4femBXNl5zIRx/qFBWHbkmvr0dRDA=;
        b=DLwjW/4kmvYwIK7l3PZOpFTl43kEAiGPGVmLKowgGzTBGZF56BlEDgMGIPnQncpj9n
         TU57q0ERVWbjrrd/A5TwWwg3Mfzk6zttR561zObHKcVPBatGhEmistJgJc+TqofsaOjv
         kMI5FWRfxY2A1A67VvbTty/gstjLADHVMZupW3MfjHNYl7IRA+fTJZMbH38mZ+lTulNm
         jHESu+xdllLBF4fHCGl31AjadkxuHFHJzaLFBzXyO6a9qg2l3lZ5Dosd+3QTw5j3eexB
         DopH77Ddng63C3btEHiwDr71/5FYK3ZWMrx4Qlp56nmUynV0RDAbcB80gMJWx4yUjalZ
         gasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551606; x=1759156406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1tnpsKtwkYd1Y4femBXNl5zIRx/qFBWHbkmvr0dRDA=;
        b=rOag47LY24zl8rAaqxD5paEz7eqPTqGIZICgYvWNrz4ueYlWqmBNBO6+kBVtVaxtoV
         Xm3A0PsYn0rYFkZJotFGHX19pX/QTlTx0318HYxjOQ8Cno9tdYkyoyRqbyALkTbSsF+E
         5en9ubp5BmTD2/1MGitIuOnrLS9a2Ne2OWndqBFPY4r977HPVLjoxJ/eE3mJH6tBpjmp
         5yc/IT0TVRQCpCrzr8u3v73IGDAjKV1tsolP/RxgVjF4gKx0nQtWaEa47uULgNF09M5Y
         1raFzfHwP6yOfpXkhYPkKLlUa/Po4zUgeTqhM6oaRvabEG9rBKehUAhlgphPhKRWVn1N
         uicA==
X-Gm-Message-State: AOJu0YzHDN7uoG6nQborNo2SStE+sUg/CQo8LR7G5g0htt0pIXH6sG3Z
	R//TuDRE6T1H0m7rWAFOU5Ee2IvRb/oqmZnF8b5PTwc6t74Q8CXgTAs2
X-Gm-Gg: ASbGnct/liDAxCng/t1HQQAmO4DE+j5mmauYT8ZM9c22sUn4NYqmZQCR+AAmp7O6EH9
	0dkKVJCnrl6eVX8zvmSAWWHABPX44THQXVpS7c50ux4t/+GnHqkgdKLUGCZke1DuOljLXVtAuto
	24LBbZt0K7g6Op1PZ+qFiEAjLH+lZBWzAoyH7SEW7ceej7rUWzTwLKXo7TR69ReEpcNcjSyt8+k
	DrFyFssPImZ+ZG64THrYhKPXRU8SStY0jZmTaUlNvTIeSpZg9OCwb8Zp2lvIQWA7ZpcXDcLzcMn
	G1O623MwvAePHofJho2NKWPa7yu2kic+jpXLeCMYAAytomrphIY69a2pG0YMtkRM2DPLrIEQG0Z
	sR1GZn9OgGB5qruwgA2FEMDrb6FW3J3O3DdxpDkMzMWm6PColizKm+YTTMxyjdnd90Q==
X-Google-Smtp-Source: AGHT+IF1R26uJRPcFOa9sD62zojsE+aFtQ+NGYBgTi8CWYwOvvjMgWXrQ4BG4DUOKz7l9L40iH1n5Q==
X-Received: by 2002:a05:6122:3129:b0:539:44bc:78f1 with SMTP id 71dfb90a1353d-54a837a6c19mr4101250e0c.5.1758551606288;
        Mon, 22 Sep 2025 07:33:26 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a72974c93sm2678219e0c.15.2025.09.22.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:33:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-09-22
Date: Mon, 22 Sep 2025 10:33:15 -0400
Message-ID: <20250922143315.3007176-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b65678cacc030efd53c38c089fb9b741a2ee34c8:

  ethernet: rvu-af: Remove slash from the driver name (2025-09-19 17:00:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-09-22

for you to fetch changes up to 302a1f674c00dd5581ab8e493ef44767c5101aab:

  Bluetooth: MGMT: Fix possible UAFs (2025-09-22 10:30:00 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix build after header cleanup
 - hci_sync: Fix hci_resume_advertising_sync
 - hci_event: Fix UAF in hci_conn_tx_dequeue
 - hci_event: Fix UAF in hci_acl_create_conn_sync
 - MGMT: Fix possible UAFs

----------------------------------------------------------------
Calvin Owens (1):
      Bluetooth: Fix build after header cleanup

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs

 drivers/bluetooth/Kconfig        |   6 +
 drivers/bluetooth/hci_uart.h     |   8 +-
 include/net/bluetooth/hci_core.h |  21 ++++
 net/bluetooth/hci_event.c        |  30 ++++-
 net/bluetooth/hci_sync.c         |   7 ++
 net/bluetooth/mgmt.c             | 259 +++++++++++++++++++++++++++------------
 net/bluetooth/mgmt_util.c        |  46 +++++++
 net/bluetooth/mgmt_util.h        |   3 +
 8 files changed, 296 insertions(+), 84 deletions(-)
