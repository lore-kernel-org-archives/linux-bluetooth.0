Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629D1D63F0
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765019726; cv=none; b=j+SS4mE2EDVvDoCg8I++9AwjPEEZd6llyXGpa+zgdeZKWKB+C4QgfmwPLiuXiOwFF4qXQK2bpKP+QJherfj6Q07QFmudpBlFWq4GAn0S38IvlOeW0To2tpfwhbfimUiNSZiE35YG0Va6UOyMDlKrT7ncB/PzMx4Ebc2y0B4e51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765019726; c=relaxed/simple;
	bh=c2m5pIS7MLT3fMzw797uxDkj3wthgK7nNDcTnM6A7Pw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CAzZE/dR4bBw4keI2DtbIqS/R66YxbmQFpX30QB0RWlo1iBwnhdKAA+jnVBAxauRHL6hgve2iiIECeOoeeaAjwNavITlTtUJIoNZCq06YrKSMtCnljPtd/i6Nfz/FxP71vRpPKudFtRq54NEv5a1kDD9b4vwiIbjifUeBU9INQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O38QUQkZ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O38QUQkZ"
Received: from github.com (hubbernetes-node-6e1478c.va3-iad.github.net [10.48.219.73])
	by smtp.github.com (Postfix) with ESMTPA id 1B2473C0E06
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765019724;
	bh=RbC5K60lkYF+6sBC/5VxaCgvKE4EduOggmAUbf/8auY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O38QUQkZdDnXZQM20ucWsu+/GRyR80/tCBQIVaslYFeLe0OFBhbRwVBHYYMxzbixf
	 3hrworGFu8R9ORJsArK7THRvhZBQPYKMS/zmIe2Yclo+eIjWpmkL6TP9Qis18X3p2c
	 Jx+EKWa4/mgzdzA+pLGXFKr1c/2YSVkKPGQP30Cc=
Date: Sat, 06 Dec 2025 03:15:24 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031057/000000-a22a38@github.com>
Subject: [bluez/bluez] 28598c: lib: move VCS, TMAS, GMAS uuid strings to
 uuid.h
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

  Branch: refs/heads/1031057
  Home:   https://github.com/bluez/bluez
  Commit: 28598c1be7de23f3a1c07ec24caed956f185b539
      https://github.com/bluez/bluez/commit/28598c1be7de23f3a1c07ec24caed956f185b539
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M lib/bluetooth/uuid.h
    M profiles/audio/bap.c
    M profiles/audio/vcp.c

  Log Message:
  -----------
  lib: move VCS, TMAS, GMAS uuid strings to uuid.h

These are needed in several places, so move also string version of the
uuid to uuid.h.

The naming in string vs. uint16_t uuid is not systematic in this file.
Retain the _STR suffix to be clearer.


  Commit: 9e6df3ea5267580953f9d4db5adaae8d7f7c2e3a
      https://github.com/bluez/bluez/commit/9e6df3ea5267580953f9d4db5adaae8d7f7c2e3a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: check size before trying debug print


  Commit: 87299d3c61ebc0ef8b79a92577a72420ee916b9f
      https://github.com/bluez/bluez/commit/87299d3c61ebc0ef8b79a92577a72420ee916b9f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M src/shared/gmap.h
    M src/shared/tmap.h

  Log Message:
  -----------
  shared/tmap, gmap: add macros for feature names and listing

Better use constants for feature names to avoid typos.

Add macros for generating lists containing all features / roles.


  Commit: 8f1f14a9ae3ae1ec6df474bfcdf00793239a57f9
      https://github.com/bluez/bluez/commit/8f1f14a9ae3ae1ec6df474bfcdf00793239a57f9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: use tmap/gmap macros for listing features

Use listing macros to generate the feature lists.


  Commit: b2314bc405611c999e337085e3f9f8c32b030d1c
      https://github.com/bluez/bluez/commit/b2314bc405611c999e337085e3f9f8c32b030d1c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M src/shared/tmap.c

  Log Message:
  -----------
  shared/tmap: deactivate service if setting Role to 0

Deactivate TMAS if roles are removed.

Also add NULL checks to the set() routine for convenience.


  Commit: dffd7b4e8f79789a4f3fe1fb8860cc5db005cec6
      https://github.com/bluez/bluez/commit/dffd7b4e8f79789a4f3fe1fb8860cc5db005cec6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M src/shared/gmap.c

  Log Message:
  -----------
  shared/gmap: deactivate service or remove feature chrc if role removed

When role is removed, the associated feature chrc must be removed too as
it's then Excluded in spec.  If all roles are removed, deactivate the
service instead to avoid consuming ATT handles.

Reserve exactly the right number of handles for the service.

Also add null checks to the feature set routines for convenience.


  Commit: b5634dc6a2442ed2cadd56477e02b0a8fe774bdb
      https://github.com/bluez/bluez/commit/b5634dc6a2442ed2cadd56477e02b0a8fe774bdb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M unit/test-tmap.c

  Log Message:
  -----------
  test-tmap: test removing and adding role


  Commit: 2d40655ae6ebe3c373ab15da8f09209eb4c4e56f
      https://github.com/bluez/bluez/commit/2d40655ae6ebe3c373ab15da8f09209eb4c4e56f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M unit/test-gmap.c

  Log Message:
  -----------
  test-gmap: test removing, adding, and changing role

When role is changed the old characteristic is removed, which shifts the
attribute handles.


  Commit: 5e3503a48f4234d2819fbf95725b27ff21f69492
      https://github.com/bluez/bluez/commit/5e3503a48f4234d2819fbf95725b27ff21f69492
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: parse SupportedFeatures from registered MediaEndpoints

Parse SupportedFeatures for TMAP and GMAP features, and update the
values to the local services if present.


  Commit: fc65515ef521d9d779b61bb2355bbbebd9243d10
      https://github.com/bluez/bluez/commit/fc65515ef521d9d779b61bb2355bbbebd9243d10
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M profiles/audio/tmap.c

  Log Message:
  -----------
  tmap: remove service on device remove

Remove service on device_remove() as disconnect() is not necessarily
called on device remove.


  Commit: a22a3888f6d009ed27acb29a75532acffd7843a7
      https://github.com/bluez/bluez/commit/a22a3888f6d009ed27acb29a75532acffd7843a7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M profiles/audio/gmap.c

  Log Message:
  -----------
  gmap: remove service on device remove

Remove service on device_remove() as disconnect() is not necessarily
called on device remove.


Compare: https://github.com/bluez/bluez/compare/28598c1be7de%5E...a22a3888f6d0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
