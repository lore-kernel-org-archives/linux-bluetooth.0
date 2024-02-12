Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05247A70
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=fDtYWDKYSm+CLKqzD3PkoV640J41h+q++eN7ymSz6eKiiDiMNn+v8X7wdhOevsO8kwdB2kfjBqAnVFPHBUV9i6phQjjHH7XamQfCNG2mbQVYheAYUshldJkH8ZjBbc+NC/3OzKnGQcLuaZC3bIIqPwRfiVRbSaslRKD9J/1frn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=lzfrFProzoQf+DY+OgPnU7nG2ioiHDSOCOxKL0Ukrxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MWkXDeVlrsvdaiEnyNfiSsU8JcAnS0nolvAtP20OIZti9KgdA9KKIuAFgDmEpXBfsgW6H4s6pVIO8NdsLF7rCv8OoPHKQ0gY/7ny3O+kbHqMCofbXDm41NsleeJsP2t1R4hIqYP0pv8YHNWgnSMmTVS74zZ2snh9HCHOG3oHhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc+aVY7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc+aVY7I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC617C433C7;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768159;
	bh=lzfrFProzoQf+DY+OgPnU7nG2ioiHDSOCOxKL0Ukrxg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nc+aVY7I+Cnc9Q1h+15aas8SpcItQ/wj1ewwaIe1vp/vaOBnu9Nrcxlb6PLvgq3hj
	 uzRRa9SVd0dJd1mQD4Uuba4zorfKeLrkeRgmBZ9IvGs1n7T5oZY3R64FE+o6nsGp75
	 LUk54kUWCKy/lCmvUNvT8QozqPRyahBgq5A6TFqWihTUycyaa6S16eHw2LA3UGARPW
	 N+KdGKl2N9kRbQVZadkitTDmHEDAoS2+6u2NrTqaqZmGIdMMDhynqB0EiS2HAXJhyM
	 P47AvGs5S/aBkDYeuO1kwdW0Zhl0YD49hiZKPE1C6n9JNeOy4y5fUPXDa71yNC7ieZ
	 rydyQptasm8Tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E71DC48297;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ v2 00/10] Distribution inspired fixes
Date: Mon, 12 Feb 2024 20:02:36 +0000
Message-Id: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFx5ymUC/3WMyw6DIBBFf8XMujQ4VUy76n80LhAGmaQ+Aoa0M
 fx70X2X5+aes0OkwBThUe0QKHHkZS6AlwqM1/NIgm1hQImNrLERluO2iFVvxlMU5KwaOlRKooP
 irIEcf87eqy/sj3f4nvlUH+u/UqqFFPeOJA2twlbfnuOk+X01ywR9zvkHmWKHO6oAAAA=
To: linux-bluetooth@vger.kernel.org
Cc: Sam Lantinga <slouken@libsdl.org>, Bastien Nocera <hadess@hadess.net>, 
 Emil Velikov <emil.velikov@collabora.com>, 
 Nobuhiro Iwamatsu <iwamatsu@debian.org>, 
 Giovanni Campagna <gcampagna-cNUdlRotFMnNLxjTenLetw@public.gmane.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=4885;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=lzfrFProzoQf+DY+OgPnU7nG2ioiHDSOCOxKL0Ukrxg=;
 b=CrbWyQcw0dqUXwwAGoNZG3Ns2RpQDC1i6x9nffdSB8LcqKKnWHB2w+Rkf6J59h4k5fA+2jFCn
 ShCyL1u8+mDCKteKRUUJBR4PCxHyMz2k7Zm4DhCXwdaORoARqV6Ba+E
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello team,

This is v2 of the earlier upstreaming effort, aiming to reduce and in
some cases patches carried by distributions.

Changes in v2:
 - dropped the first patch - no longer applicable with newer kernels
 - fixed bug in phonebook/tracker patch
 - added use glib helper for obex file handling - Gentoo, Debian
 - added obex dbus service w/o systemd - Gentoo, Debian, OpenWRT

In summary, as this series is merged here's the status across distros:
 - Arch - zero patches or hacks needed \o/
 - Gentoo - one hid2hci.rules patch outstanding
 - Fedora - zero patches \o/
 - Debian - some good (hid2hci.rules, typos) patches and some outdated
   (potential infinite loop, gatt PIN segfault) - @iwamatsu can you
   verify which patches are still applicable and send them upstream?
 - OpenWRT - handful of patches

Above said, Gentoo, Fedora, Debian and SteamOS will need more elaborate
config infra, as mentioned before. Patches for that will be sent out
soon (tm).

If you're curious about v1, please follow the link below.
- Link to v1: https://lore.kernel.org/r/20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com

As always feedback is greatly appreciated o/

Thanks
Emil

---
Bastien Nocera (2):
      adapter: Remove experimental flag for PowerState
      obex: Use GLib helper function to manipulate paths

Emil Velikov (6):
      test: consistently use /usr/bin/env python3 shebang
      profiles: remove unused suspend-dummy.c
      obex: remove unused syncevolution plugin
      obex: remove unused mas/messages-tracker impl
      obex: remove phonebook tracker backend
      build: ship all config files with --enable-datafiles

Giovanni Campagna (1):
      Allow using obexd without systemd in the user session

Sam Lantinga (1):
      Return at least the title attribute from player_list_metadata()

 Makefile.am                                        |    8 +-
 Makefile.mesh                                      |    1 +
 Makefile.obexd                                     |    7 +-
 Makefile.plugins                                   |    2 -
 configure.ac                                       |    7 +-
 obexd/plugins/messages-tracker.c                   |  332 ----
 obexd/plugins/phonebook-tracker.c                  | 1704 --------------------
 obexd/plugins/syncevolution.c                      |  470 ------
 obexd/src/manager.c                                |   15 +-
 ...luez.obex.service => org.bluez.obex.service.in} |    2 +-
 profiles/audio/avrcp.c                             |    4 +
 profiles/input/suspend-dummy.c                     |  149 --
 src/adapter.c                                      |    3 +-
 test/agent.py                                      |    2 +-
 test/example-adv-monitor                           |    2 +-
 test/example-advertisement                         |    2 +-
 test/example-endpoint                              |    2 +-
 test/example-player                                |    2 +-
 test/exchange-business-cards                       |    2 +-
 test/ftp-client                                    |    2 +-
 test/get-managed-objects                           |    2 +-
 test/get-obex-capabilities                         |    2 +-
 test/list-devices                                  |    2 +-
 test/list-folders                                  |    2 +-
 test/map-client                                    |    2 +-
 test/monitor-bluetooth                             |    2 +-
 test/opp-client                                    |    2 +-
 test/pbap-client                                   |    2 +-
 test/simple-agent                                  |    2 +-
 test/simple-endpoint                               |    2 +-
 test/simple-obex-agent                             |    2 +-
 test/simple-player                                 |    2 +-
 test/test-adapter                                  |    2 +-
 test/test-device                                   |    2 +-
 test/test-discovery                                |    2 +-
 test/test-gatt-profile                             |    2 +-
 test/test-health                                   |    2 +-
 test/test-health-sink                              |    2 +-
 test/test-hfp                                      |    2 +-
 test/test-manager                                  |    2 +-
 test/test-nap                                      |    2 +-
 test/test-network                                  |    2 +-
 test/test-profile                                  |    2 +-
 test/test-sap-server                               |    2 +-
 44 files changed, 56 insertions(+), 2710 deletions(-)
---
base-commit: c1851987ca2c6e41d1e0e166e959b754e369c254
change-id: 20240124-disto-patches-efd6b726602f

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

