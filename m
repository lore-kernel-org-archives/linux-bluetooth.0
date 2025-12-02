Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4723F9C5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686434; cv=none; b=YWQWbki+moAGG6tJwnWHEBzT+A1QRgRES+OH76uivy7jVE+GIN5crjRBjYHJCbNgznpqzo2LNlQU+6oOjKpUpdqmJRoqCEHU1WbLgSCXR4n/b2zIfK2fT9nqQmJC0Ge85vc+OA8dwjz+umixWe+yQLGgqkfdX+ssZfTQ94WUZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686434; c=relaxed/simple;
	bh=Z0o27eRG6WIfrxyuuUUB0NbzF4a2oK6+vNk2UfeX0hU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DuIdamuBDFtkudCYSkz4S/Ml/LKw19qDETFFeU0pr+z/TINvCRhVV46tuY3eLUy0pTX1gnIRAmR8/D6Y4+G46mray4FdGfHohSPCA7Tl+4aOSxUhtiUnvD7xv8twAcZELBohynvdaEhfZSr3Y5HuE+FFD4D4qYZH5Ape139Iee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KGujn76Z; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KGujn76Z"
Received: from github.com (hubbernetes-node-e6b2b04.ac4-iad.github.net [10.52.220.37])
	by smtp.github.com (Postfix) with ESMTPA id 4357220927
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 06:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764686432;
	bh=x53siS0b3QnicxIZQJ87WH9LwgFHFCLXcrxD0+lYp7g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KGujn76ZwMYPbnVBHoL8CHgQHs1RAPCi5dTffxjhCcwyP5EFqYPDJBNUXdnDpZYgo
	 K1emY46ldFfwFbwUPOfizHaLYHHBl4OeH/IPIwxx+Kv4Nn4R6pAgNBfSUVt51jwZyp
	 Wv9fgOnh3AH2YJjECRYqrIL+EuCTFec7lvE8V5jo=
Date: Tue, 02 Dec 2025 06:40:32 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/71a3aa-9a97ad@github.com>
Subject: [bluez/bluez] e898a6: main: Fix wrong option name in LE options array
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
  Commit: e898a615cf5262c51737541c9262fd3692521726
      https://github.com/bluez/bluez/commit/e898a615cf5262c51737541c9262fd3692521726
  Author: Hermes Zhang <chenhuiz@axis.com>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix wrong option name in LE options array

Correct the name of "AdvMonitoring" to "AdvMonitor" for consistency
with Bluetooth Low Energy (LE) terminology in the le_options array.

- ScanIntervalAdvMonitoring -> ScanIntervalAdvMonitor
- ScanWindowAdvMonitoring -> ScanWindowAdvMonitor

This will remove the confuse warning message:

bluetoothd[973]: ... /main.c:check_options() Unknown key ScanIntervalAdvMonitor for group LE in /etc/bluetooth/main.conf
bluetoothd[973]: ... /main.c:check_options() Unknown key ScanWindowAdvMonitor for group LE in /etc/bluetooth/main.conf


  Commit: 6b9d8c38844244fe160b138f96ce80644d553861
      https://github.com/bluez/bluez/commit/6b9d8c38844244fe160b138f96ce80644d553861
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Print MediaEndpoint.SupportedFeatures

This makes command endpoint.show print the MediaEndpoint interface
property SupportedFeatures.


  Commit: 1d0655882d26e223f35e9fa3fd423f046ece0972
      https://github.com/bluez/bluez/commit/1d0655882d26e223f35e9fa3fd423f046ece0972
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add timeout / close during connection tests

Add tests for connect timeout behavior and kernel corner cases:

eSCO CVSD - Timeout
eSCO CVSD - Close


  Commit: 2769a919ebd420a62679a47bfda1f00cc2f39ebb
      https://github.com/bluez/bluez/commit/2769a919ebd420a62679a47bfda1f00cc2f39ebb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: implement Sync Conn Accept/Reject flow

Send HCI Connection Request properly for Setup Synchronous Connection,
instead of proceeding to Connection Complete immediately.

See Core v6.1 Vol 2 Part F Sec 5


  Commit: 85888a8357eac652c1760da888ac68d0417f0e89
      https://github.com/bluez/bluez/commit/85888a8357eac652c1760da888ac68d0417f0e89
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: add bthost_setup_sco() and accept incoming eSCO

Add support for bthost initiating SCO connections and accepting eSCO
ones with BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST.


  Commit: 9a97ad574642259a1b2b9b781477cd97358bc3ae
      https://github.com/bluez/bluez/commit/9a97ad574642259a1b2b9b781477cd97358bc3ae
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add socket listen tests

Add basic SCO server tests:

SCO CVSD Listen - Success
SCO CVSD Listen Defer - Success
SCO CVSD Listen Recv - Success
SCO CVSD Listen Send - Success


Compare: https://github.com/bluez/bluez/compare/71a3aa554f4f...9a97ad574642

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
