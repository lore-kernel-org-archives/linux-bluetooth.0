Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CF231CB8
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074307; cv=none; b=Q8FHh76VmEUJaE9YQUEZZ+YFGBPNpr0EWGKnSdNtvGsKb/XnovaBaa96gwbJbeWwHC7j7c284PElQffPdgMRE0IPrtLjawTIVr5RoKHike5R2j80UhhQA1piUUXgYwpqdXA+FXVmIp9LLJkfcQDjpPOJLvfjUmI2qZpwLGNyiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074307; c=relaxed/simple;
	bh=xPmsrsIjgd2vgnyWyJArpyDKkIUZQ4SFP1ij+gq3KSQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ogmlcwAr/y2PengsD8Uv/pWYO1qUJINx+qz7cNUq5nmUd1HJf4NRr4owUUh7XOMHTi774DC1oOpWShdrJ5kh0j8VEvCm49aR3W/AvRBNj698cnVFYElBB3CZYltUtWuKHIUIWVvVfCxCbXxXS/oEiio6jIs70z5NIx/ShJrVSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bfq2HyaR; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bfq2HyaR"
Received: from github.com (hubbernetes-node-afee3a5.ash1-iad.github.net [10.56.131.38])
	by smtp.github.com (Postfix) with ESMTPA id D125F140C1B
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1728074304;
	bh=tN8AF6/enDOM8d8Bg/MrIN86oPBkZs9NfhoC6fa6bHw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bfq2HyaRVN9wZIqtrg2yVAdnBA4iJaN+xxSiuV6y/KqHg5hX5rarZDBpLpaYbhiib
	 gFTZxx+1AZ7F98V9ie+LzJLl1XQ/U+ybt5eyy9nE3bPijmxKo/G0Niv+jL0T68rEnT
	 dYU66qrpTB1XTsrOBTuDOp+xsktU3PR/PaDbZKjs=
Date: Fri, 04 Oct 2024 13:38:24 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8146d8-31e5b8@github.com>
Subject: [bluez/bluez] 098b94: audio/player: Fix media_player_set_metadata
 item d...
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
  Commit: 098b94ed626244bdebed4243ee6415686dd70973
      https://github.com/bluez/bluez/commit/098b94ed626244bdebed4243ee641=
5686dd70973
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-10-04 (Fri, 04 Oct 2024)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  audio/player: Fix media_player_set_metadata item destination

Use item provided as parameter, or mp->track if NULL which is used
by MCP.


  Commit: 671f370a8e34baa1f481ac62ea34f9ba6c45e31e
      https://github.com/bluez/bluez/commit/671f370a8e34baa1f481ac62ea34f=
9ba6c45e31e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-10-04 (Fri, 04 Oct 2024)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M profiles/audio/player.c
    M profiles/audio/player.h

  Log Message:
  -----------
  audio/player: Clear playlist on Now Playing Changed AVRCP event

Some devices reuse the item ids for the Now Playing list on playlist
change. This commit allows to clear the list and prevent to keep the
previous tracks information.


  Commit: 31e5b8f206791f0f96c20d9ea358208b88e44dfe
      https://github.com/bluez/bluez/commit/31e5b8f206791f0f96c20d9ea3582=
08b88e44dfe
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-10-04 (Fri, 04 Oct 2024)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Extend ListItems to get more metadata

This allows user applications to display the playlist with
Artist, Album, Track number, Duration and Cover art handle.


Compare: https://github.com/bluez/bluez/compare/8146d8f7dd67...31e5b8f206=
79

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
