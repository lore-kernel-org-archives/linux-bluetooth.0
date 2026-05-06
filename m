Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C93F9F3E
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061991; cv=none; b=aVUXPzZbAyy3HfZwAwxezka3tcexuCLEoGjGGVZi5Qri63H6zHri4hid5mM18/gQZsX7/BCy5jnQ6+2GENCK3ZFMfr29tMsqxpY3T3/LkUenrfpZHveixvdvjgA+WY/WYdKNpQkCjrbSUjcewYZH/C9eatHPrLpItIJ+tynni9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061991; c=relaxed/simple;
	bh=CCRCpm6luc8rnK2uGy0ljFO9qojJk+AuiozdQwdJe+A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h5hZ7x3MX9A59H9JyhGhYlP6MV7CCEQk7YQkYX027s5ewZ5I/HrIcpYsOuf2lAQYyOpVpNr1jY7cL7+ytiSc0sqrDKN4AS/zrki1TrPeYA2vcbldqbqiQktnx8VIsmW6RpoObL3RsH65XqM4Em8iB8xkig6xvuBtkImQ78CnUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P/CVTLgV; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P/CVTLgV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778061986;
	bh=ca3GnIijAmPlNyTpQ86JY8m+GDggfBzlNjYAxgTFYco=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P/CVTLgVbPARhc2wVK92KZzjnTbg93mv8oq6saZFoxhEGp+Hr9sY8PQmVupNTQdZX
	 GCDpBMhCHyZ1nIFBUKubKnb877TaJXaznIX6S/WK8TA7h23cnFvzIaQvNncdtiOYEO
	 ZSUsV2+9bMFiDSNKJ+XJdTwQb96QVAsnQqsZJQBw=
Received: from github.com (hubbernetes-node-fea5f67.va3-iad.github.net [10.48.146.20])
	by smtp.github.com (Postfix) with ESMTPA id 97E8F80126B
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 03:06:26 -0700 (PDT)
Date: Wed, 06 May 2026 03:06:26 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090349/000000-036ef7@github.com>
Subject: [bluez/bluez] 7ffffa: all: Remove more unneeded MIN/MAX macro
 definition
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

  Branch: refs/heads/1090349
  Home:   https://github.com/bluez/bluez
  Commit: 7ffffa83a1d73a2e3a2236a441ed7bd2b7ffa611
      https://github.com/bluez/bluez/commit/7ffffa83a1d73a2e3a2236a441ed7bd2b7ffa611
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M lib/bluetooth/hci.c
    M src/main.c
    M src/shared/gatt-server.c

  Log Message:
  -----------
  all: Remove more unneeded MIN/MAX macro definition


  Commit: feebce7236870c9c6ef782e59c61c110ddd2d785
      https://github.com/bluez/bluez/commit/feebce7236870c9c6ef782e59c61c110ddd2d785
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add helper for "cleanup" variable attribute

Use the widespread "cleanup" variable attribute:
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup

It is implemented by both GCC and clang on platforms where bluez is
used, and can help reduce memory leaks, while improving readability.

See also:
https://systemd.io/CODING_STYLE/#memory-allocation
https://docs.gtk.org/glib/auto-cleanup.html


  Commit: bdb11f70c15bee5a5deb37c011797ef2500f5eb2
      https://github.com/bluez/bluez/commit/bdb11f70c15bee5a5deb37c011797ef2500f5eb2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M doc/maintainer-guidelines.rst

  Log Message:
  -----------
  doc: Recommend using _cleanup_ and friends


  Commit: 5984b16421ae28dc1c0fe2dfe1c5e9ccf78be055
      https://github.com/bluez/bluez/commit/5984b16421ae28dc1c0fe2dfe1c5e9ccf78be055
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify configuration parsing

Makes dealing with the error path easier.


  Commit: 036ef74099d88226fd820a29fd70f732ec06aaba
      https://github.com/bluez/bluez/commit/036ef74099d88226fd820a29fd70f732ec06aaba
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify GError-handling

Use _cleanup_() to simplify GError-handling in the error paths.


Compare: https://github.com/bluez/bluez/compare/7ffffa83a1d7%5E...036ef74099d8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
