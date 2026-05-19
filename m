Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F92F8EBB
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191286; cv=none; b=TR5eMTn6juLEMNLgn6OjxJVtGLyLjAIh7NX6Zz3d1sNxFfhm/ULB8+7cgYe1/gWQs/VW3sRkynsLDLIm725DPTLLFjTFrUw+CSoSkJ9WZkya7V9BKhDtG/HlN96rJz0An5FjwdfyE4cpW4uTClGYAFS3RIryIbQCLChUS8ATMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191286; c=relaxed/simple;
	bh=gF75hhf9IexcATrrEmP+mRISsrKTTAoVsgo6Ix8fgZk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NqH78gPLSd94BCfuv53Dd9kYrD/Lsm0/alcgqsqOn0pRPiynkl8af8atsSdBGpWVEH8svu0JHxzCcLxoaqDp7NlwevIvUktOn6opnbK2hMWy9ByNJ4Vlkoe3P173SE8Q3LYK7/ptg0mzK7tRzsDR9F64rIWsIHS3DxOgMs5lEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ds48A95N; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ds48A95N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779191284;
	bh=QKaN/MY8gOdxTL1YQSZ8UsAavlbXUJUe73pC2Cto8Vk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ds48A95NVDshN9rd8Y+G/Jqf9c2fOMgSoHAWL8mp3iluBtxclNkkFPcFFSIXd8QoU
	 jy5qU2JZ/VgUxr1bc3sNtFttslBBav43LBNP+GzmgXDGdLOMbBRsk02Z9avYiiD55g
	 +hmtHiXhEODd+9DL8HwvrmvMObmMlgNTwDzmkb1g=
Received: from github.com (hubbernetes-node-e40c59f.ash1-iad.github.net [10.56.147.19])
	by smtp.github.com (Postfix) with ESMTPA id 2A305920988
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 04:48:04 -0700 (PDT)
Date: Tue, 19 May 2026 04:48:04 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1097304/000000-e6f7d0@github.com>
Subject: [bluez/bluez] 0cb83c: client/btpclient: refactor read-commands bitmap
 bu...
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

  Branch: refs/heads/1097304
  Home:   https://github.com/bluez/bluez
  Commit: 0cb83cdaeb54b3c4b0f544f3b5689ce52974988f
      https://github.com/bluez/bluez/commit/0cb83cdaeb54b3c4b0f544f3b5689=
ce52974988f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/bap.c
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/gap.c
    M client/btpclient/gatt.c

  Log Message:
  -----------
  client/btpclient: refactor read-commands bitmap building

Add add_supported_command() and use it across all btp_*_read_commands
handlers.

This replaces fixed-size bitmask assembly with a dynamically growing
command bitmap based on opcode index, avoiding shift-width issues with
higher opcodes.
This will allow to add opcodes like GAP_SET_EXTENDED_ADVERTISING
(0x21).

Refactor core, gap, gatt and bap read-commands paths to build response
bitmaps through the shared helper and preserve existing error handling
for allocation failures.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 654df3d8b47612d2d0d740d940095982c8f9d9e9
      https://github.com/bluez/bluez/commit/654df3d8b47612d2d0d740d940095=
982c8f9d9e9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Replace advertising defines by shared ones

The advertisement types are already defined in src/shared/ad.h


  Commit: e6f7d0db186428ccb5d3734e157bc964be62a454
      https://github.com/bluez/bluez/commit/e6f7d0db186428ccb5d3734e157bc=
964be62a454
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_GAP_SET_EXTENDED_ADVERTISING support

This set LEAdvertisement1's SecondaryChannel property to "2M" to
force Extended advertisement type.


Compare: https://github.com/bluez/bluez/compare/0cb83cdaeb54%5E...e6f7d0d=
b1864

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
