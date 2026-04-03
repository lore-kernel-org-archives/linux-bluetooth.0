Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E443612EE
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208710; cv=none; b=EjuJBzLoGXYjJAIUjynWtaGRvnZilJjqEUBDk1P3IicJIyp+bZe5nfQ+ULB8y0POoM9JZJe88MRg22yB7qMP3T4V0EGohrg375B23q8xDTAFwoRS8OP6MGwsoF+fDUr9RDvh60lmLjAeKtpXUkZ0QDHHDuEHgnycgcN0weEvsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208710; c=relaxed/simple;
	bh=1SwT5Y374AoD3rlZU1Vk4rxMt5aFTbqKQ+48PiMhBy8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nYvTT3H49PJRGVo1KJDF8GsfjFi+GPyNxzrJwjxI008ovY/MctPVbb5HWji4NmF/lGtDsj6Hh6xCEKUZfU9fAQ/AWLNFj8p/Xhuk3PcbI7jRujIiTjtCWmhvLZ5zfSuZJ1V0mmYADvWA+Xjot33I9S5piQZryVaPYdJnDDvKOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VWouW6CN; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VWouW6CN"
Received: from github.com (hubbernetes-node-4521621.ash1-iad.github.net [10.56.166.31])
	by smtp.github.com (Postfix) with ESMTPA id 28C46121029
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775208706;
	bh=44lqjRxJepiopY1yvf1Kme5cB2IbJ6IEA2FRiHQGKJc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VWouW6CNUs0zhUF+wu3Nxe1nwMNgokOXENxGWQ/kGqW/4ZhP4iYW7+2RJ5gjk1XYS
	 r8qShTYybvhXUhwmGr9Ft/YfrR2Ij76aG6VTkq5bU49dxkRFyPEu9Sr/XZiIMwHw45
	 7bmK1l6bWUBqfb876gEIUzH0MrPmME+PbjWqtfrA=
Date: Fri, 03 Apr 2026 02:31:46 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076877/000000-3f0f9a@github.com>
Subject: [bluez/bluez] 77a506: shared/queue: Add way to iterate over queue
 contents
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

  Branch: refs/heads/1076877
  Home:   https://github.com/bluez/bluez
  Commit: 77a506817b36dd00a1b24a1a6b1d0ed3182542e3
      https://github.com/bluez/bluez/commit/77a506817b36dd00a1b24a1a6b1d0ed3182542e3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M src/shared/queue.c
    M src/shared/queue.h
    M unit/test-queue.c

  Log Message:
  -----------
  shared/queue: Add way to iterate over queue contents

There were no accessors that would give us an iteratable structure,
leaving us with just *_foreach() constructs that are cumbersome.

Add a way to get the first entry in the queue.


  Commit: 2583ddbff91a7777ad4b4c055f1726dc5d4cb895
      https://github.com/bluez/bluez/commit/2583ddbff91a7777ad4b4c055f1726dc5d4cb895
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M plugins/neard.c
    M src/adapter.c
    M src/device.c
    M src/device.h
    M src/eir.c
    M src/eir.h
    M unit/test-eir.c

  Log Message:
  -----------
  shared: Remove glib dependency from src/shared/ad.c

src/shared/ad.c includes src/eir.h, which uses glib, which means that
the non-glib shared library can't be used without linking to glib.

Use our own queue implementation to remove the glib linked-list usage.


  Commit: 74ebe5ad98596a577e72cf9fb508024d2087f667
      https://github.com/bluez/bluez/commit/74ebe5ad98596a577e72cf9fb508024d2087f667
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M src/shared/queue.h

  Log Message:
  -----------
  shared/queue: Fix warning when compiling ad.c

Both ad.c and eir.h include queue.h as both use the struct declared in
this header. Quiet the warnings with a stanza that means it will be
ignored second time around.


  Commit: 3f0f9ad6e79f9e299f7534131367d03af1cf9466
      https://github.com/bluez/bluez/commit/3f0f9ad6e79f9e299f7534131367d03af1cf9466
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M src/shared/csip.c
    M src/shared/rap.c

  Log Message:
  -----------
  shared: Remove unneeded glib includes

glib was included, but no glib functions or data types were being used,
so remove those includes.


Compare: https://github.com/bluez/bluez/compare/77a506817b36%5E...3f0f9ad6e79f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
