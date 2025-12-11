Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7682C21DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765480905; cv=none; b=YIH/R0QWNZwByiQOmUMJI1vIgkhv7qDWzDc6oT81xX2PXYBjE68O1dLKMBc7lZE+6jgvbvsF13mJ3xzFPRzAXoKp7mX+La5y5a2NG/PFEdPhphmDmb4/r5BL4jxjgPrHn0J7fBZargtj4DasX2UFwTKPU6gxpP0shsyayO6j738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765480905; c=relaxed/simple;
	bh=1ZVSm4ZTdetCFxwRkM0sMOIn7LiFoZW4MaHpjIHsCMs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aWmv95pod5GyCgEU9izul8zGlAETPdF8tWuPN4v6CtgxEEoqoyG5yiIsG2ND7VXDw5VZD11SPHLHapr22EJ7YBdOc3usITanHKqFzmAjKihpqdSsXWOPGOF27S8J7E/IcaWH2CJcu/TLVt7bVzNAhcNCvRrc2acLpHJHrrkeZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LVEUMNdi; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LVEUMNdi"
Received: from github.com (hubbernetes-node-c536fd1.ash1-iad.github.net [10.56.196.56])
	by smtp.github.com (Postfix) with ESMTPA id 6BE7314115A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765480903;
	bh=0i+u6D33Q4zyNMFXt9SDe1WZ4M3aaZJN4KYov+JStr0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LVEUMNdi8Q3Ld5OaesKDwKHOUruAycUD1sdeZsZE2N6AyW813fqRQjfUUR17WRGJg
	 sY4/ftPCRbEcYXpVNH+u9mj+bcCIU1grKlt4KPSU9wsMhQ0qPwp+OeUI+JQl5Cnyw5
	 NGwPTLFevXrTV50sG0QK4YW7jjjKjynaOQ8wJi3s=
Date: Thu, 11 Dec 2025 11:21:43 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032419/000000-09d4c8@github.com>
Subject: [bluez/bluez] 94a144: shared/mcp: support multiple MCP, and add
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

  Branch: refs/heads/1032419
  Home:   https://github.com/bluez/bluez
  Commit: 94a144b57cef796a6a368742b9fad5f0ca41e8cf
      https://github.com/bluez/bluez/commit/94a144b57cef796a6a368742b9fad5f0ca41e8cf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

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


  Commit: 5cd60d675d9eb1789d99d0c7014331fdbf2161af
      https://github.com/bluez/bluez/commit/5cd60d675d9eb1789d99d0c7014331fdbf2161af
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

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


  Commit: ad5d35f325f7348bb4bb7a8ad305b586f4acf1b9
      https://github.com/bluez/bluez/commit/ad5d35f325f7348bb4bb7a8ad305b586f4acf1b9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: adapt to new MCP API to support multiple remote MCS services

Rewrite to use the new shared/mcp API, adding support for multiple MCS
services on the remote side.


  Commit: db05ded2dd3babab03c7744f22da756aa4ce324f
      https://github.com/bluez/bluez/commit/db05ded2dd3babab03c7744f22da756aa4ce324f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.am
    A src/shared/uinput-util.c
    A src/shared/uinput-util.h

  Log Message:
  -----------
  shared/uinput-util: extract uinput utility function from AVCTP

Extract uinput utility function from AVCTP to src/shared so that it can
be reused for MCS.


  Commit: 71abcc1a526dfe9a61dbfc46a18b925d096422b3
      https://github.com/bluez/bluez/commit/71abcc1a526dfe9a61dbfc46a18b925d096422b3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: use uinput utilities from src/shared

Make use of the src/shared version of uinput_create() / send_key


  Commit: ed47309d7708e4e86eb8b4ebe56c3ee00b6271fb
      https://github.com/bluez/bluez/commit/ed47309d7708e4e86eb8b4ebe56c3ee00b6271fb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

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


  Commit: 09d4c824e4897acd3400baecd280ab2b4ecea2f7
      https://github.com/bluez/bluez/commit/09d4c824e4897acd3400baecd280ab2b4ecea2f7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

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


Compare: https://github.com/bluez/bluez/compare/94a144b57cef%5E...09d4c824e489

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
