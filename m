Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648226FA6E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339055; cv=none; b=V8m8jJ3LaRiq9nGXwXAzfbPpKa75QsErh5Yt/e3MvqyvCVsYo68V+tnkf6KpKccR+Q8G1xPtxXJysE6Iy9zU6EZSGzvUj58WiOpk7ecWBqbzhsU3BiY6v2BKk9zFHmu5QUIk9i1A2Aht6eVWmRVG7xJHTRBXyuLeFs187vwc95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339055; c=relaxed/simple;
	bh=JB0jDdJzDw0aXiwGNlCs9iXQeP9ffCU5sWN6HxAwg5Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YyX6KQFif1IoUGFi72giycFAYnDTmDugkzQVVEnB0vpMFFmgtil5gf1QNIY6nCcI7VP52+qmntlO/djPfJDPjb9h8rFN2dihcg3gzstYT2t/qSo3vWvMNjl4BTzSvNF6X8E4ADyyZ+TI6Sm8DpeZDMBvdAX7s9bJpEqbz5YX3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vvwytkww; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vvwytkww"
Received: from github.com (hubbernetes-node-035473a.ash1-iad.github.net [10.56.183.35])
	by smtp.github.com (Postfix) with ESMTPA id 087B11411B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761339053;
	bh=LK0cHbKpiizj4u5KRXfZMmbrTiVZHC6KEeNcfWRxDdg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VvwytkwwnZ+T4IvEWjNdk/SpRekbUVH8MQ5zCN8/Eyka+1Cefc2u3zHOC+sbDYq3O
	 lnzbIV7x5bur4Bdx135AiUhuFDl0a/nX1PiSo4Op7Eu3A2VtuuAofny6a/nVCW5bu9
	 MwapysjjtjFWvjfYJiRlV+NgqrUrR6XW17wXsUxk=
Date: Fri, 24 Oct 2025 13:50:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1015647/000000-89461e@github.com>
Subject: [bluez/bluez] 55d5c6: device: Add initial support for setting
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

  Branch: refs/heads/1015647
  Home:   https://github.com/bluez/bluez
  Commit: 55d5c6e27baaca970f33597d25af6a800fbf4c4d
      https://github.com/bluez/bluez/commit/55d5c6e27baaca970f33597d25af6a800fbf4c4d
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


  Commit: 69584b5219cd4bb491486d87d5df63f24bea218e
      https://github.com/bluez/bluez/commit/69584b5219cd4bb491486d87d5df63f24bea218e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Add support for setting DEVICE_FLAG_PAST

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.


  Commit: 2793bffe349de6166533d22397713ecee1699281
      https://github.com/bluez/bluez/commit/2793bffe349de6166533d22397713ecee1699281
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


  Commit: 82e4e77bdd043b87cc2d45713a9855379c4b2a2c
      https://github.com/bluez/bluez/commit/82e4e77bdd043b87cc2d45713a9855379c4b2a2c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast

bt_bap_attach_broadcast shall call the attach callback just as any
other instance of bt_bap_attach.


  Commit: 50cec1e20463f3bc0177af8a00b21032388e465a
      https://github.com/bluez/bluez/commit/50cec1e20463f3bc0177af8a00b21032388e465a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams

This makes bt_bap_stream_io_get_qos work with broadcast streams.


  Commit: 24e76b0cd8ca987a6d8c3cc5281fb631a3a209ef
      https://github.com/bluez/bluez/commit/24e76b0cd8ca987a6d8c3cc5281fb631a3a209ef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  MediaAssistant: Add Device option to Push

This enables MediaAssistant.Push to work with local broadcast sources.


  Commit: b0b4df71f1e39e8d77fc7e3994689e382bfb4d5b
      https://github.com/bluez/bluez/commit/b0b4df71f1e39e8d77fc7e3994689e382bfb4d5b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M src/gatt-database.c
    M src/gatt-database.h

  Log Message:
  -----------
  gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter

This adds btd_gatt_database_get and btd_gatt_database_get_adapter
that makes it possible to resolve the btd_gatt_database and btd_adapter
respectively when only the gatt_db is available.


  Commit: f8077695368569d7c704bf5df4df42178b56d201
      https://github.com/bluez/bluez/commit/f8077695368569d7c704bf5df4df42178b56d201
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

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


  Commit: d82c2b06fbdb634e99fd958b406a77e6940ab0f6
      https://github.com/bluez/bluez/commit/d82c2b06fbdb634e99fd958b406a77e6940ab0f6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M client/assistant.c
    M client/mgmt.c

  Log Message:
  -----------
  client/assistant: Handle assistant.push to own broadcasts


  Commit: a32478388b7ffb8f518be867db41e34149a612fd
      https://github.com/bluez/bluez/commit/a32478388b7ffb8f518be867db41e34149a612fd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Detect if object already contains a valid BCode

If assistant object already contains a valid (non-zero) BCode
(e.g state=local) use it instead of always request the user to
re-enter.


  Commit: bfcee89cd7fd4db8617b2f6a94f9ac7c64ba00ca
      https://github.com/bluez/bluez/commit/bfcee89cd7fd4db8617b2f6a94f9ac7c64ba00ca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    A client/scripts/broadcast-source-2bis.bt

  Log Message:
  -----------
  client: Add script that setup a broadcast source with 2 BIS

This adds a testing script which setups 2 BIS Broadcast Source, one
for the left and another for right location.


  Commit: 89461ebd0e1f7ed1f207109dbca9f4445b35e6f3
      https://github.com/bluez/bluez/commit/89461ebd0e1f7ed1f207109dbca9f4445b35e6f3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    A client/scripts/broadcast-delegator.bt

  Log Message:
  -----------
  client: Add script for testing Broadcast Delegator

This adds a script for testing Broadcast Delagator role.


Compare: https://github.com/bluez/bluez/compare/55d5c6e27baa%5E...89461ebd0e1f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
