Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F587289813
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063819; cv=none; b=LmPf/+TJh5uhNYsZodQIDiBetQ+mU1pwsqxOCrjuizxHCQ6w2g9n/TrCWpuIbRMniLeds9+kZwsANTjddeLJ+YGaZLl/HzVBgQ9GP20vq0G9fke+8iO0A8Zo40BYubPukirzLXGw3QKhpH7vm2ljOnDHD8HT4opm7ERvuMrdX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063819; c=relaxed/simple;
	bh=C8kmPUNyZjZzCpCoRiX2G/eFYPBzcfP6VijtnY3EIlo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SeeTTSG1receFDKic/tBtiFT9ucovFgIPNc70zkSS3g+fmLz9GJX3Oo3knjcjxutJ8H7fFe67KwNpt+R84CZIV+jnhRm6Zplzh1y6Ja19s1tknVv3AqbqTMXXA4Ylx4rE+zW3Le3zJ9+x0GZuhOoemI3n06o3QzTMfFJGWw7UXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vp4EMTQw; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vp4EMTQw"
Received: from github.com (hubbernetes-node-1f65a39.va3-iad.github.net [10.48.151.36])
	by smtp.github.com (Postfix) with ESMTPA id 4AFEDE0368
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752063817;
	bh=QdwmyWK539KgQ4lodHAnX13+NEMElyHvuntgF39gLWQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Vp4EMTQwWmSPkaQl2md6Hm+f2+oAqWdwP69/U7aGEUf9iO0rG8Nkp5DpbQyE+Oh3+
	 dJZYhEiUTwH0rJLjDp6YSQ8R8n+L4vvsDk9rbi0ayZkRKkzHSyuUKV6gKZQuoFqv/v
	 edcTY0cqZ6vtlRW67YOUtawQgOU9X6BvqgjMrLwk=
Date: Wed, 09 Jul 2025 05:23:37 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980500/000000-b55a78@github.com>
Subject: [bluez/bluez] a32394: btio: fix range validation of security level
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

  Branch: refs/heads/980500
  Home:   https://github.com/bluez/bluez
  Commit: a32394ee97096977807ca80ed92ef2c0fa6a48b3
      https://github.com/bluez/bluez/commit/a32394ee97096977807ca80ed92ef2c0fa6a48b3
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: fix range validation of security level

Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
but the bounds check allows the value 4 for 'level'.


  Commit: 1809ae0da3d7d1d025403d6e3440c5060f7d0e50
      https://github.com/bluez/bluez/commit/1809ae0da3d7d1d025403d6e3440c5060f7d0e50
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


  Commit: edab0beacc2f3248ab6279087c39bc75df7334f1
      https://github.com/bluez/bluez/commit/edab0beacc2f3248ab6279087c39bc75df7334f1
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


  Commit: b55a78ea5a866b48d8051fd9a2e15d2abc1d15d3
      https://github.com/bluez/bluez/commit/b55a78ea5a866b48d8051fd9a2e15d2abc1d15d3
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: fix err condition causing memleak

transfer_open returns 0 if an error occurs, condition corrected.


Compare: https://github.com/bluez/bluez/compare/a32394ee9709%5E...b55a78ea5a86

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
