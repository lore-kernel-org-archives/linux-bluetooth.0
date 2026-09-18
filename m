Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241443B7B84
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770323; cv=none; b=YUJd6xzx+KiUPBxMYQR0EJswDH8x2+ZavPkTnX4wt5bWoa6PRtc08OqE/PZM9YW5+cAAc+zo+DbFkA+mTyCyvSA0CeMv0JADgds3uluP8SKbs9qTjqJ9ck399FR9xOC2hzzFfvS9Mx4RBqEMC78wadROl7anqWQ3JoSrohU7H3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770323; c=relaxed/simple;
	bh=L/q+LFveHqgrhm10huxF/a2Ek9lMSP5D8yL/QVbIq+A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NhjCLMYD5SSe1kOU3qS9bOoNdDy2ETbTEF0ETo2RE31xDiZm1xznW2u3HuDjxlshWlJ6TShgwKhM1tK38B1rOWQn1HsJQiOQQcUAZ8D79G8J5AZWPsCwXv+H4IEt5KMXhVo4FtkWIIKNJ92kmL8Pxl8jEazcrNE9g26jqlRDDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O9hGdJFN; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O9hGdJFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789770321;
	bh=9oKEK14+J7JW4vY9wgP3D1n9UWyT6iL7XcuzXJ1sgc0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O9hGdJFNwCw314CeKA2AQ9MThMopGpjAh+jqX/UQhGRWvzfeh0f7/lin+xogIXnUC
	 bMDRb58418q/UxL8lztF9h1EtDEWjg8Y5+EsP1Ni0RKM6hAvS+U3IeqWXYBY/h78xG
	 pmm6yaJgovpneMxBfE2vLI4geKR7a1qTJloOI4es=
Received: from github.com (hubbernetes-node-213419d.ash1-iad.github.net [10.56.131.52])
	by smtp.github.com (Postfix) with ESMTPA id 4093F9201EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 15:25:21 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:25:21 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168994/000000-a2d345@github.com>
Subject: [bluez/bluez] 598f9a: transport: Preserve Release on late BAP ready
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

  Branch: refs/heads/1168994
  Home:   https://github.com/bluez/bluez
  Commit: 598f9acc24f918a4b931c5c5d96937f91599b50d
      https://github.com/bluez/bluez/commit/598f9acc24f918a4b931c5c5d96937f91599b50d
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: fdbf00415c15b45929bd62b48aa01f4faa26be07
      https://github.com/bluez/bluez/commit/fdbf00415c15b45929bd62b48aa01f4faa26be07
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: a2d3451ed0492330293fbe52e2ca31994c831dfb
      https://github.com/bluez/bluez/commit/a2d3451ed0492330293fbe52e2ca31994c831dfb
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: Cover BAP transport release and reacquire

Acquire both unicast transports, close their sockets and release them
through the same D-Bus owner. Require an empty Release reply so a late
ready callback cannot pass unnoticed by returning an Acquire payload.

Repeat three times with immediate, 100 ms and one-second reacquisition.
Check Acquire reply types and active transport states. Close returned
FDs even when a reply is malformed.


Compare: https://github.com/bluez/bluez/compare/598f9acc24f9%5E...a2d3451ed049

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
