Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351317A2E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937323; cv=none; b=TV6FgLs2NF4kGo+V8O63aGrm998kuPrKBOF/NQYH9xa0OHIbU0ASJYO7uKwPuglOKEp1QUb8UR1IuwdAao/Hf4vF50Mawnw0xnUFArqbDP7B8p1v7+7ePUskqfWnpNuFbK72AzN4m30TI1a/ZndiFzMJCJEs2/XxFECqrliKjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937323; c=relaxed/simple;
	bh=pWporQMFFYhQLxTOQl2k6rG30wvwHYBGHdBc/DRlq7g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XmQ688C8fM21pFJzvCPfkVq77VXiuruBGfA9Is01EoGCt0H+2KqQlYQBH+FzKVTVQUK1+cs1HVQLHkw1vuKEZe7imi2uO0JWg7hR0uYG6yhnpc7y8Jwti7nCDNr7JmyypQCNqdY2Ue0+nE6xrbv41ruMA0Asp58krRwusWhEgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aVWaaiFH; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aVWaaiFH"
Received: from github.com (hubbernetes-node-a0c1f41.ac4-iad.github.net [10.52.132.23])
	by smtp.github.com (Postfix) with ESMTPA id BDAC721370
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745937318;
	bh=Q6Qp3HyBMKphbCe9ywzaLWAi2X3shScUIGDoFR22nfI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aVWaaiFHh2MKD1Z+Owx63Dvuvggeo0vfDA1x6JNyGg03ITA9Yno242lkLw0J0A419
	 tqFRA0IQ5R+TRiHsRh5zKmuqJdUQn8MiJvaLmV9LPv1V/GAXaSRGa4igvXdEDII7mM
	 DIGDcpvwEm7Jn2mZIYFHjytzNdM3vqADs3IpfrpY=
Date: Tue, 29 Apr 2025 07:35:18 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958158/000000-aad0cc@github.com>
Subject: [bluez/bluez] dfa2fb: pbap: Support calling pbap_init() after
 pbap_exit()
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

  Branch: refs/heads/958158
  Home:   https://github.com/bluez/bluez
  Commit: dfa2fb1cd6714a9d3748465b70855e953f476db6
      https://github.com/bluez/bluez/commit/dfa2fb1cd6714a9d3748465b70855e953f476db6
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: Support calling pbap_init() after pbap_exit()

pbap_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send the UnregisterProfile message directly from pbap_exit(),
then call unregister_profile().

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 87f7941949a160ca41a0360e739fef469ad86b9e
      https://github.com/bluez/bluez/commit/87f7941949a160ca41a0360e739fef469ad86b9e
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/plugins/bluetooth.c

  Log Message:
  -----------
  obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()

bluetooth_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send UnregisterProfile messages directly from bluetooth_exit(),
then call unregister_profile(profile).

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.

Do not free profiles in bluetooth_exit() - profiles are needed
by a future call to bluetooth_init(), or will be freed by
bluetooth_stop() if necessary.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 3a09b8645cadad8241e905c03f892497675db27b
      https://github.com/bluez/bluez/commit/3a09b8645cadad8241e905c03f892497675db27b
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/src/main.c
    M obexd/src/obexd.h

  Log Message:
  -----------
  obexd: Support creating private system/session bus connections

Obexd can either connect to the system or session bus.
We mostly share a common connection to that bus, but it can be useful
to have a private connection.  For example, this allows us to quickly
unregister profiles when switching user.

Add obex_setup_dbus_connection_private(), which creates a new
connection to whichever bus was specified by the user.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: cc8ff2d8810ec423de795d9da60a4f0483c1c9e5
      https://github.com/bluez/bluez/commit/cc8ff2d8810ec423de795d9da60a4f0483c1c9e5
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M Makefile.obexd
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    A obexd/src/logind.c
    A obexd/src/logind.h
    M obexd/src/main.c

  Log Message:
  -----------
  obexd: Unregister profiles when the user is inactive

Obexd is usually run as a user service, and can exhibit surprising
behaviour if two users are logged in at the same time.

Unregister profiles when the user is detected to be off-seat.

It may be impossible to detect whether a user is on-seat in some cases.
For example, a version of obexd compiled with systemd support might be
run outside of a systemd environment.  Warn and leave services
registered if that happens.

Obexd can be run as a system service, in which case this check makes no
sense.  Disable this check when called with `--system-bus`.

Obexd can also be run by a user that does not have an active session.
For example, someone could use `ssh` to access the system.  There might
be a use case where someone needs Bluetooth access but can't log in with
a keyboard, or there might be a security issue with doing so.  This isn't
handled explicitly by this patch, but a future patch could add support
by calling `logind_set(FALSE)` in the same way as is currently done
with `--system-bus`.

Unregister profiles by closing private connections instead of sending
UnregisterProfile on the shared connection.  Pipewire has apparently
found the latter to cause long shutdown delays, because bluetoothd
may be shutting down and unable to handle this message.

Based in large part on the wireplumber code mentioned by Pauli Virtanen:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52

Other services are likely to need similar functionality,
so I have created a gist to demonstrate the basic technique:
https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e

Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 5b879c8598d59fa80b8d784c2cedd0e22a869f12
      https://github.com/bluez/bluez/commit/5b879c8598d59fa80b8d784c2cedd0e22a869f12
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/src/logind.c

  Log Message:
  -----------
  obexd: Support sd_login_monitor_get_timeout()

The documentation for sd_login_monitor_get_timeout() implies the API
may need to be checked after some time, even if no events have been
received via the fd.

In practice, the implementation has always returned a dummy value,
and changing it now would cause enough breakage in other projects
to make it unlikely to ever happen.

Add a handler for that case, even though it can't currently
happen in the real world.

The API assumes we call poll() directly, so in theory it could change
the timeout based on some event that doesn't trigger a callback
(e.g. sending a signal to the service).  It's hard to see how we'd
handle that without running a poll() in a separate thread,
which would be a lot of complexity for an untestable edge case.
Don't try to handle that problem.

Cc: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: aad0cc679c0af34fad399030f5c82c82f6284959
      https://github.com/bluez/bluez/commit/aad0cc679c0af34fad399030f5c82c82f6284959
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  Revert "obexd: only run one instance at once"

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/dfa2fb1cd671%5E...aad0cc679c0a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
