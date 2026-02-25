Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428522157B
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039887; cv=none; b=DjfVFxr48Fved3UruDJ2nDSclDasfl0BU3ls8YCfQFYkHHGl/I4CtzYeBUkaeQJRtYEv22lzvMHk+hEWg243Qt6mXzPJeSthWKc4H56N1BWjLEYmaA+h84qYpgbvJZQ8PxtV8ALLe02IBVX8R8xnTCM+eHQty/mmjmUPjkdecXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039887; c=relaxed/simple;
	bh=C4MgY4ljlz8bCvROoJA10occUy+7/eKM8E3w5pDxoa0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g1EzBEBqyfmJSdFMtWgblPZsXxXez1xAUe3S9DWcMadkLCMdX68YS4qMIEPgRopYdpt7bu06grBzuzwIkJKLSVfhFQ++nDl/2xYlPW4NpeQmLkTqWT6Fdbz7/fGb0JAhWvRBWZtLXlS58LS0CXPRfBzQt/4bMMzFkAKGtVPusWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hFVtQRKs; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hFVtQRKs"
Received: from github.com (hubbernetes-node-82bc4b2.va3-iad.github.net [10.48.13.39])
	by smtp.github.com (Postfix) with ESMTPA id C74A7E1412
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772039885;
	bh=ZRchbOocArfoiTxzagtSIngGIYShGEaZXh13XIfKOuM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hFVtQRKsEuRqinC1wcuCAWgI8mmgfqSdQ4kS86QEwaIG5yeFdgWVrIZPJ4E5bKNxp
	 cNgtO2RCJWkyh66gFwivq5+RqmxqoeQWjqUqhpQnqzfN8qw3VuduzRUAtvkKWBu+0S
	 ZHYTuss5n2fyNteZzqgUev15GW0vPBQpWcZS+gz8=
Date: Wed, 25 Feb 2026 09:18:05 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1057897/000000-22a0cb@github.com>
Subject: [bluez/bluez] e3b913: client/mgmt: fix compiler error
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1057897
  Home:   https://github.com/bluez/bluez
  Commit: e3b913c5749a3c2c9bd6b94b2e3270cccd22ecac
      https://github.com/bluez/bluez/commit/e3b913c5749a3c2c9bd6b94b2e327=
0cccd22ecac
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: fix compiler error

client/mgmt.c: In function =E2=80=98str2bytearray=E2=80=99:
client/mgmt.c:2385:23: error: comparison of integer expressions of
different signedness: =E2=80=98unsigned int=E2=80=99 and =E2=80=98long in=
t=E2=80=99
[-Werror=3Dsign-compare]
 2385 |                 if (i >=3D *val_len) {
      |                       ^~


  Commit: 473e7bf48989dd9947a212aba862430b69e58e26
      https://github.com/bluez/bluez/commit/473e7bf48989dd9947a212aba8624=
30b69e58e26
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M tools/btgatt-client.c
    M tools/btgatt-server.c

  Log Message:
  -----------
  tools: btgatt-client/-server: replace ATT_CID with 'shared' BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: 38fec54e72381961bf9f2815285bc611b8d6a7b9
      https://github.com/bluez/bluez/commit/38fec54e72381961bf9f2815285bc=
611b8d6a7b9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  src: replace ATT_CID with 'shared' BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: dfc1947986c120c066a8206824b27c9cbbad574b
      https://github.com/bluez/bluez/commit/dfc1947986c120c066a8206824b27=
c9cbbad574b
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M peripheral/gatt.c

  Log Message:
  -----------
  peripheral: replace ATT_CID with shared BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: e11aecc6e1b267afb6eb90d84f2454458f80f624
      https://github.com/bluez/bluez/commit/e11aecc6e1b267afb6eb90d84f245=
4458f80f624
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M attrib/att.h
    M attrib/gatttool.c
    M attrib/interactive.c
    M attrib/utils.c

  Log Message:
  -----------
  attrib: replace ATT_CID with 'shared' BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: 17b3369d77fd97ebd01fc350ae10a2d3d7b0b07e
      https://github.com/bluez/bluez/commit/17b3369d77fd97ebd01fc350ae10a=
2d3d7b0b07e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M attrib/att.h
    M src/device.c

  Log Message:
  -----------
  src: replace ATT_PSM with 'shared' BT_ATT_PSM

Avoid multiple definitions of the same value.


  Commit: eaefdefa0d413cb4abfc2d363614eecfb8a90662
      https://github.com/bluez/bluez/commit/eaefdefa0d413cb4abfc2d363614e=
ecfb8a90662
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M tools/btgatt-server.c

  Log Message:
  -----------
  tools: btgatt-server: remove unused member 'fd'


  Commit: 918d0c739ab43c0c4305c7a05100382a8edfbb4e
      https://github.com/bluez/bluez/commit/918d0c739ab43c0c4305c7a051003=
82a8edfbb4e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M lib/bluetooth/l2cap.h
    M tools/l2test.c

  Log Message:
  -----------
  l2test: add comment to -F <fcs> option

Clarify that this option has affect for BR/EDR sockets only. Use defines
instead of magic numbers.


  Commit: c85f68b3bc2d883ebbd285bd54eda1d0f571833e
      https://github.com/bluez/bluez/commit/c85f68b3bc2d883ebbd285bd54eda=
1d0f571833e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: add comment to -O <omtu> option

Clarify that this option has affect for BR/EDR sockets only.


  Commit: 75ee8b37985e73efd560606f9f11377a514d8206
      https://github.com/bluez/bluez/commit/75ee8b37985e73efd560606f9f113=
77a514d8206
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: small improvements for deferred setup

- don't pass arbitrary option values to the kernel (the kernel only
checks for zero / non-zero)
- centralize authorization of new connections in listen()
- improve documentation of command line option


  Commit: dea2035ea920e634bebe18b4f64ddaf2bc67c9bc
      https://github.com/bluez/bluez/commit/dea2035ea920e634bebe18b4f64dd=
af2bc67c9bc
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M src/adapter.c
    M src/agent.c
    M src/agent.h
    M src/device.c
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  agent: move defines and parsing for I/O capability to shared/mgnt

Allow reusing in client/mgmt.c (next commit)


  Commit: 22a0cb92cd0353a90fd77276f64706757faabf37
      https://github.com/bluez/bluez/commit/22a0cb92cd0353a90fd77276f6470=
6757faabf37
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M client/mgmt.c
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  client/mgmt: align implementation cmd_io_cap with its documentation

Documentation of io-cap in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().


Compare: https://github.com/bluez/bluez/compare/e3b913c5749a%5E...22a0cb9=
2cd03

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
