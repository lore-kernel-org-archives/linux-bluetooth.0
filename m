Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFB3C1979
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437215; cv=none; b=R/tOtACcqzwI6g67nDo05dvJePYCdHGjRe4sSicSzrDQBO2Q7Df2NaHfTvcxxGupKH2fckk8Xh8AJOFUrtTdlpgeP2jgLG2NFvNE+mEblD5v3YkfDMaPZwvLRgfwpUb57wh0SC2CvOc8M00SKr97aqqHuq9u7CowYSP8yDqQ24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437215; c=relaxed/simple;
	bh=sLE8xKFqVbhzMcusxjk0ET4MTvRJPjxEN4YkjeP9yC4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZwrW9jQcSbuBDPoYNGIPDly2C456hRI0YPDrxs5aF8KdCe8v31VOAphhNQvyuzjwgqxzAEur9n3HHtYmIq5o0WB/3jdAmxPiBcHe7ikYM2Kr+TmX3H8swSYMGePQqSfD5nmljcNTOoONA71xvC9ecTAjGuWpkz5/MxzcpKmWams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L5LE5shl; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L5LE5shl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776437212;
	bh=XjZqjTszRV1LXwZpoiijn76WxvyRTOAg+f1ViCnwk1M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L5LE5shlERDdb5i8hYrHr7aX9rbMHWdnjdWJgn9INQagzt+OGtXQCHe5MBXNNFu+J
	 t+xT+MSA7mYeqhUVgHDh7xGmHH78nGxFcEJWh4bhxGPNKbi+WBpvlLDE5fZ/2Rp5OR
	 gZoEALmkP36cz1yphpnmg2zJlZyVPWN2GUZWnzTA=
Received: from github.com (hubbernetes-node-c724ed7.ac4-iad.github.net [10.52.144.42])
	by smtp.github.com (Postfix) with ESMTPA id 4CD513226AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 07:46:52 -0700 (PDT)
Date: Fri, 17 Apr 2026 07:46:52 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082537/000000-a21fe5@github.com>
Subject: [bluez/bluez] db8ef0: shared: rap: Introduce Channel Sounding HCI raw
 in...
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

  Branch: refs/heads/1082537
  Home:   https://github.com/bluez/bluez
  Commit: db8ef020111ac38bc5988e8a46b4098b658ccaa3
      https://github.com/bluez/bluez/commit/db8ef020111ac38bc5988e8a46b4098b658ccaa3
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Introduce Channel Sounding HCI raw interface support

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP


  Commit: 070614bd6763509b554393c59ccf90416dfa8572
      https://github.com/bluez/bluez/commit/070614bd6763509b554393c59ccf90416dfa8572
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M src/bluetooth.service.in
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add Channel Sounding config parsing support

Add support for parsing Channel Sounding (CS) configuration options
from the configuration file.

Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
when running under a constrained systemd capability bounding set


  Commit: a21fe52c0ed65f192d0bf8ca637233f6db3c9acc
      https://github.com/bluez/bluez/commit/a21fe52c0ed65f192d0bf8ca637233f6db3c9acc
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M Makefile.plugins
    M profiles/ranging/rap.c
    A profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add HCI LE Event Handling in Reflector role

Open RAW HCI Channel for CS Event Handling
Parse the following HCI LE CS Events in reflector role
and route the events to RAP Profile.
 1. HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE
 2. HCI_EVT_LE_CS_CONFIG_COMPLETE
 3. HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE
 4. HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE
 5. HCI_EVT_LE_CS_SUBEVENT_RESULT
 6. HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE
Send HCI_OP_LE_CS_SET_DEFAULT_SETTINGS to the controller
with default settings selected by the user.
Map connection handle received to device connection


Compare: https://github.com/bluez/bluez/compare/db8ef020111a%5E...a21fe52c0ed6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
