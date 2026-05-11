Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04322F8E81
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516268; cv=none; b=VoYQfCBXMBKOn+kNVkmHcrLkjfjWh4LJ99q06Dcmd0RXe2n7H0/RaxSGEAMAU9LcuZM4goruSVoPaDBAeA5sz2fqypv1XxoGofK6DFn8kauLUq4XJMezeiRVHHJYSVY10ETtJ9S+I7itx6jkHdUCsjJ40BDAZKJaa0eeML0eOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516268; c=relaxed/simple;
	bh=bY5UYExxN8OcPklzX/bBEiOfPs1c5cNSLobAV5PRQuY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sKWYjVwwwpeDl1b3uvAQwYsZLV29XqAXB64D30EKNDAd+snrSIdcf7XrHqgZSStl+kXIYfYc60tMI61UjP5p9sFK6tvLimjQQqQ+Y8PQVQ5CaCAvtgScWSCwaEvLJNtLXLxGB+06ArrHfAnqFUj3mjjSsHFNaDJci2cTZhE7rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J8Mm0Aps; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J8Mm0Aps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778516263;
	bh=oyr059s3IC9DncZBJZwWWsm3g/sCPOsvCodcWNd6K0c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J8Mm0ApsnbFj9bLaRe3YrRvMjiQ7QVZtHMLMJQmmBscQEb1Mw+K6u4nDP29JhIz8g
	 HzaZlIKqppHvBoZDM89N/d/weT5ZKjQd7hOtnd1Bh9Sm15rnASQKpjIHDQgp7xZXsD
	 t7Ll8/vVmBKTEFHXjAegKZBwMj7qbFi6rezupwak=
Received: from github.com (hubbernetes-node-d5669e3.ac4-iad.github.net [10.52.163.22])
	by smtp.github.com (Postfix) with ESMTPA id EF106210F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 09:17:43 -0700 (PDT)
Date: Mon, 11 May 2026 09:17:43 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1092801/000000-af87aa@github.com>
Subject: [bluez/bluez] 61f18b: all: Remove more unneeded MIN/MAX macro
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

  Branch: refs/heads/1092801
  Home:   https://github.com/bluez/bluez
  Commit: 61f18ba7be36b9be5ab6dcdde0384342c13a3074
      https://github.com/bluez/bluez/commit/61f18ba7be36b9be5ab6dcdde0384342c13a3074
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M lib/bluetooth/hci.c
    M src/main.c
    M src/shared/gatt-server.c

  Log Message:
  -----------
  all: Remove more unneeded MIN/MAX macro definition


  Commit: 98ed10e18895daeb15710d710a0803f6115c20f2
      https://github.com/bluez/bluez/commit/98ed10e18895daeb15710d710a0803f6115c20f2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M src/shared/util.h
    M unit/test-util.c

  Log Message:
  -----------
  shared/util: Add helper for "cleanup" variable attribute

Use the widespread "cleanup" variable attribute:
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup

It is implemented by both GCC and clang on platforms where bluez is
used, and can help reduce memory leaks, while improving readability.

This implements:
- generic cleanup (_cleanup_free_)
- cleanup with specific free function (_cleanup_())
- cleanup for specific types (_cleanup_type_(type))
- cleanup for file descriptors
- capturing a variable before it is freed (so it is only freed in error
  paths for example, _steal_() and _steal_fd())

This commit includes tests which should cover all those new helpers.

See also:
https://systemd.io/CODING_STYLE/#memory-allocation
https://docs.gtk.org/glib/auto-cleanup.html


  Commit: efd84a04d454729f63e8d1066d9dc3b43065d395
      https://github.com/bluez/bluez/commit/efd84a04d454729f63e8d1066d9dc3b43065d395
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M doc/maintainer-guidelines.rst

  Log Message:
  -----------
  doc: Recommend using _cleanup_ and friends


  Commit: af36f1586544499ac5d4fa267283ea58bdaed9e7
      https://github.com/bluez/bluez/commit/af36f1586544499ac5d4fa267283ea58bdaed9e7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify configuration parsing

Use helpers to simplify temporary string usage, and cleanup in error
paths.


  Commit: 6c98d5b5189da2de46d50c8cc7f9bee0ae56c259
      https://github.com/bluez/bluez/commit/6c98d5b5189da2de46d50c8cc7f9bee0ae56c259
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client: Use _cleanup_fd_ to simplify urandom access

fd gets auto-closed before exiting the scope.


  Commit: af87aaabc6926eb294244ab8da514bc4b221b344
      https://github.com/bluez/bluez/commit/af87aaabc6926eb294244ab8da514bc4b221b344
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M tools/btattach.c

  Log Message:
  -----------
  btattach: Use _cleanup_fd_ to simplify error paths

Use _cleanup_fd_ and _steal_fd() to simplify error paths, and only
"steal" the file descriptor on success.


Compare: https://github.com/bluez/bluez/compare/61f18ba7be36%5E...af87aaabc692

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
