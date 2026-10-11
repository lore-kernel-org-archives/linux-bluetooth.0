Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDE234973
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758527; cv=none; b=g+eIKdOi9I9NrgGO7MJhTgY5+6u3DE47ngHL8w45p/XHbhsIGIvv8HvKY0TtNWg8/WQ1NrGHhcD+PeLbtDIbsUlDP79bGOrbnjG23HPhuClkvgX9+Qz+4lfOK674bTDXjWUwBhHZhj3GVdd2zscHG+sqs6wQwE0MBC2E79YwDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758527; c=relaxed/simple;
	bh=ewOODvb9P4n5WMKzGgJCIrNDqGZ3fpFowCH6kx+MmDU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eleVoXANARaviqJ1a1b75raL1vJiqHf460VciCgOdGlm++kduGpIv+aZkGU6zDTAweB1NKDSherNO86zraTvTZHRCMGaDq34m6o68Q0v6eTETiWoRuH0mziZzo9c7u4Eer1ooCVW7IxO+lQLEtSqZATn+IlWcPr5UTOnjPRYnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=f2gJhL5I; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="f2gJhL5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791758525;
	bh=DoCkn3n2q2ARLsYRum8Hvblw3/Owkyi3bQ0No2EJLSg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f2gJhL5IjdUAgKzV1cXmy6435XOP8zXzlwkKYderyHgeQgcM9tL59JrxliCthPV6D
	 rVB0K8kWH3+QqprLonV/WcyeVw5uTQ9/0wphJJzpYRqCssmKwmDrhtNrG54s2bvOCd
	 U68LI/xjq9n/w2+V7hjY2pbvLCmGaGwZldD9fTX8A69vBIs80b09wAPMbkO7vDjcgn
	 9AtsWSxfmH8FVPTiaaDAcXCCy8TU4fXzLm/KRAoghwqBSrxLXkEXWe6JRZ0C3PusX8
	 lf1s2hAxwBNJ5xzSgCchdTTBrsrq+IJ6k/taK3Uq2mRgT6eJN83acl4z1fjmSGlfVz
	 mNLaTVvzX93YA==
Received: from github.com (hubbernetes-node-6df8053.ash1-iad.github.net [10.56.165.33])
	by smtp.github.com (Postfix) with ESMTPA id 2EB9E600734
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 15:42:05 -0700 (PDT)
Date: Sun, 11 Oct 2026 15:42:05 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1183466/000000-d08111@github.com>
Subject: [bluez/bluez] f6a305: iso-tester: remove IO sources during teardown
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

  Branch: refs/heads/1183466
  Home:   https://github.com/bluez/bluez
  Commit: f6a3055dafa777051e9baedcc6faca9543c575b6
      https://github.com/bluez/bluez/commit/f6a3055dafa777051e9baedcc6faca9543c575b6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-11 (Sun, 11 Oct 2026)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: remove IO sources during teardown

Drop watches / timers in test teardown, not after all tests have run.
Avoids leaking them to following tests.

Assisted-by: opencode:gpt-6.1-sol


  Commit: e7ba17f9aaa837dc00980b75317e5de55d8e2cf0
      https://github.com/bluez/bluez/commit/e7ba17f9aaa837dc00980b75317e5de55d8e2cf0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-11 (Sun, 11 Oct 2026)

  Changed paths:
    M lib/bluetooth/bluetooth.h

  Log Message:
  -----------
  lib: add BT_ISO_PAST_POLLOUT socket option

Add kernel uAPI definition for PAST listener readiness option.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: ad56b9fe9446cdd95d67cb2e43e1f43af81a24a8
      https://github.com/bluez/bluez/commit/ad56b9fe9446cdd95d67cb2e43e1f43af81a24a8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-11 (Sun, 11 Oct 2026)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  tools: iso-tester: test PAST listener readiness

Test POLLOUT notification after LE Set PAST Parameters completes, with
and without deferred setup. Query BT_ISO_PAST_POLLOUT and skip the tests
when listener readiness notifications are unavailable.

Add tests:

ISO Broadcaster PAST Listen Ready Receive - Success
ISO Broadcaster PAST Listen Ready Defer - Success

Assisted-by: opencode:gpt-6.1-sol


  Commit: 670dc23ddd789817bcb698c789cb3a64c342d7c2
      https://github.com/bluez/bluez/commit/670dc23ddd789817bcb698c789cb3a64c342d7c2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-11 (Sun, 11 Oct 2026)

  Changed paths:
    M doc/iso-protocol.rst

  Log Message:
  -----------
  doc: iso: document ISO PAST listener readiness

Document PAST receiver setup and waiting for POLLOUT before requesting
PAST. Describe the read-only BT_ISO_PAST_POLLOUT capability query and
handling kernels without readiness notifications.

Assisted-by: LLM


  Commit: d08111bd93ec3e668cda590bcc218fe20924c134
      https://github.com/bluez/bluez/commit/d08111bd93ec3e668cda590bcc218fe20924c134
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-11 (Sun, 11 Oct 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: wait for PAST listener readiness

Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so the
Assistant cannot start PAST before receiver setup completes.

Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip waiting.

Fixes test_bass_past_transport_* test failures.

Assisted-by: LLM


Compare: https://github.com/bluez/bluez/compare/f6a3055dafa7%5E...d08111bd93ec

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
