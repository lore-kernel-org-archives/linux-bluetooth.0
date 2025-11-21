Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8212C21CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736823; cv=none; b=Ul0YvdErliZczfX4pGn9wFh//kJBaa8Tn1K8LJxMjnJNAgPKKJYUfGCLYh75ZOWcpGWjFAiPVzv16zAfbZBksTIYzlgW3AX8JMGTrdwmbqpUuiLmLZhtgw/3I3+fsh0bVraXMBwVqdQPVWbRS5lFtmG2u40XjcRa3l/yEaJYYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736823; c=relaxed/simple;
	bh=ND5N6DFcUJ9QLZKnjDoiKSsFyybTdq07tpDIG64txrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4h61zWogR5kew8vFoXLtJGNTdjLdzAktnS4hWlLYPpsCSVnXkmy8imjYDk37Vvf3wfCXrJEW9kEo9r1hOCK0q98w6HMByLejTb1x/3ywAZKUb81o9Wlt1lEk+E6pBgmxDMfuwv+2O33gLCnooqR/PJhnk5U4zDTC+Y39vpr+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDxyz0LZ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDxyz0LZ"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dfd4a02638so719129137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763736820; x=1764341620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4dAM4rKHZ5RfYoIbQ0/TZamahQ7uIG2NU8chuhPsyw=;
        b=nDxyz0LZ5MUrN9S/LgRyo/22yny5U7fQLZxt8XZj2tf+4X1L75wLfGHhzvMDK0JzbM
         p4UrYBVcAjXWBVZM3MvDgv4e5hwxi1qPZkVYQ7AXUeXWm9knH3S+uRr/YR99ZsjxMRyI
         ndkPYxF/SXHVq7tZppHwq1qSJ/C+wqybazjECge4q03hKsp2fgdosUel/9hwDmv3Bhnu
         ka7GC2UCR9DZAFvu0D72AACki8fugWEY8XhdTvwdnWKlleWSC6PHYL7Nm+L7pVJNQO4c
         nlf+Nxeg4NCycg6ihUtFjkPMCBnzyJmgKQKleIqNspD2ELkmRElNCINJ1O9GactgUR6I
         iR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736820; x=1764341620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4dAM4rKHZ5RfYoIbQ0/TZamahQ7uIG2NU8chuhPsyw=;
        b=CUu9BcP0StKBUpCdu3oSIwzj7VG3R4xGz+7Kuo/uoseG1Dqz1XF3SyaO4sD2Qq9E2v
         RYsebl/RRC7sLZeg6zkIBDtZ294nsasnlBa8tGewzEvVL8eCEV1yxZTl1OuAxhrGxY8/
         D4k0evcpD5FxtgydfroVP5lmsRcCWDezeT+/KuwTt5G4elhS2SzOh9d/wvtP+hztd6A9
         0MGyYd0dCvl864C86uWCedVivgsVHHOVIHWQJJqqFQt6hjuJNgtY4xlPBphFQT05aOKY
         hCcuTcFLjI1qVz3PtpVMlttpEDrjFGcEVmaU31NqB9ob5nA6o8sVot4R3D4R+wvatXVu
         3ZKA==
X-Gm-Message-State: AOJu0Yx9z6aAwFFsEC48Y15UF8YS0QIn5eGTf6JeYmdc2TvonnTpD1+G
	GiQu/CGBjDIqse3N7Rf8FO0JUOqHGo67OWyOIlQW2a68q/fltgq3AoI9
X-Gm-Gg: ASbGncs+YYmNP7rE2A+dqll/xcHF63v5hDn3Wdd7qUHfEqlzA5hXt9adFdqx6k9UKh4
	LPT56JEZqzaXG7tLrOEIbTZczJTtraf1qDp8XpARfe4PwxmIPrnaUM++9NtXfeFPM/ZkOG4gmZf
	AkM+TM9l2KEPlP0A/nRRjsZ4MrBRAh6DTDk3hNWcF0jN93omdHNRjhHTWKEqmOO2kZiGCTPQtTD
	FMCL8I91cota8nr8TMQcGzKu4/eJ9ca5uefCMOEY6+/SygCZvLktHj33xoqWD9J68tG6/Pp2iBY
	uyBourqT7aXTBfB23loxLXG7HpIkFgN7sxkuKtI+5zWqZxY1hn5bT+5LR7BcbiyR+kxbQvxIIEV
	3XwTGjTsJTssjoeThZ6B1rUHRnYnk9KVuvp7mHbzzGorlUZHYTu6VgJwWzXpG7J9WWCzPtYhBCb
	hSten9Pw22VVIXRA==
X-Google-Smtp-Source: AGHT+IGmub1c7/XiLBd7PGpq0zorOnqMlAnzndw1qg4uH3fSq0Q/lwgwRP8Gshpjecqrgl5ChLQ2Ag==
X-Received: by 2002:a05:6102:5984:b0:5df:c094:628d with SMTP id ada2fe7eead31-5e1de13b795mr652520137.3.1763736819921;
        Fri, 21 Nov 2025 06:53:39 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bd96889csm2353512137.5.2025.11.21.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:53:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-11-21
Date: Fri, 21 Nov 2025 09:53:32 -0500
Message-ID: <20251121145332.177015-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8e621c9a337555c914cf1664605edfaa6f839774:

  Merge tag 'net-6.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-20 08:52:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-21

for you to fetch changes up to 545d7827b2cd5de5eb85580cebeda6b35b3ff443:

  Bluetooth: SMP: Fix not generating mackey and ltk when repairing (2025-11-20 17:02:07 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sock: Prevent race in socket write iter and sock bind
 - hci_core: Fix triggering cmd_timer for HCI_OP_NOP
 - hci_core: lookup hci_conn on RX path on protocol side
 - SMP: Fix not generating mackey and ltk when repairing
 - btusb: mediatek: Fix kernel crash when releasing mtk iso interface
 - btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref

----------------------------------------------------------------
Chris Lu (1):
      Bluetooth: btusb: mediatek: Fix kernel crash when releasing mtk iso interface

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref

Edward Adam Davis (1):
      Bluetooth: hci_sock: Prevent race in socket write iter and sock bind

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Pauli Virtanen (1):
      Bluetooth: hci_core: lookup hci_conn on RX path on protocol side

 drivers/bluetooth/btusb.c        | 39 ++++++++++++++----
 include/net/bluetooth/hci_core.h | 21 ++++++----
 net/bluetooth/hci_core.c         | 89 +++++++++++++++++-----------------------
 net/bluetooth/hci_sock.c         |  2 +
 net/bluetooth/iso.c              | 30 +++++++++++---
 net/bluetooth/l2cap_core.c       | 23 ++++++++---
 net/bluetooth/sco.c              | 35 ++++++++++++----
 net/bluetooth/smp.c              | 31 ++++----------
 8 files changed, 161 insertions(+), 109 deletions(-)
