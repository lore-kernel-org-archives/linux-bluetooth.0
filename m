Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DA5172F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664316; cv=none; b=LFOS7YrjnzXVDfjDjuV7N3EYIMJf4JfN/KQLcYCEaawlTUr1bQkbCMZMFvKiPg3ze/x96YofLWkbJa44BlVGU29kEpCwKAJtD5RgXV5LuYTPtDJJBzLZX07/Xsrre72TnpJVJdowmj3+bOj1zqcBydp32YZBhBG3hzcgK+mb9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664316; c=relaxed/simple;
	bh=MZ0haOEVD7M88K34rF2Xpmln4+OnBcJQ2VlIGWWaZRQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rBKJIwUp/xe9lK6ADzzinXo+cdzK3ebb1j35xKI7lL5i36jNBsCZI/o5k+rczmK54mRsPG9rXsOXeLbjQOszaqDghQD0hns4KCC/4RTajOtwN3UmDA617phLnXlKg4uZNUkQbE4eoXY+Io2sBBEJJenpI5zx5gLanlvsQwffvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f2A+aaDf; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f2A+aaDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789664313;
	bh=sBZIZw+CoGl50pRtEC4StA0I0tY0+CRtdv0yAAqGAlQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f2A+aaDfn/8OyhqFhI1IJUgSCOf/iDpEhJIyabGjq9I3+mJ/eCeKa7jXN1w25hrNO
	 cr3cs95UClEYsrvUQmyU3S0KWe7t+Zh+ZRdEYTSVz1jlvOpohIa6Jx3QVZOfcxZdt2
	 2SyHJ8tVeN/tPm98oiL+3xiZJeyiskmyhQgHrtOM=
Received: from github.com (hubbernetes-node-0e6f440.ash1-iad.github.net [10.56.207.15])
	by smtp.github.com (Postfix) with ESMTPA id DFC658402BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 09:58:33 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:58:33 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1167792/000000-c27e15@github.com>
Subject: [bluez/bluez] d8ed4a: shared/bap: Skip local metadata Config
 callbacks
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

  Branch: refs/heads/1167792
  Home:   https://github.com/bluez/bluez
  Commit: d8ed4a642abad923c56e90c038547d9cc7f7ba44
      https://github.com/bluez/bluez/commit/d8ed4a642abad923c56e90c038547d9cc7f7ba44
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Skip local metadata Config callbacks

When reconfiguring a client stream that is already Codec Configured,
setup_config() queues Codec Configuration and then caches metadata.
stream_metadata() emits a same-state CONFIG notification for that local
update. The profile callback treats it as the peer's configuration
completion and clears config_pending before the peer has responded.

If the control point response precedes the ASE state notification, QoS
setup can run while need_reconfig is still set and fail locally.

Cache client metadata in CONFIG without emitting a state notification.
Keep genuine peer CONFIG notifications and server metadata handling
unchanged.


  Commit: c27e1581c612b134d33ec19e56b92fcfbf20d6c6
      https://github.com/bluez/bluez/commit/c27e1581c612b134d33ec19e56b92fcfbf20d6c6
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test-functional: Cover BAP metadata reconfiguration

Exercise the real daemon by clearing a configured unicast endpoint and
reconfiguring its retained ASE with empty or Media-context metadata.
Require successful configuration and check the resulting transport.

Use ATT MTU 48 to prevent the control-point response and fresh ASE
notification from being batched together. Without the shared/bap fix,
the Media case fails QoS setup; the empty-metadata control still passes.

Call SetConfiguration directly because endpoint.config does not pass
metadata for unicast presets. Remove the fixture's redundant config
command: SelectProperties already configures both ASEs after pairing.


Compare: https://github.com/bluez/bluez/compare/d8ed4a642aba%5E...c27e1581c612

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
