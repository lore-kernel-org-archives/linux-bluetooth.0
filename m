Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6497130E828
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420035; cv=none; b=bbpvvu+Hh2y3oyBTTHhBo6t82SLlZmcqS2/Crr0qV8KAYeXsqLdb6ByW/twz4ZuZFD4ht2w/2Lthxgw7tdtkxl0FYX8Ldi/c26J59WzNGb8CGM7AiT+wDdCuLJ7C3sqCDoaF8Nm+jUNw2XJOPGYIlV6mPy1z1VOY+KgusGlBoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420035; c=relaxed/simple;
	bh=p+/6Le+2nIwInDn+g0OACkFJ4w9VDXTcyUwk3H+o2BM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E3ZW8bLB3d/pxazLeeOHvGGaMVKDFpNIli6zZWHb3WQq08U1O0deNQuJG8H05ZAEk9tgINkGABzfdI2UZ+wiiTeS3ptsirLsSFpZiw3k5mxTat3jqZ3C3XEuipJIbAs61VmFBbiaK0qmj7vytA8TwOeX4C43puEu3Ojc10RCuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VDqMZ4Oq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VDqMZ4Oq"
Received: from github.com (hubbernetes-node-1214c93.ac4-iad.github.net [10.52.139.37])
	by smtp.github.com (Postfix) with ESMTPA id 870D3202FA
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750420030;
	bh=5hJGC5T5Fl/dNZ3Tp03Ut85of3D/+ybVdz1olnz5zOw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VDqMZ4OqkdQfAzWt6L8LclnEpJ0TB1znJglzmq6j8WW/wfouuh0wLFikGaCte8xAv
	 No2a4+qPhqTkVbqUfveyJxC1A9WPNBltarbA3KXf+B488ikvfeEs+nu25nmsH00n5A
	 RE27ZyROUG36kr9LRJsXTi7cyqpUlscZK3bBn+hE=
Date: Fri, 20 Jun 2025 04:47:10 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974231/000000-514701@github.com>
Subject: [bluez/bluez] 514701: Refactor uid_state handling
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

  Branch: refs/heads/974231
  Home:   https://github.com/bluez/bluez
  Commit: 514701a0867a9c478d6f50e203fb16f14b46580e
      https://github.com/bluez/bluez/commit/514701a0867a9c478d6f50e203fb16f14b46580e
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M obexd/client/driver.c
    M obexd/client/driver.h
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    M obexd/src/logind.c
    M obexd/src/logind.h
    M obexd/src/main.c
    M obexd/src/transport.c
    M obexd/src/transport.h

  Log Message:
  -----------
  Refactor uid_state handling

We talked recently about refactoring logind.{c,h} to fit more neatly
into the program's wider architecture.  This patch sketches out a
possible approach.  It compiles, but has not been tested beyond that.
If I'm on the right track, I'll come back with a proper solution.

The old API provided callbacks on high-level "init" and "exit" events.
That made sense for the limited case it was used for, but seems
unlikely to scale if this starts picking up more use cases.  So the
RFC API just provides a single event that passes a `logind_cb_context`
struct to callbacks, and provides `LOGIND_USER_IS_ACTIVE(ctxt)` to
replicate the old behaviour.

The old API invited individual transports/drivers to use it directly,
which again made sense for version 1, but bypassed `transport.h` and
`driver.h`.  The RFC API registers callbacks with `driver.h` and
`transport.h` in a more normal way, and they pass `logind_cb_context`
straight through to the callbacks.  That means we won't need to do
much refactoring if the struct changes some day, but also means
individual transports/drivers need to know about `logind.h`.
The alternative would look something like this:



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
