Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453082D3ED2
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047194; cv=none; b=TnyZ7RulnhwlwbUNh63H9R+AzMGp7jGf2CUexltoi/IvAdK51bQ/yl1dpCAGgw8mGvvTVODTfXzLw0EViX2RGzwFwIbRhh2aLV4L4P+YMkjeJfg48ZUn/sp5olAkbRBKPLYaTSm59IoIN9q1wMP6MW3Gq2z3wG4AQ8D7hinPX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047194; c=relaxed/simple;
	bh=es0nRDta2z4CDBICJb2FrkNVsBS05hR8iWJ4YQMdpx8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ETCMNfck/WWTYKgoB6npPssGwRbE0h2GxXcDXx391ebR/7xNvI7Ce1Q7A4g0vac+9NNQWKiBW3L2nkkOvzlGvT06zgr2aozb/w0Imt7sI+e3iA6cG/k90079bqT1Jk2V/fbdvN2CiWe7k14SdQCC5ELzKvbZ7qQGbjWCzWj4ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NVybxzYP; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NVybxzYP"
Received: from github.com (hubbernetes-node-e6fac74.ash1-iad.github.net [10.56.155.40])
	by smtp.github.com (Postfix) with ESMTPA id 87CB01411B7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772047192;
	bh=wCbJdzWadU95zNwtF6yqWwXo2voIcz9mXlAEeM7AC0I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NVybxzYPKBhZaQBuTh1PZXJgDu1HSP21YzJPL0+/Lgynw2p8yL3WEuD++teGedMBf
	 knW/IOEMzFM2v7DiiydHCuknNexkpuWMEUYEk35ojo0tAqqUuwHlf/xoZJxp89s73G
	 +t8d05gBia31fucxbPikclFIwGUIy74wIQL4Jrxc=
Date: Wed, 25 Feb 2026 11:19:52 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a96f5f-bf52d6@github.com>
Subject: [bluez/bluez] 451fff: client/mgmt: fix compiler error
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 451fff520c8a02dd8d45c9c676a206d1c06b5325
      https://github.com/bluez/bluez/commit/451fff520c8a02dd8d45c9c676a20=
6d1c06b5325
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


  Commit: 9648dbaa8d01090353c7987a709ab9c6ba5bda3c
      https://github.com/bluez/bluez/commit/9648dbaa8d01090353c7987a709ab=
9c6ba5bda3c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M tools/btgatt-client.c
    M tools/btgatt-server.c

  Log Message:
  -----------
  tools: btgatt-client/-server: replace ATT_CID with 'shared' BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: 7617732fd20b39144e9a430e625a071af4f2225c
      https://github.com/bluez/bluez/commit/7617732fd20b39144e9a430e625a0=
71af4f2225c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  src: replace ATT_CID with 'shared' BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: 5767a7dded4f7b8424d8f803f9ae84a3cacba259
      https://github.com/bluez/bluez/commit/5767a7dded4f7b8424d8f803f9ae8=
4a3cacba259
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M peripheral/gatt.c

  Log Message:
  -----------
  peripheral: replace ATT_CID with shared BT_ATT_CID

Avoid multiple definitions of the same value.


  Commit: cd6a809f7b43b00f3e05f4c46ffa74756aaa2a7d
      https://github.com/bluez/bluez/commit/cd6a809f7b43b00f3e05f4c46ffa7=
4756aaa2a7d
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


  Commit: 776f9062c8450bb9b37297f1f01c0c9800dfdc91
      https://github.com/bluez/bluez/commit/776f9062c8450bb9b37297f1f01c0=
c9800dfdc91
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M attrib/att.h
    M src/device.c

  Log Message:
  -----------
  src: replace ATT_PSM with 'shared' BT_ATT_PSM

Avoid multiple definitions of the same value.


  Commit: d5c85b052eeaf34dec1b2e85144615c7b99d0af2
      https://github.com/bluez/bluez/commit/d5c85b052eeaf34dec1b2e8514461=
5c7b99d0af2
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M tools/btgatt-server.c

  Log Message:
  -----------
  tools: btgatt-server: remove unused member 'fd'


  Commit: c8a7462f34907248a6259e8a26b79baaa1f7245b
      https://github.com/bluez/bluez/commit/c8a7462f34907248a6259e8a26b79=
baaa1f7245b
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


  Commit: bf52d63014fb68ba027629118837a8031abfeff4
      https://github.com/bluez/bluez/commit/bf52d63014fb68ba027629118837a=
8031abfeff4
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


Compare: https://github.com/bluez/bluez/compare/a96f5f4eba9a...bf52d63014=
fb

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
