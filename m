Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2973E9C1A
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504047; cv=none; b=a41OKcVdhpDVB9ECAwCLxxU/im5fde96/vFmf1ys2AgBeUCVYZKCx1T8KyHOxnlpNRMOJzWURQlpbWTB+872v6W5TQDFD0NxuEe52CuJIF55pyn30GRH/fFkQIZTTewC3Yw8LPBG0lK5LmJGL4hikStPoX3y+6fjTfiH3jW6a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504047; c=relaxed/simple;
	bh=KsALnQ7OjE26KILk6ZSGe6Ke9EgzKl/HnCEeCxpI3/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOrRck2wDsDsPvUZyUwMUQNlYVjQR20b33un8y/KLsSRNr5QhUY1uWYl5pdJ391K7GYIOVZdjzKfSuM36Nl9jI2HT8sjPmnYCqLvm3JvWnzG+kvPCHgkWJJ7zNErieL+ZACnOmtd1F6MBo9cXz3SoghI/o31DZZkrkjC3ueNWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np4sG8V/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np4sG8V/"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59aa414167eso2026308e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504045; x=1781108845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LdSRb4C5c5f23VF8YFsFSRCjScwvrWEISBSuouPkOs=;
        b=np4sG8V/Qc1FvA7AdhiXQH0Ekmal1GPX9FrZskumE636O07ClGw/7zN8fFf/D9+UJc
         lSqp+6IpLHnNJJJmmIUWUftSkbj6sfXOhxhUtIEt0JBXK+Dc+2PhWYNbI/+5qSU2RCw+
         4f+ZwljNeKyzefMY9ySUjHfHAcxAp8WjSepBWkFdG2mVlX7alcBruQh45VJ0niODtJpz
         FUsjsMt5eg+n35VJT80gt/v126y1bNZK9gYzlEh2RFi37gBsLqNL/b990fDVn3k2k+yG
         ycBgeuGcudj5e9q+lG3jjbGEW9Y7dh1QzKXK9bEtH5WMb8bQoVIvBbq/lFHZ9mUYZYVR
         BRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504045; x=1781108845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LdSRb4C5c5f23VF8YFsFSRCjScwvrWEISBSuouPkOs=;
        b=b87P4GpocTqlffsG1ryyfwPMjn1zxqUMdGOBCQy9Es8Yh+AOT0YA8ZoMbW1UjnQYKL
         EfT0rJWZh6ZrHEoG3ALrnyflBQ4I5Kh6a61ijLwANupGcg9TCrRKt1FS/vLNuU8sq6Vm
         +1JUi5OXZ0EnkwFMaFA1PKimmjLhgHnXoUP5ELOvPpzvApVWwALOpKzT01ANbg7OgvSe
         8jRib3XpWjuxHEvF4DxuBOdjjm7F2Zs+Tk+Zg3TzmvumW4tLjsq9ogW6E2anoCln5LAC
         FS5idYhvcIax5DM/6dLySWdeVLtv9xsJykfqo8pKdeRzomvusEjoFSi5MqMb6vtKNNO8
         nmcA==
X-Gm-Message-State: AOJu0YxkSz0KD5SrkmrkFUhuGVVlIf2/qT3ucl/an7wCaICnFwAIOYbA
	Q34hLpiMPkxS4OTMFJeZAu1O0rB1e5M3lrk6fffxmo6V7Aw6wfyovN/Tzp265xtTMCQ=
X-Gm-Gg: Acq92OFFsXRNV5Qh79M8DEkwcWzrxw/Bs1TQYJsXyxbM+0P5HxorhK82ECAUYORuidD
	juLvclZGPniVtJICmWpOWj/JXQr0NpUaF/jMh0r3aBtbhChU86HAXwz9XU9f3MFIgFwEJwEs+L8
	nXtXQzzoJTTHO7QLdtOKiv92pKe8Ou7HXWh8liDnd2VYDAJjZ5Pv4sAQlSjI51xG9XkYHXU8Dfv
	6apEUdtz4abrJTx27DjW8l7PcA1xt68+7OoglJFEWf9Og36iWgkgYeHUgq7cAnv/FtU4MvNwObb
	6ZdypZeXnOcS0KDJOMDynkWhhG9n/JW6QIhuNEC/iWnBi3eREBfPtvplu+4rR5ZhFzaLIS6B3vy
	lwpuFmaEp4OOeFNe3nZcEwVJWMvGJUf6pe5ltI3/fw9NT1RlBDt0ASIfytnz3cEVBVT0kQHfcRt
	oGZtpVrlR9CRd1uN8w5o+xx5jExXHgQOgSqydBaFPa+a5783VFItQg+5vPoDtGMoHo/rAChlkU3
	S95jO3zPk8OJV/pmqk19c5Bd9wS
X-Received: by 2002:a05:6122:1814:b0:5a1:fbbd:6bd0 with SMTP id 71dfb90a1353d-5a6e5612e27mr2148393e0c.5.1780504044819;
        Wed, 03 Jun 2026 09:27:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d777a638sm2752657e0c.8.2026.06.03.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:27:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-06-03
Date: Wed,  3 Jun 2026 12:27:14 -0400
Message-ID: <20260603162714.342496-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit cdf88b35e06f1b385f7f6228060ae541d44fbb72:

  Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-03

for you to fetch changes up to 149324fc762c2a7acef9c26790566f81f475e51f:

  Bluetooth: MGMT: Fix backward compatibility with userspace (2026-06-03 11:24:12 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: fix memory leak in error path of hci_alloc_dev()
 - hci_sync: reject oversized Broadcast Announcement prepend
 - MGMT: Fix backward compatibility with userspace
 - MGMT: validate advertising TLV before type checks
 - L2CAP: reject BR/EDR signaling packets over MTUsig
 - RFCOMM: validate skb length in MCC handlers
 - RFCOMM: hold listener socket in rfcomm_connect_ind()
 - ISO: Fix not releasing hdev reference on iso_conn_big_sync
 - ISO: Fix a use-after-free of the hci_conn pointer
 - ISO: Fix data-race on iso_pi fields in hci_get_route calls
 - SCO: Fix data-race on sco_pi fields in sco_connect
 - BNEP: reject short frames before parsing

----------------------------------------------------------------
Bharath Reddy (1):
      Bluetooth: fix memory leak in error path of hci_alloc_dev()

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
      Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
      Bluetooth: MGMT: Fix backward compatibility with userspace

Michael Bommarito (1):
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

SeungJu Cheon (3):
      Bluetooth: RFCOMM: validate skb length in MCC handlers
      Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
      Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect

Yuqi Xu (1):
      Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend

Zhang Cen (3):
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks
      Bluetooth: bnep: reject short frames before parsing

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/bnep/core.c     | 57 ++++++++++++++++++++++--------------
 net/bluetooth/hci_sync.c      |  5 ++++
 net/bluetooth/hci_sysfs.c     |  6 ++--
 net/bluetooth/iso.c           | 63 +++++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_core.c    | 46 +++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          | 17 +++++------
 net/bluetooth/rfcomm/core.c   | 67 +++++++++++++++++++++++++++++++------------
 net/bluetooth/rfcomm/sock.c   | 26 ++++++++++++++---
 net/bluetooth/sco.c           | 20 +++++++++----
 10 files changed, 233 insertions(+), 75 deletions(-)
