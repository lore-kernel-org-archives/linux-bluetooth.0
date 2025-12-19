Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321C31ED81
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165556; cv=none; b=WU24gIaKW3SD6YQ0l3lSqIkGN/NbPemeXwdph5WDodhMZxRDNLI6Sbvkz2gKg7klICnw9TRk74SHJw0/w+eH0p5phDUpglV0Byxa97MgXZNfRfZMbluUneqDRcQsYxWcacRo3lXo47fn+k2gjmhzavxmz8XBhd0C42P+ZKi356I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165556; c=relaxed/simple;
	bh=I5dv/0LhLLx22zontxJJgHphHxcJ+6vgl25LFUPWSo4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qAwUBZU6qsYRvZ60Anq2nVVnM6b3yOQaZCFQrbfMEJh4O//4SLY0w8g+kQaHyz/akeVYvnqybCCLo88ZnfJXHFiBHBvo8noMVFElCP383Lcfx+ptiGH5MHoj6VfjbblGaTXvcSNGt4NLfGIFHAWWLWhMhtLJe/GZLyWwnmYGYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bNVM8hGd; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bNVM8hGd"
Received: from github.com (hubbernetes-node-8bb5569.ash1-iad.github.net [10.56.203.132])
	by smtp.github.com (Postfix) with ESMTPA id AD6CB6003B4
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766165553;
	bh=B5dyLA4NbmUEM3pfdck2MIQpgr8PMeCPkWoNp7t8CdY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bNVM8hGdwK+07AOhROiiQwlY704S2ceXsbb/icY83GAWOT0hc06hDNsqXtaLW6Vl2
	 zaGUIopg4IofxlWVXP7hCSH1kvrz9fx0WQgSaHD4itXs934iF30rUxlY6NRCdLQ85s
	 E4GXmxbDzzD6m/maMXT240LVPgZgQm/aU51khoT8=
Date: Fri, 19 Dec 2025 09:32:33 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1035135/000000-1255b8@github.com>
Subject: [bluez/bluez] 59f108: media: decouple local org.bluez.MediaPlayer
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

  Branch: refs/heads/1035135
  Home:   https://github.com/bluez/bluez
  Commit: 59f108d0cc692993d72cef898a460db26a27cc19
      https://github.com/bluez/bluez/commit/59f108d0cc692993d72cef898a460db26a27cc19
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

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


  Commit: 0fdce2ad19e4ee871461320821ad547a557baed7
      https://github.com/bluez/bluez/commit/0fdce2ad19e4ee871461320821ad547a557baed7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: expose org.bluez.MediaPlayer information via GMCS

Select one of the local org.bluez.MediaPlayer instances as the "active"
player, and expose its playback controls via GMCS.


  Commit: 1255b8bd7dc8f08912dc0d4f4b45f6d51bbb2f59
      https://github.com/bluez/bluez/commit/1255b8bd7dc8f08912dc0d4f4b45f6d51bbb2f59
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  tools/mpris-proxy: allow selecting which adapter to use

mpris-proxy by default uses the first adapter it sees over DBus.  Add
option for selecting a specific one.


Compare: https://github.com/bluez/bluez/compare/59f108d0cc69%5E...1255b8bd7dc8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
