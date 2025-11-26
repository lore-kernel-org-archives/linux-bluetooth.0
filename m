Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136729B204
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174235; cv=none; b=CR+Bf0NzzTV5o0FZzgqe+t5tvRHK8Mdn2kSkN2qwroDfmpxHEyvOXrYugLUO81eq0RD7GajAP0XU1zP5oUhpoVJCHDas6uls021OopIkd976fOERMfJJnO977d+xOr/NI1gjLKwFwwsGmdCUzFofhDavSce39OIMekAIT0gCYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174235; c=relaxed/simple;
	bh=fd26chSRw4EiQQD4lkAfc2JO715V6j2B9qKGamsWRmk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=n2CRy0inPCW4Z5aXGys4TMh2SP2kKe+VtBZ3b0YikBGJNzomqmNtIgGEzAfmQ6R8oHfABH0wgNTdv2P5GCgPFyFcqk7anKJ6/N3OsV9EW4QhU0M8zjkjcGDH4MejN00FW7bUAnrG77Wc61H7YcUu/a/8kgwwOyF9fGMWwGjlwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NQd6kOwL; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NQd6kOwL"
Received: from github.com (hubbernetes-node-a9ec292.ash1-iad.github.net [10.56.173.19])
	by smtp.github.com (Postfix) with ESMTPA id 949F36007F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764174233;
	bh=Czdddj4JczY+s6sah0kxQgjlslGHyjFRQtr/7iXQY0E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NQd6kOwLMCX82GqXgU1iRFoTkwpAju6By0TpKwZZAlKtS4TqbZiqOwZ7gfdQMoleJ
	 AmI6qbXXSGA+jsAiMa1d/D56J8sZy2B+g1F2kvd1SP0XI4l3iEb3XVRZpFU2uctgaa
	 pVTVKrRN1qMld51lQ/8eKzcXcYR/zJYGbuJwfRik=
Date: Wed, 26 Nov 2025 08:23:53 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0b7395-0f56b2@github.com>
Subject: [bluez/bluez] 12e32e: shared/tmap: add TMAP Service
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 12e32efac2e495f965bd5aeeb1406744d749addd
      https://github.com/bluez/bluez/commit/12e32efac2e495f965bd5aeeb1406744d749addd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M Makefile.am
    M lib/bluetooth/uuid.h
    A src/shared/tmap.c
    A src/shared/tmap.h

  Log Message:
  -----------
  shared/tmap: add TMAP Service

TMAP Service is just a simple service with a Role bitmask.

The value can be used to figure out which TMAP roles the remote device
claims it supports (matters for available mandatory features).  Also can
advertise the same for remote clients.


  Commit: 7b93dae26a57a88ed373b078a4f3a9f03fd1ea13
      https://github.com/bluez/bluez/commit/7b93dae26a57a88ed373b078a4f3a9f03fd1ea13
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-tmap.c

  Log Message:
  -----------
  test-tmap: add test for TMAP Service

Add tests on TMAP service for reading the role attribute.


  Commit: 0f56b20f9196b1b460ba1d446510b20901378909
      https://github.com/bluez/bluez/commit/0f56b20f9196b1b460ba1d446510b20901378909
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/tmap.c

  Log Message:
  -----------
  tmap: add TMAP profile

Read TMAP Role from remote devices and enable advertising the value for
local services.


Compare: https://github.com/bluez/bluez/compare/0b7395a34796...0f56b20f9196

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
