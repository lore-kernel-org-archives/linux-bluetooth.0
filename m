Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EA341AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526081; cv=none; b=QHADG8lsaPMPVf2DAbCs2m1ivronloQGM8wEQzwSsKccRKoZfTiTPGgUoOikJWnFoMLk0Cugo+EK7kXj04fA2adJdi8i1tKcJYaLeY7Fb8mmSkwKYyLNrZkgPRhkIXO0DdTnJYuoFdB1vj2mwBtP4jP/YN5Ge8l2unIshOnsk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526081; c=relaxed/simple;
	bh=HqGitRDEd3ngFP0PTQGAFoI34FVu8kXeXU8ZJab67UU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Oaxw1hLk8NjIX+5sJNlY09DxSnhnnNiY43Fs4IdPqhkNIy6tgE5JoAxfMsek0mf4/j6hhl1QL2HKA6RbXHpwQ9yaXmdfmnOhRj+DRmA7OrxyHgzzWkAIwhQwbJC2I9fYNW7Eu26Q7iiJFNZgDKYmHbxjoT694GrlToKUFTymYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QrLJtMeB; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QrLJtMeB"
Received: from github.com (hubbernetes-node-d78fc17.va3-iad.github.net [10.48.142.30])
	by smtp.github.com (Postfix) with ESMTPA id 429E74E05DB
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752526079;
	bh=hVhxrCO6asAmpdIte10xO5Pk7wCzB+ZPvMF4YSHxsHU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QrLJtMeBoOPd3T3vviMz3p+SEA0wj0UA79VU7Pr5LJSmS1Ei1a+AGB8iqWkmAVqug
	 QnjUA+C/7mSs7sWC6hNQb+hieEiB/bDuGPueqXBlW9f4vButxueJPe0aEPi3vaNXiO
	 sH60au7FaSyTrLKTwxoZfkmZ/7AhuJaPCZowuqts=
Date: Mon, 14 Jul 2025 13:47:59 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982213/000000-e40ecb@github.com>
Subject: [bluez/bluez] 77cfff: device: Add btd_device_bdaddr_type_connected
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

  Branch: refs/heads/982213
  Home:   https://github.com/bluez/bluez
  Commit: 77cfff3ba001d10369c9844bf01379764758d3a0
      https://github.com/bluez/bluez/commit/77cfff3ba001d10369c9844bf01379764758d3a0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_bdaddr_type_connected

This adds btd_device_bdaddr_type_connected which can return the
connected state based on the address type.


  Commit: 74009521222ddfd7c757ce40f03e5e07ea3fe489
      https://github.com/bluez/bluez/commit/74009521222ddfd7c757ce40f03e5e07ea3fe489
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Bearer.BREDR.rst
    A doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  doc: Add org.bluez.Bearer.LE and org.bluez.Bearer.BREDR

This adds bearer specific interfaces so they can properly be operated
separately.

Fixes: https://github.com/bluez/bluez/issues/1350


  Commit: 84e94e1a638c35d757ed6625840684fd2f7c0659
      https://github.com/bluez/bluez/commit/84e94e1a638c35d757ed6625840684fd2f7c0659
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M Makefile.am
    A src/bearer.c
    A src/bearer.h
    M src/device.c

  Log Message:
  -----------
  bearer: Add initial implementation of org.bluez.Bearer.{BREDR, LE}

This adds initial implementation of org.bluez.Bearer{BREDR, LE}(5)
interfaces.


  Commit: 8873ae3b92776df520d45e37f3f5d46656f982ac
      https://github.com/bluez/bluez/commit/8873ae3b92776df520d45e37f3f5d46656f982ac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add support for org.bluez.Bearer.{BREDR, LE}1

This adds support for printing properties related to
org.bluez.Bearer.{BREDR, LE}1:

> info XX:XX:XX:XX:XX:XX
...
	BREDR.Paired: yes
	BREDR.Bonded: yes
	BREDR.Connected: no
	LE.Paired: yes
	LE.Bonded: yes
	LE.Connected: no
...
[CHG] BREDR XX:XX:XX:XX:XX:XX Connected: yes


  Commit: e40ecb4745442b0bc6c5e53616298531b08bf931
      https://github.com/bluez/bluez/commit/e40ecb4745442b0bc6c5e53616298531b08bf931
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Rework handling of Disconnected signal

Print with color the signal to indicate there is a change, also rework
the order of the parameters and use bearer specific suffix if the signal
comes from org.bluez.Bearer.*.


Compare: https://github.com/bluez/bluez/compare/77cfff3ba001%5E...e40ecb474544

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
