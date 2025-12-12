Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A9293B5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554033; cv=none; b=oV3ktgg7Fwepe9lxwTydqo4k8T6/6d1yHOIFkzG/vTpJ0wSFCMNYFrYdadzwNm4FDLUwJv6rpW8SwnLxFPGH1g+TiyHljCDAyNiL7gtr/efNA12M/MKFV5U+0zPFrTmk69q4YI3rd2ziF81DF5iVF2+GofGGQrBhKkimD5y2rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554033; c=relaxed/simple;
	bh=5v0T2DSyFFOXIIfSqkVLxATkN1M7awfIqPs8S6pew+8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y0vqk+BRPrtc9snxSbT2R3zFz1IMSOzYGynI6npuoylMJ2u+01b4GMWQulbZfZRaHPe2I5/S+Vt1sJPLAFqjqgwEGBrXeixIduoUyhpBgrUZMu/GOKRnatpVjhGPC8P0ETxov4QOuwUb5L71gW5GmkJ5wZKUbFycRDgdz2sED7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Y2oeKu0/; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Y2oeKu0/"
Received: from github.com (hubbernetes-node-0156574.va3-iad.github.net [10.48.210.65])
	by smtp.github.com (Postfix) with ESMTPA id 578DFE0D01
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765554031;
	bh=Xmejscxbd++YcBTYjnlHp2Gsr/YN6ytVZU0rC92O18I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Y2oeKu0/iMEfNbLP4x2Po4DX1CIyOe3WBYUUMJGetXQqLz3k69hm3LWB18yikWoHK
	 evzUa1iAXFi5GGNZjPnFkjgMN0M0B+a8gL/GxhXiUT5owJ6fJycrlKPoSR35fuEBt8
	 IHXzkTBmnrzwyIetVDvo128qJeW4PALjg4CuHHlg=
Date: Fri, 12 Dec 2025 07:40:31 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a589b0-a2ef82@github.com>
Subject: [bluez/bluez] 44a1d0: l2cap-test: Add tests for LE 2M and Coded PHYs
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
  Commit: 44a1d0c73ab5e4377884b30e89fbc2091c6743f4
      https://github.com/bluez/bluez/commit/44a1d0c73ab5e4377884b30e89fbc=
2091c6743f4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-test: Add tests for LE 2M and Coded PHYs

This adds the following tests that uses BT_PHY to retrieve the ACL/LE
connection supported LE 2M and Coded PHYs:

L2CAP LE Client - PHY 2M/Coded
L2CAP LE Server - PHY 2M/Coded
L2CAP Ext-Flowctl Client - PHY 2M/Coded
L2CAP Ext-Flowctl Server - PHY 2M/Coded


  Commit: 270b899e963051907af85f69483565da2edaae0d
      https://github.com/bluez/bluez/commit/270b899e963051907af85f6948356=
5da2edaae0d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Call.rst
    A doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc: Add new telephony related profiles interfaces

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.


  Commit: 7204618e59ad59317e5231bcf163f115c018ca4b
      https://github.com/bluez/bluez/commit/7204618e59ad59317e5231bcf163f=
115c018ca4b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    A profiles/audio/telephony.c
    A profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add shared interfaces implementation

This implements the Telephony and Call DBus interfaces which will be
shared by telephony related "headset" profiles.


  Commit: cfc372d4f21b040ab99fd860fb483055cb192a1f
      https://github.com/bluez/bluez/commit/cfc372d4f21b040ab99fd860fb483=
055cb192a1f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add skeleton for HFP profile

This starts the Telephony interface for HFP HF, allowing to connect to
the remote HFP AG device.


  Commit: 5c7bb30960212c07f3b9e04b863194e54f8a1bb4
      https://github.com/bluez/bluez/commit/5c7bb30960212c07f3b9e04b86319=
4e54f8a1bb4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP SLC connection and event support

This implements the HFP HF SLC connection and events support for the
Telephony DBus interface.


  Commit: b3677421feee65f2c87f40123d242d51af51396a
      https://github.com/bluez/bluez/commit/b3677421feee65f2c87f40123d242=
d51af51396a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-telephony.rst
    M client/main.c
    A client/telephony.c
    A client/telephony.h

  Log Message:
  -----------
  client/telephony: Add new submenu

This add a new submenu to bluetoothctl to be able to manage telephony
related "headset" profiles.
It currently allows to control calls from an HFP phone, i.e. starts a
call, hangup a call, accepting or rejecting an incoming call.

Audio part is not yet supported.


  Commit: a2ef82f1aaa950659812b3e807702c46e820a0c8
      https://github.com/bluez/bluez/commit/a2ef82f1aaa950659812b3e807702=
c46e820a0c8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: fix notify_data leak in notify_data_write_ccc

Calling bt_gatt_client_unregister_notify() when ATT has disconnected
leaks the reference to notify_data: in notify_data_write_ccc() the
bt_gatt_client_write_value() fails, the destroy is never called, and
notify_data_ref() is leaked.

Fix by balancing unref notify_data on write failure.

Log (unit/test-mcp):
Direct leak of 5760 byte(s) in 90 object(s) allocated from:
    #0 0x7fd7e2ce6f2b in malloc
    #1 0x0000004227e5 in util_malloc src/shared/util.c:46
    #2 0x00000044a81c in register_notify src/shared/gatt-client.c:1782
    #3 0x000000458367 in bt_gatt_client_register_notify src/shared/gatt-c=
lient.c:3685
    #4 0x00000049f9f5 in foreach_mcs_char src/shared/mcp.c:1834


Compare: https://github.com/bluez/bluez/compare/a589b0d73c41...a2ef82f1aa=
a9

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
