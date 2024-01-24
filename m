Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6403136666
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139866; cv=none; b=ZsV8w5yyFTl+L/APbbFycpDxcNHuUpt9jvWofFgTkvTqn+9Uu870RMDe/oUsIqwZSzyPwBHRFFhfJncAmOyTt6mlyPO7Z1qo4iottKL3vymK6zcLpDgqmOkODRXKi/I0IT3Jk/Cp/ahZ4GvSWYJQFLrphcslUTXRO5KpwRe5PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139866; c=relaxed/simple;
	bh=AOOg0dl+uZW4GfWAD/DTVkausWiBx0RPHyv4va2otSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mie+JvvoMx7xTsNrLTBpS+cOhWvjeuy+O7xDpUkhLXjZzhNwDdPsCCLLEtfZJzfXeuw6teobuCkzzLocbATykuARFdWhai+/JD6ncEhhK91f3KzfVR6Y8FRpV+o9aU758y0lX+d92dJOOeKPBiKAXYgq/hWXyUE4Hd2nJZSs8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGotN99d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGotN99d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63264C433F1;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139866;
	bh=AOOg0dl+uZW4GfWAD/DTVkausWiBx0RPHyv4va2otSk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rGotN99dRyYI0iSESWs/JqrvBNO+UR4s+ZmQSnOIj5zOtNk+iqYn6BwYG1sEPoqBG
	 gpFcLabQoIzFZSSr/4j8d0DGb7WySP6RTIEK4l4BQTXRWyQBgPUjfMPVWI2blIX3R6
	 ZOev/QW5gyWv1U8gZdH5sPQZqm6g/Mg6vYKd9b6R2kT73KSQySQgtCVmkvsKsntYQz
	 rs1RkJB5XrEZRLkt93o01x0ToIKTxcuFMzJNnI0COHjRTi+lLARsCSGtCX+UJkOGXG
	 5shbMqWGyhFWsLYPp1J8Ydj1t/0W02SAvS4dFpl/OD4/RzSPDKUYosQeHbgbNrWHRd
	 kaypEZ+kqwKeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B02C46CD2;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ 0/9] Distribution inspired fixes
Date: Wed, 24 Jan 2024 23:43:54 +0000
Message-Id: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALqgsWUC/x3MQQqAIBBA0avErBN0EIOuEi1Kx5yNhSMRhHdPW
 r7F/y8IFSaBeXih0M3CZ+4w4wA+bfkgxaEbUKPVBq0KLPVU11Z9IlEUg9sndE5jhN5chSI//29
 ZW/sAvKb5lV8AAAA=
To: linux-bluetooth@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>, 
 Rachel Blackman <rachel.blackman@synapse.com>, 
 Sam Lantinga <slouken@libsdl.org>, Bastien Nocera <hadess@hadess.net>, 
 Emil Velikov <emil.velikov@collabora.com>, 
 Nobuhiro Iwamatsu <iwamatsu@debian.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706139864; l=3925;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=AOOg0dl+uZW4GfWAD/DTVkausWiBx0RPHyv4va2otSk=;
 b=QY8O+HQf+nEZmTZ6m0rsjlXngZgOwgKMRBsgdGQqPhofE2MMMcy5tWzYmfmSgV5LTGW01I87l
 Ua5BRs6/01EA3fLAMGloaIvU6DIARcS6jWnstIEqo6P9paiZhxj5wfn
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello team,

This series picks (directly where possible) distro shipped fixes, for
upstream inclusion.

In particular we have:
 - first two patches have been in SteamOS 3 for about 1 year
 - adapter: Remove experimental flag for PowerState - has been shipping
   in Gentoo and Fedora since Dec 2022, at least
 - use /usr/bin/env python3 sheband - Debian inspired
 - remove unused suspend-dummy.c - Debian inspired
 - remove three unused obex plugins/backends - inspired by ^^ removal
 - ship all conf files with --enable-datafiles - Arch, Gentoo, Fedora

Everything apart from the first two, should be dead trivial. I have
little knowledge about the SteamOS inspired fixes, so hopefully
maintainers won't have too many questions there ;-)

As the comment in the last commit says - there's one final batch
(planned) of patches. Allowing for more flexible conf management, akin
to `man sysctl.d`.

Although I will send those out, once most of the existing patches have
landed.

---
Bastien Nocera (1):
      adapter: Remove experimental flag for PowerState

Emil Velikov (6):
      test: consistently use /usr/bin/env python3 shebang
      profiles: remove unused suspend-dummy.c
      obex: remove unused syncevolution plugin
      obex: remove unused mas/messages-tracker impl
      obex: remove phonebook tracker backend
      build: ship all config files with --enable-datafiles

Sam Lantinga (1):
      Return at least the title attribute from player_list_metadata()

Vicki Pfau (1):
      Enable alternate Bluetooth connection modes

 Makefile.am                       |    8 +-
 Makefile.mesh                     |    1 +
 Makefile.obexd                    |    3 +-
 Makefile.plugins                  |    2 -
 configure.ac                      |    6 +-
 obexd/plugins/messages-tracker.c  |  332 --------
 obexd/plugins/phonebook-tracker.c | 1704 -------------------------------------
 obexd/plugins/syncevolution.c     |  470 ----------
 profiles/audio/avrcp.c            |    4 +
 profiles/input/suspend-dummy.c    |  149 ----
 src/adapter.c                     |   49 +-
 src/btd.h                         |    2 +
 src/main.c                        |   66 ++
 src/main.conf                     |    5 +
 test/agent.py                     |    2 +-
 test/example-adv-monitor          |    2 +-
 test/example-advertisement        |    2 +-
 test/example-endpoint             |    2 +-
 test/example-player               |    2 +-
 test/exchange-business-cards      |    2 +-
 test/ftp-client                   |    2 +-
 test/get-managed-objects          |    2 +-
 test/get-obex-capabilities        |    2 +-
 test/list-devices                 |    2 +-
 test/list-folders                 |    2 +-
 test/map-client                   |    2 +-
 test/monitor-bluetooth            |    2 +-
 test/opp-client                   |    2 +-
 test/pbap-client                  |    2 +-
 test/simple-agent                 |    2 +-
 test/simple-endpoint              |    2 +-
 test/simple-obex-agent            |    2 +-
 test/simple-player                |    2 +-
 test/test-adapter                 |    2 +-
 test/test-device                  |    2 +-
 test/test-discovery               |    2 +-
 test/test-gatt-profile            |    2 +-
 test/test-health                  |    2 +-
 test/test-health-sink             |    2 +-
 test/test-hfp                     |    2 +-
 test/test-manager                 |    2 +-
 test/test-nap                     |    2 +-
 test/test-network                 |    2 +-
 test/test-profile                 |    2 +-
 test/test-sap-server              |    2 +-
 45 files changed, 167 insertions(+), 2696 deletions(-)
---
base-commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
change-id: 20240124-disto-patches-efd6b726602f

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

