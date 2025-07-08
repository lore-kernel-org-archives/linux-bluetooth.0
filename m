Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7429B776
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960726; cv=none; b=k1tDMlwuMJ/sr+L+tFVsvI/FQb9SxaIdFKY346/6/hakv/uxo5vWkWCaSh+rxFy7Tv9L6uvn//R63F2VNwdHh11dTCvzjKIC1x1DIdLsBxNniF71pKjj/3pL9P/y5Y4SO9dfLczkcuRYdD69tdBbT5oaG8YKd+Rr5Jwlqsj7Lvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960726; c=relaxed/simple;
	bh=CpUzSzpswSYpthkYODABThKe0xhC5sdK9HioDbgE1Tw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=czpjtljAJyujb8V76/sOJ4stoPJ1sJqDDHN0FcIyK03RyxQddj6D7JFF12oopjHpvKSOXqyU1gZtO/TGhNlnF42+A3HWejarDMYUJi9jpuDYCRl5katr8wB+ScjWWOY+nDo69KgttvAjJ1tBxvnREwC8kEcHxJwpNcFB5fwaBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KnBCa541; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KnBCa541"
Received: from github.com (hubbernetes-node-75b5bb6.ac4-iad.github.net [10.52.183.49])
	by smtp.github.com (Postfix) with ESMTPA id 9A937640299
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751960723;
	bh=WDPYxfEOrxJrt5wdPHWOmwSs0faz5qp7V6LIEIJiNNA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KnBCa541qoNoOpGbiLZjkQxJw9/8G3ZeOTQPyHzLzyAIHPLoEOEBCuGUACB5YTAIv
	 4gjI2Q+CWheJWftahuXHjQk9poh3VXK1iPizt04wwbG2KCAljg0d3Q93biMWDvPZwZ
	 kbCKZcsZ3by1Td9ri/BHuGn/6cwCY3+s2ih+wOAk=
Date: Tue, 08 Jul 2025 00:45:23 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979927/000000-c74271@github.com>
Subject: [bluez/bluez] d925af: btio: fix range validation of security level
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

  Branch: refs/heads/979927
  Home:   https://github.com/bluez/bluez
  Commit: d925aff1485cf33d60557efd44b3db45b2f84241
      https://github.com/bluez/bluez/commit/d925aff1485cf33d60557efd44b3db45b2f84241
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: fix range validation of security level

Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
but the bounds check allows the value 4 for 'level'.


  Commit: 0912ffde6a01d5e787b6883201c160c421fd1858
      https://github.com/bluez/bluez/commit/0912ffde6a01d5e787b6883201c160c421fd1858
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


  Commit: 4f17104ab7493de93ee4d1db428ff01c05126496
      https://github.com/bluez/bluez/commit/4f17104ab7493de93ee4d1db428ff01c05126496
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


  Commit: 1c6ef345ea4bd569959b4333e2dbeee799e398a1
      https://github.com/bluez/bluez/commit/1c6ef345ea4bd569959b4333e2dbeee799e398a1
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: close fd after sending when nconn=1


  Commit: 7187338cb0f39bc193f11135cb64a5fede8b8126
      https://github.com/bluez/bluez/commit/7187338cb0f39bc193f11135cb64a5fede8b8126
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: fix err condition causing memleak

transfer_open returns 0 if an error occurs, condition corrected.


  Commit: 03ca538c8ff3fc21b734c7d10048007bcecf9cb9
      https://github.com/bluez/bluez/commit/03ca538c8ff3fc21b734c7d10048007bcecf9cb9
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  profiles/audio: fix memleak of bt_bap

Make failure branches deallocate memory before leaving.


  Commit: 0ac037158b21dd0e67c4e337385276089d42bcdb
      https://github.com/bluez/bluez/commit/0ac037158b21dd0e67c4e337385276089d42bcdb
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  src/shared: fix memleak


  Commit: f75df3ae83d1288e3ef68016d18a1550fd0df109
      https://github.com/bluez/bluez/commit/f75df3ae83d1288e3ef68016d18a1550fd0df109
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/gatt-db.c

  Log Message:
  -----------
  src/shared: move null checks before dereferencing


  Commit: c9f54bddda9ceb5d057bbc08a7271d71e84dd15b
      https://github.com/bluez/bluez/commit/c9f54bddda9ceb5d057bbc08a7271d71e84dd15b
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: remove repeating conditions


  Commit: 188ef95b3ffed41e7da72ce0bb09fe2a7a60a777
      https://github.com/bluez/bluez/commit/188ef95b3ffed41e7da72ce0bb09fe2a7a60a777
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


  Commit: c74271b46eb791b341aaf9d1fe3dadc9f797557c
      https://github.com/bluez/bluez/commit/c74271b46eb791b341aaf9d1fe3dadc9f797557c
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  src/plugin: fix args order

According to other functions and arguments usage, the
case with external_plugin_init seems to be erroneous.


Compare: https://github.com/bluez/bluez/compare/d925aff1485c%5E...c74271b46eb7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
