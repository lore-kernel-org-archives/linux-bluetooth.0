Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8C4E73D2
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777460; cv=none; b=r5FHJYkHL6MZ5vFNSCvBrt/1BaENI0T4TvC5uHYO5A11xA8+QZ2j3n6ZR6PUwAzcIa1zKNveJfZI5Mxm3U9YMB13agnoQ7kJAQZRiemr29+i98d86sPwix1/9aifr4nKa0wxSmkNba3ojfKScTvFNxFIdwWkGwRKUqLjfg5BSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777460; c=relaxed/simple;
	bh=xQJU79+rOqzwfB1G3NRGJaJlw/W65NZqRlPlLhHM16s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=plkkb7ObLUl8EZtok7cFrZ5Vq6RuvQnzQEZvA0AY6Gtw6xYzM9zOrbNU4hdxLMIjiIqRBV/vAyfIGapgQXMme57KG1UcCdpHN95ApIUM1GuPzir3/8H32Kgnp8/dGxWqb1+dN4dmwvq4xdq21AZyszuI6lBmTO0tP5BQoVkXCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=DprGJskI; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="DprGJskI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790777427;
	bh=VMGis1QDHlI0BTcQXNi1v36OSu4pPB6GJ52rfKiSPlE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DprGJskI/HCOXi+RAX8Ge0cdLlNex8jNxC71vY8sra9sgBSCyoRaDZVSld7ylUuQe
	 +JnpBLbGdhSGcJCXBiEhsawLc2pOa/yNr6NkISFwpHa853Zfr06ZqpExRGOi/KeCG/
	 HCanJqRsf+bQhUeR28hmtuFHl3WrxvGneQtUk3nFoi/DNYCZgGbPhfxKG4fS5q4MzZ
	 hSu+LWYFxvICu+z3/GF6AS6CuN71IuZGM2aXg2KbzB70UTuEkNaniGJNgcKyjTKYV6
	 b7OU/9eyRfBmSuRlYWsFKD9rodH4gu44eX+hQ/B4C2lpnX2Ar8dH7BWIBse1PNvIb6
	 ukuhpuDchmSWA==
Received: from github.com (hubbernetes-node-53d2209.va3-iad.github.net [10.48.75.77])
	by smtp.github.com (Postfix) with ESMTPA id 77A6F34150A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:10:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 07:10:27 -0700
From: mkaros <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176758/000000-645bd5@github.com>
Subject: [bluez/bluez] 645bd5: audio: Fix stale AVDTP connecting state
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

  Branch: refs/heads/1176758
  Home:   https://github.com/bluez/bluez
  Commit: 645bd51a50b2a5e7606268599e73d99cae72da96
      https://github.com/bluez/bluez/commit/645bd51a50b2a5e7606268599e73d99cae72da96
  Author: Kun Ma <mk02092022@gmail.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M profiles/audio/sink.c
    M profiles/audio/source.c

  Log Message:
  -----------
  audio: Fix stale AVDTP connecting state

When a remote dual-role A2DP device reconnects autonomously, both sink
and source services transition to their respective CONNECTING states
upon AVDTP_SESSION_STATE_CONNECTING.

If the remote device only configures one direction (e.g. initiating a
stream from remote Source to local Sink), the unused direction's state
remains stuck in CONNECTING even after the underlying AVDTP session has
reached AVDTP_SESSION_STATE_CONNECTED.

Subsequently, when policy or userspace attempts to initiate audio
playback (e.g. via sink_connect() or source_connect()), the call fails
immediately with -EBUSY due to this stale CONNECTING state.

Fix this by only returning -EBUSY if the underlying AVDTP session is
actually still in AVDTP_SESSION_STATE_CONNECTING. In addition, check if
a stream already exists on that service to prevent concurrent stream
allocations while the session is connected.

Link: https://github.com/bluez/bluez/issues/2381



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
