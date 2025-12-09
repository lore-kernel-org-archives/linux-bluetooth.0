Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74901D27B6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315887; cv=none; b=uUvbusbM/k5hAqJXB1o+CuMUv8BQAUvY27JJ2U/EZktCc47sbZPaKW8GDH4XucQeSuz/LF/LPFu1hVWTSjHb8bZdYaeS3zqmzDyfqVbzXm2Ra2ZJXjFKbaFhgCfnKnZcvwxH/hxsGZ2xLZmTrnATFDtgVKM9NZayG7kXkHHcbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315887; c=relaxed/simple;
	bh=S54vw7uSmKlucP6QGtJTUnI1ofQH949A1dsYtO1088I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=evFDLq96ilvWuCU4AOBW+264XQjkmPaIKbAyULkp8E54QyznlrWyTjF5dkRZFxueqiBmYVsKP9jPpgLvpOIlJ5WPUvMDf+QWhRk9+fo83BkgkTwHbeRsXvlyGblclJaNnURB90cv5g92Hf9VLCPPlk7O0wt1H2cy96QFBXJI+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W7Z5UeJD; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W7Z5UeJD"
Received: from github.com (hubbernetes-node-cd1727b.ash1-iad.github.net [10.56.191.38])
	by smtp.github.com (Postfix) with ESMTPA id 0E85A9210FF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 13:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765315885;
	bh=vRieM+u8arkwY9K7HKnfQ0XRTHqPdcfBwkOYNga7rDI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W7Z5UeJDk0wcdqQ1rme6K627y7pl8Bm0Jai8Oj2BsO+ONMxD1QKnfsqD8ITQHrtXw
	 A9uDO+whbkvwpIraY/aBuLu2h5Ht4MEB+Tf/0pyN3h5iHn8O/W+5rHGaO61HpoFNuK
	 +VE5PDl392pI83bCUW5YypEu6oWf8fExWKdYRhVk=
Date: Tue, 09 Dec 2025 13:31:25 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031829/000000-c626e4@github.com>
Subject: [bluez/bluez] c86662: shared/mcp: support multiple MCP, and add
 non-stub...
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

  Branch: refs/heads/1031829
  Home:   https://github.com/bluez/bluez
  Commit: c86662d9b9ebcb92e5ccd47886bf7c10829eea2e
      https://github.com/bluez/bluez/commit/c86662d9b9ebcb92e5ccd47886bf7c10829eea2e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M lib/bluetooth/uuid.h
    M src/shared/mcp.c
    M src/shared/mcp.h
    M src/shared/mcs.h

  Log Message:
  -----------
  shared/mcp: support multiple MCP, and add non-stub MCS server

For Media Control Client, add support for multiple GMCS / MCS services
on the server. Revise the API accordingly.

For Media Control Server, make it a complete implementation (OTS still
missing), and add an API the profile can use.

This is mostly a complete rewrite.


  Commit: de14e8d57a77c1c4262a19c3ad4551be79f54d19
      https://github.com/bluez/bluez/commit/de14e8d57a77c1c4262a19c3ad4551be79f54d19
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: add tests for MCP / MCS

Add tests for the Media Control Client / Server implementation.

This contains basic GGIT and state transition tests.  Not all state
transition tests are here, as they'd largely test the upper layer of the
profile which is not tested now.


  Commit: 7774e6b0e50b4d99a0f87ca6fff1384175372686
      https://github.com/bluez/bluez/commit/7774e6b0e50b4d99a0f87ca6fff1384175372686
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: adapt to new MCP API to support multiple remote MCS services

Rewrite to use the new shared/mcp API, adding support for multiple MCS
services on the remote side.


  Commit: adcf919c4dcef9012d771bb8caaf5a37e2af91ab
      https://github.com/bluez/bluez/commit/adcf919c4dcef9012d771bb8caaf5a37e2af91ab
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/avctp.c
    A profiles/audio/uinput-util.c
    A profiles/audio/uinput-util.h

  Log Message:
  -----------
  avctp: move uinput utilities to uinput-util.c

Move basic uinput utilities to a separate file, so they can be reused
for MCS.


  Commit: 95b460cf16efa4b1302e0084a893fe306c4b57cf
      https://github.com/bluez/bluez/commit/95b460cf16efa4b1302e0084a893fe306c4b57cf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: add local GMCS service that emits uinput media keys

Implement simple GMCS service that is always inactive, and emits media
key presses via uinput for Play/Pause/Stop/Next/Prev MCS commands.

In practice, this seems to be enough to support media control keys on
headsets.  Some headsets (Creative Zen Hybrid Pro) also refuse to
connect if there is no GMCS service.


  Commit: c626e4c9ee969e04ed25f924d21a9bc340dc302b
      https://github.com/bluez/bluez/commit/c626e4c9ee969e04ed25f924d21a9bc340dc302b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

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
    #3 0x000000458367 in bt_gatt_client_register_notify src/shared/gatt-client.c:3685
    #4 0x00000049f9f5 in foreach_mcs_char src/shared/mcp.c:1834


Compare: https://github.com/bluez/bluez/compare/c86662d9b9eb%5E...c626e4c9ee96

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
