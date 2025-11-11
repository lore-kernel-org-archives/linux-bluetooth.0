Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64236B06A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870452; cv=none; b=fcpQPzJdB0GDr6D+Mj7rnHsjuJW5Lz2bZgc/erqOY29e49DI9LxGIq32sX4BbpSjKfv3KFW2u7eI6Es1kd6oF29W8g3/9MrBVnrgJUt8wYHZs+RzgcLS/uxm2U7SPtykSId3URdeYUx6QRkd9sQ61OYgidAcSh35Kc4t8YAkSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870452; c=relaxed/simple;
	bh=Y1DIK9oNHsdhGOzVTvNXsawBgEt4/ucPYN+TUbY1n6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSYtAnxhtyprNYuaIix1lrGo0iZEKJ9Ja3JK8wavgAZ3UdLWQfalUoesD1bwGa1ckXHTLc1x6Zwtr5p5AzoJv3ka3azFbzaBSPhvyHjW65ACXUAEojsxzmeFp1zpAtpSkjdz6yxWnoIOVpxYBoo5xnTA4UffQXNxs/3GjwZ5WMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDLOkkJF; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDLOkkJF"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93729793469so1821332241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870447; x=1763475247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mX5Bv9bZcRLgPEw2WkBKxv2dX3a+A+38dOkxX5EtiM=;
        b=hDLOkkJF24oNM+P+x4aGn+8lZ9J+XAiEfGpaNoobhkikeLyNMKAzXvkClzxpk/JMVl
         yr2Vh+bm8pFTW55o2MYncamMS0sQ9w7AcmSQJVp912Gb837YB55MW6+0biUwgDR/93AH
         q2NWEYQ099gxuXh8uOMagjwqxyRyHQh+RWivjW8faTFabR3z5uPS8pXDHhoq+tp9R+8P
         OGS89EAUpU3WdrdzIVR9izlZj1EaHFLseqnYjXVycCmWqg4Rc2nccPj6Jl89Z0jKlLsh
         nUaHDCI3YravOKXFpE6dyEq4uzRRYuJvfA70TuPUTwaRQDCpdudz9gJNsRyxXDucRcqs
         LViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870447; x=1763475247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mX5Bv9bZcRLgPEw2WkBKxv2dX3a+A+38dOkxX5EtiM=;
        b=unGwuoTY7RBwP7caN8ILaNOSt8kp3BTOf5Q39U0PPu5EReCI0AstLUPJJl4dUc1bR7
         RFHJR1ObXTjUHXrZAc3NDRm1x7UWTn1VOq77FgHdaSpEQjIsAvlgaqB5t0BgGPrBKQXU
         MWjpiXHwA8zVmZLD8LSu5VvRK3E8VXulX4ScgSVEV6aQPtQDntecXGCBCLdFuroGKSjY
         LZj6eXO1haUh9MsFuWvNrtfhgxrZSjj3hErbIq3X7c4kHGkJftUfZs8ebjrjwDW7gkE7
         fw6yLeOdzs9TeA4Kqp+excNs/f8Y5eT+taOoH0HfqStW8Go1EjwFR2kgC3hmDJ75D/co
         cMvA==
X-Gm-Message-State: AOJu0Yz2FKHbtrqQ4C1UtDwwSpwNlJY3f1dEUIMq56ea1tuSo8zNscI7
	zk+rODbdmKVejld4slZ5pSCqps5OoMdfb1iOCrXJjFysnUh3suSfz/dM
X-Gm-Gg: ASbGnctemtcCGaemYuhOVIqaRO6LhavNO1HBP4o/hgz3kbIDFdjJEDd1H3Oz8If/TmI
	X+jbz4F359FVsF+1KZAMSKaWm/q2UesZ6w1cIeVGjuBLXO+pwUs8pGy/uwzcYpKB3ouCnkpHT+v
	yaJqqjpeXoCK9j0hs0s1X2Rxqaq+pSf8/iYgR+G9STl68Rz1eqB189fnx21PjaLsesBw4rI6ZDL
	alLqFWGt0Cy7QQdQ1s/Dc6hc9ohqO/1EnqY59hox67jN4nMTSo3zxcU5eihAgHA3YR2pveCnsPs
	adw9+OG1TRPmzZvvOaBUMjw0ScgRMZ8KsXtZSX9wc7cP3Eovf2hiltNvykuTigU5jYxPtEeV55q
	fme7zKSCzzqm7W35hYd8iAnGHB/h3SVe32oFP8pAFdX/sRV0buc2MVvTm6XIWbzPZ7Sdf6uN9FY
	Si4Fo=
X-Google-Smtp-Source: AGHT+IHkF/foArhnzTKr6PgOpEQVO2LXTiYrrZBRM8n/hA3PfGQND5C6T9Ksm6FQat1FH0UGGoCOnA==
X-Received: by 2002:a05:6102:c90:b0:5dd:b317:aa19 with SMTP id ada2fe7eead31-5ddc46ae5d5mr4227154137.13.1762870447462;
        Tue, 11 Nov 2025 06:14:07 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93720dcf560sm4668670241.2.2025.11.11.06.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:14:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-11-11
Date: Tue, 11 Nov 2025 09:13:57 -0500
Message-ID: <20251111141357.1983153-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 96a9178a29a6b84bb632ebeb4e84cf61191c73d5:

  net: phy: micrel: lan8814 fix reset of the QSGMII interface (2025-11-07 19:00:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-11

for you to fetch changes up to cd8dbd9ef600435439bb0e70af0a1d9e2193aecb:

  Bluetooth: btrtl: Avoid loading the config file on security chips (2025-11-11 09:06:57 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Fix not cleaning up PA_LINK connections
 - hci_event: Fix not handling PA Sync Lost event
 - MGMT: cancel mesh send timer when hdev removed
 - 6lowpan: reset link-local header on ipv6 recv path
 - 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
 - L2CAP: export l2cap_chan_hold for modules
 - 6lowpan: Don't hold spin lock over sleeping functions
 - 6lowpan: add missing l2cap_chan_lock()
 - btusb: reorder cleanup in btusb_disconnect to avoid UAF
 - btrtl: Avoid loading the config file on security chips

----------------------------------------------------------------
Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
      Bluetooth: hci_event: Fix not handling PA Sync Lost event

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Pauli Virtanen (6):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: L2CAP: export l2cap_chan_hold for modules
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: 6lowpan: add missing l2cap_chan_lock()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

 drivers/bluetooth/btrtl.c   |  24 +++++-----
 drivers/bluetooth/btusb.c   |  13 +++---
 include/net/bluetooth/hci.h |   5 +++
 net/bluetooth/6lowpan.c     | 105 ++++++++++++++++++++++++++++++++------------
 net/bluetooth/hci_conn.c    |  33 ++++++++------
 net/bluetooth/hci_event.c   |  56 ++++++++++++++---------
 net/bluetooth/hci_sync.c    |   2 +-
 net/bluetooth/l2cap_core.c  |   1 +
 net/bluetooth/mgmt.c        |   1 +
 9 files changed, 158 insertions(+), 82 deletions(-)
