Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632743403E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481807; cv=none; b=Rv8tbIdCEfH2DlwEuF9kAeboveGzu2M47S4dmdA1JaGotHsjhzjEtu2IxBP2+YoKNeA7cZd1ESlccOP5yYCwhuxRW97y2FsZNklBZAOceXikj3iRDt+mVcdEcad+YA610/MnuP3otFqfytvn26ySjAVNRIf+8iJPxGJoG3G+amA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481807; c=relaxed/simple;
	bh=5gJhlA8pfPQINheeeu5rp7kIhXLRui0bWZjMElhilF0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UXrq4GgmxrB6oW6zEl+UrDgLDMNeehFN50mf9eV2kZ97mMJhbBAjGll2iLwmzJz6TbbjNXfNhiuAy9w9/gv9KNvQWMc32pe/ZcBD/9jPlEerXbzrgc4zxqGJn7F3YhAz28D9HcxVHNYtpd3ce8+YIvCYPGu/6SxtIJogNB6TLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UXnBqvxz; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UXnBqvxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786481805;
	bh=ZaZzxBpCPicPXShCcguo/BxdPZEnHnv1z/zszXOMWI0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UXnBqvxz/5ncX9gSkSswYFdxcrztny8/SFZ3EYikEPQLqp2TvW7NzZX+6CUd/Q20l
	 6QrVqM8f34gnyg5BubUpzVh6YcXp53VDsxvrc4SfvZ7qYmbwYYpwYGLOGd0JMrleaS
	 BJmtRj9SkHiUo+UkjG2hIgatdKH7lBBAHOTvk+R8=
Received: from github.com (hubbernetes-node-18da2dc.va3-iad.github.net [10.48.73.109])
	by smtp.github.com (Postfix) with ESMTPA id 7903B501822
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 13:56:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:56:45 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/690c16-10df0b@github.com>
Subject: [bluez/bluez] 45747c: tools/l2cap-tester: add tests changing
 BT_SECURITY...
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
  Commit: 45747c6d0c853e1d711f24d1e7dc85a99d085925
      https://github.com/bluez/bluez/commit/45747c6d0c853e1d711f24d1e7dc85a99d085925
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: add tests changing BT_SECURITY after connecting

Add tests that change BT_SECURITY value after connection established:

L2CAP BR/EDR Client PIN Code Change Sec - Success
L2CAP LE Client Change Sec - Success
L2CAP LE ATT Client Change Sec  - Success
L2CAP LE EATT Client Change Sec - Success


  Commit: ea77a7229c76a88e348c502a66ce500278cfa868
      https://github.com/bluez/bluez/commit/ea77a7229c76a88e348c502a66ce500278cfa868
  Author: z4pdy <305461556+z4pdy@users.noreply.github.com>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Avoid scan prompt when discovery is already active

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.

Changes in v2:
- Move variable declarations to the beginning of cmd_connect()
to fix the ISO C90 build failure.


  Commit: 10df0bb748449ba00ffe04fc4d77f4d287b97161
      https://github.com/bluez/bluez/commit/10df0bb748449ba00ffe04fc4d77f4d287b97161
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    M emulator/main.c
    M emulator/server.c
    M emulator/server.h

  Log Message:
  -----------
  emulator: btvirt: support debug for -s socket server

Support btdev debug -d when using socket server -s.

$ btvirt -d -s
Bluetooth emulator ver 5.87
Request for /tmp/bt-server-bredrle
bredrle: host10: > 01 01 10 00                                      ....
bredrle: host10: command 0x1001
bredrle: host10: event 0x0e opcode 0x1001
...


Compare: https://github.com/bluez/bluez/compare/690c16df6067...10df0bb74844

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
