Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECF361679
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677377; cv=none; b=if477aw+2mTlyd5ZvcH/E+UHRyCGo/uJxiH9JrT6leai53FZX6X8Vzke1flit890b5yHNlpQsqTVsZB2lbFP531Q4a8rSvIpyxHU1VCP0HgT0ngSn1+eJGOKZs/Gt/ZAxAFLduWrEy6AMFRzLRcz9Kh5BLHgxXFLrkpXJJuKUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677377; c=relaxed/simple;
	bh=etXitY6UmIj2sMlNeeinl340rvs5ezhLWbThZ93TS3s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZvByn5BPTlhaa4NsTLW+vPpKtpj47HdiWiLXpetMxm9YFxgv5LoXHWPQjVV111gTepF4Cbz5g/iVSr8muzKaQgf1Uyxkj7SdkmXCOijikr2FwWkWOKsSfVbGYd3yLF9GaE7sGmV2ufYlj5bjGYGt/jOnYAQzLbZcKSyS7LNoU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VIGk2xAE; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VIGk2xAE"
Received: from github.com (hubbernetes-node-913926b.ac4-iad.github.net [10.52.172.31])
	by smtp.github.com (Postfix) with ESMTPA id 8D66264079C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775677375;
	bh=IN6KCOE1kTeIPSEOevOvsJzcUV4If2Qj50eP0mpVypA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VIGk2xAEuDpk6yfsqc/mNUba5JlBO9P12wxp3Uj6oKsIenOkPgoJR/Xnk2iX5Qfn9
	 C+r37ceIwzb1yWGfdQ897VbMo2NhPF85hxi46e1G8qQG+VUKkQlc/BrW+E4qAOCPEz
	 QbTywleM+4QD3N3uC+zMVVZuulG5b8EPPKIqHf/I=
Date: Wed, 08 Apr 2026 12:42:55 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078829/000000-e7cf12@github.com>
Subject: [bluez/bluez] cc13ea: device: Fix btd_device_connect_services not
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

  Branch: refs/heads/1078829
  Home:   https://github.com/bluez/bluez
  Commit: cc13ea5b68c31cfd9fa5e143f8c1da3c07230fcf
      https://github.com/bluez/bluez/commit/cc13ea5b68c31cfd9fa5e143f8c1da3c07230fcf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  device: Fix btd_device_connect_services not discovering

btd_device_connect_services would not attempt to discover in case the
selected bearer is BR/EDR and once discover is complete then it shall
proceed with connecting the services.


  Commit: 218d158cb27c07e5c7295ab2267cbfd0929d798e
      https://github.com/bluez/bluez/commit/218d158cb27c07e5c7295ab2267cbfd0929d798e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

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


  Commit: e7cf124debab534fb301c8b6d7581955e911ce5a
      https://github.com/bluez/bluez/commit/e7cf124debab534fb301c8b6d7581955e911ce5a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Stop discovery when connected with filter.auto_connect

If device was connected via filter.auto_connect method (e.g. connect or
scan.auto_connect) stop the discovery session after the device connects.


Compare: https://github.com/bluez/bluez/compare/cc13ea5b68c3%5E...e7cf124debab

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
