Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064D1AAA15
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364880; cv=none; b=HGA7nYvfcDQO7i/h+xOGSwPRybmPcsnhBhjANc0U+bOydVLuCIWCbCMD1IbIn7njHFqF5GMaQAUbr9o8ZQR+/7aXd4V4k1+KC+xvF/Xep655kq/Z3PO3eHpMydRWb3kOPY1Cj0OpjKpyAZPsQ+AMuFMZLKD9P3uYQ7Qlz6dzQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364880; c=relaxed/simple;
	bh=M1h7FmrqCTHHCBErV9S3wCwTJgIFGcn7TXitNgcVW54=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZCCpdriNmfvR0S2Q4ph9qxgwhwanBS08mf2G9xRCnJ6HUHhbwbCTb0SEin9I2wuornkzH8sjKOsoCmODZxhP2pt3M/Xelj7e8Ar2K3X/pb56iROMzaXkws0qpFldnixWMOno3tXkcDRLOCjYHh80ljz9RM6el+pEN7tPQ97wBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hs5FuBrn; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hs5FuBrn"
Received: from github.com (hubbernetes-node-87edd45.ac4-iad.github.net [10.52.206.19])
	by smtp.github.com (Postfix) with ESMTPA id 0B6A76408F0
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 11:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1736364878;
	bh=Y9a/Tj2dIPqy+MK5nQ4rP41pPIDwTv+Tszn+TC/d9S8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hs5FuBrnBg2y5fNwlCmQrU+PF3kGvjeUMr7fx7hdLEtqRE03vlYnOS8xXP06DaR4I
	 Qrf+lEXjZci+KVmq7OpPTJJTA5XhAyFkwznBjsEJTmU9alRY4IBkh3jzEFfPloy3Sk
	 7zfZJBplRr702kqn1v92fgHYQMhN7ejzUIph9/rg=
Date: Wed, 08 Jan 2025 11:34:38 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/79900d-8f8539@github.com>
Subject: [bluez/bluez] c281bc: autopair: Move handling of wii controllers
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
  Commit: c281bc460884c16ec9314dc4baa858915e412c90
      https://github.com/bluez/bluez/commit/c281bc460884c16ec9314dc4baa858915e412c90
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M plugins/autopair.c

  Log Message:
  -----------
  autopair: Move handling of wii controllers

This moves the pairing handling of wii controllers to autopair plugin.

Link: https://github.com/bluez/bluez/issues/911#issuecomment-2571606630


  Commit: 7679c96954ec68656f041c093463d86f4efa2513
      https://github.com/bluez/bluez/commit/7679c96954ec68656f041c093463d86f4efa2513
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M Makefile.plugins
    R plugins/wiimote.c

  Log Message:
  -----------
  build: Remove wiimote plugin


  Commit: 4fa24e6583a300962071a1d3a5493abf58fd36cc
      https://github.com/bluez/bluez/commit/4fa24e6583a300962071a1d3a5493abf58fd36cc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Make BTSNOOP_PRIORITY_DEBUG the default

This makes BTSNOOP_PRIORITY_DEBUG the default so it captures debug logs
from the likes of bluetoothd which is very handy when debugging problems
as otherwise the logs have to entered separately making it hard to
figure out the ordering of the messages.


  Commit: 8f853903bdf49b4c111dcf13a0d5c81a84b7f2a6
      https://github.com/bluez/bluez/commit/8f853903bdf49b4c111dcf13a0d5c81a84b7f2a6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Switch back to kernel hidp if uhid cannot be initialized

If bt_uhid_new_default doesn't work it is likely that the underline
kernel doesn't support it so this attempts to switch back to kernel
mode (hidp).


Compare: https://github.com/bluez/bluez/compare/79900d49ac68...8f853903bdf4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
