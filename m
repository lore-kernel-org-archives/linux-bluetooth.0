Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038413ED5D9
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082950; cv=none; b=VpdxphSDBZ45OqEs1McVtSM5WycoelddhmInrrz0b9906wpBJU6+RTYBMSvSZLrO6nYSxVtADabZ01zgu5N9GBGXfiYO36KphWHMpZGVytjzeYnzt0vmIckAuuF3DOrh0gFY0ffVlXDqRVdPLZP+p06lHb0Kyk0YN/8lo0X3RxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082950; c=relaxed/simple;
	bh=y8uqLhZMPFxz0Ch0+HNK2kn4oE/a+G4GXMYEfFWtAy4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NSq+Da8gGbvQl2blVNhWLoRWDT6CmftkOLKQEvzQj7Qak4u02yeTREEY7dOzVCLZBM/5bvv5GLVsqyPLx+QhnvzrgKMafkg9xZbUvKl4UX/hhK9WEt/LSWY/x3lsTcD/fBwpBjBzxo+g9Iw8ve3oN/ZqMAQ0bxafXMubrmxhwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ee7wQVTe; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ee7wQVTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778082944;
	bh=X76ax60SRFDVr+JYCLgznSV1k8CdXPhSEXBt46Slo58=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ee7wQVTeW/tDRki+eA0MG1kwFxV4hA78xRyDca+wjhtwHAo1AJ7PLKLeoKcqFCTlz
	 F9FZTgPRQ/cR6LX1Bt0PcichpOSkrsEi7aA4NBgSXNv40jp4ff/22SvLhvpy822pLT
	 i57YtrzYXw3laoGi9V0EkO0n+JXdH07zujaahINQ=
Received: from github.com (hubbernetes-node-fb5e6e9.ac4-iad.github.net [10.52.125.37])
	by smtp.github.com (Postfix) with ESMTPA id B695A7810E2
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 08:55:44 -0700 (PDT)
Date: Wed, 06 May 2026 08:55:44 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090532/000000-dc4d19@github.com>
Subject: [bluez/bluez] eff7db: all: Remove more unneeded MIN/MAX macro
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

  Branch: refs/heads/1090532
  Home:   https://github.com/bluez/bluez
  Commit: eff7db7ed10341dd510b0a045d31a49761f8dc4e
      https://github.com/bluez/bluez/commit/eff7db7ed10341dd510b0a045d31a49761f8dc4e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M lib/bluetooth/hci.c
    M src/main.c
    M src/shared/gatt-server.c

  Log Message:
  -----------
  all: Remove more unneeded MIN/MAX macro definition


  Commit: c3200ddcfe6913d6959dc0baf2a66a42a58bf371
      https://github.com/bluez/bluez/commit/c3200ddcfe6913d6959dc0baf2a66a42a58bf371
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


  Commit: 706acaec9481a82aef2833b51a4c001cb96beea2
      https://github.com/bluez/bluez/commit/706acaec9481a82aef2833b51a4c001cb96beea2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M doc/maintainer-guidelines.rst

  Log Message:
  -----------
  doc: Recommend using _cleanup_ and friends


  Commit: 5b442f494b6c9eba048ff06500d29d9b93f78821
      https://github.com/bluez/bluez/commit/5b442f494b6c9eba048ff06500d29d9b93f78821
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify configuration parsing

Makes dealing with the error path easier.


  Commit: dc4d19132e80ae285d9d7fbe776dad85b43f7121
      https://github.com/bluez/bluez/commit/dc4d19132e80ae285d9d7fbe776dad85b43f7121
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify GError-handling

Use _cleanup_() to simplify GError-handling in the error paths.


Compare: https://github.com/bluez/bluez/compare/eff7db7ed103%5E...dc4d19132e80

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
