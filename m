Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C272AD25
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385282; cv=none; b=QGGxlZ4OYkzA0e3gWl4FbLEiCzbT+/q8jyQk+tMXBMrsdpeErq0yBF+DhRMyywlZml5+lIyalq+6CEtDBZD8sZh9601ii8ZJ46DKmWYrPvs9anD1Nw7UNo0GlIQ7jJPIFDHqwyQwrQpqYFbBOoGxxLuej8dL3sqxjXRsdbrONbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385282; c=relaxed/simple;
	bh=Jk+jZmF4V70AZrda6jaRq807zeOo+toayWSrMVwDYxg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XQUt75i2iYSaNYLiBf5ADIC6PHXWUuXZE7aYh7RCW6cAprI15z3ila/EypE5L7N+qll9tSEWyvEFSr+4jaJCEPI0YtBkYUs8A+cwz0oIUMwJJTYvBFiTWFsTdx4g7O9wZ4XCQ55iykJpnGBX90NBJkGwnWfGl7MLUwnEM+YYi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=htWMydwZ; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="htWMydwZ"
Received: from github.com (hubbernetes-node-dbac0ba.va3-iad.github.net [10.48.133.41])
	by smtp.github.com (Postfix) with ESMTPA id 8D7EF4E02FF
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 08:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765385279;
	bh=YuqvNqz83EUsKTvItBbZYTNLpc3WA8n0SJ+POcwGV98=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=htWMydwZksN6fnbOiZmRyDFd1ALaVxcaVAEw/T+VTarWWyDXe2BAXlXt+ExNwWPFp
	 gK3VbfXzMcA9u6Dpf2ZXxxRiPOTjUo4t3mCGrwDweH7Twg2auhbBwfY7hzehlspLES
	 cq4vNul/s3lbyBuqCcALl74mqsiFlbQg5tFftdlM=
Date: Wed, 10 Dec 2025 08:47:59 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032051/000000-1cc4ca@github.com>
Subject: [bluez/bluez] 670409: shared/mcp: support multiple MCP, and add
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

  Branch: refs/heads/1032051
  Home:   https://github.com/bluez/bluez
  Commit: 670409978b0765255e825493a8967c1d0af3afa6
      https://github.com/bluez/bluez/commit/670409978b0765255e825493a8967c1d0af3afa6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

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


  Commit: 72e73a7e02d302a19a4372d8bce6043c55a16000
      https://github.com/bluez/bluez/commit/72e73a7e02d302a19a4372d8bce6043c55a16000
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

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


  Commit: 62c3a3d4d92547be421e309a0c9fc9cc2f2be317
      https://github.com/bluez/bluez/commit/62c3a3d4d92547be421e309a0c9fc9cc2f2be317
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: adapt to new MCP API to support multiple remote MCS services

Rewrite to use the new shared/mcp API, adding support for multiple MCS
services on the remote side.


  Commit: 0bea9d5d4c82a89df921f5ff0f31c73c516b7daf
      https://github.com/bluez/bluez/commit/0bea9d5d4c82a89df921f5ff0f31c73c516b7daf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

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


  Commit: cfae0d0084de619765eebd12299f65cdf6464270
      https://github.com/bluez/bluez/commit/cfae0d0084de619765eebd12299f65cdf6464270
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

  Changed paths:
    M profiles/audio/uinput-util.c

  Log Message:
  -----------
  uinput-util: fix compiler complaint about strncpy usage

Fixes:

profiles/audio/uinput-util.c: In function 'uinput_create':
profiles/audio/uinput-util.c:97:25: error: '__builtin___strncpy_chk'
    output truncated before terminating nul copying as many bytes
    from a string as its length [-Werror=stringop-truncation]
   97 |                         strncpy(dev.name + len, suffix, slen);


  Commit: a24489e7e58a3d827fbb456571315c72ccc9880d
      https://github.com/bluez/bluez/commit/a24489e7e58a3d827fbb456571315c72ccc9880d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

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


  Commit: 1cc4caaab2cef11200ceb3b34f54f6b5fda4b7d9
      https://github.com/bluez/bluez/commit/1cc4caaab2cef11200ceb3b34f54f6b5fda4b7d9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

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


Compare: https://github.com/bluez/bluez/compare/670409978b07%5E...1cc4caaab2ce

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
