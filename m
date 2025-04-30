Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058591DFE09
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020129; cv=none; b=WMD09gHZOESwQfJCseQmdzld3apJMOXH/LE4wdOUinBY+e6GffsNQ2pVq5qlRtNdKbgVshp0penqUMb4611wRddJPDrjFtcCxdCh5VX7K1b6jp9vRUGQ6hhhuPRC10ule4dAy3hD+EmNO28HfQHz6O4v4V/PIJ2QgAb4JLuOSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020129; c=relaxed/simple;
	bh=CP35hcLmHBpvnAP8CmXk46N/+mwy+qpU7qrvYJMG1Bs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fr3NiBtpIBaU7eW0KlBdMp1WWbhqmuxHxhWI+gFTVkzPRrdvTqqC8IL4B7fb0K3QeraOCIeZkpg4TNen1RMbBfry2fMpRFHzqoDwx9FE/jikVhD7aDtOzzt3bA1rMOwsZVc8UsEaOykXjn6NdhfI1laIYpIqMoa715Rx1qpt4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d9L0AGzl; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d9L0AGzl"
Received: from github.com (hubbernetes-node-d1b9fb1.va3-iad.github.net [10.48.222.58])
	by smtp.github.com (Postfix) with ESMTPA id 10EFEE1055
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746020127;
	bh=boyQQRs1szV3BTsLfpHp/QIVWZTAslqjWRqN6o5XJ3I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d9L0AGzl1u0ZjIptQ1TUFY2gqkWURG50y7mviWhmNg8XQHRlLvDbQYGpxokqDChNy
	 Awc6FuGPPu9NloVGIJ733AV+rdDA/yh6wwZhnVVeQPtEUwVrDDr/Qc62v5FIAr1+nj
	 56C8ZG6nCHEoE0XznGSde9TOB8m412CKJrxGYHJs=
Date: Wed, 30 Apr 2025 06:35:27 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958531/000000-771c0d@github.com>
Subject: [bluez/bluez] b92322: obexd: Unregister profiles when the user is
 inactive
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

  Branch: refs/heads/958531
  Home:   https://github.com/bluez/bluez
  Commit: b923226f335d25879498196e3113736968a976c6
      https://github.com/bluez/bluez/commit/b923226f335d25879498196e3113736968a976c6
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

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


  Commit: 4dbe23c5e1c4659044b50e689000c5602a839ff9
      https://github.com/bluez/bluez/commit/4dbe23c5e1c4659044b50e689000c5602a839ff9
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

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


  Commit: 771c0db8b02f4e688725d39c0c52afae3b6128a5
      https://github.com/bluez/bluez/commit/771c0db8b02f4e688725d39c0c52afae3b6128a5
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  Revert "obexd: only run one instance at once"

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/b923226f335d%5E...771c0db8b02f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
