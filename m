Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058D21883E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708810; cv=none; b=GPcP0XPo8aUwLh6MhvM5pz385MH3KaCLekg7Kf0YKENWIrb9wAU51TNDofPE7WHmXQvroqcPBsfaaog8SnOfZnK1tdPy7IwoJHhDn7p9D4r2j3Uhv/8aGhKx3Kk7KCb24c/nWrQlm85AtDV9A3OA7R4o8ued5tF1hvmRAasHsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708810; c=relaxed/simple;
	bh=jb5LtTbdxTLmIH+c8OSEPEcn+uZZi/IN68vbxtQcOSU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MmvEMtHjriD/2YqxBy8iv1AqVOigEAvfVM97Nx2kW87nd6O3Y/DKbtNhEeD9j1QY7aSiaILTfMo5+1SGcH/wVF/FTsqEgkoA/S33CtVDOF4ePZg52qFW93RK4T01G7XzHXfnUKMNxYOkD72WCBMLrUFB4wn8L1nnwYnHzNsd/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z8lDzUir; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z8lDzUir"
Received: from github.com (hubbernetes-node-56813b9.ash1-iad.github.net [10.56.225.86])
	by smtp.github.com (Postfix) with ESMTPA id B93A2600757
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764708807;
	bh=5uehAK6tSgRrb9xn8DARx+Z5BtbsQAwhuh6DCU7LCOE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z8lDzUirYq2qEllTtv7IXQfxOFm7WBTnv7XIjdMtat+1J1oWyOzWxrMPLOXaCeoi8
	 FsK/7dXzC+cuwsFWPEbE2gVaY8FfjrPHPbbujG5Y1Pr7vS/yjbodarJG2vpGU2CF0k
	 ueHOjWr0y9zOgXm53s84RwH3W/LnYRaOO69sDHSI=
Date: Tue, 02 Dec 2025 12:53:27 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029869/000000-d21535@github.com>
Subject: [bluez/bluez] 617e7f: profile: add after_services for ordering
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

  Branch: refs/heads/1029869
  Home:   https://github.com/bluez/bluez
  Commit: 617e7f7db6be5cbdeae4a69e18761b770f33edeb
      https://github.com/bluez/bluez/commit/617e7f7db6be5cbdeae4a69e18761b770f33edeb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

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


  Commit: dc2d782c008937a05f55f19992581fef27104b7b
      https://github.com/bluez/bluez/commit/dc2d782c008937a05f55f19992581fef27104b7b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

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


  Commit: ac5f5a333c27285228552637ca1883e839e27056
      https://github.com/bluez/bluez/commit/ac5f5a333c27285228552637ca1883e839e27056
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: use after_services in service autoconnect and sort also GATT

Use btd_profile_sort_list() for selecting the order in which services
are connected: first by priority, then by after_services.

Probe and accept also GATT services in profile order. Previously this
was done in the order they were in GATT db.


  Commit: 868ef3b95480cc7d45324a26e166a8d00f603cfb
      https://github.com/bluez/bluez/commit/868ef3b95480cc7d45324a26e166a8d00f603cfb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M src/service.c

  Log Message:
  -----------
  service: implement btd_profile::after_services callback

Handle btd_profile::after_services callback when after_services
dependencies have finished connecting.


  Commit: 0e55ecd81ed52bbd4ea8d8af2b5dc66226381237
      https://github.com/bluez/bluez/commit/0e55ecd81ed52bbd4ea8d8af2b5dc66226381237
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: have unicast client wait for VCS & TMAS & GMAP

Have unicast client to wait for VCS, TMAS, and GMAP before creating
endpoints and transports, so that their information is available at that
point.


  Commit: 693b73340e4a4c88b97ca2260bb65e4e64a7cdc2
      https://github.com/bluez/bluez/commit/693b73340e4a4c88b97ca2260bb65e4e64a7cdc2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M src/shared/vcp.c
    M src/shared/vcp.h

  Log Message:
  -----------
  shared/vcp: add ready callback to bt_vcp_attach()

Add callback that is called when VCP client has finished attaching, so
that caller can know when it can be used.


  Commit: d215356302ee80defe30cbe8b712a1d635e2b665
      https://github.com/bluez/bluez/commit/d215356302ee80defe30cbe8b712a1d635e2b665
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M profiles/audio/vcp.c

  Log Message:
  -----------
  vcp: wait until client ready before marking profile connected

Mark vcp profile connected only when VCP client is ready, so that
dependent profiles do not try to use it when it is not yet initialized.


Compare: https://github.com/bluez/bluez/compare/617e7f7db6be%5E...d215356302ee

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
