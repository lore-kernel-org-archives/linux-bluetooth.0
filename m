Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD374217F31
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670461; cv=none; b=sddLjC+apAl0GOqVlIgIDAKru5hUN6UqRliTnbBX9zYUfqgeMGyth0Z0bXuUTd9BOs0S6W8ruvtua9nY02EFCgeGXvekZ+nO0qbNlYw50W13KiCg9pEh/9HD+Skkau60LSs+ltxcvZAYSh3za5voSbfNlg9G7yHxVK7iLjrUgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670461; c=relaxed/simple;
	bh=kizWeub/fTYEfgAR6lyE02Yr7Z4ZdBgLhHD14FKeRMM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a9dow/SksgsiAFbP7oCuf8/7vKOAF9quCXiHAjl17nEyfT1FHaP0SJ/EA6ZskPjoZoXu2QWUIsRVWZg8uTpizqOGul2SQ1bh7j14yMYAAWSV3mW2PH+hzn3UTCcCnWeLg4EPBi3GhT2o2VJrLG7pbBcSM2swSxKrBAbFW+xEUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UK3FWri4; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UK3FWri4"
Received: from github.com (hubbernetes-node-06dd849.va3-iad.github.net [10.48.125.88])
	by smtp.github.com (Postfix) with ESMTPA id D96794E0968
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770670459;
	bh=pJjRY8gHZdOD9tFJMusIDxH9jNEUkMo5WmNIqeR4QXE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UK3FWri4ZZqplYFuc+bkqu1fbxGDUEeqh/9tnI7XZqJSxsP75pSruVbR4zbnKHhvK
	 /ssz8fl+2DT5zKFxlDtOnhG72d/N0QC5DWkgKO8ulFECfw0nho5Yb6NXJa/+LBZzqC
	 9/DOSIGaIge/U5dYON+9SXojff4M0lQv9TtJbm/0=
Date: Mon, 09 Feb 2026 12:54:19 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052425/000000-4b83f8@github.com>
Subject: [bluez/bluez] f7ada9: shared/util: Add byte-swapping macros for
 constants
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

  Branch: refs/heads/1052425
  Home:   https://github.com/bluez/bluez
  Commit: f7ada9ee6bf13e9dfee92aee847af1bd252fcbeb
      https://github.com/bluez/bluez/commit/f7ada9ee6bf13e9dfee92aee847af=
1bd252fcbeb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-09 (Mon, 09 Feb 2026)

  Changed paths:
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add byte-swapping macros for constants

We can't use functions to populate constants, so add new helpers for
the various __bswap_constant_XX macros available for that purpose.


  Commit: 4b83f8842c1e1809a5738e0dbfa0e78ea71eb0f5
      https://github.com/bluez/bluez/commit/4b83f8842c1e1809a5738e0dbfa0e=
78ea71eb0f5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-09 (Mon, 09 Feb 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: Fix compilation on big endian systems

Use new helper macros for byteswapping constants.

This fixes the build on big endian systems like s390x:

emulator/bthost.c: In function =E2=80=98bthost_setup_sco=E2=80=99:
./src/shared/util.h:43:26: error: initializer element is not constant
   43 | #define cpu_to_le32(val) bswap_32(val)
      |                          ^~~~~~~~
etc.

Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
incoming eSCO")


Compare: https://github.com/bluez/bluez/compare/f7ada9ee6bf1%5E...4b83f88=
42c1e

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
