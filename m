Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D411DE3C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471019; cv=none; b=Zi2LHsJblmWiFQywdKWdmCkPct2Mqw3v7Xz+WPeZf/IHy/XZy+vfrrSzKOpBGgyu1Rqkr19SWgcOSwEglvQl+okA/R+eaJnZ3W4IrqIufBb3gaRwTvhvUpIUleEyus7saSxg2LKrW0ELc6K9/IBpdE0MSJNuBG090XkYRrooeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471019; c=relaxed/simple;
	bh=piYsA2QIyufrUgwz9NhYVAzft+Xr5LoxgUk6Lsz5W0w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QCWN6QsNvs/yqUW2wXRfqxFk7Nq1XApv999fUvCNuPBMZZRpgd7F7eA+YJYpNfRX90/fwh3vRzEUedG+S7Ozg+9SR/FhHDh4yNKVbeNHCbvsbmgmYVIIqpwqwcO5ilpDJMYhMhMrZtC/Nj0clG/PRKbvImUWlSR3D7D/W8IaIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ENfbJdLU; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ENfbJdLU"
Received: from github.com (hubbernetes-node-e176a6c.va3-iad.github.net [10.48.201.82])
	by smtp.github.com (Postfix) with ESMTPA id 240DC3C11EC
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 15:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762471017;
	bh=dGrQ0hqubSGOfdkF4pVgOEtyMljIcqFsA3RMwqay++Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ENfbJdLU8Y1uMvSnCcJ/pBT+exXapTE53bvq/RZRAV61wT5hCOWD+iOHuq9trlwiB
	 qTKtav/JegDf2BDsjGDYjGCz3KMTLMNeRAs0UoquQv9L4R/NztXNWCo+Hnox0xH4aw
	 wlUKHyq15UDRAn8/gfQlkfm3yKMdWyVt7K0B2VCs=
Date: Thu, 06 Nov 2025 15:16:57 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/654c4f-ec5819@github.com>
Subject: [bluez/bluez] 070ef3: monitor: Decode Bluetooth 6.0 version
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 070ef3d7e96eb09c03a0c2b2a213fc436d4bb462
      https://github.com/bluez/bluez/commit/070ef3d7e96eb09c03a0c2b2a213f=
c436d4bb462
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode Bluetooth 6.0 version

This decodes 0x0e as Bluetooth 6.0.


  Commit: 7fe16b6dfd1f05b75bdb6678a408dfd31533fce6
      https://github.com/bluez/bluez/commit/7fe16b6dfd1f05b75bdb6678a408d=
fd31533fce6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h
    M emulator/hciemu.c
    M emulator/hciemu.h
    M emulator/main.c

  Log Message:
  -----------
  emulator: Add support for LL Extended Feature Set

This adds support for emulating LL Extended Feature Set introduced in 6.0=

that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_=C2=ADFeatures(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)


  Commit: 69e5da687980ea29dd833887616f0e30d9c0b876
      https://github.com/bluez/bluez/commit/69e5da687980ea29dd833887616f0=
e30d9c0b876
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add tests for 5.2 and 6.0 Bluetooth version

This adds the following tests that attempt to initialize controllers
with version 5.2 and 6.0:

 - Set Low Energy on 5.2 - Success 4
 - Set Low Energy on 6.0 - Success 5


  Commit: f82bc288a8d80042198b0c29fb82f283a7fd4d44
      https://github.com/bluez/bluez/commit/f82bc288a8d80042198b0c29fb82f=
283a7fd4d44
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix no setting state delegator IO is closed

If delegator IO is closed it means PA Sync is terminated as well.


  Commit: 14f868fd141a3b2f9664bfb25911e1fe8d35c6a6
      https://github.com/bluez/bluez/commit/14f868fd141a3b2f9664bfb25911e=
1fe8d35c6a6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-06 (Thu, 06 Nov 2025)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: always show A2DP Delay property as sink if DelayReporting

The Delay property is currently not shown to sound server unless remote
side has acked delay reporting.  However, when we are A2DP Sink, we
reply to delay report requests with the current value, so the value
logically exists and is active.  This behavior was apparently changed in
commits 05f8bd489fd1 and 5d4efe960fd.

Show Delay value for local A2DP Sink endpoint if it has DelayReporting.

Fixes: https://github.com/bluez/bluez/issues/1541


  Commit: ec5819b882813d7f55d91f829bd586e640891d20
      https://github.com/bluez/bluez/commit/ec5819b882813d7f55d91f829bd58=
6e640891d20
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-06 (Thu, 06 Nov 2025)

  Changed paths:
    M .github/workflows/stale.yml

  Log Message:
  -----------
  github/stale: Fix not removing stale tag when an issue is updated

In order for stale action to automatically remove stale label from
issues it requires the following permissions:

issues: write and pull-requests: write

https://github.com/actions/stale?tab=3Dreadme-ov-file#remove-stale-when-u=
pdated


Compare: https://github.com/bluez/bluez/compare/654c4f5755e7...ec5819b882=
81

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
