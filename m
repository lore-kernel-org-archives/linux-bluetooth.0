Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E92D5C92
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360777; cv=none; b=jaeYcftbmT4ggWZcCB4crU2L2kFyWvwWCS1ZdpAgpjjdtkZ4GHIXudbuFs6qB2tS9RiNYIASm8zraUnW4l6u0dN1GdC4+IifWMxdtiw8ICvGQzsqRiorPHQHWNBC5asy3e/tRNW8VIOczMKge5oxMebYHUyBs3ww1qE/NH5Cd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360777; c=relaxed/simple;
	bh=KK5//mmL1pAs0/toqjmaSg3nkZmwCbQO5dtpXJZ5VmM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HlQ31kwglDjroPygxGtvDMh9IOgyfJ51H+086sDlQBeqiAVpeVFjoKRKyZDpLYMJWgw8EBQn+EOS+ufh86IsnPjjpv1DyqcbBGphVvBq366PvLw95BKNcKKHMadLgOkRl3GdwXgrQaISNMwx2UcQjuw3lQWCuoysO06Gmv0ly5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hCSLRLaz; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hCSLRLaz"
Received: from github.com (hubbernetes-node-892c1da.ash1-iad.github.net [10.56.181.38])
	by smtp.github.com (Postfix) with ESMTPA id 0E317921079
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764360775;
	bh=OHA1EE+qsLHm8pF6wiiArcPElRICE/SPIs8A8yYOIzg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hCSLRLazGgIKraojPQD0VdnY3RGPfs7Cvl1pgmRy6krbsnrRK5migqoWJk5kiVbG7
	 oI4TphXRXre71vSPrJJs4glQPvQzvOUUQjOU6hD0QXKh/2ETBKg8D53wYlvPqZUP6W
	 1sliqUUM2USSIHPpe8bZ1Lqw1hQgaUBihSijNxNs=
Date: Fri, 28 Nov 2025 12:12:55 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028785/000000-f84f03@github.com>
Subject: [bluez/bluez] 5eddb1: shared/gmap: add GMAP Service
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

  Branch: refs/heads/1028785
  Home:   https://github.com/bluez/bluez
  Commit: 5eddb1cbc95a7bf1b3d122c788cc2f05ed0d88b2
      https://github.com/bluez/bluez/commit/5eddb1cbc95a7bf1b3d122c788cc2f05ed0d88b2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M Makefile.am
    M lib/bluetooth/uuid.h
    A src/shared/gmap.c
    A src/shared/gmap.h

  Log Message:
  -----------
  shared/gmap: add GMAP Service

GMAP Service is just a simple service with bitmasks.

The values can be used to figure out which GMAP roles and features the
remote device claims it supports (matters for available mandatory
features).  Also can advertise the same for remote clients.


  Commit: 26e6b513dbbcd378d5565f2c4d9ffbe10d2367df
      https://github.com/bluez/bluez/commit/26e6b513dbbcd378d5565f2c4d9ffbe10d2367df
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-gmap.c

  Log Message:
  -----------
  test-gmap: add test for GMAP Service

Add tests on GMAP service for reading the attributes.


  Commit: ff7f5804e1a532556c16e33b3140fa1d6732d392
      https://github.com/bluez/bluez/commit/ff7f5804e1a532556c16e33b3140fa1d6732d392
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/gmap.c

  Log Message:
  -----------
  gmap: Add GMAP profile

Read GMAP properties from remote devices and enable advertising the
values for local services.


  Commit: 647dfb64159996e63bd1b192b895b9e785773342
      https://github.com/bluez/bluez/commit/647dfb64159996e63bd1b192b895b9e785773342
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: org.bluez.MediaEndpoint: add SupportedFeatures

Add SupportedFeatures field for indicating TMAP & GMAP roles and
features.


  Commit: fa4dbb2cfb302070fa421ee39c593d432bfa4b01
      https://github.com/bluez/bluez/commit/fa4dbb2cfb302070fa421ee39c593d432bfa4b01
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add SupportedFeatures for MediaEndpoints

Indicate TMAP & GMAP capabilities in SupportedFeatures.


  Commit: 4f108be42681d3ba11c2e9c67d468ae3e240a540
      https://github.com/bluez/bluez/commit/4f108be42681d3ba11c2e9c67d468ae3e240a540
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  profile: add after_uuids for ordering profile startup

Add btd_profile::after_uuids to specify the profile connect/accept order
for autoconnect.  This is a "soft" dependency so it doesn't fail if the
other services fail to start nor try to start them if they otherwise
wouldn't.

Add btd_profile_sort_list() for sorting a list according to profile
ordering, taking account priority and after_uuids.

Add btd_profile_find_remote_uuid() lookup utility, needed when using
btd_profile_sort_list() with uuid lists.


  Commit: 238362e0d1b281db78b9b3c96f7cc4237e73c43c
      https://github.com/bluez/bluez/commit/238362e0d1b281db78b9b3c96f7cc4237e73c43c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: use after_uuids in service autoconnect and sort also GATT

Use btd_profile_sort_list() for selecting the order in which services
are connected: first by priority, then by after_uuids.

Probe and accept also GATT services in profile order. Previously this
was done in the order they were in GATT db.


  Commit: 50c126c680ecf2c4c04535725b03a046672efede
      https://github.com/bluez/bluez/commit/50c126c680ecf2c4c04535725b03a046672efede
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M src/profile.h
    M src/service.c

  Log Message:
  -----------
  service: add btd_profile::ready callback when after_uuids ready

Add btd_profile::ready that is called when after_uuids dependencies have
finished connecting.


  Commit: f84f0363f04da9cc4c771826c20854a75d32f68e
      https://github.com/bluez/bluez/commit/f84f0363f04da9cc4c771826c20854a75d32f68e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: have unicast client wait for VCS & TMAS & GMAP

Have unicast client to wait for VCS, TMAS, and GMAP before creating
endpoints and transports, so that their information is available at that
point.


Compare: https://github.com/bluez/bluez/compare/5eddb1cbc95a%5E...f84f0363f04d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
