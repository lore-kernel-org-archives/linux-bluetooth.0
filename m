Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB02D6E54
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925361; cv=none; b=XR27YrER7Jx42GQd3ILRqLxbhweGt+gjje60oo7980tBPhLUgRVGs7jJinWMmxXOszbupYwnqLnDzrrSmGaFhnJtDgZvAlsHgFB3GoUKccuYXJKpEiC1VLmQFQQUyv0CT6cm+Sc56NVeCbHTS3Hxo+De3hJGLXltro4ILc68jH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925361; c=relaxed/simple;
	bh=kqnb6cB+Kk3vb92SXVgPgIb9yGsjhgwnqDV9JQlw6jA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kFvC1VyOh78g2BQPhw90w2o8KeoEXwKzgcEzLCrngdslSK74NW4PPIisjgj1I0wlnfhuNfoq9GOs18eNxhSsqA7SC8Almaj3XVMRV3mxEPM96VT61/HV3tI5XtcIZ8Bn0HV/iLIOXzrIMQMmVrYXX6UnHwgCGMK7zRgsVEUsxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dfGc8dP0; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dfGc8dP0"
Received: from github.com (hubbernetes-node-b1f14c9.va3-iad.github.net [10.48.168.30])
	by smtp.github.com (Postfix) with ESMTPA id 469AF4E011B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756925359;
	bh=rvzmUVQOoStv9zMzcIjSXf7aquq7HOPxLX2JrwDYx4Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dfGc8dP0z1u5Y+i0gC1ETHYaMWwVSV70FnyRxVyFeyYHiHlZcQ8HIBpHbDFesJuJ8
	 Fn/GGjbZiXX8Csy9DRa2WedMHF/cqWqF2KQYuxJ9pjkFBIAIa6tRCCdvR6ZyPc9hy7
	 AouHtc/zOIVM9hY4RsNHJCu0+4JkmwvsFmmZstfo=
Date: Wed, 03 Sep 2025 11:49:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/998542/000000-20a982@github.com>
Subject: [bluez/bluez] 20a982: main.conf: Add FilterDiscoverable option
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

  Branch: refs/heads/998542
  Home:   https://github.com/bluez/bluez
  Commit: 20a9828916db3c4273e48958511efbc8d8415ff7
      https://github.com/bluez/bluez/commit/20a9828916db3c4273e48958511efbc8d8415ff7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-03 (Wed, 03 Sep 2025)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add FilterDiscoverable option

This adds FilterDiscoverable option which can be use to control if
devices in non-discoverable mode shall be filtered or not, the default
is true to adhere to core spec:

 9.2. Discovery modes and procedures

 All devices shall be in either non-discoverable mode or one of the
 discoverable modes. A device in the discoverable mode shall be in
 either the general discoverable mode or the limited discoverable mode.
 A device in the non-discoverable mode is not discoverable. Devices
 operating in either the general discoverable mode or the limited
 discoverable mode can be found by the discovering device.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
