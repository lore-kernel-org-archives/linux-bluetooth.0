Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455253;
	b=ZiuXNIsqjKXS3PQuSUPpRk9HHdZO+r6FGTXmcLa+sitIyOF4w4w5pcQP61uIvFsyuLW2
	 tRRYrQcwiRCRkCYp9PbqsnqI8ZUVTabEtAdwGl/TD1mfzjb6sJpVPQ+Guo+AgtqIix/Tz
	 raFF0WaOB/2z63AgXp85xKlyihdJkC+dss4RKhp1jnFOJ5FBbjAupzrEPAVuOscT9e7dp
	 gfEqRoUOdRAB2GdEEIe8c8unYiLn1CXNFDI/LSaedi1yZy+0OgaIVetG/sy9FRX35ugoP
	 xKrE/y1EUZzO+GQWMCmhhJffrvBbBW4QaUaCX56enoCnzHrlMi+4QTLZSyTwqBpc1yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pTxUnvDjANJ9l3Kj71UoNPPJRMztFFW3BLCmjld/5QU=;
	b=F/8tPPe3lpg1ChYKNFn3xUXUhykbPFx806uooYOD0mXBnV+ZnmiF5GZDAd35ce4eaSZl
	 C9Y4RyLyDbiP9Dg+8sJOJQ9mxJhdVtixXuVnFvlzxXT7yirPoUtsPaaHoTDpk9fCs6YLm
	 290I0rolfhkf/9P6sxQ3y/dzInFkPkpQZC4QIBgw+ZO/E9LmGvAdNCduaVYlOWbBFAxkw
	 PJthmG/8Jyd2GF3JDcA7nfP78Q3DtoE76EZRSesWx0QPDxd8ozrbrFSh2moLH01biyfpv
	 qzSIN+SbMcjx1/zs2n04daCyRb/nmXP8udwPf1Sj9lsoXN7caoLZf5YdEKLPFseFtLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u1uw1e7/";
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93104606A69C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93104606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1uw1e7/
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1250315137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455251; x=1796060051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTxUnvDjANJ9l3Kj71UoNPPJRMztFFW3BLCmjld/5QU=;
        b=u1uw1e7/ldotRYzQiqhdMXwBwX/do6GuppzXT7t26WdY5wCItLn2mHAybEoOh6K1sV
         edhmhM/2wmic1XFgM87SKigjkf7TMZ17XdVsILe84q69AlxZj+JPDqJmPQDZfahxhnnD
         k8tz1vivuzMigWmAp3gP8qBF5YpcwTjrt59OZUa0NWvPVJUlkgTTPyXswIBhyam5aBKv
         xjkhnqw9MrqOA9egrqNv35zw6uen2VnJkmnMvb//y+xcX/mYB7ZhZSO05DvPdD86BPJF
         wTcNZZMh4E8kkVZV3vcospU53oDpuiY5+tTtxI7wNVChAWOu6A3qXQ2rE5LVGZ0f3m+x
         ZJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455251; x=1796060051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTxUnvDjANJ9l3Kj71UoNPPJRMztFFW3BLCmjld/5QU=;
        b=UiTrnZbJarrqk7h3/XeB54NXoC1+ctaYmSZYNy7MDRp6GMJIsQUOfqhXSgHVyfCMTo
         iLWTbMpb+9ivAm/vhASOvrV98tbOiA3acOkatQS+F0TJwe/FReoYuMsaGdglQQQCot8y
         rPa/Ef5ADBMDand1ovNNQ2+6DKGS5m8KrGRjxdtRFrUOWNEFpA7AoAjPccYV6AjIZZ7M
         B+hcXZOrj2Zxw0rkwmrBZFv+8MOCTLwq3FAHCunFNsnGPAV+sNVsq3/14IsPpXpOqOJK
         zgg5dTvrsjILlVGXT7HKaINYKGGYYyBzq3QiMOEltP4zHTtT0Z8qLn1xxVJSx90nQ3Z5
         F1zA==
X-Gm-Message-State: APuU4Z9lOzfEEiJq502fFfAlv7g+9Vp1HCZLCbEgPtdaYrBWWrhAIAVa
	F1zre+ctXrY+vuSp5dydqEiqswuK9ouzRMtsKn21i5S0UWYboCLePEm17TU32A==
X-Gm-Gg: AZFdTZf7vt1WJGB/DoGCFGC6trd40FvUe5k2qFkQRIS5s+jwILiF1ps3V61DEHZYVMC
	aPbnOiy6PpWsmNEutKyUfxrKqpnEIcDVHJyzjHtP1NFUkP6OPp4Bql85xYdIoH5UJrGUmwm890I
	QqA7ojjemWy9IM/r+KCn8IBv6sxt2K3VPQfWzgzSCXrT5y4qYdvimWm64CT9kf8GW4w7Flk4c2c
	ONxbH6yV4r6H4N4qe0vpAuNkN55vQ6jA/vSNN1MYz64emeHRiQ1TLNAUEWgalp1JdG/LHR7DwA9
	9bc41zZJhdh632K0xuHaHiVyACfxhSU4999AwfMGfggXJI5Lsu1TjfVjB95ybgYC0TL5feJLBVM
	EMnhcrI3eQMG3H2ZjXv5/J5nj2dAi0MBg0sgVUkEBT30hkFYqgAe6DdESn1B7FAspyjZii1li06
	dZm+ZWvTGKt1O5XJkgO5jv6roro/lWrg4XDTfcMZf3lNTbZAoAJa7cF7uXcH0NNoHYatVd3V9B1
	e92IaD2EQ4XBoUehkitXJVYVpZMqlOmp+RGzHEqSpqDlRuXZoEyQRDekSvjDQH5WXj+uMAhQSma
	bR7kjXPkckfsN7Kdepk/FBYbnUmmYjzC9W3rHxDzen1R+7FQhrKB96VCzrwTKH6mBaf7Axl7HPF
	bMYoNJ6VJk68/POTpsmBQg/OcmKbt3/hErgk+4pSqb71phzUF9UD6qBAMYHdbU7O1
X-Received: by 2002:a67:e706:0:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d73942ad2emr4987813137.21.1795455251020;
        Mon, 23 Nov 2026 09:34:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e8265e55sm12635830137.11.2026.11.23.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:34:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-23
Date: Mon, 23 Nov 2026 12:34:08 -0500
Message-ID: <20261123173408.3632176-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 5beb86f98c3d45f6d64be5b6d6c77480487b41b4:

  Bluetooth: L2CAP: return LE credits from recvmsg under the conn lock (2026-11-17 11:39:36 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-23

for you to fetch changes up to 4fe38719e6738feaa90486e36b0790dd5d960a96:

  Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access() (2026-11-20 10:57:23 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Take req_sync lock in hci_power_on()
 - hci_core: Hold hdev->lock when removing advertisement monitors
 - hci_core: Don't fail removing a monitor unknown to the controller
 - hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
 - hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
 - hci_sync: Fix remaining advertising instance UAFs
 - hci_sync: Use controller handles for periodic advertising
 - hci_event: Validate sent command length in LE Set Ext Adv Enable
 - hci_debugfs: Fix racy toggling of debugfs controlled flags
 - L2CAP: Use a reserved ident for L2CAP_LE_CREDITS
 - L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
 - SMP: Serialize link key updates from smp_notify_keys()
 - SMP: Check smp_data before using SMP_DEV()
 - SMP: Don't create the BR/EDR channel while unregistered
 - MGMT: Fix read_index_list() buffer overflow
 - MGMT: Reject zero multi advertising rotation duration
 - MGMT: Fix mesh transmission locking and lifetime
 - MGMT: Fix use-after-free in mgmt_powering_down()
 - MGMT: Retain the selected legacy advertising schedule ID
 - MSFT: Protect the event prefix with hdev->lock
 - MSFT: Free the response of the monitor commands
 - MSFT: Record the filter state on Command Disallowed
 - MSFT: Only enable the advertisement filter with monitors

Drivers:

 - btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
 - btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()
 - btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
 - btrtl: Return -ENOMEM if bt_skb_alloc() fails

----------------------------------------------------------------
Cen Zhang (2):
      Bluetooth: hci_sync: Fix remaining advertising instance UAFs
      Bluetooth: hci_sync: Use controller handles for periodic advertising

Kiran K (2):
      Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
      Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()

Luiz Augusto von Dentz (17):
      Bluetooth: mgmt: Fix read_index_list() buffer overflow
      Bluetooth: hci_core: Take req_sync lock in hci_power_on()
      Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
      Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
      Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
      Bluetooth: SMP: Check smp_data before using SMP_DEV()
      Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
      Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
      Bluetooth: mgmt: Reject zero multi advertising rotation duration
      Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
      Bluetooth: mgmt: Fix mesh transmission locking and lifetime
      Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
      Bluetooth: MSFT: Protect the event prefix with hdev->lock
      Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
      Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
      Bluetooth: MSFT: Free the response of the monitor commands
      Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller

Nguyen Ngoc Thang (1):
      Bluetooth: L2CAP: Use a reserved ident for L2CAP_LE_CREDITS

Thomas de Gruijter (2):
      Bluetooth: MSFT: Record the filter state on Command Disallowed
      Bluetooth: MSFT: Only enable the advertisement filter with monitors

Tzung-Bi Shih (2):
      Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
      Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails

Zhao Li (1):
      Bluetooth: MGMT: Retain the selected legacy advertising schedule ID

 drivers/bluetooth/btintel_pcie.c |  31 +---
 drivers/bluetooth/btrtl.c        |   9 +-
 include/net/bluetooth/hci_core.h |   7 +
 include/net/bluetooth/l2cap.h    |   5 +
 net/bluetooth/hci_core.c         |  81 ++++++++-
 net/bluetooth/hci_debugfs.c      |  32 +++-
 net/bluetooth/hci_event.c        |   9 +-
 net/bluetooth/hci_sync.c         | 344 +++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_core.c       |  33 ++--
 net/bluetooth/mgmt.c             | 377 ++++++++++++++++++++++++++++++---------
 net/bluetooth/mgmt_config.c      |   8 +
 net/bluetooth/mgmt_util.c        |  23 ++-
 net/bluetooth/msft.c             | 118 ++++++++----
 net/bluetooth/smp.c              |  58 ++++--
 14 files changed, 861 insertions(+), 274 deletions(-)
