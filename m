Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4914386C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752528; cv=none; b=iyGY0SQIIcua4YEIp3Wp+ZB5TKrhKd3NmoNZlPdlYi2+kDvDNy13qLLLOU5lILpUeZ9fXD/x1XPw2uITDSa6A+wTO4w7piqk7V279NBtZYeVe2Ljqt1ajlf0F2+ptEagapMW5B89eiVGNXrLPF1XXmocSpH+y73o9YJKCT9I7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752528; c=relaxed/simple;
	bh=LESBeNJERwcziPANP+JxgtOTk8++pX6tLVbolxnd+jg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OX6KE5iDKCEgSG+Qevw1F0TjvCaGkmqKJwiVJ91oip1FLNNO3zuG8yzEQn3+yPHv+GZtwtMjoQwq8j24FI+jNrJV44V460PaZa4pPkOZyRPdxMpRzqOrI35k+U7om0UIl5daz8qfLae1k3nFzlbNkcZy7z4JeijuMvpHL2Jz6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XL2jORtb; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XL2jORtb"
Received: from github.com (hubbernetes-node-6350b8c.va3-iad.github.net [10.48.153.33])
	by smtp.github.com (Postfix) with ESMTPA id A7D148C05AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1723752525;
	bh=MbXFQnl7lncNUIod0Tz6xKoXVGiOOHLVrlZLSerWCF0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XL2jORtbim/Lra8dJCV8BvpgMD819bn5YfmcFWbKAQwZBFIw+D1yjKitX53kQNPYo
	 fHK4Xy2dPDH5BCLUaYeOxftPjWK0UxceRNfvFIP1Pi69yzclQbKbNjLA7d9Mtmtkmg
	 MhVgcc5rbuX6D7qbT+MLDIvz44ZTc/pqAXGB2YJM=
Date: Thu, 15 Aug 2024 13:08:45 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/537e39-939133@github.com>
Subject: [bluez/bluez] 3b7f4b: test-uhid: Add support for device specific
 testing
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
  Commit: 3b7f4b4d3c83bc1c302a56f0eaa7c2b842e014d7
      https://github.com/bluez/bluez/commit/3b7f4b4d3c83bc1c302a56f0eaa7c2b842e014d7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-14 (Wed, 14 Aug 2024)

  Changed paths:
    M unit/test-uhid.c

  Log Message:
  -----------
  test-uhid: Add support for device specific testing

This enables device specific testing and switch to run
bt_uhid_new_default when running as root so the actual kernel driver is
used:

input: MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0031/input/input86
logitech-hidpp-device 0005:046D:B025.0031: input,hidraw10: BLUETOOTH HID v0.14 Mouse [MX Anywhere 3] on 00:00:00:00:00:00


  Commit: c315b42e053892e623dc8a755a278d369d910291
      https://github.com/bluez/bluez/commit/c315b42e053892e623dc8a755a278d369d910291
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-14 (Wed, 14 Aug 2024)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c

  Log Message:
  -----------
  device: Promote Device.{AdvertisingData, AdvertisingFlags} to stable

This promotes AdvertisingData and AdvertisingFlags to stable so they can
be used by upper layers without having to enable experimental.


  Commit: 9391332938293b37cd29013dde65fdeeec614b5d
      https://github.com/bluez/bluez/commit/9391332938293b37cd29013dde65fdeeec614b5d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-14 (Wed, 14 Aug 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Create devices if they are connectable

Rather than just depend on discoverable also check if the device is
considered connectable since upper layers shall now be able to use
AdvertisingFlags to detect when a device shall be considered visible
or not and bluetoothctl has been using it since commit 815f779aa8e4
("client: Use AdvertisingFlags when available").


Compare: https://github.com/bluez/bluez/compare/537e399aa096...939133293829

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
