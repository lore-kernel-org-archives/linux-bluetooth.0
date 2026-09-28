Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB64E73AC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609369; cv=none; b=o1bylW0NMo4vQTdSgmyTU+tOeeGyb+B+HK4W/DdVkRBBmY3N/bcBvi+sdq5xYybrW4IrBAZyfeVS9+IxJe002OxARZoXeo2rp61Arhi2IHbvW2fgXRUN/6lC0UM/uTNdK7C18Q9HZwYsKF6xemYmIJ2awiCz3E4MvkuJgrHwSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609369; c=relaxed/simple;
	bh=pM2ZaPJvm5Rgd1AaTYxU7u4yvAKak1gkstY7SWaFSQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pciz9IYBZOjWcM+PVwaPvSC8K5rE8hVPAidmqIXkVbqTcG3npT+niHnxJjCReNeLkLj3ylkpz3keMBvrlPEcfigvcAzocI0zTcsrOErskSXypxI8YC40EcxNa1IUnX6jtabqawNz9fCgrhWsIvxRJQbYhIjxjPTPX05ImShUcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5Uhr49o; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Uhr49o"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5caec6d2983so2686698e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609367; x=1791214167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MEOfh53Bs8xIHBW+TfNPqEs+6m7Qp6MngOl0fo6oGhY=;
        b=H5Uhr49o/k2R31KkZZxBwJHiP37KX6Yi4ayy413sHdwd2/xuU4T1W03qyto6M6a5xH
         IOwCp77NAZUs0BtR8mVRbNPQFsPHk4nwk3UtvVzc8xrWJzdDljsuAcENY4GeniI5SSVd
         l4V16WQ2NUDef0u8gMvGBZ2pG474I10NSHAeQXWefK6e9dA9xRcw/yLmvWzn4RGk3HzJ
         cidxrqP3UOJvvA5Tb8wNxgMzefZLW+Bw1/coB3dnG700imT9DHPfnVqYdPi6nHQtkKer
         tg0pHua9ivOBQ/CTOnPcGba7E0ImFd+4sWPvPkhJvaJAj+M4vun7eCe2fZGopFTqspyK
         fglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609367; x=1791214167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MEOfh53Bs8xIHBW+TfNPqEs+6m7Qp6MngOl0fo6oGhY=;
        b=zBh3ddXis88NZNQO70bHJvFxKOov9BaPUBqRHVIIaaexD71IU5S08l0g6hejGm333M
         /ypaLtRHiHXiO6Mn5MS/aM0bLvpGZWd0Sng5jD55EZHhc0fezX1ICCQPZ1W8dhnpGoMU
         CdAcsFVy4CCNMpLMt5PYemZP8OB5n9VxQ5VqNBvW0SZOLmNT1MOuofbhGaIuDELyY24Y
         uFtAKhQIg4O/cjZ5wnmzz1wrjwvT7tmUyD0Kg/1JpiBGZf9q6MDiGkDX3PqTdlBWlASz
         ke2TpEHkUf0jXoHJUdhashWHBFaJ+hwM8sIVajviv6PxpVu04u55BrKRABXNj/qGncBO
         LR3g==
X-Gm-Message-State: AFq9FYJgqTNS8KQsad8HBKf3nIWF2TChSZvs2IltkWrQDZ6yM4f7JKBa
	Kda+joekyymVXO/anBpZlZ6uVLVatarKkv6Pr5B6b/0mSGkDA9BCl56p
X-Gm-Gg: AYBFou3A+u+RZYnFpjAfk+a0V9ohI0NZGzGODqn5I54YT6vQCahtH0y3MhTK4v01klO
	VJAvM8rGTJZJjXQgNBBTLLeHapxCv8n8JnaEAlrq4Br9M4D1WpMQ12lDJ3O+p10Sl+vo0mTvYSj
	oiXvK/bl4PXeQtDYo6AROYuvt/E32Ave6viXYN487zed3dfGLjgJXx8a633yJklyfKUFTusQzQe
	vqdJMjs8eSj61VQJRR8gmGc6j3aOgB8T43lQzql/PFzaNgsDN6iUIWh5X3XnDvRh0BmZHTjJ4KZ
	v0UHDTfAzhjtuMlAgyvkzMYHrbAJTaDrdr+8E0bQhAlsWzGEQgcQFqt3yBCxbnyMSsWqJ8NSOVI
	JSVdw8PpO9zPKz/T0Ty9Qg1FQlvcbv5ExGgP8QXE+33yDm1R32n3XWUv0mv7fyLzHQk8mWv+aNi
	GAqIx/NC8LOhYxve/5wQlib1Flkr3ts4Oo6KmtbP+CJiesJGUzdx3qMbUg2uTHllDgyZ+Rag93r
	6DJ5Q5hInZRqLtfamAkReefsu40nTrwEPxVBIjUiqaoS7NOLK1Y0BCc0zP2H/HPgW0aAtCkzb8=
X-Received: by 2002:a05:6122:2804:b0:5ca:f811:25ac with SMTP id 71dfb90a1353d-5cb0b48d45dmr6283450e0c.14.1790609366686;
        Mon, 28 Sep 2026 08:29:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde615a356sm9194650e0c.14.2026.09.28.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:29:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-09-28
Date: Mon, 28 Sep 2026 11:29:19 -0400
Message-ID: <20260928152919.942973-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6d91041bb38b97e2feb625123cc0529d7b83a0e1:

  Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame() (2026-09-21 09:37:20 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-28

for you to fetch changes up to 848a7a91c7f03675d3bd8db6f7721cbf9cb50e21:

  Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown (2026-09-28 11:00:20 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Serialize ACL scheduling with channel deletion
 - hci_core: Serialize SCO and ISO scheduling with teardown
 - hci_core: Serialize fragmented ISO packet queueing
 - hci_core: Fix inquiry cache timestamps on 64-bit systems
 - hci_core: free the HCI ID if naming fails
 - hci_conn: Lock parent access during enhanced SCO setup
 - hci_sync: Fix inquiry cache use-after-free
 - hci_sync: don't drain cmd_sync backlog on unregister
 - RFCOMM: Fix initial port reference race
 - SMP: Serialize SMP remote OOB data access

Drivers:

 - btintel: fix buffer over-read in btintel_hw_error()
 - btintel: validate DDC record lengths
 - btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
 - btintel_pcie: reject oversized TX packets in send_frame()

----------------------------------------------------------------
Chandrashekar Devegowda (3):
      Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
      Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
      Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()

Chengfeng Ye (7):
      Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
      Bluetooth: hci_core: Serialize fragmented ISO packet queueing
      Bluetooth: hci_sync: Fix inquiry cache use-after-free
      Bluetooth: RFCOMM: Fix initial port reference race
      Bluetooth: Serialize SMP remote OOB data access
      Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
      Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown

Linmao Li (1):
      Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems

Nguyen Ngoc Thang (1):
      Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister

Sai Teja Aluvala (1):
      Bluetooth: btintel: validate DDC record lengths

Sang-Hoon Choi (1):
      Bluetooth: hci_core: free the HCI ID if naming fails

 drivers/bluetooth/btintel.c      | 15 ++++++++---
 drivers/bluetooth/btintel_pcie.c | 12 ++++++++-
 include/net/bluetooth/hci_core.h |  5 ++--
 net/bluetooth/hci_conn.c         | 18 ++++++++++----
 net/bluetooth/hci_core.c         | 54 ++++++++++++++++++++++++++++++++--------
 net/bluetooth/hci_debugfs.c      |  2 +-
 net/bluetooth/hci_sync.c         | 19 ++++++++++++--
 net/bluetooth/rfcomm/tty.c       |  7 +++---
 net/bluetooth/smp.c              |  2 ++
 9 files changed, 106 insertions(+), 28 deletions(-)
