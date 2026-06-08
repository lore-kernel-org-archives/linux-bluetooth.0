Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20448165E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930557; cv=none; b=NhzF2tDDPY5BUlmkyy1Cp+llRGu+zwLvqmeafVpKoclsJVcJBRuWA1L0ww+5jNQ6z+6Nqwt6C0HzepZiO/RaOMFL+N9ehRthxZq0JOEijLDbyREzrWzZkMYqGrMjmCQmJ0bm7h3KNSd9/OSM8Ii7FQpmjWxc1tG6eU7+nmt9jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930557; c=relaxed/simple;
	bh=UH92EFMwiCzBb9DMD1VjHvcpCoJLODDiixN4hAb8t2w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TM6d6/bPHR8/8/9IYW+9I9v0LtLjrHkW+0cqEiAmMxoDPbK6z1z6hLkOwjbR9P14VDT/hExfunWfOL/PoNZfMWZISb32W3ti+KM5XELgzMY2wiBJZharm4yzNviib4BzAviK8ObKEmsEWK1674zgAZQO4mQn6JrLY69Mrtudc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BX5cPKnt; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BX5cPKnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780930551;
	bh=0fzaAPoG9hvsITit/Lxv3jy83uskQZ2VnjYe4ItnufI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BX5cPKnt1H2o10kH43257Pc6gBRajvHKuBMgmkwXf5iDPejKyW9N81vC/2mD3hCp5
	 GmLbGlGyiPfZnE0m7PHBgi+AX8tuEJeBOxM1cUA+cavxUYX9JrXf4rr3rVS+0qk7iD
	 1xR8cf7rmhRPvthXGTs8RlhqHA3WeWRKlPYgX21E=
Received: from github.com (hubbernetes-node-4231746.va3-iad.github.net [10.48.14.24])
	by smtp.github.com (Postfix) with ESMTPA id 7031B341000
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 07:55:51 -0700 (PDT)
Date: Mon, 08 Jun 2026 07:55:51 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107804/000000-12ee17@github.com>
Subject: [bluez/bluez] f8fd83: avdtp: Add GetConfiguration DBus function
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

  Branch: refs/heads/1107804
  Home:   https://github.com/bluez/bluez
  Commit: f8fd83da41d0f7478ef4748b7aef68f7fab4ea60
      https://github.com/bluez/bluez/commit/f8fd83da41d0f7478ef4748b7aef68f7fab4ea60
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h

  Log Message:
  -----------
  avdtp: Add GetConfiguration DBus function

Change avdtp_get_configuration to accept remote SEP instead of stream a
and add an async callback for response/reject handling; the old function
was not used anywhere (unit-test just copied signature), so it was
changed in place.

Add a GetConfiguration async D-Bus method to the remote SEP interface that
returns the retrieved configuration as a byte array.

This can be used to pass: AVDTP/SRC/INT/SIG/SMG/BV-11-C


  Commit: 12ee17f9ca7eab2b4b210e7c2fc004c4e868a9bf
      https://github.com/bluez/bluez/commit/12ee17f9ca7eab2b4b210e7c2fc004c4e868a9bf
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M client/player.c
    M doc/bluetoothctl-endpoint.rst
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  client/player: Add get-config command


Compare: https://github.com/bluez/bluez/compare/f8fd83da41d0%5E...12ee17f9ca7e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
