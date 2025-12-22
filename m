Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF62D0606
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436595; cv=none; b=M2pmWNDprQIcLCMhdEk5m4sexQKhVbKUgQ2YX+g4bs0whBhJGSjrYc782uK8oyX2PuvjQDIjbjgWSMeJgqADTKXUKXJMreruMzLvjhGh0+XUBgkgr4zG+0itCtUz6DWPyxHYLrEwXyLMMYoG+ZiYRA6MxWFIaS60x1az8HjMcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436595; c=relaxed/simple;
	bh=fUgDpuP/h6Sam5qzDFFwAlvWPPwpAEStLMwFZhyOceY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CzHEyxRU9Lbyq2E7XFEoJH2Qjv07Qk7Au3Q3HSVA+mrQKj28p4+3kwjmTtO3/tYT/3AMZb4gDJeKNEDT2i/seTLnDK3ylV5B5ZbL+7I3Vqz4nS3yFNPOg1ShorlT/lXWWKV/kWISqK+HGqra69JEayhDXJWxMY3oRclXWBryXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z2cvuogy; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z2cvuogy"
Received: from github.com (hubbernetes-node-008393c.va3-iad.github.net [10.48.219.13])
	by smtp.github.com (Postfix) with ESMTPA id A1811E0A87
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766436593;
	bh=z19+D5Lzat/UHje/BJd6gAEoC3d29pGrKVpbecM9McQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z2cvuogyYa3t7bKR4BtTpiJ/ClglyAYcSDFNHYWVIORCd7+nZOCoGfxzUrG518G+i
	 FkWPlXjquN8gsDeN2z64jCMrLT92+lPeybjGxTvRfNQB5zTUoXD9OHhzEAlMJiLn6I
	 HMMKAgnBB9ILQKdqXcpows3sKKVwCJ65Wf7nJnkM=
Date: Mon, 22 Dec 2025 12:49:53 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a43170-05813d@github.com>
Subject: [bluez/bluez] a91198: audio/hfp-hf: Add Operator name support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a91198dd5f18bbde518df99428c9bf9befb09ed6
      https://github.com/bluez/bluez/commit/a91198dd5f18bbde518df99428c9b=
f9befb09ed6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add Operator name support


  Commit: 41b37da5e31c73c873feb397e335d6ee922a6fd0
      https://github.com/bluez/bluez/commit/41b37da5e31c73c873feb397e335d=
6ee922a6fd0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add simple call support

This allows to dial, hang-up, answer or reject a call.


  Commit: 684b48b897e64ac7ad8f09227244b7b2695d4725
      https://github.com/bluez/bluez/commit/684b48b897e64ac7ad8f09227244b=
7b2695d4725
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add in-band ringtone flag support

This flags is set by remote phone when it wants to play the ringtone
through the audio channel.


  Commit: fbeb3a96d9f4735f92b6d8cc4a244c29c027dca1
      https://github.com/bluez/bluez/commit/fbeb3a96d9f4735f92b6d8cc4a244=
c29c027dca1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M Makefile.plugins
    A profiles/audio/avrcp-player.c
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  media: decouple local org.bluez.MediaPlayer from AVRCP

The local media player API should be used also for MCP in addition to
AVRCP, but it's currently calling directly into AVRCP.

Invert the API to be DBus player --> hooks, and attach AVRCP to it
allowing multiple backends.

Rename media_player to local_player, to fix the naming conflict with
player.h, which is the API for remote player --> DBus, ie. the inverse
direction.

Don't modify the AVRCP side of the code to these new wrappers, instead
keep the old AVRCP API and use an extra indirection in avrcp-player.c,
which may make it easier to add new features for MCS.


  Commit: 0e73d96c692c456d6f417a5db829744fb92e4adb
      https://github.com/bluez/bluez/commit/0e73d96c692c456d6f417a5db8297=
44fb92e4adb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: expose org.bluez.MediaPlayer information via GMCS

Select one of the local org.bluez.MediaPlayer instances as the "active"
player, and expose its playback controls via GMCS.


  Commit: 05813df5e490ab7a791bf4ec6f49c68142f24688
      https://github.com/bluez/bluez/commit/05813df5e490ab7a791bf4ec6f49c=
68142f24688
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  tools/mpris-proxy: allow selecting which adapter to use

mpris-proxy by default uses the first adapter it sees over DBus.  Add
option for selecting a specific one.


Compare: https://github.com/bluez/bluez/compare/a431702e9ec2...05813df5e4=
90

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
