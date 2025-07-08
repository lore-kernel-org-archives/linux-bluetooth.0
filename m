Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32E2D3209
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974146; cv=none; b=HwLLj3ttz+LvfzCvjabrSQkc4PXXXorr4Yb3Khq1UNJdW9vMuHnqp6TiVZNyCFGPA9Q/67bOCotpo23kQ711quOJVQOtfDFDIX+3P4N5LRqfmsLmV1tcY46yN+1BogMH8hb+uwjZvSjh/ZfzlZ5bZffgzxRNLjSIGd6HJeh6GEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974146; c=relaxed/simple;
	bh=9ov/C0EmAsqvkZOWNVxvDGP452QoI7Bi6m5jpPsA9RQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T0GDBLAa+0VAND1QIvErY6LSVRhnbqcnX/ya3Jv30HgdgWUN/zTQu2IzbTvO1X+Uk9IhjPW+7puCfurfohbdud7dSvmaAZbvuITte3hrG5zf+QnVnXiJsq/pk8041yF6U7abKfd55Vpp/k+FVYS3mbUGR6ZvBr9LiTq4IyTH8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WVYfjdce; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WVYfjdce"
Received: from github.com (hubbernetes-node-0321d76.va3-iad.github.net [10.48.206.26])
	by smtp.github.com (Postfix) with ESMTPA id 7414D4E0261
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751974144;
	bh=w60cc4G228v9ArF4NEiz4tEp6QLLjWN+AihSlgGM36Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WVYfjdcejcIH2EvDCu+Fvjj5kl9v+txxMJLaUzXJ8UEf+38o+u0drExcQVmBaUzEF
	 2NqrCDl9gcFKya+KiSz/i06XhYAPX/ikSxgn9BEqfjziPTGJjGULcrT4mCWHb40P3k
	 xNfEwVI/7gX5jSmILgmEQd9tDKADb6yhcFGr0OHA=
Date: Tue, 08 Jul 2025 04:29:04 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980014/000000-039865@github.com>
Subject: [bluez/bluez] f3f409: btio: fix range validation of security level
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

  Branch: refs/heads/980014
  Home:   https://github.com/bluez/bluez
  Commit: f3f40966eac14590835f2cda2a3116a5c0d76ed4
      https://github.com/bluez/bluez/commit/f3f40966eac14590835f2cda2a3116a5c0d76ed4
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: fix range validation of security level

Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
but the bounds check allows the value 4 for 'level'.


  Commit: c74cb330726075e168d40ed23b08d50710a2c537
      https://github.com/bluez/bluez/commit/c74cb330726075e168d40ed23b08d50710a2c537
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avrcp.c
    M profiles/audio/bass.c

  Log Message:
  -----------
  profiles/audio: add nullity checks

Cover bass_setup unsuccessful search and btd_device_get_service.
This change is motivated by the other usages where checks for
NULL exist.


  Commit: bc1b7e183ef596eba018df63ebe37cca8c0d3eaa
      https://github.com/bluez/bluez/commit/bc1b7e183ef596eba018df63ebe37cca8c0d3eaa
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/vcp.c

  Log Message:
  -----------
  src/shared: add nullity checks

Check util_iov_pull_mem where iov len is not verified
beforehand. Check vcp_get_vcs for NULL.
These changes are based on other usages where those
checks exist.


  Commit: da6d5cc18a1b7b8aaa03e3b6d22d1e45f2c152b1
      https://github.com/bluez/bluez/commit/da6d5cc18a1b7b8aaa03e3b6d22d1e45f2c152b1
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: close fd after sending when nconn=1


  Commit: 519a30dc04e0df83a44b50ac9284c51b795df67c
      https://github.com/bluez/bluez/commit/519a30dc04e0df83a44b50ac9284c51b795df67c
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: fix err condition causing memleak

transfer_open returns 0 if an error occurs, condition corrected.


  Commit: 8a932a007b77c1200aebb000cc7fe106c5e98c07
      https://github.com/bluez/bluez/commit/8a932a007b77c1200aebb000cc7fe106c5e98c07
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  profiles/audio: fix memleak of bt_bap

Make failure branches deallocate memory before leaving.


  Commit: 6afb456faa035fa745448224094243d8ec03af1a
      https://github.com/bluez/bluez/commit/6afb456faa035fa745448224094243d8ec03af1a
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  src/shared: fix memleak


  Commit: de8ece1c7a04eb1d3e56eac033bdcbf7ceedfeb5
      https://github.com/bluez/bluez/commit/de8ece1c7a04eb1d3e56eac033bdcbf7ceedfeb5
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/gatt-db.c

  Log Message:
  -----------
  src/shared: move null checks before dereferencing


  Commit: 7e54a1903f4088fa5fa903f7e945c02beb48f26c
      https://github.com/bluez/bluez/commit/7e54a1903f4088fa5fa903f7e945c02beb48f26c
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: remove repeating conditions


  Commit: 3cdf1806dbb2db46e41fdea790df67fdc303257b
      https://github.com/bluez/bluez/commit/3cdf1806dbb2db46e41fdea790df67fdc303257b
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/bass.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  profiles/audio: fix io_unlink args order

Seems like a breaking bug. Analogous to bt_bap_stream_io_link,
but there the order is correct.


  Commit: 0398652761cfe9a6fa41487c2e890592038bda91
      https://github.com/bluez/bluez/commit/0398652761cfe9a6fa41487c2e890592038bda91
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  src/plugin: fix args order

According to other functions and arguments usage, the
case with external_plugin_init seems to be erroneous.


Compare: https://github.com/bluez/bluez/compare/f3f40966eac1%5E...0398652761cf

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
