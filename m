Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB4265CBE
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381833; cv=none; b=CmCKz7E7eby+ylNPUO6El0R569Qc+FmxI8alVjsRdt+JD/krRsuHwDcPnRJQ0BM8CIm/ULwA7Qnbjj+IaEPCiXodQDw66GB9EmOPSI9iolzzlO6zp+Ejmq//UaNmFF4cug0xx6yG/GUtEWUZ0tSuUvH/wTibRzJ4Id7mZS+dtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381833; c=relaxed/simple;
	bh=YLIhPlDnRJFm+kKft2me5r3ihgoa9zmwK9RdgoSrg5o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SGGe49PzkOdzV7bNmYpujBv3T24Yh5ahHT+0+XqGOGt5Yhgj8csuZiA00+CtI37bIQt4fD00soxRpAkifgSvd198jRoEZpWnq+O4EaGT+9XYGU3c/eB1cbVnZl0kaaLCPTRnH9vgT2Hn7wGMhTN1R5napFH5HJiIsNzWfldEH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KR+wFQBL; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KR+wFQBL"
Received: from github.com (hubbernetes-node-006a804.va3-iad.github.net [10.48.206.56])
	by smtp.github.com (Postfix) with ESMTPA id A272E4E0413
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765381830;
	bh=Z3/WrSfi0kUFFRmusibKO0hbkdbCE9iUnQyG3N70yDA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KR+wFQBLlJeKYfd76gG8/KEyLG5s1j5PN2EZIHXNZn67n5rMWFgVYQFlZUNTICu+B
	 HkvpiuIVobndbVGyO3Q790DB3qvp8IsuCzJy93sJyxK+H/mdJUvRZgqkWmsPbmca08
	 0r9xlvY2qTu5jSoy6v/JjnOvBgvaej29tkzs8qcI=
Date: Wed, 10 Dec 2025 07:50:30 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032038/000000-d1aa17@github.com>
Subject: [bluez/bluez] ccd89a: shared/mcp: support multiple MCP, and add
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

  Branch: refs/heads/1032038
  Home:   https://github.com/bluez/bluez
  Commit: ccd89a3cf1a99f41657a93cfbd9f6ee49a12aa11
      https://github.com/bluez/bluez/commit/ccd89a3cf1a99f41657a93cfbd9f6ee49a12aa11
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


  Commit: 608b3ab6488e99de18e535b395a098425b8b7050
      https://github.com/bluez/bluez/commit/608b3ab6488e99de18e535b395a098425b8b7050
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


  Commit: 13dce720dc4864f337b91fa1fdeb204695c58055
      https://github.com/bluez/bluez/commit/13dce720dc4864f337b91fa1fdeb204695c58055
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: adapt to new MCP API to support multiple remote MCS services

Rewrite to use the new shared/mcp API, adding support for multiple MCS
services on the remote side.


  Commit: 3142def64ace65b4048f38707bc2c519d26f1fcc
      https://github.com/bluez/bluez/commit/3142def64ace65b4048f38707bc2c519d26f1fcc
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


  Commit: 56b242bc36bf8dc80aba38a6bb8f7f8fef678ca7
      https://github.com/bluez/bluez/commit/56b242bc36bf8dc80aba38a6bb8f7f8fef678ca7
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


  Commit: e62af835d801a062e0e376c21eefb8dd3ec72d1c
      https://github.com/bluez/bluez/commit/e62af835d801a062e0e376c21eefb8dd3ec72d1c
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


  Commit: d1aa1777bfe14193aab7aa0e05e581d33bd545a4
      https://github.com/bluez/bluez/commit/d1aa1777bfe14193aab7aa0e05e581d33bd545a4
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


Compare: https://github.com/bluez/bluez/compare/ccd89a3cf1a9%5E...d1aa1777bfe1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
