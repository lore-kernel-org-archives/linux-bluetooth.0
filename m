Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAB2DF3F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649139; cv=none; b=jjrkFMP/cWn0y0CV6KW7NGA/d1qMCQZ4NxqpgwUFOJ1s9oWwiIcp/deYrI+pbLD0kiMf9znW9wKYJKryFnEFhhfHM5Bq0E+OTau55KwjsOB6pjtGFu0dB5SHY52u7ClIv3zqeQ4C5c0pAvJgx09itVP06KAx2rR0jhz5fw5YmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649139; c=relaxed/simple;
	bh=T33C6KzLFon+MsxJzNsx2RmpUwBUOWR2JzRKQJnL8DY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WFGRaYO6taL7jLZlVNXNcHOEHsdr5nETysyf8+NsTFVWXDCLkLOWXDFiK26OjSbhqw9kRBDLT7tLp3IbOQEvr9BeOFmbnpjx4AZbxtHj2eusLkT8N/Mgfyx8yeYbu5QA0Rw3OCfmHrUz6oU18eRX11J74Szb6beLjC57gm1eHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G+jDlyNY; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G+jDlyNY"
Received: from github.com (hubbernetes-node-756baa6.ash1-iad.github.net [10.56.203.102])
	by smtp.github.com (Postfix) with ESMTPA id 5CFA1141227
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760649136;
	bh=YdeN1X//BpmpoZ8UuGtZzpTujBC8KmkLXJj8BDXpmm4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G+jDlyNYB/xqgKyKWA8IiyoqoPjd3gO3J9kxuCDyR8UFO4TC4nzTVj8fs6MkxW8DE
	 FyFIC6Gv0nboGC7qFy1qzljqblCjTRto8rFmDCXFzy9DWVGfDAHo591O9eBKBWkuEc
	 zpqzcXVZJdc6TBjRbPdnBLgFQL84RAM+Re+H9P4E=
Date: Thu, 16 Oct 2025 14:12:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1012546/000000-d7308c@github.com>
Subject: [bluez/bluez] c91e5e: bass: Only attach client if initiator
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

  Branch: refs/heads/1012546
  Home:   https://github.com/bluez/bluez
  Commit: c91e5eddac1093350c4ea3e93314c5267c5815d0
      https://github.com/bluez/bluez/commit/c91e5eddac1093350c4ea3e93314c5267c5815d0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Only attach client if initiator

This makes calling to bt_bass_attach conditional to being the initiator
of the connection, otherwise both device may act as both roles which is
not recommended.


  Commit: 4b7caecbf17274b28aebea4f94deae4f28229ced
      https://github.com/bluez/bluez/commit/4b7caecbf17274b28aebea4f94deae4f28229ced
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

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


  Commit: cbeb7c22cb6ae21cff930afd96b0e4a9980d5985
      https://github.com/bluez/bluez/commit/cbeb7c22cb6ae21cff930afd96b0e4a9980d5985
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Add support for setting DEVICE_FLAG_PAST

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.


  Commit: 4acd2f4415edfca118599d107ed22837c144fe2b
      https://github.com/bluez/bluez/commit/4acd2f4415edfca118599d107ed22837c144fe2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  MediaAssistant: Add Device option to Push

This enables MediaAssistant.Push to work with local broadcast sources.


  Commit: 7aa408878c4ef42598fad83e62de19c046fbc281
      https://github.com/bluez/bluez/commit/7aa408878c4ef42598fad83e62de19c046fbc281
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add bt_bap_get_db

This adds bt_bap_get_db which can be used to access the gatt_db passed
to bt_bap_new.


  Commit: 57fdafd8e42ae017f30cdb96a1e4c522b7ebfc00
      https://github.com/bluez/bluez/commit/57fdafd8e42ae017f30cdb96a1e4c522b7ebfc00
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast

bt_bap_attach_broadcast shall call the attach callback just as any
other instance of bt_bap_attach.


  Commit: 3c6e247d66224430f4c2d28685b35bc6bff20e48
      https://github.com/bluez/bluez/commit/3c6e247d66224430f4c2d28685b35bc6bff20e48
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams

This makes bt_bap_stream_io_get_qos work with broadcast streams.


  Commit: dd0d6325d045320875b0b375ff586587239240c3
      https://github.com/bluez/bluez/commit/dd0d6325d045320875b0b375ff586587239240c3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M src/gatt-database.c
    M src/gatt-database.h

  Log Message:
  -----------
  gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter

This adds btd_gatt_database_get and btd_gatt_database_get_adapter
that makes it possible to resolve the btd_gatt_database and btd_adapter
respectively when only the gatt_db is available.


  Commit: 87c330033027fc48a97819bb8e8f969a31e3ce5a
      https://github.com/bluez/bluez/commit/87c330033027fc48a97819bb8e8f969a31e3ce5a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

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


  Commit: c06b82bcb778af92fca7d4ff422a735f37c83f3d
      https://github.com/bluez/bluez/commit/c06b82bcb778af92fca7d4ff422a735f37c83f3d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M client/assistant.c
    M client/mgmt.c

  Log Message:
  -----------
  client/assistant: Handle assistant.push to own broadcasts


  Commit: cb54d3f3f3e6ad248c355ce4b253eb668892ff6c
      https://github.com/bluez/bluez/commit/cb54d3f3f3e6ad248c355ce4b253eb668892ff6c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Detect if object already contains a valid BCode

If assistant object already contains a valid (non-zero) BCode
(e.g state=local) use it instead of always request the user to
re-enter.


  Commit: 9fa3423192c477fe117edf9e87215e773ae58be4
      https://github.com/bluez/bluez/commit/9fa3423192c477fe117edf9e87215e773ae58be4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    A client/scripts/broadcast-source-2bis.bt

  Log Message:
  -----------
  client: Add script that setup a broadcast source with 2 BIS

This adds a testing script which setups 2 BIS Broadcast Source, one
for the left and another for right location.


  Commit: d7308c5cc26d63e68bdbab5f9c433d34acc2dee5
      https://github.com/bluez/bluez/commit/d7308c5cc26d63e68bdbab5f9c433d34acc2dee5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    A client/scripts/broadcast-delegator.bt

  Log Message:
  -----------
  client: Add script for testing Broadcast Delegator

This adds a script for testing Broadcast Delagator role.


Compare: https://github.com/bluez/bluez/compare/c91e5eddac10%5E...d7308c5cc26d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
