Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D522083
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597606; cv=none; b=Q1pQ7yJT8LC816+2oAXwhsIufLGG5p9uOUa3eYq1WbRrjTUwLl697nR2psDFy7wFgpkjCR9IGqDELqy+In/691rodw2Nk0Eiz6+cVwHah+aueMIyVYryk4BU55V06jyn5A33AZDjlci3DreWiO3Y1YocCqEuDPFglMfwIfjnaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597606; c=relaxed/simple;
	bh=3USYTVV+CoW9g3pHF8dMlNDHfxyHb19EfjbED7lMrMw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rs6ZTJfa3x4n1wCejCIQrUT5X7D53I+tbOZM1TytyBkQCtOWeBi6nUdXFm4oqo4/gd4Cid8qvG0iqpgi/hPhAddgw467JnIbHURLFmnlLDg2XeSxdkXLUuEIbgfXiYkujge7D6mFMtJ/xcOclRGrLH76lymFNQ1mAsdP7Hqshlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ba9Xz0ng; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ba9Xz0ng"
Received: from github.com (hubbernetes-node-48454f9.va3-iad.github.net [10.48.85.29])
	by smtp.github.com (Postfix) with ESMTPA id 5A53C2C1016
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775597604;
	bh=UKoC1EADd+kMqiKXPEhP6wjYsJ+W0sTUpWe4INYb1pw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ba9Xz0ng2Gq9S1SAptqs8U312jSw1l6iQYgs6lTC/9sCvTOzkWzYPrbMRD6497eWJ
	 yruSeY4AMuyCqtgKHOfCDwez0HuW7plae5fZnaS9cDrfuekZ+JB6eOUQyb4B9NqV4M
	 7il3ldiEpHjg9fxdzINdGUnpi1QExj3IhvwlwraU=
Date: Tue, 07 Apr 2026 14:33:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078371/000000-4013af@github.com>
Subject: [bluez/bluez] a95380: device: Fix btd_device_connect_services not
 discov...
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

  Branch: refs/heads/1078371
  Home:   https://github.com/bluez/bluez
  Commit: a9538003a81014b7ddfb4f8effea72d67de69a13
      https://github.com/bluez/bluez/commit/a9538003a81014b7ddfb4f8effea72d67de69a13
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-07 (Tue, 07 Apr 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  device: Fix btd_device_connect_services not discovering

btd_device_connect_services would not attempt to discover in case the
selected bearer is BR/EDR and once discover is complete then it shall
proceed with connecting the services.


  Commit: 4013afdfbe12a5ec353d5f7769e4caa1a9947b6c
      https://github.com/bluez/bluez/commit/4013afdfbe12a5ec353d5f7769e4caa1a9947b6c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-07 (Tue, 07 Apr 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Prompt user to start scanning on connect command

If connect command don't find the device object make it prompt the
user to start scanning and set discovery filter pattern to given
address and mark it to auto-connect:

[bluetoothctl]> connect XX:XX:XX:XX:XX:XX
Device XX:XX:XX:XX:XX:XX not available
[XX:XX:XX:XX:XX:XX] Scan and connect (yes,no): y
SetDiscoveryFilter success
Discovery started
[NEW] Device XX:XX:XX:XX:XX:XX
[NEW] BREDR /org/bluez/hci0/dev_XX:XX:XX:XX:XX:XX
[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
[CHG] BREDR XX:XX:XX:XX:XX:XX Connected: yes


Compare: https://github.com/bluez/bluez/compare/a9538003a810%5E...4013afdfbe12

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
