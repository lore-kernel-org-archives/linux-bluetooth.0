Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E762F6194
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578875; cv=none; b=TF9/hnN1iq2D0L1nvI1NmwWMT0PJaO3CDllJ7Mf8p2+yKxqIh1M5ONHzBXfoOneewUyi/Ml1ZxC5KbRh0OIbj9FtY8sk5k/XjnsVnGgzHdmVnzh6+EhNX0tb2seoLjMgmpLRnuAM3ZWj6A+UUkTz3FTB+x1QacjfL/SpsS/i8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578875; c=relaxed/simple;
	bh=4ZP570R5vmJzjOhD4gVfgRSV/eL+AxpDdpoWsS5vdNw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VbRQFa0RlA49Vh7dHwj3AKopTcYHERz8yYIfTlcOSKrENmv7o25eheZkMgn7sXcMckzmYrEp162WFroEfhxAOyyOl01sXn4NSouJR2XsPmaIChFR3Aegr9SZbbDPCFqv6MtotCN0aNa5dyvQAeXzHBe7cjNpkFo5mrS5Nb4DZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IaSI0y9Q; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IaSI0y9Q"
Received: from github.com (hubbernetes-node-8a5d584.ash1-iad.github.net [10.56.157.33])
	by smtp.github.com (Postfix) with ESMTPA id 697A16010CC
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764578873;
	bh=S9O0yyaoUu0GSAsU2G+kIEh/T3cMcZ8WIT9SO2im3z4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IaSI0y9QCCwQvBv5oMvdbkqvTFlD4vIi4tfklcBim3TaQtj8Upn6wOf5MDXCsW69A
	 1dNqqIZ376P31uA0KnqgHQkog5slteUCODKrmNuNeO8KpgHyqlxdbwCE9wGosRq+If
	 C4Ie3XzoduOsWQuH5ZmIBUVvQqf7OWj9Ml5oxKHU=
Date: Mon, 01 Dec 2025 00:47:53 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029135/000000-c5ee3f@github.com>
Subject: [bluez/bluez] d08018: profiles: Add bearer field to btd_profile
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

  Branch: refs/heads/1029135
  Home:   https://github.com/bluez/bluez
  Commit: d080184985deaa6431968d3cfec6f4c231bf546c
      https://github.com/bluez/bluez/commit/d080184985deaa6431968d3cfec6f4c231bf546c
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/asha.c
    M profiles/audio/avrcp.c
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/ccp.c
    M profiles/audio/csip.c
    M profiles/audio/mcp.c
    M profiles/audio/micp.c
    M profiles/audio/vcp.c
    M profiles/battery/battery.c
    M profiles/deviceinfo/deviceinfo.c
    M profiles/gap/gas.c
    M profiles/health/hdp_manager.c
    M profiles/input/hog.c
    M profiles/input/manager.c
    M profiles/midi/midi.c
    M profiles/network/manager.c
    M profiles/scanparam/scan.c
    M src/profile.h

  Log Message:
  -----------
  profiles: Add bearer field to btd_profile

Add bearer filed into btd_profile to indicates which bearer
type this profile belongs to. Thus we can distinct the services
per bearer.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: 04269bd99c8584d3541823022817675144a110b5
      https://github.com/bluez/bluez/commit/04269bd99c8584d3541823022817675144a110b5
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: c5ee3fd377d0634c57d10017afb16c8f3adc804a
      https://github.com/bluez/bluez/commit/c5ee3fd377d0634c57d10017afb16c8f3adc804a
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    A client/bluetoothctl-bredr.rst
    A client/bluetoothctl-le.rst
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add shell cmd for bearer connect/disconnect

This patch adds shell command for bearer connect/disconnect.

Signed-off-by: Ye He <ye.he@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/d080184985de%5E...c5ee3fd377d0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
