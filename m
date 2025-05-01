Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545302AF04
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746106429; cv=none; b=L2MZR0dnSZdIhA6lTJ/iITLUlYG5kBfvWxJ+Y+n9izOrbqGsMvUg+rPWf+/bkwjqvO4gzTf9ysHNedTYqghtnxXCslfJsTizm7Ts0vJ03OzNjsE22fP1zXcaYx5TuOo4stjaMehzvtY5o4mlaSZKDR+HM5BcsthgFtk6Fhv+Y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746106429; c=relaxed/simple;
	bh=ocSfkUfww2/6cOVlBDS+F8aeVjc51fLqFr1bVCjF9Pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rBTU3eD9CXhFUbS6Hymcv//l483UDhuyYVc6+0IpnOQhlG6Hy6g1P77Ucl6oreyGftUIzD1QwY6Xv8DBOt+dLiKGUWD3+PsveIUqAbgXdnj4rLQsHzl2PQ+cfOOdvdDpk49hSDYivkUMXw0ZFA6gnqbecvs0d2plzBl0EmVUIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SgIjL2zA; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SgIjL2zA"
Received: from github.com (hubbernetes-node-5f624db.ash1-iad.github.net [10.56.209.106])
	by smtp.github.com (Postfix) with ESMTPA id 6FF456003C3
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746106427;
	bh=DruoItjo5qRuOofWPzfaqpgwwXGesbyikKoa16gnRoE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SgIjL2zAGRvcrhgCf0fDVH9H+Z/HJUcaR7FefiLkyYnr0x9GuN+vDOpeVym4y6Jf1
	 72qSFYF7hl9Bv4mjHSXLDioXQV0Wl/Dg8U6zSIP/81EPEVdPEoAh5mqJFZnr9IwgeK
	 tauamalmY7UvDS2Ctfy+CAaetZnXdK+o+q6pl3pU=
Date: Thu, 01 May 2025 06:33:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5b6c09-f8d0dc@github.com>
Subject: [bluez/bluez] 765356: obexd: Unregister profiles when the user is
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 765356e80262a20c359ec7722a5590232442d0d3
      https://github.com/bluez/bluez/commit/765356e80262a20c359ec7722a5590232442d0d3
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-05-01 (Thu, 01 May 2025)

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


  Commit: 8b29b5a46cdc7015a1dc5b502fe103e0c2e7f219
      https://github.com/bluez/bluez/commit/8b29b5a46cdc7015a1dc5b502fe103e0c2e7f219
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-05-01 (Thu, 01 May 2025)

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


  Commit: f8d0dc114036806c25856ec1f0161d3e5ef5e2a1
      https://github.com/bluez/bluez/commit/f8d0dc114036806c25856ec1f0161d3e5ef5e2a1
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-05-01 (Thu, 01 May 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  Revert "obexd: only run one instance at once"

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.


Compare: https://github.com/bluez/bluez/compare/5b6c096fb859...f8d0dc114036

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
