Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850E409277
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768495; cv=none; b=AiTFjYc+5TefjD4sLMGtSxCHIA7hLV9dkFO+H4mCMfuRCEvrIn1fqhZnpjOTbItyTA6+AJj7AoYzyJUJ8R0ssKXbgkHGaXrJ1Dfg7uLuidEc0cvFRyJWXj+MGSskfQcujDm8+dFpn+s9iSd7guBbeiTuLE7JFISA8BNCSOEwE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768495; c=relaxed/simple;
	bh=IgC8CWkX2sChYQDj6nqS9tP6ApZIbeqUHxdh0j0gtGc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZVZIOOJxtU2gBxEhVuMpvh3CDLjKtPNEdKTSAV0DuM+zFwQl7uEMbfoySzzjrsjAOteL2PkrzeN9KM52/St68EuSLdeocUIz+4fCdUSONjGUlbss7kWbHCac3+pYp5xE6bY/GkplqbiRS0Uf44YoXQ8DE7ml1N66oPzQprLHH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X+yYTOig; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X+yYTOig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787768487;
	bh=hShvGxTe9SA/SUctnSsS2ts1r8pVVO2TfqVXHUhbgY0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X+yYTOigywJd0A1O1Mo7OwAVUp4HePLvoW1OYwe83gZER85uXxOhXrLBAsznhWa6s
	 DBKvhTArk18CI2V581UVYhdzDljAY3aZRHhu1SgNmB4CgOnCKzBNhjZGJKfCyeGS/f
	 idI7GdOQ7LgwScEFXQfGAMHi5jSd+ZTaVzqCjouQ=
Received: from github.com (hubbernetes-node-4512462.va3-iad.github.net [10.48.77.82])
	by smtp.github.com (Postfix) with ESMTPA id 8B6433414A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 11:21:27 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:21:27 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152198/000000-e561a7@github.com>
Subject: [bluez/bluez] 368446: btio: add BT_IO_OPT_FORCE_ACTIVE support for
 L2CAP...
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

  Branch: refs/heads/1152198
  Home:   https://github.com/bluez/bluez
  Commit: 36844661b7ea2ed80c2a2704c5d6429f006826be
      https://github.com/bluez/bluez/commit/36844661b7ea2ed80c2a2704c5d64=
29f006826be
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-26 (Wed, 26 Aug 2026)

  Changed paths:
    M btio/btio.c
    M btio/btio.h

  Log Message:
  -----------
  btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets

Introduce BT_IO_OPT_FORCE_ACTIVE in btio and plumb it through option
parsing and L2CAP setup.

When set, btio now programs BT_POWER on the underlying socket, allowing
callers to explicitly control force-active behavior.


  Commit: e561a7c662a0495b1ae18e517c2db484c55aaeae
      https://github.com/bluez/bluez/commit/e561a7c662a0495b1ae18e517c2db=
484c55aaeae
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-26 (Wed, 26 Aug 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  profiles/input: disable force-active for Nintendo Switch Pro v1

For Nintendo Switch Pro v1 controllers (VID:PID 057e:2009), set
BT_IO_OPT_FORCE_ACTIVE to BT_POWER_FORCE_ACTIVE_OFF on the HID interrupt
channel during connection setup.

This avoids repeated host-triggered Exit Sniff requests and reduces
Sniff/Exit Sniff churn linked to unexpected disconnects.


Compare: https://github.com/bluez/bluez/compare/36844661b7ea%5E...e561a7c=
662a0

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
