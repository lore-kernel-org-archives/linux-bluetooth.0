Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208449C4C7
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301114; cv=none; b=lmbp2bhWec+Lfa35VzVrOPDZszdYD2WjGAAvkT711dJlNcyIt57sEtU0K+dLB50jtXC/HDLW2l3tTIQTPKli+xUrdy3FU5FwsyjRLsFpdV9g9VKWUAzbsFsDl0xkgRB31Nqy34UQzawME97EUGNG0et5ffFmmNiq5QT6/ee6msA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301114; c=relaxed/simple;
	bh=QcifMbs4IScIaWOfaore87SDbTB8XGbw3584W4E/4tU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b9bqirNUTGGLYW1MHukLkdkKpYCTMAKBpdBdPTw3sGzvV6slIUblZ2UB69H25r4C0qdwm1euLvCB4CFJsDis79MK4dCH3QA7crkbIMY3+4GurXE8uajnk6aQ1/O5j6qNQfXZH2GGVNYcwnO3AaUKc5lbDpbeyqBQirARKs74Xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=e/FElF2z; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="e/FElF2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791301112;
	bh=d5ROFBUXghvJ9FcApcLYFovE2uxsX0mOWa0e1UIsApg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e/FElF2zxPrKNqpFFrg8aPVqikG7J4o5B6ZzPrC/WEe68WKOruysGUq929bhdPXkq
	 Z8NC8fCFGu+GfbLDJM65e5wg6WI8hZJEI1tR03K07oRKw8UDBF2M5TM+m7+MHXSwC2
	 EohExCYAh7XFM7UlsOO5t3bKltl4chg2nH4dUeoY65/lg5s80ZejqTWyeiJuWbx2WP
	 isusKOnHoMFwM3Qk76av8+YZmL/ImjGn5UhPyQkqr4Wp4S7DbaKFZretdAf2hMr52k
	 XPLngln/B9/n0ZJ3PqopefAw0oMS/9R8WIJql26oLlhIOCw0oEmqrfeM1YYetBQKZ2
	 CIpOYXSWwLIBg==
Received: from github.com (hubbernetes-node-6425e8a.ash1-iad.github.net [10.56.202.59])
	by smtp.github.com (Postfix) with ESMTPA id 82264600CC5
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 08:38:32 -0700 (PDT)
Date: Tue, 06 Oct 2026 08:38:32 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1180235/000000-2e6860@github.com>
Subject: [bluez/bluez] e1ea74: transport: Preserve Release on late BAP ready
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

  Branch: refs/heads/1180235
  Home:   https://github.com/bluez/bluez
  Commit: e1ea7423ea3be02338e514bca16a01e3973dcb88
      https://github.com/bluez/bluez/commit/e1ea7423ea3be02338e514bca16a01e3973dcb88
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-10-06 (Tue, 06 Oct 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Preserve Release on late BAP ready

A late stream-ready event can reach bap_resume_complete() after Release
has queued Disable. It then replies to Release with an Acquire payload
and drops the Disable request ID. Client disconnection can subsequently
free the owner while the Disable callback still refers to it.

Only complete pending Acquire/TryAcquire requests from this path. Leave
Release and its request ID for the Disable callback or cancellation.

Fixes: 466fce0209a3 ("transport: handle BAP Enabling state correctly when resuming")
Assisted-by: Codex:GPT-6


  Commit: df5d17697e7302f379efff4fb34017a0f7f68a1f
      https://github.com/bluez/bluez/commit/df5d17697e7302f379efff4fb34017a0f7f68a1f
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-10-06 (Tue, 06 Oct 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Recreate stream IO after an early Enable

When reacquiring a transport, the stream can reach Enabling before its
previous CIS finishes disconnecting. Once teardown completes, IO
recreation accepts only QoS, while CIS enabling requires existing IO.
The pending Acquire consequently stalls.

Allow deferred IO recreation in Enabling too. Keep the existing CIG-busy
checks and recreate all IO before enabling CISes.

Fixes: 7feff47a9fbe ("bap: delay QoS & IO creation if CIG is busy or setups configuring")
Assisted-by: Codex:GPT-6


  Commit: 2e68607f4261540a66453cd68d67b0bc13ab6317
      https://github.com/bluez/bluez/commit/2e68607f4261540a66453cd68d67b0bc13ab6317
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-10-06 (Tue, 06 Oct 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: Cover BAP transport release and reacquire

Acquire both unicast transports, close their sockets and release them
through the same D-Bus owner. Require an empty Release reply so a late
ready callback cannot pass unnoticed by returning an Acquire payload.

Wait for both Acquire replies before Release, and for both Release
replies before the next Acquire. Only requests on different transport
paths are concurrent; no path has successive operations queued without
waiting for its preceding reply.

Repeat three times with immediate, 100 ms and one-second reacquisition.
Check Acquire reply types and active transport states. Close returned
FDs even when a reply is malformed.

Assisted-by: Codex:GPT-6


Compare: https://github.com/bluez/bluez/compare/e1ea7423ea3b%5E...2e68607f4261

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
