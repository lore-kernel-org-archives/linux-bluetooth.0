Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CC35959
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092307; cv=none; b=r+slhcJ2BrFDiPzOOXetZtiSAvdUZGs4S0BttFrnywm0xaFc1BZQaR5Z35pGa5LwlaP+bIh7mfKY96Bs28xZdY+gVgiE6hc5bpIM33hjvF0afv/mqtKIBda+BJideM0YQGwpuGrjiHlWWhfwTKQWIQ0xy/NmTyuniC6Watbmer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092307; c=relaxed/simple;
	bh=AVgtpEI1aAnleCe1sR/ckcag+sH33RgX/ZNdopIrhqo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YAmcfvTSAJ34/JNfABhjKLX8m6xbUGL6wNyV8uRw0zJ/zWf3DsqyUoy3oiNGaYIon+vCE4+UFBHwrUk2NAVhFMk4Xqi7mCcAUL6/4qGzs7KujCIpxOOOL6m55B2q/Ypp004Q303RzcVd1Un0HWQuAVanpnauKTyv5euqFmO2R4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h+umqj9l; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h+umqj9l"
Received: from github.com (hubbernetes-node-89bba52.va3-iad.github.net [10.48.124.70])
	by smtp.github.com (Postfix) with ESMTPA id 068014E06C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743092305;
	bh=xIy1RHT0TvsFifoI1XAi1aStLuQZyoQo1oU3Xge+zH0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h+umqj9laVQdpraIUuvHs8p9ezt2neF9PKT2AAeKXEz1wUyyyzXyv445ghh1Qsir3
	 4bXLGm6beChSh3uburrbQP9n6HZuYBgCZHoZbK7jhYnqzHs0604BqbZ6pbefLemehm
	 XEXoRdhP9tQEgPedXSUEJlLgj0bLo+bE7ZxzEl3w=
Date: Thu, 27 Mar 2025 09:18:25 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0f0039-5df952@github.com>
Subject: [bluez/bluez] bbc1c2: main: Fix handling of legacy experimental LL
 Privacy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: bbc1c2a7f06e3a77af70e1e030df047afe6a6d3a
      https://github.com/bluez/bluez/commit/bbc1c2a7f06e3a77af70e1e030df047afe6a6d3a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix handling of legacy experimental LL Privacy

Legacy experimental LL Privacy was not enabled by default but
CentralAddressResolution is which may cause problems with old
kernels were LL Privacy may not work as expected.

Fixes: https://github.com/bluez/bluez/issues/1138


  Commit: 8e2cece67dbe2bc92900a8fb72fed19fe114ea3e
      https://github.com/bluez/bluez/commit/8e2cece67dbe2bc92900a8fb72fed19fe114ea3e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Attempt to elevate security on Pair while connected

This would make Pair act behave the same as when the device reconnect
and bonding already exists.


  Commit: 1c2ec29900e48c785f7faa8fbe88f3085aaf806b
      https://github.com/bluez/bluez/commit/1c2ec29900e48c785f7faa8fbe88f3085aaf806b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Make Connect and Pair mutually exclusive

This makes Device.Connect and Device.Pair methods mutually exclusive so
they cannot happen in parallel, so just as Connect:Connect and Pair:Pair
combinations the Connect:Pair and Pair:Connect will now return
org.bluez.Error.InProgress.


  Commit: 45b61a10bd0af9b0b13f508166369eb1138ae448
      https://github.com/bluez/bluez/commit/45b61a10bd0af9b0b13f508166369eb1138ae448
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Use btd_device_is_initiator instead of Connect message

Device.Connect message is not the only way to initiate a connection as
there is also the likes of Device.Pair which will initiate bonding, so
this incorporate the bonding check into btd_device_is_initiator and
replaces the checks of were Connect message was used to determine if
initiator to use btd_device_is_initiator.


  Commit: ac1f8dd88a46da193b9226724a3ac60a0876598a
      https://github.com/bluez/bluez/commit/ac1f8dd88a46da193b9226724a3ac60a0876598a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Make bt_att_set_security never downgrade security level

Requesting a lower security level than existing one shall result in no
operation since higher security satisfy a lower one and it is never a
good practice to allow downgrading security to begin with.


  Commit: 5df9521ce4d50ffa48153503bc5156c11e6ed26b
      https://github.com/bluez/bluez/commit/5df9521ce4d50ffa48153503bc5156c11e6ed26b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Elevate bt_att security if bonding is in progress

When bonding is in progress it means Device.Pair has been called thus
the user indicated the intend to pair/bond from the start so the
security of bt_att shall be set in order for it to wait until pairing
process complete before attempting to proceed with GATT discovery and
any other traffic.

Fixes: https://github.com/bluez/bluez/issues/1125


Compare: https://github.com/bluez/bluez/compare/0f0039045088...5df9521ce4d5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
