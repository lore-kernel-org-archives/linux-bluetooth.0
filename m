Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AE335094
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925944; cv=none; b=RWpJsxoEX9JaRR2XDNS5L9o2eyBZJTjLH5UVvYQYSiJeSJqcGYE01t1kldNkpuOdJSd0yINhLDJ5i3p25OQhxjH+Y30F92JuSEWRBO1LpuThA5KqJH3GWY6tcUD8o/hhIj7wlkFdcK8NYVPB2ybc/MpxAAOZNs45srB5Q+i7M5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925944; c=relaxed/simple;
	bh=hmTHfh1YuqxaPxaiWLMotd3S8f47JEes7rh4vPSode0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P/+uSkgGQPnM4v/PNrGwTXZT6X5y0MG0mHf/zkQthEVSnK4CQZokZycIMzZa4AsaxQU6aMKvuyd7x6OMyUg0nuDhXtficu41/XNW34ADcQVJeeNd03RecFGrVrrZdha/u0/gu8kAA2fF5ZGRhevHsVGMGTNUtUEEKhOzFpeRFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RVXFRkpY; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RVXFRkpY"
Received: from github.com (hubbernetes-node-9a31bef.ash1-iad.github.net [10.56.14.27])
	by smtp.github.com (Postfix) with ESMTPA id AB76C92084E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 14:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765925941;
	bh=F0HImCk192f6xm5KBcg/CWwbS8kY1CjdElVBIz7K9c0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RVXFRkpYoXNx/RMrfuil06uy0VtumHoBHyv/DmVdIhSN4/8i0VRxKgQEbLWPoO8yg
	 hAgKnxAQkLD3gUAKEFmW4vvPAlk8/oGeHkZSjApLdfa73QZUH7yHZGkoYAdZP4KKFU
	 +oFKYECvnIgBOJ3jpprEQS2ZmiBmZgprg33ZzHP4=
Date: Tue, 16 Dec 2025 14:59:01 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033942/000000-5d8a64@github.com>
Subject: [bluez/bluez] 3e862e: media: decouple local org.bluez.MediaPlayer
 from A...
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

  Branch: refs/heads/1033942
  Home:   https://github.com/bluez/bluez
  Commit: 3e862e30efe30167aed944976e48de726e728a7b
      https://github.com/bluez/bluez/commit/3e862e30efe30167aed944976e48de726e728a7b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

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


  Commit: b7a005ce9f88f6efe5a9cf0911d07d2b937ebc59
      https://github.com/bluez/bluez/commit/b7a005ce9f88f6efe5a9cf0911d07d2b937ebc59
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: expose org.bluez.MediaPlayer information via GMCS

Select one of the local org.bluez.MediaPlayer instances as the "active"
player, and expose its playback controls via GMCS.


  Commit: 5d8a64102dd062fba0db128744f0fcdf77a262c2
      https://github.com/bluez/bluez/commit/5d8a64102dd062fba0db128744f0fcdf77a262c2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  tools/mpris-proxy: allow selecting which adapter to use

mpris-proxy by default uses the first adapter it sees over DBus.  Add
option for selecting a specific one.


Compare: https://github.com/bluez/bluez/compare/3e862e30efe3%5E...5d8a64102dd0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
