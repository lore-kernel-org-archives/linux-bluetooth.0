Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF22836B5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653160; cv=none; b=Zy4WP3JwfkA6BY4E5FNVcx46VRpX8e6T4T1BgFx9vAHI07uO/KMj4OeYYpH8EBYm0PdhhitD9IlYRiRkgXRVAnGoiFq1VJ0EhgCP+3D1ffwasuIn/JmMGLpkfU0+N6syV8rnsn2dWU1XZ5/sf/Gcr5Z0QULutICYGhst48yzqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653160; c=relaxed/simple;
	bh=yVgBsb4oWonjeIQHDXpIg+T6xdpiQs/5NSvAsFpmyEk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HaSWEtvTGctpTIpfK4TGzqxf2xBf36FEni4gq5I3gOPqZrQZZIW9pW1vBuWTVex3UY3L7za0EAyUjQnzterM5fW3s6YKvu6MG3MjEornVG3ReJFZxeWEYADCCp6O0SSSyonT/20bISCgisi7C3QpyhW7VK/zsUYpaQ91Wnrlfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DPqyz5A0; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DPqyz5A0"
Received: from github.com (hubbernetes-node-c7e061a.ac4-iad.github.net [10.52.164.26])
	by smtp.github.com (Postfix) with ESMTPA id 7D631700703
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749653157;
	bh=agGw3BED/5C52e0HEY3qcocYR1SqPYhY+f/WgPh7bUg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DPqyz5A0aBfJCKQRlZRzuNC9VJmpZiVcX46Lo2bjEdC+iflB9URl6dqwWxLAlwd5A
	 1erjhfhL1rCfIeHoRhgft7qF9Qs7r86oLgaHpHk3G0zzXKq11MbVIxGbr8hNZSrfCP
	 cd3pQIS6s8LCJxuMZBYtpI8WLPHjlJNj4glsnyrA=
Date: Wed, 11 Jun 2025 07:45:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/95b72b-aea0f4@github.com>
Subject: [bluez/bluez] b7dfcc: doc: sco.rst: BT_PHY is read-only
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
  Commit: b7dfccf0e52aa4628a731dd555f038d18ddd42fe
      https://github.com/bluez/bluez/commit/b7dfccf0e52aa4628a731dd555f03=
8d18ddd42fe
  Author: ValdikSS <iam@valdikss.org.ru>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M doc/sco.rst

  Log Message:
  -----------
  doc: sco.rst: BT_PHY is read-only

The kernel is missing BT_PHY setsockopt support, as of 6.16-rc1.


  Commit: 883c1c11c6448e7f0ca04e523a5ac2030d7f161c
      https://github.com/bluez/bluez/commit/883c1c11c6448e7f0ca04e523a5ac=
2030d7f161c
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    M obexd/src/logind.c
    M obexd/src/logind.h

  Log Message:
  -----------
  obexd: Pass at_(un)register value to logind callbacks

Logind (un)registers callbacks that it calls when the user's state change=
s.
Callbacks may also be called during (un)registration.
Clients may need to handle those initial/final calls specially.

Pass an argument indicating whether this is being called during
(un)registration, and modify existing callbacks to ignore that argument.


  Commit: df0036d9e41fc4bb0fe8839b7833bac16359396b
      https://github.com/bluez/bluez/commit/df0036d9e41fc4bb0fe8839b7833b=
ac16359396b
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: use the public DBus connection

PBAP must not use its own private DBus connection, as it needs to
receive messages sent to the bus name of the public connection.

PBAP must not unregister itself when the program is exiting, as it might
cause a long delay.  Unregistering at exit is redundant anyway, as the
service will be implicitly unregistered when the connection is closed.

But PBAP must unregister itself when the user becomes inactive mid-sessio=
n,
so systems with multiple users logged in at once can share bluetooth.

Use the public DBus connection instead of a private one,
and explicitly unregister the profile if appropriate.

Thanks Pauli Virtanen for pointing out the exit issue:
https://lore.kernel.org/linux-bluetooth/ae15a9fa4bf0bd509dd3d44f1f364e241=
e50956c.camel@iki.fi/

Reported-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8=
e69fb47535f@collabora.com/
Suggested-by: Pauli Virtanen <pav@iki.fi>


  Commit: aea0f46f173f85a71908452b0c6ed16f647f6117
      https://github.com/bluez/bluez/commit/aea0f46f173f85a71908452b0c6ed=
16f647f6117
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M obexd/src/main.c
    M obexd/src/obexd.h

  Log Message:
  -----------
  Revert "obexd: Support creating private system/session bus connections"=


This reverts commit 237d818ef294e22be87fba69b3cdd79c75c201e7,
which encouraged the use of private DBus connections.
Doing so caused a bug, so it's better to remove the temptation for now
and re-add it if a legitimate use case is ever found.


Compare: https://github.com/bluez/bluez/compare/95b72bbf1fe4...aea0f46f17=
3f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
