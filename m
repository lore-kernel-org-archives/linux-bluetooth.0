Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BA3E6DD2
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312686; cv=none; b=PGcMeEzdWhIb5/9m++W5O9fDNHYo7/NKgjQlxpqi+WiEUYpDPlR+NxC3grLij+pQiNjPAXabKiORqEBDkRFv8X8WGr9SrKC1aqcFTXtiH9ihnqRDsQxhQv/oNaVfcG9g7Um+VB1TpsZQMvKNzD++plxI+AGBi8AUf+dN+7fHS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312686; c=relaxed/simple;
	bh=blQI/BKvfn62/zi2u4Wjuaf5jQ40Ej/ql+X6JgO0V8Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hhOnmf3oHRD75hmWyKjFtY2fsSRK9jywoRyXnFUr5GquLRoplOtYw43E46zFC+O/l+KO4iWrEJ4P+X0xH4fO8OJTIdSTe1orxEGbOjQHG3xsWrzOK5BGQvzMrFR0Yb/A/RP8YE8EJw/bKkyf+RMukWhftK/xDrn5rrfJHHmu+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CTCKHPDw; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CTCKHPDw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777312684;
	bh=E9WC3Uwi0Gbfq5xdx6ONVxWMDzlaA6Lyie4UaGIoP3s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CTCKHPDwliW39RgskaPmgXzH6LYsjXJ+ribjd8jlTvo6cT+BsfwD7TqYSOqGGCoxq
	 oyvFrGD3eCOmCiyj1KrXjhaiAtrYOQIQEOB7Wvp7cxwgITHyjieK71dPsxGxlwhIIG
	 W5t/FtUel1h0AB+UPOdiDZiCRIn1RV64J9u1DIg0=
Received: from github.com (hubbernetes-node-d0a4592.ac4-iad.github.net [10.52.162.23])
	by smtp.github.com (Postfix) with ESMTPA id 4D8AE321061
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 10:58:04 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:58:04 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086318/000000-9100a7@github.com>
Subject: [bluez/bluez] c18634: audio: Add ability to desynchronized linked
 transport
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

  Branch: refs/heads/1086318
  Home:   https://github.com/bluez/bluez
  Commit: c1863432872e715acaee7ddeb32e93d6a9149983
      https://github.com/bluez/bluez/commit/c1863432872e715acaee7ddeb32e9=
3d6a9149983
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: Add ability to desynchronized linked transport

If bluetoothd is started in testing mode a new Desynchronized property
is added, allowing to prevent automatic acquire of linked transport
objects.

When desynchronized, each transports needs to be acquired separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


  Commit: db2fc7fa960a711f3e6c4691c4f73858a44ef23a
      https://github.com/bluez/bluez/commit/db2fc7fa960a711f3e6c4691c4f73=
858a44ef23a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc: Add documentation for CIS transport Desynchronized property

This is only supported when bluetoothd is started in testing mode.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 9100a7fccc84fc1f9d0c7b49612900297d94e187
      https://github.com/bluez/bluez/commit/9100a7fccc84fc1f9d0c7b4961290=
0297d94e187
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to desynchronize linked transports

After linked transports has been desynchronized, they should be acquired
separately and read handler should only be started for source local
endpoint.

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


Compare: https://github.com/bluez/bluez/compare/c1863432872e%5E...9100a7f=
ccc84

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
