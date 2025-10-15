Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9F2629F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543197; cv=none; b=Urlvm6oxvQEOZZq/fd2YVkASvqxomeKaWNeQx8Yr5EjFyxbOTngeVjvpOuUlYq4OJ57En/qK+DvjCemPeLUUhVRS4M23eO6DPnprvinWlm+BDIHvRl11u1n4lLB4r4GjXYHKjbRuleBNa1fgF0WFDhulBS12fprW30/gpjJEths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543197; c=relaxed/simple;
	bh=16+ENBTR+SPSYWg2uDThWOkDK/nhcsZUZ6/Y/0OHXhE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kBp1tG+4R4NiPe/LPf7m2WxLuKGEtswe+dWyYJWuaIwgUcaXKKLaIgv7ZklIiA29n708QRSKZu1JhnKCU19mBbPAUXZnkZpX6wIJdpQIrK6UYjfj+RYmJD5PETAC/1sSJp1Wt/BptZrgXC4n92gr2J5rH8J/tOgWv9lFe1zz2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ag3mZLnE; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ag3mZLnE"
Received: from github.com (hubbernetes-node-aa1bca4.ac4-iad.github.net [10.52.134.25])
	by smtp.github.com (Postfix) with ESMTPA id F17E4210B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760543195;
	bh=CkELMV8naOkQJMVGTHnN5cAgp8JIKEj9QY0JL6nnEPw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ag3mZLnERV8r0lDMxIXXE3jWu4YoZeTOuJM87Gxf47NuLhmNG6Nrl45wT+7bygK1u
	 Q+LsPXPWCiJVtdGAQirGK6Dif7exHH5A126HK6jlznwxYK2p054IKfD7c5Bf741I8R
	 qAwtL3F9VB6db7SGmsLo8SvS//nypp6tQIQyHt1A=
Date: Wed, 15 Oct 2025 08:46:34 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1011959/000000-42be56@github.com>
Subject: [bluez/bluez] 32197f: bap: tolerate inverted STREAMING and
 iso_connect_cb()
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

  Branch: refs/heads/1011959
  Home:   https://github.com/bluez/bluez
  Commit: 32197fd668cb86c0d6750cb68d51f225f993bd48
      https://github.com/bluez/bluez/commit/32197fd668cb86c0d6750cb68d51f225f993bd48
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-15 (Wed, 15 Oct 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: tolerate inverted STREAMING and iso_connect_cb()

Ordering of STREAMING and iso_connect_cb() is unspecified, as
kernel/Glib do not preserve the order of these events.

STREAMING before iso_connect_cb() causes transport to fail Acquire()
since bt_bap_stream_io::connecting == true.

Fix by marking IO as connected even though the connection didn't yet
complete. The socket fd is valid, although not yet writable/readable.

Fixes: https://github.com/bluez/bluez/issues/1506


  Commit: 42be568f2c1286bb0f4de833e12630af9a676bfb
      https://github.com/bluez/bluez/commit/42be568f2c1286bb0f4de833e12630af9a676bfb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-15 (Wed, 15 Oct 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: wait until BAP fd is writable/readable before resuming

Connection may still be pending when entering STREAMING.

Wait until the fd becomes readable/writable before continuing.


Compare: https://github.com/bluez/bluez/compare/32197fd668cb%5E...42be568f2c12

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
