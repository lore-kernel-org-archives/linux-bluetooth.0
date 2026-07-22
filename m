Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8435C19B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749348; cv=none; b=jbZeu7DJ0xi10A30A7YoXcg7d4ckKYWks6vGdTCHJ4l0Xas1QUUudl5JfoU7FNcuB9zhYuS8aJLk67sbB1pWHBQyI7cYd8emWo9AQ38JV/LI3feUHBrUZH6WwR4PcUdg/Nf+CNwN+5IF6UWAYa93mam3hqf9QkMrxwUwpxOxmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749348; c=relaxed/simple;
	bh=FEnmjSIIZuvj3Dg09UXwalbLSbjJvhnpFhjp2zX75TY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KN2ltoXYpe7e7oj3plVOQwDS2/UVm9uFfcJhkY6d5EpW67RxVe3oM21amQVubSxQiAGEghvL80g0HGgpcSsCdBTplU1jijmgEGgbLlS84FXQKYbAMNAwgjfPGviereWfVL/h6+waq0HypHcJbexXBYBUj8epaZcIFp6AFZIwgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OZ0/7usR; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OZ0/7usR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784749346;
	bh=XPtAb5UN/fJJqbfwaepascPDu6Os7ee3pBdxiIcCU5Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OZ0/7usRZ1MNCmo8c/a9trByxy6v0iOidyniE+VaMF2qnk6lLY9zcUc/hBUFu7BBd
	 FQ2qrO2F9YsHbrdc8Q7+ypa9GLCDpPJQtJp4rD9CphJ/ysfIpfNggAEctimBzgGQfY
	 AbNXBvP5MZE6ahnBIBeLfs0xzP45NUtoRCfy3qXE=
Received: from github.com (hubbernetes-node-8c59d4e.ash1-iad.github.net [10.56.171.43])
	by smtp.github.com (Postfix) with ESMTPA id 163D8921104
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 12:42:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:42:26 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f3f03d-89d477@github.com>
Subject: [bluez/bluez] 679b38: shared: Add create_context CS config parameter
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
  Commit: 679b38459c0ff21728a575ab8629189aa18151b7
      https://github.com/bluez/bluez/commit/679b38459c0ff21728a575ab8629189aa18151b7
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-22 (Wed, 22 Jul 2026)

  Changed paths:
    M src/shared/cs-types.h

  Log Message:
  -----------
  shared: Add create_context CS config parameter

Add create_context in bt_rap_le_cs_config structure


  Commit: 442008ec267b6fb1e7841d66ada12428e7f832ec
      https://github.com/bluez/bluez/commit/442008ec267b6fb1e7841d66ada12428e7f832ec
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-22 (Wed, 22 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: Add create_context param as part of CS Create Config cmd

- Add the create_context field to the CS Create Config command.
- Route HCI command-send failures and non-zero-status completion
events to CS_STATE_HOLD instead of CS_STATE_STOPPED.
reserving CS_STATE_STOPPED for the clean/expected
stop (Procedure Enable Complete with state == 0x00)


  Commit: 1fd9b7de3be4b40186672177c1fbe25bf522012d
      https://github.com/bluez/bluez/commit/1fd9b7de3be4b40186672177c1fbe25bf522012d
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-22 (Wed, 22 Jul 2026)

  Changed paths:
    M client/cs.c
    M client/cs.h

  Log Message:
  -----------
  client: Add create_context CS config parameter

- Add the create_context field to the CS config parameter table so
bluetoothctl can control whether cs.start writes the CS configuration
to the local Controller only (0x00) or to both local and remote
Controllers via the CS Configuration procedure (0x01), matching the
Create_Context field of the LE CS Create Config HCI command
- Change the license in cs.c and cs.h.
- Drop RangingInterface support for now,
as it is still under discussion.


  Commit: 89d477bb5494eef0b24e5667be62f854da250a97
      https://github.com/bluez/bluez/commit/89d477bb5494eef0b24e5667be62f854da250a97
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-22 (Wed, 22 Jul 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc: Document create_context in bluetoothctl-cs.rst

Document the new create_context parameter introduced in client/cs.c.


Compare: https://github.com/bluez/bluez/compare/f3f03d728542...89d477bb5494

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
