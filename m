Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3828DF1B
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069287; cv=none; b=ZpwLfj++Hs4mh5uQq4kpPM9IVdgoAzG+7y/FjLPjn+YXcePZ21K8CCqApTMknxn+zQApRMeGSfb0/SHveq66Q/6jCdfaQRqhZ+bI4KkX6mBgx7LPzWoIKVJjcwKAIRbl9HYrF8uxu0bvR61q2O0bKrh7AtliAjqv/iWx9A5hKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069287; c=relaxed/simple;
	bh=zYd9NX2jlGYk/T17KN/3+G3Da896fh8u9BanyGQO+RY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WLmMkkMc2t7nBy+h08ffJimzHnEaOd+QhWpsjTEaKSFedlylfg8st56wmOYGDbxZoLuj3mXAz+pRsRwFZ0SmBHq3Vjz+oFQ/vcDXmyNyEtNoE4HwvDkte1gg7VPN1D0lIi/32WdJ8tbUBMwmkmVnIPzgXHAs/KTxZtPJMZ5FT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lGPwgmwg; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lGPwgmwg"
Received: from github.com (hubbernetes-node-5430fb2.ac4-iad.github.net [10.52.136.22])
	by smtp.github.com (Postfix) with ESMTPA id CB8F670091E
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752069284;
	bh=cgrkxGy2WJ/gi+681JdnhDAGm7s+UD48py0jn/G3N8I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lGPwgmwg4cvutFQ87b2Yh69vbRr1bb+ISshT+FusgixuplXfqIoatSSsEyZ2jMUQg
	 Sy8iPtCAeotF3/4jaUJGnm0qzfGoLeZRXcOL2K5ikTUv16xsabhGa699Oxw6hhLZXZ
	 qz0kZWxOzdoog0sn9uMAziX479wdXN3HBzU1PndI=
Date: Wed, 09 Jul 2025 06:54:44 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980540/000000-b00403@github.com>
Subject: [bluez/bluez] 340fde: btio: fix range validation of security level
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

  Branch: refs/heads/980540
  Home:   https://github.com/bluez/bluez
  Commit: 340fde776e00622969c475989ad8a1badc2c075b
      https://github.com/bluez/bluez/commit/340fde776e00622969c475989ad8a1badc2c075b
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: fix range validation of security level

Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
but the bounds check allows the value 4 for 'level'.


  Commit: 29361026d98a59655d4810873a7aff5e5f868d7b
      https://github.com/bluez/bluez/commit/29361026d98a59655d4810873a7aff5e5f868d7b
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

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


  Commit: c653ac1fb8725f9d0a0c3eb0a0a94d4d8365df8d
      https://github.com/bluez/bluez/commit/c653ac1fb8725f9d0a0c3eb0a0a94d4d8365df8d
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

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


  Commit: b004030371dbf83e35c4b6638db5cfd289f159ba
      https://github.com/bluez/bluez/commit/b004030371dbf83e35c4b6638db5cfd289f159ba
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: fix err condition causing memleak

transfer_open returns 0 if an error occurs, condition corrected.


Compare: https://github.com/bluez/bluez/compare/340fde776e00%5E...b004030371db

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
