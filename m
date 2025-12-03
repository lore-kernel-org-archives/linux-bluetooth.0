Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D982C0271
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764797200; cv=none; b=pAJ5H7ZO3U2XuVjU4cjsu/dW95qISECNBeX6MHFtNr+RymGFhWjiMV1hklO0M+MgUSavUv3J1rb+SBu0UM5GYHnlAyIHCErejTTy8yxUf2zfAAGsybYnIml8bPF390BM7zQcIDjHqE2u0d4P1CgTjaAi3bS3d16+uZfg2mjnZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764797200; c=relaxed/simple;
	bh=Z9LEoUaktEPSdlVTK/0gZrYs9nPWIuwNRWGf00bozXY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pPbwD0l5MbIeu0VCsIkndcphpfxhKJflWwSntcJSnVK3zxN6TyBjNDhwb25I3JqhfsHywF879IWFuDIUI7OMAOdVv8XiF+vG82OyP9QGg8lavRlgtvpvw3YUVo5S5s3j4T/Ar2F8Ae5acP1LKilAFRWCWDy7FMZgiI5ZP2x8Ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZSBZftA2; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZSBZftA2"
Received: from github.com (hubbernetes-node-7e248ca.va3-iad.github.net [10.48.222.42])
	by smtp.github.com (Postfix) with ESMTPA id 924AF3C11A7
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764797197;
	bh=LsQn186pGz8YdoyG2ti/FNesw5Q/o481yiZdnifGefM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZSBZftA2hlgxH2Mr9M9VPQqIIzEJX39nGB/4d4oeiUuLAcxaT/CxEQpP30Vh46EYF
	 LlVBojdfVeQgOZJRAhD2aFRCxuUjV55vej0F5LAbjVXR55W3fZL+RQxIqD5Xu2nhhy
	 Czjr0o2zm6VPWmZiZxoCmRXmQxyNpsfP0mds7m40=
Date: Wed, 03 Dec 2025 13:26:37 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/143037-e55dd6@github.com>
Subject: [bluez/bluez] 580627: profile: add after_services for ordering
 profile s...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5806271a69d62e01c4e045346f09ca8f2be134c2
      https://github.com/bluez/bluez/commit/5806271a69d62e01c4e045346f09ca8f2be134c2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  profile: add after_services for ordering profile startup

Add btd_profile::after_servicess to specify the profile connect/accept
order for autoconnect.  This is a "soft" dependency so it doesn't fail
if the other services fail to start nor try to start them if they
otherwise wouldn't.

Add btd_profile_sort_list() for sorting a list according to profile
ordering, taking account priority and after_services.

Add btd_profile_find_remote_uuid() lookup utility, needed when using
btd_profile_sort_list() with uuid lists.


  Commit: 37f1d5de78d4aba486e704ff74e307a98b4f30b2
      https://github.com/bluez/bluez/commit/37f1d5de78d4aba486e704ff74e307a98b4f30b2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/btd.c
    A unit/test-profile.c

  Log Message:
  -----------
  test-profile: add tests for profile sorting

Add tests to check btd_profile_sort_list() works correctly.

The test uses queue instead of GSList in case device.c is converted to
use queue later.

Makefile.am: separate out bluetoothd_internal_sources (excludes plugins
& main.c) and add stub for symbols in main.c.  The profile.c pulls in
large parts of these so it's simpler to depend on them all for the test.
This doesn't cause any recompilation.


  Commit: cdcd845f87ee670715772754f7f7040483baa973
      https://github.com/bluez/bluez/commit/cdcd845f87ee670715772754f7f7040483baa973
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: use after_services in service autoconnect and sort also GATT

Use btd_profile_sort_list() for selecting the order in which services
are connected: first by priority, then by after_services.

Probe and accept also GATT services in profile order. Previously this
was done in the order they were in GATT db.


  Commit: 7f8ac0c1fbcdbd79d4c1c71f329878296b9fa135
      https://github.com/bluez/bluez/commit/7f8ac0c1fbcdbd79d4c1c71f329878296b9fa135
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M src/service.c

  Log Message:
  -----------
  service: implement btd_profile::after_services callback

Handle btd_profile::after_services callback when after_services
dependencies have finished connecting.


  Commit: b78808cfb3b83f208dafd9fc626b64e5d28f4939
      https://github.com/bluez/bluez/commit/b78808cfb3b83f208dafd9fc626b64e5d28f4939
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: have unicast client wait for VCS & TMAS & GMAP

Have unicast client to wait for VCS, TMAS, and GMAP before creating
endpoints and transports, so that their information is available at that
point.


  Commit: 02e03055052c9fe1443f6b5e8a0dff6e8d78f2d3
      https://github.com/bluez/bluez/commit/02e03055052c9fe1443f6b5e8a0dff6e8d78f2d3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M profiles/audio/vcp.c
    M src/shared/vcp.c
    M src/shared/vcp.h

  Log Message:
  -----------
  shared/vcp: add ready callback to bt_vcp_attach()

Add callback that is called when VCP client has finished attaching, so
that caller can know when it can be used.


  Commit: e55dd6e089e5c5ea445f3b93ccbdc4c70b4af84c
      https://github.com/bluez/bluez/commit/e55dd6e089e5c5ea445f3b93ccbdc4c70b4af84c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    M profiles/audio/vcp.c

  Log Message:
  -----------
  vcp: wait until client ready before marking profile connected

Mark vcp profile connected only when VCP client is ready, so that
dependent profiles do not try to use it when it is not yet initialized.


Compare: https://github.com/bluez/bluez/compare/143037cfe607...e55dd6e089e5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
