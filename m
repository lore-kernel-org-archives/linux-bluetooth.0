Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4863FE37A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340925; cv=none; b=XKCwGbY8KUBeX8gUaEufLyIMR8h0rRb1DQp01iD+++rMTMKrZUMC+mxKSHU9IxlvW/CffzWIlIQmz0Pe1v5fc5qq40EShxG5zGFD3nIWCr0LDzhk90cWmpbDcLK+GIIReHe+FA0v6qLjsPapORKznCmtu35YG8j5ioDhmfS6qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340925; c=relaxed/simple;
	bh=Y367OmfseYGbhiEHSpYgThgsWZklF2zQtd80uIrjKGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QK5ea0oYs5hdFI2iUmcYyvUnoImTsO5vTYZlfSJLdYsFhIRRP6IQ0T+D09qBJulWECcgQbMstWXLzEDyXZbBRpkOdgF9rbc7gyou0gyb7mzv72jRBLJC/uouY8WA1FVQGYazOc5eSuJOXXbKe/yhcaVtWGWOFi5aj5mumHERFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=djV3HoIo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="djV3HoIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787340921;
	bh=Y367OmfseYGbhiEHSpYgThgsWZklF2zQtd80uIrjKGY=;
	h=From:To:Cc:Subject:Date:From;
	b=djV3HoIoU2AoEpwDmSdNlf06JH57+OU72wjFdfnf4m/yHo1oUFx8Y+KmnknJaiBky
	 7s8UElJq1pm7273ZM5j2bBklOSPw41GF1NQ7HLp+muQ2U8b78Sbm/3Y1N9+Zi9HFT4
	 AY4W9vNQ7zPgLZWQfHfNQ2G7lDE2vMuyU7NAeEy3p4Uub7o+0vTYXm9G6DbDFvzC5r
	 h1yymA1ol0/D4HpzGwTkYAp7P2jET0H8pNl0GcapbdP/FNzAoK2E/TXnSKaWUBah93
	 K0EyrGmmpy2QEaZ5gn6F8oy9vPd3/aQsIMdr/14m+waWx9xtLnKvjzAsia0IWeX4Hn
	 2zDTBeo8HQMLw==
Received: from vninja (unknown [100.64.1.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gkiagia)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DAD3917E080A;
	Fri, 21 Aug 2026 21:35:20 +0200 (CEST)
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: George Kiagiadakis <george.kiagiadakis@collabora.com>
Subject: [PATCH BlueZ 0/5] player: Fix crash and related defects around the pending request
Date: Fri, 21 Aug 2026 22:34:44 +0300
Message-ID: <20260821193449.1336263-1-george.kiagiadakis@collabora.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A player that advertises the AVRCP NowPlaying feature bit but not the
Browsing bit exports playable MediaItem1 objects while the player scope
is still unset, and calling org.bluez.MediaItem1.Play() on one of them
crashes bluetoothd with a NULL dereference at offset 0x28.

media_item_play() dereferences mp->scope, which is only ever set from
SetBrowsedPlayer or ChangeFolder, and both are reached only when the
player advertises Browsing (features[7] & 0x08). The /NowPlaying folder
and its playable items are gated on a different bit (features[8] &
0x02), so the two can disagree. msg sits at offset 40 in struct
media_folder on LP64, which is the reported fault address.

Patch 1 fixes the crash. A plain NULL check is not enough, because the
pending message would then have nowhere to live and Play() would answer
nothing at all rather than crash. The pending request moves from struct
media_folder to struct media_player instead. Every user already stored
into mp->scope->msg, so the slot was per player in all but name, and the
mutual exclusion between ListItems, Search, ChangeFolder and Play is
preserved. The move also fixes a lost reply, since each completion
re-read mp->scope and found a different folder whenever avrcp moved the
scope while a request was in flight.

Patches 2 to 4 are further defects in the same area, found while
auditing the ownership of that message:

  - destroying a player dropped the pending request without answering
    it, so the caller waited out its D-Bus timeout on every AVRCP
    disconnect;

  - NumberOfItems has not been refreshed on SetBrowsedPlayer since
    f17d3a2c3, because a guard swallows the property update that
    commit deferred into the completion;

  - a busy Search() reports EINVAL where its three siblings report
    EBUSY.

Patch 5 adds unit/test-media-player, which drives the D-Bus surface of
profiles/audio/player.c over a private session bus. Against the tree
before this series, three of its nine tests crash and three fail.

Each patch builds and passes make check on its own. The final tree
passes 39/39 and is clean under valgrind.

George Kiagiadakis (5):
  player: Fix crash on MediaItem1.Play() without a browsing scope
  player: Answer pending request when the player is destroyed
  player: Fix NumberOfItems never being updated on SetBrowsedPlayer
  player: Report EBUSY from a busy Search()
  unit/test-media-player: Add media player tests

 .gitignore               |   1 +
 Makefile.am              |  13 +
 profiles/audio/player.c  |  80 ++--
 unit/test-media-player.c | 838 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 891 insertions(+), 41 deletions(-)
 create mode 100644 unit/test-media-player.c


base-commit: c73fa2f9ae2d366cb8a4f101fa9a5ccd9f33a4ea
-- 
2.54.0 (Apple Git-157)

