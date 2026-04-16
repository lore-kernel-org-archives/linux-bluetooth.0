Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46928751B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354710; cv=none; b=e7pKHCQ6rC/UgG+gPtZHMzH6DVqdjrmx7Jyd+nYpj7MePhR4tJnu8LHZO44bFkxrg/7oiXqdDNdFtjcrCcXzrz2wJYk0jZCAeP89zniaFKJNDANHhqXTq3gmBkyYZotP3O4BEViIAaj7aljVl5bBG0masd5vVNgd9vQCQohvCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354710; c=relaxed/simple;
	bh=3YD9J4kBpijYTd7vEM9Annl9fUAOEJWGZKl6OSzqQWM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZtFoVClzTAdPTL3ZvmcKRWT4NeBEKnD8dViBXc6QoYdmIWTQTrLDLWBnog+X1qIDVfuYe+El06PUyL/EdAYMl5v1ewtJ4gld+TVrvfBf/6MXKjtNJCKWW4wbIQuvhHytWuGw4V2oRKAFPh/mXuyH2ZLUbr6vqTBbFjPEdtZwnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FQR3qZGo; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FQR3qZGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776354707;
	bh=OK9Un0DMx5ndQY79qm5WcFhNqIhWJAt1zgAuXdcfybE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FQR3qZGoJm6V4t2/rfxYpV8yee5Z3XuacyfskfJS1DlGU7K5rO9FYwzGS+ABOv4pc
	 izXN1HsOvH0FeTi7jb8KwvkHHSk6nkuANFWO9Hvksm/bSsQMa2lmKQSqWY7qauhnMa
	 PrzpWQ6rF55cAC26s9kq+Jvn9Kv+YGzr2MU/aebM=
Received: from github.com (hubbernetes-node-7aeaeb7.va3-iad.github.net [10.48.139.39])
	by smtp.github.com (Postfix) with ESMTPA id 58FDA1812AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:51:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:51:47 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/590bed-07a0b8@github.com>
Subject: [bluez/bluez] 91c340: shared: Remove glib dependency from
 src/shared/ad.c
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
  Commit: 91c340d359b7ae6cd690ae2c6b2acda48c8837f6
      https://github.com/bluez/bluez/commit/91c340d359b7ae6cd690ae2c6b2acda48c8837f6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

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


  Commit: 6a6aaeba6aed3b5994476f9e21a0e417a158c44e
      https://github.com/bluez/bluez/commit/6a6aaeba6aed3b5994476f9e21a0e417a158c44e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M src/shared/queue.h

  Log Message:
  -----------
  shared/queue: Fix warning when compiling ad.c

Both ad.c and eir.h include queue.h as both use the struct declared in
this header. Quiet the warnings with a stanza that means it will be
ignored second time around.


  Commit: 07a0b87e6b34c57f36ce8995a6414bc2e3332790
      https://github.com/bluez/bluez/commit/07a0b87e6b34c57f36ce8995a6414bc2e3332790
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M src/shared/csip.c
    M src/shared/rap.c

  Log Message:
  -----------
  shared: Remove unneeded glib includes

glib was included, but no glib functions or data types were being used,
so remove those includes.


Compare: https://github.com/bluez/bluez/compare/590bed15fbaf...07a0b87e6b34

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
