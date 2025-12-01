Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16B1C32FF
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608428; cv=none; b=Ugb7mNCHJS9myDX7hyXvL0wUg5wtHIZ85CXRlkmWYdc+ZjjJ5lhsq2e4HKA76BqTwLCieHhswdM4GJD2mEUp2ET9AO65l1hofY3XY+L4xeaqcY9o8exia8FkDAUVMrnsskwHNdsHHxRf6IcX0oAWFlpe8ZquZVFgyBS+SzbH2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608428; c=relaxed/simple;
	bh=U0aXVxjChOulxj3kljT9xNY57+4CS6qZfzT8V3t5zlY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NzFxwYToJ2txhPLnVmkC8EJ4t5Sf6FulQxlT8W3oMUvIbgO+uAGpLBF0aZuu9k/y5Fc8JvEaxYlR7H4ezPGjTS+DwX7rO5BykdUj2tkiPC5MtJRqBNSDv9wHPVrwNSGpuHDy7OB8z7aThFw0BVTzT2g6uGXg12tJ66hQKSMdkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k3W5vuDl; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k3W5vuDl"
Received: from github.com (hubbernetes-node-26ba929.ash1-iad.github.net [10.56.148.45])
	by smtp.github.com (Postfix) with ESMTPA id A7B0B6004BE
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 09:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764608425;
	bh=5UHKPmaUgdY71dcxHc9jlcoMxWAc4AkNn4hDoKqlnqM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k3W5vuDlH3tSFWyk6mmzdpWUkoai+1oATion2kx+IMNm4lFKHQVgJb8jHoXvH0d/r
	 +khm2kfal0hHK/Pn47OOIG3lNYRKZo2Dc4oM6psSiOHQtcDaC+5u7dYYXrCONJK3jE
	 IRIb4yyZoaIn159fAvanneY5XKF1r+9IGbUikK/g=
Date: Mon, 01 Dec 2025 09:00:25 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d42182-71a3aa@github.com>
Subject: [bluez/bluez] f11433: shared/gmap: add GMAP Service
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
  Commit: f11433431e921c48abd795b4bc43bea7695b43e3
      https://github.com/bluez/bluez/commit/f11433431e921c48abd795b4bc43bea7695b43e3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

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


  Commit: 5312066e67c8073de03fb90110bb8bbeee4b07b8
      https://github.com/bluez/bluez/commit/5312066e67c8073de03fb90110bb8bbeee4b07b8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-gmap.c

  Log Message:
  -----------
  test-gmap: add test for GMAP Service

Add tests on GMAP service for reading the attributes.


  Commit: c6b1aed97b6a2e61ed415eb85c27941ce6ed5393
      https://github.com/bluez/bluez/commit/c6b1aed97b6a2e61ed415eb85c27941ce6ed5393
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/gmap.c

  Log Message:
  -----------
  gmap: Add GMAP profile

Read GMAP properties from remote devices and enable advertising the
values for local services.


  Commit: d4332653009c447d178876f2c86bc2360feaf27a
      https://github.com/bluez/bluez/commit/d4332653009c447d178876f2c86bc2360feaf27a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: org.bluez.MediaEndpoint: add SupportedFeatures

Add SupportedFeatures field for indicating TMAP & GMAP roles and
features.


  Commit: 71a3aa554f4f4b589ecc1a81d0df4e6880361d8d
      https://github.com/bluez/bluez/commit/71a3aa554f4f4b589ecc1a81d0df4e6880361d8d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add SupportedFeatures for MediaEndpoints

Indicate TMAP & GMAP capabilities in SupportedFeatures.


Compare: https://github.com/bluez/bluez/compare/d4218235678c...71a3aa554f4f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
