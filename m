Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DA17BD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340112; cv=none; b=ZLQ6aOsWVyEspwF7BTs4q73Ojwqg+663pgYPUWQ3VY/PqIbWcOtTovTUl/TgRuLNR50/7n3OUYcCYyg9uGHCB/8EwLPWoRVkVzn33YHqtPGtABXFNiukX4o28YnwdVpHxTCGk1LeE3ChNxVfFnzPa45zYr6uvDaNRZ4Bi4SxpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340112; c=relaxed/simple;
	bh=yqbO/gn1Sh0sSEX9Gm2VbUfPIqOEQ2pAto15ouPdgVk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uG44o5SdTeTehNan7Y34FRNl0G9cgCbN+pbJbFVeYaBLU/1RpvKss+WHkhzoV8chHL9UgJinJFsf0HwwWi4ovGmsutRpbL/L2inmqscZwRtP1naYth/fp3tDI/rMJnVVl/vDvZkK6u197PdMRjNXhXB7y8/k9NzBJJRMJhX5qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j8KDN53S; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j8KDN53S"
Received: from github.com (hubbernetes-node-77677fe.ash1-iad.github.net [10.56.131.81])
	by smtp.github.com (Postfix) with ESMTPA id 85BF5921125
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747340110;
	bh=QBA0nbqdwTSWiAgh1kBZJSJbPaVMi2DX6q1dxyL5s+o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j8KDN53Sz/byzQoEdepj3wsaMyk5X+AXeCIqtr2SyHCykmJMisQY8JKUoaVQNewbe
	 1KjlL68BPIuFgRTjPXPC0uwLviQCA9hQtxNoURaIrsvUJjGljpMRtR0Tp8JjVo81gs
	 T/szcmxPz0/l/7IfkVTV90njovTuoY2lCPghW3ZM=
Date: Thu, 15 May 2025 13:15:10 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/080174-00969b@github.com>
Subject: [bluez/bluez] 00969b: device: Reply br-connection-key-missing on
 connect...
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
  Commit: 00969bdb17ea01af8722d5bdcf8b2c19e06e9456
      https://github.com/bluez/bluez/commit/00969bdb17ea01af8722d5bdcf8b2=
c19e06e9456
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-15 (Thu, 15 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Reply br-connection-key-missing on connection bonding error

Currently when connection is removed while the client is waiting for
Connect() the failed message is br-connection-canceled, even if this
is due to bonding error.

Implement to reply with br-connection-key-missing, when the connection
request fails due to a bonding authentication error, allowing the client
to differentiate connection failure reasons.

This has been tested by:
- pair a device
- disconnect
- edit pairing info to change last character of Key entry of [LinkKey] in=

  /var/lib/bluetooth/<adapter_address>/<device_address>?info
- restart bluetoothd
- in bluetoothctl, connect <device_address>



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
