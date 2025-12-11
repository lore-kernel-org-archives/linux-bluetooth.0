Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903D224249
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484634; cv=none; b=oo9oiIOb7eSDhA5mSfKL/2V3avF3LSMsm0btvHBfRJgOyR160HgB+gLMGD81TYjzoSnqxSrtfYaNMpbKGuVllc4stJwaMQQ0wZuAKeYk1CZb1vIDSAuGtqCMdFWYimiUySwjzT1dtlpug3sQZ9ReNeIl1R8GfTnIuyyMBTf0rI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484634; c=relaxed/simple;
	bh=n/IlQFd85/tzHeeJNbDQF0h5FmPzYWP4YOywBF487n8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dxz+JgR/2dIA0cn0rgDvJ05o7dcpjplWx1Uv1SrEcKEdkW4NIEhxDWM1c7L7IRsn5s7FydRH9Ly1xIMsG9m1EpjvQQ5t98WxsbHrBTsPY9x5zEqa4DNktFhwz/Z4qhygW87wQycPbyaxtXr4SaRhCoW4NHfwaUt0o0dbAhXKLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C9CWBIxY; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C9CWBIxY"
Received: from github.com (hubbernetes-node-2afa137.ac4-iad.github.net [10.52.83.28])
	by smtp.github.com (Postfix) with ESMTPA id D2E37641307
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765484629;
	bh=tbW/2kcKh1iJ9SToUwcrhf3jY3aJojH9eVZRSn+NJYg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C9CWBIxYAi3fLh7TcdxyraGlyt0EXpV81bFnX31MeBMtnqH0l14EVDsyOY1+iqtD8
	 nuDIQZ5BCXrgTqrvO/r4MONDQsmAqZ57l+NLA0oAHTNJLmB/lEuzYsAKNIzRAfJfqP
	 ytjqwVkOGB3oXAZDgNRbP2Q2Yws7ZQLcNP48qMSE=
Date: Thu, 11 Dec 2025 12:23:49 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032429/000000-dff021@github.com>
Subject: [bluez/bluez] e8851b: shared/mcp: support multiple MCP, and add
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

  Branch: refs/heads/1032429
  Home:   https://github.com/bluez/bluez
  Commit: e8851b5d31c925e746f9e6ebdaf3248d540761a4
      https://github.com/bluez/bluez/commit/e8851b5d31c925e746f9e6ebdaf3248d540761a4
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


  Commit: 66abaf958d7c5d4a3bd32b8aedbf04c1df331f02
      https://github.com/bluez/bluez/commit/66abaf958d7c5d4a3bd32b8aedbf04c1df331f02
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


  Commit: 941ba3bc5cfa5810adc318d96955cdf3aaf886b8
      https://github.com/bluez/bluez/commit/941ba3bc5cfa5810adc318d96955cdf3aaf886b8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: adapt to new MCP API to support multiple remote MCS services

Rewrite to use the new shared/mcp API, adding support for multiple MCS
services on the remote side.


  Commit: f1af45ac2f1fb6b5b3af1fefb076fc1ceedf8766
      https://github.com/bluez/bluez/commit/f1af45ac2f1fb6b5b3af1fefb076fc1ceedf8766
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


  Commit: f9bce93e84044a065136a869149ba96823d1fb65
      https://github.com/bluez/bluez/commit/f9bce93e84044a065136a869149ba96823d1fb65
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: use uinput utilities from src/shared

Make use of the src/shared version of uinput_create() / send_key


  Commit: b8ddf808b883c06648608b09f2a0d5d50decbc5d
      https://github.com/bluez/bluez/commit/b8ddf808b883c06648608b09f2a0d5d50decbc5d
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


  Commit: dff021391e89b2b51a252e5263d1a2d0009709ac
      https://github.com/bluez/bluez/commit/dff021391e89b2b51a252e5263d1a2d0009709ac
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


Compare: https://github.com/bluez/bluez/compare/e8851b5d31c9%5E...dff021391e89

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
