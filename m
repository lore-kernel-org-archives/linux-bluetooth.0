Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFD311C2A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932012; cv=none; b=AjeXOq3SOLeSAzq2UE5AsMeaGc3CbP4K6xP6X415fG1tIHZ1J8bBor6eGYMHqNDi4pGvtL/FESkp3u3p3jEzLcMUizqKpxwsDkzVpxjJIw1vST08RyA+nbH4IWKXoiBGqw3RU1iHBJQWShPRciE3QYO3k3CHpG4yz4aS5N+aBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932012; c=relaxed/simple;
	bh=agjPNPpll4YXeOLSIgwiFAlzAzKFUzrBIBU0Ykc3vOc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VR0+dnMVpqDgd9nw8iHr/NbUDJnk5ILaDxjID8RC9wtaPRFkGcAqYOFdU7RDNdmUnv/JDXx+zLmT46bmJYYXv4pyURuDUQ9eFPO9u2CzgJh8caENuF+ztIIjl5nkXcYlfQc0cokjpm/5GeHSmSgOIghfzPF/HcZsU2RpDHuyt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Jt8mZ6kA; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Jt8mZ6kA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776932010;
	bh=9ZehD9rVPjchwgYs7r+5JdSb5BoF1kWLXYoWWZBICo8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Jt8mZ6kAv7c869WcBCWPEIYSDr7a9GeMEjUsutmEr1iS2kkBrAcb1l9nxGRrEB1hN
	 lw326LrywUtXMHvBpaXixEJqj1S5Pb4lP2Deqp+ASDgfyfQlKMZtzm5QdFYeGZjrN2
	 nIRfgeWnmEGtrVUVLh7jZIi5jktEBXa6EoIMjAZI=
Received: from github.com (hubbernetes-node-76be4d8.ash1-iad.github.net [10.56.201.55])
	by smtp.github.com (Postfix) with ESMTPA id DA3D26010D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 01:13:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 01:13:30 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084559/000000-f44f8c@github.com>
Subject: [bluez/bluez] f8f43f: audio: Add ability to force CIS transport Links
 pr...
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

  Branch: refs/heads/1084559
  Home:   https://github.com/bluez/bluez
  Commit: f8f43f9bcd6f3507e7e258fb7abeda0e43168a16
      https://github.com/bluez/bluez/commit/f8f43f9bcd6f3507e7e258fb7abed=
a0e43168a16
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: Add ability to force CIS transport Links property

If bluetoothd is started in testing mode the Links property for CIS
is readwrite and can be used to force transport objects Links.
This can used to unlink transport objects by sending an empty array.

For unlinked transport objects, each transports needs to be acquired
separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


  Commit: 7bd76e0b3708985aade4e5db8457142e19a973fc
      https://github.com/bluez/bluez/commit/7bd76e0b3708985aade4e5db84571=
42e19a973fc
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc: Add documentation for readwrite CIS transport Links property

This is only supported when bluetoothd is started in testing mode.


  Commit: f44f8c555c8b923e7b8f1c01b71a9e68a79477b2
      https://github.com/bluez/bluez/commit/f44f8c555c8b923e7b8f1c01b71a9=
e68a79477b2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to unlink transports

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


Compare: https://github.com/bluez/bluez/compare/f8f43f9bcd6f%5E...f44f8c5=
55c8b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
