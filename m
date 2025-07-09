Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E992E611B
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069236; cv=none; b=iMqBbT9We4DVF/mFKs9DVEecQa8koSpIHojLB95bpJO1KPJbJ5nxg/HawxpVT9I16O4EduSEpsHJeupwF+vxLHN/9lQTIVn8FYekWrdfcKR2y91iNpcO+uI6Isn9oIZxjlUnq+iQQKW2hIAmzKwDgYtRQZA9/alD1ulqB11ZIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069236; c=relaxed/simple;
	bh=loHKDWmtnjvWw6AAccnXXhxBzpkZb7aRhLRniQS1yzA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j2Q3OkevXMYQzJdwhetn0WMyQ4uXRpjvfyUIVl2E7eMlABuU7MU+4lZsOea5vTAagXpZ9WW2Slbr1jzg84du8KV7wraLSeu0P+vajWaom53f0wF6PJxrbxH21ey6L5SfXKj3ucpjh/EWCF/yH7nfBb8y+JqeLAegn8Eol0yM7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dPdDPeTs; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dPdDPeTs"
Received: from github.com (hubbernetes-node-4ecc5c8.va3-iad.github.net [10.48.176.37])
	by smtp.github.com (Postfix) with ESMTPA id 38E14E1135
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752069234;
	bh=t49GxS1vSsadwB/WnQr5banLpqMYBPJsmu4SEhEx3wU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dPdDPeTs7uPlWKSdc9GbTCo34//nJiUIEkSAasMPy8ifdKv1J1m5LNMvGFVOfQxZs
	 uLjdqXFXLGo/Pn6eqrI98WNQ0fINumK6eOzbPJEUzft45TnG2XljEWJUiRqNJdfR4K
	 BUvJubKNMM3ORj16FgRkHTeTQhXbCZu0OAiZx5c8=
Date: Wed, 09 Jul 2025 06:53:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a3824b-09212f@github.com>
Subject: [bluez/bluez] 80a6b9: btio: fix range validation of security level
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
  Commit: 80a6b91d758ac94d6b6d40250d68f06cd4a06097
      https://github.com/bluez/bluez/commit/80a6b91d758ac94d6b6d40250d68f06cd4a06097
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: fix range validation of security level

Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
but the bounds check allows the value 4 for 'level'.


  Commit: 77932f2dac1af0506e289703e43e057d21c40fce
      https://github.com/bluez/bluez/commit/77932f2dac1af0506e289703e43e057d21c40fce
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


  Commit: 9432bfe81afd177be2778c65b640658f88b7ef28
      https://github.com/bluez/bluez/commit/9432bfe81afd177be2778c65b640658f88b7ef28
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


  Commit: 09212f9d110e268332041c6038895e581d73d4bd
      https://github.com/bluez/bluez/commit/09212f9d110e268332041c6038895e581d73d4bd
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: fix err condition causing memleak

transfer_open returns 0 if an error occurs, condition corrected.


Compare: https://github.com/bluez/bluez/compare/a3824b4aac0e...09212f9d110e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
