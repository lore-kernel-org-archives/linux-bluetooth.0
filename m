Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EA30594F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573165; cv=none; b=ka7uoD2Aae+7eBTGDpWRu1disG7GzNpZPwe6AGdYxn0iiLCvIRCnjhupRCFejMLydUR3imyY+6lszPSZ8D+pusg1+q5fMOR5CPXgSVyXDWwLz0RtgzNzAhdZO4zEvBMXAHgTOyreztxSEoxs8o3bu4o+i4hcmb3HJSSFGWSlpXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573165; c=relaxed/simple;
	bh=x439303KmhXdd4M8gRL01yjH7nXtLBNKZI/vCERZK78=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MMPrgO46TT5vDuJ3nLxQ/774rXQdC9HQ0EqICwNHQgmP5rBo0w83GckruQQMG6EvjUSVY6GSvtZJ7IwaC6cqbc8mLcSRQLvhxwRNnXFAQGyLX1VI1aYaau3MMrwBMXR0SIg02Qw36PYAxGVNFU1CW6cB33KcT9KYzFQ2GYYeY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IosfNPgw; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IosfNPgw"
Received: from github.com (hubbernetes-node-164ef87.ac4-iad.github.net [10.52.208.73])
	by smtp.github.com (Postfix) with ESMTPA id 6DCFB400CB5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761573162;
	bh=7cMWpZ1kOvgpfV3XZMWsSoKwuIBj9XY3xuN8weaVOzc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IosfNPgwGf3lHlMNLR9TLUvu1BaqghLkEHI6FcHpTRPTQRUuBvL3YINRyLffxC8U8
	 20BdjO//KfttbrJV3kD+FqUbl4SU8+ZetXmw738K9ylJKnWp2ULeewh0XWPtoQoL4e
	 rZc/7+KEVLOY57YB9w0joUDGRCLyhxAVIhdCv4m4=
Date: Mon, 27 Oct 2025 06:52:42 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/43aed4-f80a2a@github.com>
Subject: [bluez/bluez] 4fe45c: device: Add initial support for setting
 DEVICE_FLA...
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
  Commit: 4fe45c54895f44cd734332ad3df3c9701c6f84fd
      https://github.com/bluez/bluez/commit/4fe45c54895f44cd734332ad3df3c9701c6f84fd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add initial support for setting DEVICE_FLAG_PAST

This introduces device_set_past_support which can be used by drivers
to indicate that DEVICE_FLAG_PAST shall be changed.


  Commit: a5ceeb414c8694b6a7c9dc8b98ee390b57df1ad7
      https://github.com/bluez/bluez/commit/a5ceeb414c8694b6a7c9dc8b98ee390b57df1ad7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Add support for setting DEVICE_FLAG_PAST

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.


  Commit: 3c67d49258ca60aea6fb2d14932e46efa0f4dba4
      https://github.com/bluez/bluez/commit/3c67d49258ca60aea6fb2d14932e46efa0f4dba4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add bt_bap_get_db

This adds bt_bap_get_db which can be used to access the gatt_db passed
to bt_bap_new.


  Commit: 603ffaf50af110e184db95dcc39507f2495a8a92
      https://github.com/bluez/bluez/commit/603ffaf50af110e184db95dcc39507f2495a8a92
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not calling attach callback on bt_bap_attach_broadcast

bt_bap_attach_broadcast shall call the attach callback just as any
other instance of bt_bap_attach.


  Commit: c560149e1afb362c32dbaa709662e9e6ddabfbaf
      https://github.com/bluez/bluez/commit/c560149e1afb362c32dbaa709662e9e6ddabfbaf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams

This makes bt_bap_stream_io_get_qos work with broadcast streams.


  Commit: 1452790f1489db4f9fb1363dbe8b6fdf3b4d5e6b
      https://github.com/bluez/bluez/commit/1452790f1489db4f9fb1363dbe8b6fdf3b4d5e6b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  MediaAssistant: Add Device option to Push

This enables MediaAssistant.Push to work with local broadcast sources.


  Commit: bde3c34fd7ef72ebdacd4b5489fd72cf493a4084
      https://github.com/bluez/bluez/commit/bde3c34fd7ef72ebdacd4b5489fd72cf493a4084
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M src/gatt-database.c
    M src/gatt-database.h

  Log Message:
  -----------
  gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter

This adds btd_gatt_database_get and btd_gatt_database_get_adapter
that makes it possible to resolve the btd_gatt_database and btd_adapter
respectively when only the gatt_db is available.


  Commit: 10b2a2ff312d3208122bbbbfb510d89db0cf6455
      https://github.com/bluez/bluez/commit/10b2a2ff312d3208122bbbbfb510d89db0cf6455
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  bass: Implement Device option for Push

This implements support for MediaAssistant.Push with local broadcast
sources.


  Commit: 667db9a82a3f8cdc33f50b0301bd2b146ef5cf7f
      https://github.com/bluez/bluez/commit/667db9a82a3f8cdc33f50b0301bd2b146ef5cf7f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M client/assistant.c
    M client/mgmt.c

  Log Message:
  -----------
  client/assistant: Handle assistant.push to own broadcasts


  Commit: fdf49338d97d1b75a8f4434ad8bbf5bf7e75e117
      https://github.com/bluez/bluez/commit/fdf49338d97d1b75a8f4434ad8bbf5bf7e75e117
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Detect if object already contains a valid BCode

If assistant object already contains a valid (non-zero) BCode
(e.g state=local) use it instead of always request the user to
re-enter.


  Commit: e52f05e1d6645ee67e5206cfe6c49a7303200054
      https://github.com/bluez/bluez/commit/e52f05e1d6645ee67e5206cfe6c49a7303200054
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    A client/scripts/broadcast-source-2bis.bt

  Log Message:
  -----------
  client: Add script that setup a broadcast source with 2 BIS

This adds a testing script which setups 2 BIS Broadcast Source, one
for the left and another for right location.


  Commit: f80a2a57c910c0530632d2caa2dba559d0f7f63c
      https://github.com/bluez/bluez/commit/f80a2a57c910c0530632d2caa2dba559d0f7f63c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    A client/scripts/broadcast-delegator.bt

  Log Message:
  -----------
  client: Add script for testing Broadcast Delegator

This adds a script for testing Broadcast Delagator role.


Compare: https://github.com/bluez/bluez/compare/43aed48c30da...f80a2a57c910

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
