Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735F262FE6
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848198; cv=none; b=l315fAOtdiKxU+3kx7AEvqVCFn98Kk6tldPA9sqF2wP4sCTlMlz4Kso/oTGXoFdJfX8siDDV5XjAJbu/fPhcuydn6q9OeRNev9ycsHFsSi6JizxFBGGeHP3mTkQADysw59lpdk4x7FNVS43ajBz5G0nBo9QCOl6mEOsXVHKz7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848198; c=relaxed/simple;
	bh=bLg2ypKmhsJLY5gb22bfVO+53QV13816FFkw11jJqa4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UuJWo1Qg7H/NPaYhS3pWx3B2AMwXCXhwoKyrJ1XC7bpkPOFmcMYv8yu3TuANchIWSxBVQG/T0J/5iC58AnQCZy0U4kP7IcLvXVIBvhFdyeRZdp8emSVwrnWEDgsuymZpUtTupWSusLU8CKYIFe66WBalMpJn+rCvQ1W3gFlzT04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lnq3lOjd; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lnq3lOjd"
Received: from github.com (hubbernetes-node-61de8af.va3-iad.github.net [10.48.144.43])
	by smtp.github.com (Postfix) with ESMTPA id EF5018C0D99
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745848196;
	bh=9CX9aQL/nC+YBbk/SJYYLsO1WbaCUNRqp2eGaNYedqU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lnq3lOjdix9kOQq3quaKnVOIlpUdc/kqP0fx8WkLypypIT8NC7u62Pd6ZLKolyMan
	 j9IVe1x77dlzWKcGtGoOU4rIesrtWbR2CR7jbEukaJv/3SA7+XiT4mdbgfL2klohVq
	 ZxzyhZNNd8GlM2ssoJD0+bThVxt4h+8BSxypf1H0=
Date: Mon, 28 Apr 2025 06:49:55 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957730/000000-9a58a1@github.com>
Subject: [bluez/bluez] 9afbce: pbap: Support calling pbap_init() after
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

  Branch: refs/heads/957730
  Home:   https://github.com/bluez/bluez
  Commit: 9afbce45b7ce64269eea3da1d9ae9eca2fe60258
      https://github.com/bluez/bluez/commit/9afbce45b7ce64269eea3da1d9ae9eca2fe60258
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

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


  Commit: 73ccc40580c32b6baa461447041e6af4fc5f62d5
      https://github.com/bluez/bluez/commit/73ccc40580c32b6baa461447041e6af4fc5f62d5
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

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


  Commit: 5a201e5f6ac7feea5d170d34e117c46689e1b155
      https://github.com/bluez/bluez/commit/5a201e5f6ac7feea5d170d34e117c46689e1b155
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

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


  Commit: bdead1f7be05cc72a375b098213b0aac73f825be
      https://github.com/bluez/bluez/commit/bdead1f7be05cc72a375b098213b0aac73f825be
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

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


  Commit: d13886173ceb99e952aed6cf9f0740cc0743926f
      https://github.com/bluez/bluez/commit/d13886173ceb99e952aed6cf9f0740cc0743926f
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

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

Cc: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 9a58a10482ca3429a62885199f7ad376ec553899
      https://github.com/bluez/bluez/commit/9a58a10482ca3429a62885199f7ad376ec553899
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  Revert "obexd: only run one instance at once"

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/9afbce45b7ce%5E...9a58a10482ca

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
