Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD74FC8D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568551; cv=none; b=JuECtXv7F5tMfpmxT08+jyHQJ4daiZGH7LsnVVWEz0lJ70V2I1J0wvh4lv5rGgrjHvQtLgXGMQS12p2hvNWGazupwgcCyAio0UdSE/fSvrzVp7xcNQNVAEuR5WyYjk8v/9IYSBiP8+gURxPWeebo1pgdcaS6/u5D3fblAsIn5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568551; c=relaxed/simple;
	bh=cih0RUv1CwodrrjIvVD2QVQ5NEKrncDsgYV0+wM1nk4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eaNZOi5UusH/qxDMxQAQ9QiPHSh42Vqp1gymvfzQeg78Ymf6WVhxeMRNmQ1UDSGb1BVvnINXfeGxRwHUbcntBhRa+k00/b49Zu78sP0mlIlj7d12UcXYTngoRCBttYp1yU//LfIxBt2mPPWJIci9VSWJUjyJns1q1eQ26ca0tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ecu/uUgk; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ecu/uUgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789568549;
	bh=g9TTl2geAXyojFXfrhfNqe0Xvo2v8xtLp0hHSmT4YLM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ecu/uUgkACdUUofxYrDEw3ewm3NeW9gDdYn1SeDzQTUFC7UhR7h1VMvbtvGSv1kZW
	 E7Gkae8CNHWJg0AVOwKkLsRBvRdVXhqf4Wl/ELehhwG/FrnEA4v7vGgsy4GOoDwp6N
	 X/5xaeSX4bHXLro5uNdZO5NuLZFM8U9RnQors8XQ=
Received: from github.com (hubbernetes-node-75ebdff.va3-iad.github.net [10.48.73.61])
	by smtp.github.com (Postfix) with ESMTPA id 55E40340606
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 07:22:29 -0700 (PDT)
Date: Wed, 16 Sep 2026 07:22:29 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1166364/000000-c66e9b@github.com>
Subject: [bluez/bluez] 070cb5: shared/bap: Skip local metadata Config
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

  Branch: refs/heads/1166364
  Home:   https://github.com/bluez/bluez
  Commit: 070cb5cb03e8eef46835813b23c601bd8e6b21e8
      https://github.com/bluez/bluez/commit/070cb5cb03e8eef46835813b23c601bd8e6b21e8
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

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


  Commit: c66e9ba6278610c52074e44ebc033c5b03f95f3f
      https://github.com/bluez/bluez/commit/c66e9ba6278610c52074e44ebc033c5b03f95f3f
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit: Test metadata during BAP client reconfig

Add client tests for both remote Sink and Source ASEs. Reuse an actual
configured stream, start a second Codec Configuration, and cache local
metadata before the peer responds.

Check metadata retention and absence of an extra local CONFIG callback.
Require QoS to remain blocked after reuse and after the successful
control point response. Only the fresh peer CONFIG notification may
make the stream ready for a nonzero QoS request and the subsequent
exchange.

Without the shared/bap fix, the premature local CONFIG callback attempts
QoS before the stream is ready and both tests fail at that assertion.


Compare: https://github.com/bluez/bluez/compare/070cb5cb03e8%5E...c66e9ba62786

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
