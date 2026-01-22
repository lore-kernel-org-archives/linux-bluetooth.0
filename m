Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1234847A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073614; cv=none; b=NrBxdIjXFhdS/80eUDfaSBe8avP5DkUECRXdxImX8C+apAVVb/9FZe/mpOCfwt2a9i0INuq3R5kQnWfYhZzar1+5VSC85lbDll9ae8/LIvjVZR+RiK2KAqcyOk7yh4nkX72xIY7xhhbI5911VUFOr5flgK8222S4BQGXqRsTuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073614; c=relaxed/simple;
	bh=tb9EvzJLiXEg5ea8vbegwB1XwyTssDpmpIlOd3w0oME=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C42Lh3MQ4GufFgYas0xMOZdeY7TZIBRdKY4LffEGvwDNvYyztUpheEPXi1u2KM68ch3z/YO9E5lX5OhtfnnYquXynp/ckpN3g6XjlA2x9WTBBWiZf8CombfowBZeteoJGPJgNLu0mXk7OKvdia2lWKVGXzN/YXphrJp4uL6tmi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=arwuIY7G; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="arwuIY7G"
Received: from github.com (hubbernetes-node-d1211bb.ash1-iad.github.net [10.56.211.49])
	by smtp.github.com (Postfix) with ESMTPA id 98FC3140D0B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769073611;
	bh=T1+14Jyi8mqBn0eTUvs8UaaG3mhjUNIKgVnAUyRwe2A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=arwuIY7GvGQ4wUsJsyS17TbQYPNwC6pRDA/WUgIyY48sN+Uzjy+yX7tcWqnSCsfnp
	 qggZ+8hlhOqoBOE1awBAkskNBb3/L3Seg3RHVqq4pjfAGGQte5VN6KkOaGZpphRA3W
	 RNtIsdu0/pgAHPTFuL/sSMjB2eHJFbbIOFGmKCvU=
Date: Thu, 22 Jan 2026 01:20:11 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1045561/000000-740595@github.com>
Subject: [bluez/bluez] 64ccc5: doc: Rename section 7 man pages
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

  Branch: refs/heads/1045561
  Home:   https://github.com/bluez/bluez
  Commit: 64ccc564161588b5277517042cf0652e89fcdba4
      https://github.com/bluez/bluez/commit/64ccc564161588b5277517042cf0652e89fcdba4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/hci-protocol.rst
    R doc/hci.rst
    A doc/iso-protocol.rst
    R doc/iso.rst
    A doc/l2cap-protocol.rst
    R doc/l2cap.rst
    A doc/mgmt-protocol.rst
    R doc/mgmt.rst
    A doc/rfcomm-protocol.rst
    R doc/rfcomm.rst
    A doc/sco-protocol.rst
    R doc/sco.rst

  Log Message:
  -----------
  doc: Rename section 7 man pages

So that rfcomm.rst can be used for the rfcomm command-line utilities.
This does not change the names of the generated man pages.


  Commit: 48b9f99905879b032031e840fd6efb0a74ef277e
      https://github.com/bluez/bluez/commit/48b9f99905879b032031e840fd6efb0a74ef277e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    M Makefile.mesh
    M Makefile.tools
    R client/bluetoothctl-admin.rst
    R client/bluetoothctl-advertise.rst
    R client/bluetoothctl-assistant.rst
    R client/bluetoothctl-bredr.rst
    R client/bluetoothctl-endpoint.rst
    R client/bluetoothctl-gatt.rst
    R client/bluetoothctl-hci.rst
    R client/bluetoothctl-le.rst
    R client/bluetoothctl-mgmt.rst
    R client/bluetoothctl-monitor.rst
    R client/bluetoothctl-player.rst
    R client/bluetoothctl-scan.rst
    R client/bluetoothctl-telephony.rst
    R client/bluetoothctl-transport.rst
    R client/bluetoothctl.rst
    M configure.ac
    A doc/bdaddr.rst
    A doc/bluetooth-meshd.rst.in
    A doc/bluetoothctl-admin.rst
    A doc/bluetoothctl-advertise.rst
    A doc/bluetoothctl-assistant.rst
    A doc/bluetoothctl-bredr.rst
    A doc/bluetoothctl-endpoint.rst
    A doc/bluetoothctl-gatt.rst
    A doc/bluetoothctl-hci.rst
    A doc/bluetoothctl-le.rst
    A doc/bluetoothctl-mgmt.rst
    A doc/bluetoothctl-monitor.rst
    A doc/bluetoothctl-player.rst
    A doc/bluetoothctl-scan.rst
    A doc/bluetoothctl-telephony.rst
    A doc/bluetoothctl-transport.rst
    A doc/bluetoothctl.rst
    A doc/bluetoothd.rst.in
    A doc/btattach.rst
    A doc/btmgmt.rst
    A doc/btmon.rst
    A doc/ciptool.rst
    A doc/hciattach.rst
    A doc/hciconfig.rst
    A doc/hcidump.rst
    A doc/hcitool.rst
    A doc/hid2hci.rst
    A doc/isotest.rst
    A doc/l2ping.rst
    A doc/rctest.rst
    A doc/rfcomm.rst
    A doc/sdptool.rst
    R mesh/bluetooth-meshd.rst.in
    R monitor/btmon.rst
    R src/bluetoothd.rst.in
    R tools/bdaddr.rst
    R tools/btattach.rst
    R tools/btmgmt.rst
    R tools/ciptool.rst
    R tools/hciattach.rst
    R tools/hciconfig.rst
    R tools/hcidump.rst
    R tools/hcitool.rst
    R tools/hid2hci.rst
    R tools/isotest.rst
    R tools/l2ping.rst
    R tools/rctest.rst
    R tools/rfcomm.rst
    R tools/sdptool.rst

  Log Message:
  -----------
  doc: Move all the man pages to doc/

No modifications are made to the documentation files, their sources (rst
or rst.in) are just moved to doc/ and the autotools build files adjusted
for the new path.


  Commit: d934a36c1657ebdad40685f97c9cb816b7c8a157
      https://github.com/bluez/bluez/commit/d934a36c1657ebdad40685f97c9cb816b7c8a157
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/assigned-numbers.rst
    R doc/assigned-numbers.txt

  Log Message:
  -----------
  doc: Port assigned-numbers.txt to RST


  Commit: 26038a614259c3f8279d34c55e87ffa9494618f1
      https://github.com/bluez/bluez/commit/26038a614259c3f8279d34c55e87ffa9494618f1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Thermometer.rst
    A doc/org.bluez.ThermometerManager.rst
    A doc/org.bluez.ThermometerWatcher.rst
    R doc/thermometer-api.txt

  Log Message:
  -----------
  doc: Port thermometer-api.txt to RST


  Commit: c7bb6ec825ac7025b98ac7ce1d747b4baf4ec343
      https://github.com/bluez/bluez/commit/c7bb6ec825ac7025b98ac7ce1d747b4baf4ec343
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/security-bugs.rst
    R doc/security-bugs.txt

  Log Message:
  -----------
  doc: Port security-bugs.txt to RST


  Commit: 376e82f43ce55af5f3f641dbd05a995e7b3d6f57
      https://github.com/bluez/bluez/commit/376e82f43ce55af5f3f641dbd05a995e7b3d6f57
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/coding-style.rst
    R doc/coding-style.txt

  Log Message:
  -----------
  doc: Port coding-style.txt to RST


  Commit: 0c9a3eab28622ea907e8529ab35b5eadbe361db3
      https://github.com/bluez/bluez/commit/0c9a3eab28622ea907e8529ab35b5eadbe361db3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.SimAccess.rst
    R doc/sap-api.txt

  Log Message:
  -----------
  doc: Port sap-api.txt to RST


  Commit: df875b30d59d4e1c17700119fe6c3a8d61ad5236
      https://github.com/bluez/bluez/commit/df875b30d59d4e1c17700119fe6c3a8d61ad5236
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/maintainer-guidelines.rst
    R doc/maintainer-guidelines.txt

  Log Message:
  -----------
  doc: Port maintainer-guidelines.txt to RST


  Commit: 740595707286f7b5b12fa91e9dbdfd4f4bbda078
      https://github.com/bluez/bluez/commit/740595707286f7b5b12fa91e9dbdfd4f4bbda078
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    R doc/health-api.txt
    A doc/org.bluez.HealthChannel.rst
    A doc/org.bluez.HealthDevice.rst
    A doc/org.bluez.HealthManager.rst

  Log Message:
  -----------
  doc: Port health-api.txt to RST


Compare: https://github.com/bluez/bluez/compare/64ccc5641615%5E...740595707286

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
