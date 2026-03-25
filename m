Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCF34E76E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467851; cv=none; b=FnyIR0jIVJGhLEctuYydiiHwyXXuGePTbDQU4XPdc93a8mBlmKrxiDs8ljn5vOIV++0zcrBh00JUbXY1xzu0jawrgI5o1snjN7kiV/2tl9GDocQZ7nR6yypUU0tBZABVoyoJmOdD1o6R1TcKHaInHgyVnYAaWi56Et8Le6qAwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467851; c=relaxed/simple;
	bh=78c9neIIAyWLevt4ozwWCiA4bTLgXpJDR+RWtdoP8iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eeoYiXAUDi6Rv5QtZK4ZOoItytyawCzNp5fc+hwhM6rDD91q3Se2PZK9OhcjFE7XbBSlDK9dDeGKQw8+n12MAEb9vknj4x9t7DiRsg2IOSVI+S/HQf1uWSyb2bZA6EPoQTxfrLLJked2ldh7zQcuvHU29wGtX3T6EZoIsjZSgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEX9SAxp; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEX9SAxp"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5675d609621so259851e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467849; x=1775072649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vG63buxikYzZRa5bTcoW9Euem18H8lifInafLz0wjA0=;
        b=JEX9SAxpy4edbn+QLPPcSaZLrTpl5he6WE/GqwC4wMl+p02yQulTExeyDS2GROYZMq
         JjGlKAMsEk5FpUYoyHMOp6u3w5I/LI5KTO0alNhBZH25WD32VI0q1iftimECCjpmVIzP
         4czU/MuRKvucu5w0x7fGYTJeb+jB471Zm6yEIbPuqoYtzTdUrHv46CxZ3fjhibXEyD5+
         yYV840EZoIy008adJnPzhTnLFPMkobriRnH/AtwtalVe+6up7L92GcELY+tqI+JOWkp0
         rQgeyfRB8XqnB4xEWjs5kdMvvo/gBuYPw47wNgGFDpSxhLnii+0hqiqCOX5OR6g9Ndv6
         Sciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467849; x=1775072649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG63buxikYzZRa5bTcoW9Euem18H8lifInafLz0wjA0=;
        b=qrskqcTWW0UGkeB+7+Y6GqPCr3F7uD3OCPw1u9O2QtAuUVHlY/dcv6Oosg3EV/AatB
         3xJ5H62RLYhLrOdvGoyhzwG+hSCT+EX70jDtkl29vNiFuanw22KRcqf1OJKw0Sc3HVCi
         RqgSSuIqzbOZC5F5FZGs+DPLduVG0IdeDZNPJZ/65RU17VSNL8RGLv8EI8YlnBcGR1tP
         kBtkFILBzq/3F0rT7qYFj7Minb3t10jibWfeOxjhqDbgRbzKNP5pPClSxubkV9aiWSlc
         bN34Lq4ln7Qm8jW7N4DSstTKMHis9nO/eo6dHENwFmwJwXZ2dz6jy3fAvbZwKuQBIUcG
         RlhA==
X-Gm-Message-State: AOJu0YzP69rf16zpboX2jzsYWMKQQ3+9ivpCN19ZY44xDZEZgzQGMiy6
	te9s0wGk8gOMBflVwrrns8sF7y+I32atyP20uVyoaARxeorQ3LxBftHtcOEqhrXw
X-Gm-Gg: ATEYQzxRAt99UHr3EtK9A4/sZUZXB/Wl7XCsjUCKhRsg+3GzmDiKaWI6g8FjEqyJ8Ni
	MuTyyBuiDqvH0h+EA+gruoI7mImTuUOsZ74NiHsl3dm/iVc6qIdQ6rOfCfB7VLRD2GCfcdbv8tL
	RriW98nT6AK7d7V9QS7TMlob9grV/Hs5kHxMsTt0KPUUCc+wX7mDjd/sPM0/IVv2/7OCKuM02lN
	Y1XHx0taMghHMUKN5i5BA63d8UtuwdJByhkT496JL2Hr+TTbivOlekF3OBKOSCdn/4OCZgkMvT1
	gORMx+2ckjFqxb03vpvfzji79Zf+lPpdU4RB+APPvf/U7d12x+mc3HAvxg4nuPLwxGKDbJ4ctft
	MesBVs8CgKMcbAnvarh8i4QpaA+zq3JnXruIw0H/wXL8RqzXxir2J13Vvt4oYiyUURrb98465v7
	qJVAulWFSlzj4mHuWjkG2Kuy84wnraRkOVGWtxhQKthwxFXKxKctrVClj1iQ66aB5oLCFjnNA8u
	WeQsFyxm47wIJMtCyyp2fNRIxCE
X-Received: by 2002:a05:6122:8289:b0:56a:fcbf:8aa4 with SMTP id 71dfb90a1353d-56d21f3d2c7mr2718324e0c.2.1774467848270;
        Wed, 25 Mar 2026 12:44:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d38abfsm1312353e0c.11.2026.03.25.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:44:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-03-25
Date: Wed, 25 Mar 2026 15:43:58 -0400
Message-ID: <20260325194358.618892-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:

  net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-25

for you to fetch changes up to 129fa608b6ad08b8ab7178eeb2ec272c993aaccc:

  Bluetooth: btusb: clamp SCO altsetting table indices (2026-03-25 15:32:55 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - L2CAP: Fix deadlock in l2cap_conn_del()
 - L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
 - L2CAP: Fix send LE flow credits in ACL link
 - btintel: serialize btintel_hw_error() with hci_req_sync_lock
 - btusb: clamp SCO altsetting table indices

----------------------------------------------------------------
Cen Zhang (1):
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock

Hyunwoo Kim (2):
      Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop

Pengpeng Hou (1):
      Bluetooth: btusb: clamp SCO altsetting table indices

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

 drivers/bluetooth/btintel.c | 11 ++++++++---
 drivers/bluetooth/btusb.c   |  5 ++++-
 net/bluetooth/l2cap_core.c  | 31 +++++++++++++++++++------------
 3 files changed, 31 insertions(+), 16 deletions(-)
