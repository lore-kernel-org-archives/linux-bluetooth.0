Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C41DDA3C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975174; cv=none; b=APxrYZw7y+q+w1Pxfv0BotJ6dovQIdbsTUXbpQbxMsgJlZFmlNAmp8dd4xGzDfAWFtfBVv4Qoxh4fFzsWFVJlU2sysBx+Tb+H5OcKqiHsmH9Bgc0v1kALcEY9Jw08i1r5nOgtInpue2hGwlj+hK//D5hQhimzGKTu/k7dR2sPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975174; c=relaxed/simple;
	bh=RT5KFYi9rjDBfUSmWxVyHhs9joAIfzlu7Cq3Vfea9rM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VQzex3vWMFeb9+q5QZ/KZxC03TO3TUJFI+/7swS+q0ZquesfjIdCg03SJan9Mvd+9irpgh+4Jb7NIijj6/fWU2wvSpdLREm4DsvqOn+0aow+b7+1d2irNQX8wKd/cJfUBt8sWhT6Kuqb6MusQLEWtJ9OP7rYtM1MPuHBgskTaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU90smw6; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU90smw6"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51882748165so29011e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736975170; x=1737579970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rji6jECYg9vqAK27wpja8rPr0seyPgDoXVWjax/UQ6k=;
        b=ZU90smw6Yifxb+ymrC4+O63/ZEY4P+P/WhCtcvMglzQ6SDCXGBEjK8VeAR/NhTuFGo
         NDi9MvesSqJ3MpwTOqTm4sfRYCXtt7VMIVWt3ISlGB1CB/mOsUKBqq6snX8JzBMYX5dg
         rLcBwhXkAFVNrEXSYQ+8W7ypr2xjftZL9yf88R92vstURHTy9dDM6g8DYDITb2n2LmUc
         iaBqgV3qS54bgr9dXpEpMCqywu7Dy+skhIaRrIJRY6j5uFI/HxAXA3W5PcCKu9Mok+R0
         Lwp+Y6kMkY5rMwF6hvCaHTa9mXdXam8+IBkMDezXoSaPsd7m4mtanMGWpLY/HxhmTGq9
         S8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736975170; x=1737579970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rji6jECYg9vqAK27wpja8rPr0seyPgDoXVWjax/UQ6k=;
        b=VY1Ve6kkLIF+ixal2oWyVI7QeX5NAH7IkW0YGsl1z3BCjT2dlyqhCZTh8GLcoNhcZG
         TYhmGJK/5LIZ5PrQq++oyk7+0iBWnOxR/0jt+yRnwvkWKINueUpO5FIr2jvPMt0hUMMB
         /AGxVp9jN7Pke2Z8AYSqUun749fQnsArIr+nvGe6wHj6ajhy4pnimgjSfBhkOdEgIsFl
         w9uHwMhb7kyITYQ09sL5bPn9RaEZc0dtyqJbOZYQinJP+8Ts5Q1Zpj3rOMN3p6HEV+FM
         gcOnc8WTsjEHPwAxsL6klsJcVjmCRCkh+z8hRvGHRQb6KGYNDEX6A+xWcTNOCAdhMpCJ
         v/aw==
X-Gm-Message-State: AOJu0YxTEDWCnreO6Ihmrg9XVcpd+K3PqYkuscBWNOiVibJ1l2LyjLH1
	0Ko4rv8Rls1Cvphgfe1Kiv4Y3pwxRo5vuBjxcb1vRmzQxT39+ptTO2uZfzrT
X-Gm-Gg: ASbGncveAIaONDAT4+lErFw2DnJXIrX5duLCm2T4wTvnUxttxrTlyiGPX5RYiyulINf
	VAP9q78cKHxkZZUp/JKtkfg2B1ZzDOrqZplSBi/6MQujj8wAF4usP+8Udh7VhQgyDif08/DQHc0
	4wbMPEnGNZZLEw+xSH7Tec3T5dPSdWK7vA8Aml+E6tszvGvqS1fqaOY8mkj0tHrJEzy1edOknjp
	bv2cRzzs3JvHoidKq+RoGf2PU1rr3nUzDWsU1U94hwY07/d3D1cbl+9fqX5MmO7LIRscl1KY4v9
	S1iG23mYZKOAFf/Av6voqT+T6zfT
X-Google-Smtp-Source: AGHT+IGT+1kurNduCYWlzyHtafty6r/ALGRz8BZ2lZrH0PwWsx51dvzy3bvwJc6rNgSQ4ed2ghqolw==
X-Received: by 2002:a05:6122:3718:b0:51b:8949:c9ab with SMTP id 71dfb90a1353d-51c6c510233mr27227098e0c.9.1736975170445;
        Wed, 15 Jan 2025 13:06:10 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51ce81071cfsm59047e0c.29.2025.01.15.13.06.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 13:06:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2025-01-15
Date: Wed, 15 Jan 2025 16:06:06 -0500
Message-ID: <20250115210606.3582241-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d90e36f8364d99c737fe73b0c49a51dd5e749d86:

  Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux (2025-01-14 11:13:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-01-15

for you to fetch changes up to 26fbd3494a7dd26269cb0817c289267dbcfdec06:

  Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync (2025-01-15 10:37:38 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - btusb: Add new VID/PID 13d3/3610 for MT7922
 - btusb: Add new VID/PID 13d3/3628 for MT7925
 - btusb: Add MT7921e device 13d3:3576
 - btusb: Add RTL8851BE device 13d3:3600
 - btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
 - btusb: add sysfs attribute to control USB alt setting
 - qca: Expand firmware-name property
 - qca: Fix poor RF performance for WCN6855
 - L2CAP: handle NULL sock pointer in l2cap_sock_alloc
 - Allow reset via sysfs
 - ISO: Allow BIG re-sync
 - dt-bindings: Utilize PMU abstraction for WCN6750
 - MGMT: Mark LL Privacy as stable

----------------------------------------------------------------
Andrew Halaney (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922

Charles Han (1):
      Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()

Cheng Jiang (3):
      dt-bindings: net: bluetooth: qca: Expand firmware-name property
      Bluetooth: qca: Update firmware-name to support board specific nvm
      Bluetooth: qca: Expand firmware-name to load specific rampatch

Dr. David Alan Gilbert (1):
      Bluetooth: hci: Remove deadcode

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925

Fedor Pchelkin (1):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc

Garrett Wilke (2):
      Bluetooth: btusb: Add MT7921e device 13d3:3576
      Bluetooth: btusb: Add RTL8851BE device 13d3:3600

Hao Qin (1):
      Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw

Hsin-chen Chuang (3):
      Bluetooth: Remove the cmd timeout count in btusb
      Bluetooth: Get rid of cmd_timeout and use the reset callback
      Bluetooth: Allow reset via sysfs

Iulia Tanasescu (1):
      Bluetooth: iso: Allow BIG re-sync

Janaki Ramaiah Thota (1):
      dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750

Krzysztof Kozlowski (1):
      Bluetooth: Use str_enable_disable-like helpers

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Mark LL Privacy as stable

Mark Dietzer (1):
      Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x

Max Chou (1):
      Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()

Mazin Al Haddad (1):
      Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Ying Hsu (1):
      Bluetooth: btusb: add sysfs attribute to control USB alt setting

Zijun Hu (1):
      Bluetooth: qca: Fix poor RF performance for WCN6855

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  10 +-
 drivers/bluetooth/btbcm.c                          |   3 +
 drivers/bluetooth/btintel.c                        |  17 +-
 drivers/bluetooth/btmrvl_main.c                    |   3 +-
 drivers/bluetooth/btmtk.c                          |   4 +-
 drivers/bluetooth/btmtksdio.c                      |   4 +-
 drivers/bluetooth/btqca.c                          | 200 ++++++++++++++-------
 drivers/bluetooth/btqca.h                          |   5 +-
 drivers/bluetooth/btrtl.c                          |   4 +-
 drivers/bluetooth/btusb.c                          |  73 +++++---
 drivers/bluetooth/hci_qca.c                        |  33 ++--
 include/net/bluetooth/hci.h                        |   1 -
 include/net/bluetooth/hci_core.h                   |  14 +-
 include/net/bluetooth/hci_sync.h                   |   1 -
 net/bluetooth/hci_core.c                           |  24 +--
 net/bluetooth/hci_sync.c                           |  76 ++++----
 net/bluetooth/hci_sysfs.c                          |  19 ++
 net/bluetooth/iso.c                                |  36 ++++
 net/bluetooth/l2cap_sock.c                         |   3 +-
 net/bluetooth/mgmt.c                               | 145 ++-------------
 20 files changed, 340 insertions(+), 335 deletions(-)
