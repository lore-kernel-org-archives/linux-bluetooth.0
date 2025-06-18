Received: from xtrwsrct.outbound-mail.sendgrid.net (xtrwsrct.outbound-mail.sendgrid.net [167.89.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F41A2632
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274750; cv=none; b=Ff5eWWD3QR6HC8rB4aRVltAQnQD5kfTQYrlRNKBVM4nPNHUEQMoqvE4DZ1x3IdIbX79tFZWOi8KIxvbigGF8sSG/qX/saUUInlzILGmRwlE+9ehmzojTaC7ju2KNDMJ5hzTrabaZGXLF01XHilRcyhBqxLpzim9UUoFLp0eYMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274750; c=relaxed/simple;
	bh=oemAjv6KNtewsdgNHLeLQqVxjEYMBB7haOVoSvHNklc=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=d9YBq+W1Ic+MMOOyJws9+msn48s4y361/At+lxWJFrfFRU2sJ0ejakLYx7FR9bp3jnZ3eGdqKCdwhcuTlGIosc/Ax8kZGDRoqkpZErNgCGiUyeJBwKpKgkkiTY83rPlLvG0rLz68SJF5TLnPD2Cc5054k+f4gn/kyxsZn84Rmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E0xV2OE8; arc=none smtp.client-ip=167.89.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E0xV2OE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=noQl9coSWsFBJabVb7j0Rb2QYleRAF09Vd+4V4EAFuE=;
	b=E0xV2OE8YTtRLxk0WR6RwGPJglVji44OluFQLQmjIhj+hrFvbtMcBjEAkTOyxWiJKfYy
	BjswJFjZq5M+c+568KU+PZ6r017mvPL/pOpMjeIJVIjBhUZlTr/+N8mH/TzWEaG2tIBWQc
	tLGhvN0nB++6e9zZ2hI0w5JAj2tvwakgk=
Received: by recvd-7f68b6458b-4xt9k with SMTP id recvd-7f68b6458b-4xt9k-1-685312BB-9D
	2025-06-18 19:25:47.724093583 +0000 UTC m=+1219959.294886945
Received: from out-26.smtp.github.com (unknown)
	by geopod-ismtpd-38 (SG)
	with ESMTP id 7gJTKi5rRyeUvCl6FLxvjA
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 18 Jun 2025 19:25:47.718 +0000 (UTC)
Received: from github.com (hubbernetes-node-ac97d46.ash1-iad.github.net [10.56.15.60])
	by smtp.github.com (Postfix) with ESMTPA id 54F446010E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:25:41 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:25:47 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/973550/000000-5f1737@github.com>
Subject: [bluez/bluez] 54142e: test-runner: Add -U/--usb option
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAuDi979jhQpP?=
 =?us-ascii?Q?aIYHGf3F2qyBEeyV4ShkGoJO6T17gvm97HAWg11?=
 =?us-ascii?Q?QoJW23lWa8bFOaTE5SutpwuFRzCy7OfhqNJi0Rz?=
 =?us-ascii?Q?cs8rWqu8EHwPjDrQnou4qyveA8oc=2F18B6H1guA4?=
 =?us-ascii?Q?aCUVdBlKifIWJr8FOk1mZr6tf1HUXBB8R1QNJwC?=
 =?us-ascii?Q?0chyXya582O66nDB4fJaUcAmqw=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/973550
  Home:   https://github.com/bluez/bluez
  Commit: 54142ed08d395182f7edb7d2aa2922ef9f927bc5
      https://github.com/bluez/bluez/commit/54142ed08d395182f7edb7d2aa2922ef9f927bc5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-18 (Wed, 18 Jun 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -U/--usb option

This adds option to use a host controller plugged over USB:

> tools/test-runner -U "usb-host,vendorid=0x8087,productid=0x0036"... -- /bin/bash
> dmesg
[    1.046214] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    1.192623] Bluetooth: hci0: Firmware timestamp 2025.18 buildtype 2 build 82364
[    1.192638] Bluetooth: hci0: Firmware SHA1: 0xa66e016b
[    1.197362] Bluetooth: hci0: Fseq status: Success (0x00)
[    1.197368] Bluetooth: hci0: Fseq executed: 00.00.04.196
[    1.197371] Bluetooth: hci0: Fseq BT Top: 00.00.04.197
> lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:0036 Intel Corp. BE200 Bluetooth
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub


  Commit: 8fc8434b1afc209440effa2a9c95c112ae09586b
      https://github.com/bluez/bluez/commit/8fc8434b1afc209440effa2a9c95c112ae09586b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-18 (Wed, 18 Jun 2025)

  Changed paths:
    M doc/test-runner.rst

  Log Message:
  -----------
  test-runner.rst: Add documentation for USB-passthrough

This documents the newly added option -U/--usb and adds a dedicated
section that explains the required the kernel image to build with
some extra config options to enable passing -device qemu-xhci in order
to use -device usb-host.


  Commit: 5f173704514c9e14138eaa20e4151afeca90f0a8
      https://github.com/bluez/bluez/commit/5f173704514c9e14138eaa20e4151afeca90f0a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-18 (Wed, 18 Jun 2025)

  Changed paths:
    M doc/tester.config

  Log Message:
  -----------
  tester.config: Add config options for USB-passthrough and drivers

This adds the necessary options in order to enable USB-passthrough
configuration and also enable most of the drivers so they get
build-tested.


Compare: https://github.com/bluez/bluez/compare/54142ed08d39%5E...5f173704514c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
