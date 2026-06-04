Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF83DA5D5
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572302; cv=none; b=rjAvsmK8RhFHllas7JTYM3JkujqBSdG7RhuMu17AD+kjrvQgohHO0nb7iW2S3baMoC/VWp6pC9mQ0GUTPsLpv1NsjCIORWXT5sXTvT65C6RWO5m3ub3BH5rJAXjRlZBvaMzDTbZ53MpH5s44/qd2W2+jvYgKq81bVAMzaTgVBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572302; c=relaxed/simple;
	bh=KetW5F6ZWLhHHK0zE03XR8COfFhGY9EYPXNf+jeDpqw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EzOKsD5QJ9IG42we7gEsj7H8nlymwcUUHLl+x+sPxku4zfIOuSo5K3t1hRmkEs2GjBdU8k3ymtV0rBShEuuk0gvpAJyYlLfyQ1Ds+AP8LyKy2y2VdP30yaDwURN9ODQax+n9x1PsdbZlk42pQ/01aZT24SkTP7wo86h6gicfEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PbrAKw1A; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PbrAKw1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780572300;
	bh=2DRpyWfGwBhi4znjPQ8n3mnkrXC+XwoA2LWrfUYS/CE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PbrAKw1AWUiLqFndLlzqRnavssXTrdXRqhqBjeoYf1rUid/snMdB/f3+PhQgBD/bc
	 veKHhY8CoDItCVMG8MFS70LLyvWYZf5nB6uuxXBkvHBwDBASa2iEaXgU2bjTWcrSPl
	 umDCsHYa5MN4puTU49TvvA5Zoj2pLihucWf2EHEI=
Received: from github.com (hubbernetes-node-4e632f8.ac4-iad.github.net [10.52.221.15])
	by smtp.github.com (Postfix) with ESMTPA id 47F8A320151
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 04:25:00 -0700 (PDT)
Date: Thu, 04 Jun 2026 04:25:00 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105837/000000-f47761@github.com>
Subject: [bluez/bluez] f47761: profile: Set L2CAP IMTU for OBEX profile
 listeners
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

  Branch: refs/heads/1105837
  Home:   https://github.com/bluez/bluez
  Commit: f47761fdd48ec82c2b5d232c1bd10235b360ab8c
      https://github.com/bluez/bluez/commit/f47761fdd48ec82c2b5d232c1bd10235b360ab8c
  Author: Wei Deng <wei.deng@oss.qualcomm.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Set L2CAP IMTU for OBEX profile listeners

The default_settings entries for OBEX profiles (OPP, FTP, PBAP, MAS,
MNS) have no imtu field, so ext_start_servers() creates the L2CAP
listening socket without an explicit IMTU. This causes the socket to
advertise the L2CAP minimum of 672 bytes in L2CAP_CONFIGURATION_RSP,
limiting the peer's outgoing PDU size and degrading Rx throughput.

Add an imtu field to default_settings and set it to 32767 for all
OBEX profiles that use L2CAP. Copy the value in ext_set_defaults()
and apply it to the listening socket via bt_io_set() after
bt_io_listen() succeeds.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
