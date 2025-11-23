Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5722579E
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915924; cv=none; b=rNASYAMKxS6t0NzOFOP3sX3ufTqaVuyqgToqgSm7AZtqq9qOXg69Rzx2K3kIOmskVMc/FMg68L94Xx88LPC/qMpFTVqCrfMxBt1wrq5ZA59N2kVTW8pg/5Uc7V8BmPzbwnTS9jx4PiVy3QJTIPdBa/aZQj2mCXnaniQSO2x3y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915924; c=relaxed/simple;
	bh=PqATHG24rYFtdd8mdkaSgl4+Jqs0J+/X/nx2sriFmXo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GV1NGRq5/Zvyx+PvQzE13IG7kRroAYMPNJbPFCmoYQI1wFsuasrQ/alfMvkCmlANosw172jFPJrwjQF5NEwjbqIoY80ZChwVoqwwfbWI01T+LD8Kl4evq3TLnqcbk4t28l78YjUYB0pdrL+B1VxzTPzR662rxV1AzLL0Zo5SYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AKNWMeVB; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AKNWMeVB"
Received: from github.com (hubbernetes-node-58caf4e.ash1-iad.github.net [10.56.168.37])
	by smtp.github.com (Postfix) with ESMTPA id 810FB14022C
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763915920;
	bh=KVSrSswUF8mMFiRhCglXYdxm0/tY2/tsffD24dwZkr8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AKNWMeVBS8TRwLnS33u2H4Ikt3gp7mJv7uhzbHht0MYO2CNYfO6/QTWKompBHu1vB
	 lQaWD+oiUEYSeCg3Ptf28dGt8gjvJBXF4pcGt8tmP00/Ew/3aLb+CnitdUGKsDEK3J
	 gQ/JQFO260WvCkDnSRisAduJQeHsghT+Idtgw9hI=
Date: Sun, 23 Nov 2025 08:38:40 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026711/000000-f5872e@github.com>
Subject: [bluez/bluez] 80e60b: shared/tmap: add TMAP Service
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

  Branch: refs/heads/1026711
  Home:   https://github.com/bluez/bluez
  Commit: 80e60b4f55c27a4fa56176ea669c24ca68bb825a
      https://github.com/bluez/bluez/commit/80e60b4f55c27a4fa56176ea669c24ca68bb825a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M Makefile.am
    M lib/bluetooth/uuid.h
    A src/shared/tmap.c
    A src/shared/tmap.h

  Log Message:
  -----------
  shared/tmap: add TMAP Service

TMAP Service is just a simple service with a Role bitmask.

The value can be used to figure out which TMAP roles the remote device
claims it supports (matters for available mandatory features).  Also can
advertise the same for remote clients.


  Commit: ea90fd37dfc6a4649e5585d2c678492d5ecaa2be
      https://github.com/bluez/bluez/commit/ea90fd37dfc6a4649e5585d2c678492d5ecaa2be
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-tmap.c

  Log Message:
  -----------
  test-tmap: add test for TMAP Service

Add tests on TMAP service for reading the role attribute.


  Commit: 99953b4fc0a922993c686558d8137786cd41bfad
      https://github.com/bluez/bluez/commit/99953b4fc0a922993c686558d8137786cd41bfad
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/tmap.c

  Log Message:
  -----------
  tmap: add TMAP profile

Read TMAP Role from remote devices and enable advertising the value for
local services.


  Commit: 575d6e7d4de2fc416f98e8da3942888844b6aa4d
      https://github.com/bluez/bluez/commit/575d6e7d4de2fc416f98e8da3942888844b6aa4d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: have unicast client wait for VCS & TMAS

Have unicast client to wait for VCS and TMAS before creating endpoints
and transports, so that their information is available at that point.


  Commit: e0db0211999d9cca745c4f84034529429c2a9f0b
      https://github.com/bluez/bluez/commit/e0db0211999d9cca745c4f84034529429c2a9f0b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

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


  Commit: e68d2fb43c391f16b4a3d3ba5b6e577396cdd389
      https://github.com/bluez/bluez/commit/e68d2fb43c391f16b4a3d3ba5b6e577396cdd389
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-gmap.c

  Log Message:
  -----------
  test-gmap: add test for GMAP Service

Add tests on GMAP service for reading the attributes.


  Commit: d992424281c71092cabcaac86eee677f51ec33c3
      https://github.com/bluez/bluez/commit/d992424281c71092cabcaac86eee677f51ec33c3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/gmap.c

  Log Message:
  -----------
  gmap: Add GMAP profile

Read GMAP properties from remote devices and enable advertising the
values for local services.


  Commit: c30fc6a06bf57004dd94e840dbfcf7f96c84b5a1
      https://github.com/bluez/bluez/commit/c30fc6a06bf57004dd94e840dbfcf7f96c84b5a1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: unicast client wait for GMAP service

Wait until GMAP properties (if any) are read before configuring
endpoints and transports as BAP Client.


  Commit: f86a08101d6e9dd597b4d280db64ef141555b7d3
      https://github.com/bluez/bluez/commit/f86a08101d6e9dd597b4d280db64ef141555b7d3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: org.bluez.MediaEndpoint: add SupportedFeatures

Add SupportedFeatures field for indicating TMAP & GMAP roles and
features.


  Commit: f5872e81f4df93d8a55627e5fe6b04ce88f86df2
      https://github.com/bluez/bluez/commit/f5872e81f4df93d8a55627e5fe6b04ce88f86df2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add SupportedFeatures for MediaEndpoints

Indicate TMAP & GMAP capabilities in SupportedFeatures.


Compare: https://github.com/bluez/bluez/compare/80e60b4f55c2%5E...f5872e81f4df

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
