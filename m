Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42A1865FA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267013; cv=none; b=bUM3HCHvUrTwzpn+gZN5gEjy9pZuvUhBO/qDi+m11ccLGr6D0u18LKJKvl6TOWadAdRx9ZVm2SoTfXyZRNXbH43Mjsh8as5cCQUvC6eCApOJ6z7sVpH9nFA8la4dyRiKpIATQADEwM57pgyaIFdzW8wO/kpxolcfOonwOOVjB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267013; c=relaxed/simple;
	bh=7fp1Si6aNBB9ZjQHr626oc4d6kQ7LfIVgYrda33B/II=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kKRgHocXyiPelXmAv0rBTbfCd5gKDF/eN/XmO5GFcK6n6wCalYmt3vIfWtJtAaezl8FE/9I+LBQb1Db3YsENttWp+bP6+s7/PfHLXvpN3tUm6SRJM7Ay8ONS3tUQ+WD5Kkk9UqL/btUaTSGIGTkM5DBUlcWwMcibaDIHSsX343Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GWacGazW; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GWacGazW"
Received: from github.com (hubbernetes-node-e690191.va3-iad.github.net [10.48.173.49])
	by smtp.github.com (Postfix) with ESMTPA id CB3D23C1275
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762267010;
	bh=7Ksy5m+yI3g0M2U+FiTViXi3nGpiscL4goAPjn7bIvE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GWacGazWKm+M5QmXb6hYL0ne9O0f4EGw1ha3dSfHm7g6z0e+Zt42TUrtw5x1sbip6
	 gBBnrqX2SEOBmPg2Cr5ggpwUEDZ41LmYC5HPPiP9xHgD76RvSq6rT8rrPvTN0kkod6
	 wtRofdTdbijbQUSh57INcZtqrdzmiWfSFbS56de4=
Date: Tue, 04 Nov 2025 06:36:50 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019482/000000-53ff16@github.com>
Subject: [bluez/bluez] 707fb3: monitor: Decode Bluetooth 6.0 version
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

  Branch: refs/heads/1019482
  Home:   https://github.com/bluez/bluez
  Commit: 707fb3d15ab2e9339e1132fdd01150923da535cf
      https://github.com/bluez/bluez/commit/707fb3d15ab2e9339e1132fdd0115=
0923da535cf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode Bluetooth 6.0 version

This decodes 0x0e as Bluetooth 6.0.


  Commit: 43f76a1aa526f74e5e5b58faf59817575d9dbe42
      https://github.com/bluez/bluez/commit/43f76a1aa526f74e5e5b58faf5981=
7575d9dbe42
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


  Commit: 53ff16cb2aac116c0cfecaafc6bc1ee8ee72eb4d
      https://github.com/bluez/bluez/commit/53ff16cb2aac116c0cfecaafc6bc1=
ee8ee72eb4d
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


Compare: https://github.com/bluez/bluez/compare/707fb3d15ab2%5E...53ff16c=
b2aac

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
