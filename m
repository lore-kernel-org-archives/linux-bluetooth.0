Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02F78F29
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876504; cv=none; b=EBiwe4ouDQmop8Gn2oa4k+2XgZ26XoBLE3powggaczkR/YeR4/NmyJ7DDuZm/Kbyd5s4X8t1CjGp6lEPCTGQExlOMY8z4YBQgl6KoeJaKO7XNEoVnn9h7FUYEUq3P5Cfgf6hf2tXOkDL9fiT9wh/2VQLOTV0TFFUTtAy/3PJnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876504; c=relaxed/simple;
	bh=djTmt1VPEZQob+9xmZyHRR9lWH8tJyYuJqVJSIRHJn8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bPS5yUePG3V+S4nx81tA5ZvEo4gDGZ5EX7MhAnzVpK8BsO2EqAcsFtXxOva+aV5FHlCX3btMUbQQsK1jcMrMkAgD6A8GhbqbrcvIoSTr2qIm+WA5FLjbpn/B+OuMiTJRVb//f0aBiJgh8mM84y2tOjV00sq576J3VMfV1f5D7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RGiY+Ko9; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RGiY+Ko9"
Received: from github.com (hubbernetes-node-3683199.ac4-iad.github.net [10.52.200.84])
	by smtp.github.com (Postfix) with ESMTPA id 9D79B700926
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745876501;
	bh=m2ohPwNENQz20W6TjGGWzVuqCB7tBVYI2PkLAVSOTiM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RGiY+Ko9El5bJYKbldLrGLKfusGohKEWlqqmYWdCm9QxAGtKKpAPjq8mlFGTqakOh
	 0kxncrGS/k9pkttcZ6bPOQq34H5wtDwcCe89i2zvEyA5NDzWnxMOvSCVdIIRGEn+D6
	 9OQnofGct8UbcuqRU/wzsDBIS6hGazRcGqUKGnL8=
Date: Mon, 28 Apr 2025 14:41:41 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f1d167-f96f3b@github.com>
Subject: [bluez/bluez] 2cfc35: hciemu: fix accessing wrong/uninitialized
 variables
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
  Commit: 2cfc3521cdfae78f386ed4a20824bab1d01b3c25
      https://github.com/bluez/bluez/commit/2cfc3521cdfae78f386ed4a20824bab1d01b3c25
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c

  Log Message:
  -----------
  hciemu: fix accessing wrong/uninitialized variables

Fixes: aeeb4fd64adf ("hciemu: set bthost ACL MTU to match btdev")
Fixes: a112d4345771 ("bthost: implement fragmenting to ACL MTU")


  Commit: 9a4c0385a07a0fca13c4eb28dc5aca56175bb1dd
      https://github.com/bluez/bluez/commit/9a4c0385a07a0fca13c4eb28dc5aca56175bb1dd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO

Add tests for obtaining timestamping capabilities via ethtool ioctl:

L2CAP BR/EDR Ethtool Get Ts Info - Success
L2CAP LE Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info No Flowctl - Success
ISO Ethtool Get Ts Info - Success


  Commit: 295ec99499c9061b0b9c1cbfc834b1cc7d7b1290
      https://github.com/bluez/bluez/commit/295ec99499c9061b0b9c1cbfc834b1cc7d7b1290
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix comparison of narrow type with wide type in loop condition

In a loop condition, comparison of a value of a narrow type with a
value of a wide type may result in unexpected behavior if the wider
value is sufficiently large (or small).

Fixes: https://github.com/bluez/bluez/issues/1213


  Commit: 25c23ffca7e6c1aba67ae685ba3fc9060efacd82
      https://github.com/bluez/bluez/commit/25c23ffca7e6c1aba67ae685ba3fc9060efacd82
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Fix comparison of narrow type with wide type in loop condition

In a loop condition, comparison of a value of a narrow type with a
value of a wide type may result in unexpected behavior if the wider
value is sufficiently large (or small).

Fixes: https://github.com/bluez/bluez/issues/1211


  Commit: e18ce6c959a1135b3487ce0a63bea3e319b89a43
      https://github.com/bluez/bluez/commit/e18ce6c959a1135b3487ce0a63bea3e319b89a43
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Fix potentially overflowing call to snprintf

The return value of a call to snprintf is the number of characters that
would have been written to the buffer assuming there was sufficient
space.
In the event that the operation reaches the end of the buffer and more
than one character is discarded, the return value will be greater than
the buffer size.

Fixes: https://github.com/bluez/bluez/issues/1215


  Commit: 51adc109d41a1ada5d8ef0637412a631775a5d70
      https://github.com/bluez/bluez/commit/51adc109d41a1ada5d8ef0637412a631775a5d70
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Fix potentially overflowing call to snprintf

The return value of a call to snprintf is the number of characters that
would have been written to the buffer assuming there was sufficient
space.
In the event that the operation reaches the end of the buffer and more
than one character is discarded, the return value will be greater than
the buffer size.

Fixes: https://github.com/bluez/bluez/issues/1216
Fixes: https://github.com/bluez/bluez/issues/1217
Fixes: https://github.com/bluez/bluez/issues/1218
Fixes: https://github.com/bluez/bluez/issues/1219


  Commit: f96f3b34db40228feb2efb9cc81df92853d0111e
      https://github.com/bluez/bluez/commit/f96f3b34db40228feb2efb9cc81df92853d0111e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Too few arguments to formatting function

Each call to the printf function, or a related function, should include
the number of arguments defined by the format. Passing the function more
arguments than required is harmless (although it may be indicative of
other defects). However, passing the function fewer arguments than are
defined by the format can be a security vulnerability since the function
will process the next item on the stack as the missing arguments.

Fixes: https://github.com/bluez/bluez/issues/1221
Fixes: https://github.com/bluez/bluez/issues/1222


Compare: https://github.com/bluez/bluez/compare/f1d167215935...f96f3b34db40

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
