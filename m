Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398325D914
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285155; cv=none; b=iNkbEqZ1IVZ9JojhyPchjfbvQphrRxMO8iqO1T25E2rCTmSjZj8IgLy6SxS/OOCqNaYN1TE6BIwhd8TrOm7QJihuw5Le2Z7X8fsiqW0regE9eKoTKuClkTrNNhVbBSmZFSJdHQkV28j0dxWEHwxcukf6XjpnlCDlqCZwIDShawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285155; c=relaxed/simple;
	bh=gS4s17oNTiMzmBEdWiVGdLhOQ/8dBxXcXK3luLv5HfU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nChH2jklowdCJRrKcJ4rE92OhJF4tdA5QBvcaYoFLi7nLiws4rQAXifTbV2fL2vqbxG6JzTmY+zW2GcSuVYAPw5DBzDAmy64hGnaDyNOs7MRVD5x1gsIA+eNSGWI2bMvb1ewnPhtsl1kcMwLGNULkAwwMOOpT5mk5sL+NVNRISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aQchVDY2; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aQchVDY2"
Received: from github.com (hubbernetes-node-a670f64.ash1-iad.github.net [10.56.163.31])
	by smtp.github.com (Postfix) with ESMTPA id 847389210D3
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741285152;
	bh=pzza8mO8YT1sYw05F1eS/1Imn850lE8uDaq2wmi3YJo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aQchVDY2DxyiC3PTAGqYqvWtrd5c/becTEUaIdZJ8BKvtvJV1pPGB1kKqOk1fMxYw
	 OtFNI7+bOAqXR5d6PmIPe8ffJFeFBUnjHw2u79szHJdthyVRCIKHZ688/MGX6sRr65
	 Bqn7A52SG5vfPqBZp+lfq8NvDEDKD5fuuh8KmVzk=
Date: Thu, 06 Mar 2025 10:19:12 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/26bc1c-4d3c72@github.com>
Subject: [bluez/bluez] 04cd5d: btdev: Fix scan-build warnings
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
  Commit: 04cd5d2a97c887938ff53b621a4a4a6cc7eec967
      https://github.com/bluez/bluez/commit/04cd5d2a97c887938ff53b621a4a4a6cc7eec967
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix scan-build warnings

This fixes the following scan-build warnings:

emulator/btdev.c:1126:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn' [deadcode.DeadStores]
 1126 |         while ((conn = queue_find(dev->conns, match_handle,
      |                 ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1127 |                                         UINT_TO_PTR(handle))))
      |                                         ~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1413:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn') [core.NullDereference]
 1413 |         pending_conn_del(dev, conn->link->dev);
      |                               ^~~~~~~~~~
emulator/btdev.c:1535:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn') [core.NullDereference]
 1535 |         send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
      |                    ^~~~~~~~~


  Commit: a22935f9baf507788b438e1e704f735de07fd392
      https://github.com/bluez/bluez/commit/a22935f9baf507788b438e1e704f735de07fd392
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Introduced PreferredBearer

This introduces PreferredBearer property which can be used to indicate
what bearer shall be connected first rather than just using last seen
bearer which may not work always since it seems some devices sometimes
advertises on LE bearer but expects connections over BR/EDR e.g:

https://github.com/bluez/bluez/issues/1092

Also with the introduction of LE Audio this might become even more of a
problem since most likely users would like to select which bearer to use
rather than using the last-seen policy.


  Commit: 03240630b39bc777a66babf6737b26a8dc51c0ab
      https://github.com/bluez/bluez/commit/03240630b39bc777a66babf6737b26a8dc51c0ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add implementation of PreferredBearer

This adds initial implementation of PreferredBearer.


  Commit: f2e7c8f9960094622044197f99e0dc5599fea896
      https://github.com/bluez/bluez/commit/f2e7c8f9960094622044197f99e0dc5599fea896
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add support get/set PreferredBearer

This adds support for PreferredBearer which is printed with the likes of
info command:

bluetoothctl> info <addr>
...
	PreferredBearer: last-seen

It also introduces a new command to get/set the PreferredBearer:

[bluetoothctl]> bearer --help
Get/Set preferred bearer
Usage:
	 bearer <dev> [last-seen/bredr/le]

[bluetoothctl]> bearer <addr>
	PreferredBearer: last-seen
[bluetoothctl]> bearer <addr> le
bluetoothd: @ MGMT Command: Add Device (0x0033) plen 8
        LE Address: <addr>
        Action: Auto-connect remote device (0x02)
[CHG] Device <addr> PreferredBearer: le
Changing le succeeded
[bluetoothctl]> bearer <addr>
	PreferredBearer: le
[bluetoothctl]> bearer <addr> bredr
bluetoothd: @ MGMT Command: Remove Device (0x0034) plen 7
        LE Address: <addr>
[CHG] Device <addr> PreferredBearer: bredr
Changing bredr succeeded


  Commit: 4d3c721ee037bcc9553bc2e6a8b7fe0bebb3b50c
      https://github.com/bluez/bluez/commit/4d3c721ee037bcc9553bc2e6a8b7fe0bebb3b50c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M doc/settings-storage.txt
    M src/device.c

  Log Message:
  -----------
  storage: Add support for storing PreferredBearer

This adds support for storing PreferredBearer into device info file.


Compare: https://github.com/bluez/bluez/compare/26bc1c9cd9df...4d3c721ee037

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
