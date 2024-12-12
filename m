Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65029A9
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027459; cv=none; b=GHc3q4xddAC5IwxZj4yXSRtHAzzsdxb6J65KJTcJ94gBEtw7O6xjpoxEkrZ06cUcGQS2vU8TrXqlXDjWNOyJ2kSOilm2zZcKGwkux7gXChIHXEpHA9+EgVFf6lZtTj1zA2MbADRuQIm+mTnbZANMwfJYj20PxkKWk6/LPjTwLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027459; c=relaxed/simple;
	bh=K9rUJCzri+oaOn7aKfbIb4UC1ZQ2SbE8EKQf0/ieN1g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RoavC7vmt2IWzhNFOiCsm3mRCda6MFBucqKBhysVtWl25zlhWxB4o4tOBJS7kAAnnQ7Hy0CUwHxCBSpc+7guAf0aEBZd2DCJzSemo2+J1G99lXo6x1/qrFJPNUsrkzOVMj1uCrEymELYScRo426i47T3H5w5wZ/a2LuoVDgon+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bRP2DMgx; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bRP2DMgx"
Received: from github.com (hubbernetes-node-fcab8d3.ash1-iad.github.net [10.56.173.16])
	by smtp.github.com (Postfix) with ESMTPA id 911D514084B
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1734027456;
	bh=A8uc5WOr9CUC8NyEYmDMfsex5mPAUKpQ++dUcGOAs/A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bRP2DMgxnlUy8cLsl4efNLo5TJh0NzSBJoEZM2QJJjTMLEIVp8ExWF+M92vQCE91w
	 6qPNwyMYn9md2soGPDwiIukunzvOhFtKFgzOVV9YcfrbjaAYQlqa0dQCktRaol+aUs
	 uPJrnyr4iZW5thP1PZNO9rBKU2/kQiAiXCh7uwdM=
Date: Thu, 12 Dec 2024 10:17:36 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b1fd40-40e5eb@github.com>
Subject: [bluez/bluez] 5f0ec3: tools: Use '>' as prompt end marker
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
  Commit: 5f0ec38851e165265627eb69158dbb336ce3fd02
      https://github.com/bluez/bluez/commit/5f0ec38851e165265627eb69158dbb336ce3fd02
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-11 (Wed, 11 Dec 2024)

  Changed paths:
    M client/main.c
    M client/mgmt.c
    M tools/bluetooth-player.c
    M tools/btpclientctl.c
    M tools/mesh-cfgclient.c
    M tools/mesh-gatt/util.c
    M tools/mesh/util.c
    M tools/meshctl.c

  Log Message:
  -----------
  tools: Use '>' as prompt end marker

This replaces the use of '#' with '>' as prompt end marker since the
former is used to describe comments on the script which might be
confused with prompt.


  Commit: d1eb37042d9d2890647f31de38da946e34063433
      https://github.com/bluez/bluez/commit/d1eb37042d9d2890647f31de38da946e34063433
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-11 (Wed, 11 Dec 2024)

  Changed paths:
    M client/bluetoothctl-admin.rst
    M client/bluetoothctl-advertise.rst
    M client/bluetoothctl-assistant.rst
    M client/bluetoothctl-endpoint.rst
    M client/bluetoothctl-gatt.rst
    M client/bluetoothctl-mgmt.rst
    M client/bluetoothctl-monitor.rst
    M client/bluetoothctl-player.rst
    M client/bluetoothctl-scan.rst
    M client/bluetoothctl-transport.rst
    M client/bluetoothctl.rst

  Log Message:
  -----------
  bluetoothctl: Update documentation to use '>' as prompt end marker

This replaces the use of '#' with '>' as prompt end marker since the
former is used to describe comments on the script which might be
confused with prompt.


  Commit: 560dcd2ea3d267674c6ab5f7c60c62cd6ed4b6f7
      https://github.com/bluez/bluez/commit/560dcd2ea3d267674c6ab5f7c60c62cd6ed4b6f7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-11 (Wed, 11 Dec 2024)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h

  Log Message:
  -----------
  share/hci: Introduce bt_hci_send_data

This introduces bt_hci_send_data which can be used to send ACL, SCO or
ISO data packets to the underline HCI socket.


  Commit: 5527c88bc717439e8d11f9ffffc502a1b2fa785f
      https://github.com/bluez/bluez/commit/5527c88bc717439e8d11f9ffffc502a1b2fa785f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-11 (Wed, 11 Dec 2024)

  Changed paths:
    M Makefile.tools
    A client/hci.c
    A client/hci.h
    M client/main.c

  Log Message:
  -----------
  client: Add HCI submenu

This adds HCI submenu:

Menu hci:
Available commands:
-------------------
open <index> <chan=raw,user>                      Open HCI channel
cmd <opcode> [parameters...]                      Send HCI data
send <type=acl,sco,iso> <handle> [data...]        Send HCI data
register <event>                                  Register HCI event handler
unregister <event>                                Unregister HCI event handler
close                                             Close HCI channel

Examples:

In order to open a user channel the controller needs to be power off
first:
bluetooth# power off
bluetooth# hci.open 0 user
HCI index 0 user channel opened

Then commands can be sent hci.cmd, so the following is sending HCI reset:
bluetooth# hci.cmd 0x0c03
HCI Command complete:
  00

For sending data packets to specific handle hci.send can be used:
bluetooth# hci.send acl 0x0000


  Commit: 6905331e2cd8894040b18d1711444fb5e654b958
      https://github.com/bluez/bluez/commit/6905331e2cd8894040b18d1711444fb5e654b958
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-11 (Wed, 11 Dec 2024)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-hci.rst

  Log Message:
  -----------
  client: Add bluetoothctl-hci.1 man page

This adds bluetoothctl-hci.rst which is then converted to
bluetoothctl-hci.1 using rst2man.


  Commit: 40e5ebd0cb2cb3c3957fec710a18f29efe4b6e65
      https://github.com/bluez/bluez/commit/40e5ebd0cb2cb3c3957fec710a18f29efe4b6e65
  Author: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
  Date:   2024-12-12 (Thu, 12 Dec 2024)

  Changed paths:
    M tools/obexctl.c

  Log Message:
  -----------
  tools/obexctl: Add support for system/session bus

Currently obexctl only uses session bus.
As obexd has been enabled support for both session and system bus.
Configuring obexctl to use session/system bus during the runtime
if the name is available over session or system bus.


Compare: https://github.com/bluez/bluez/compare/b1fd40996000...40e5ebd0cb2c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
