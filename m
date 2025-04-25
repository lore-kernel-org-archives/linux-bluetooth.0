Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8178F2D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609032; cv=none; b=ImSYIAcxSfoQNRSrcPGJKi5tXk91MTf/BGcPQK6TZj4n42wajj4C++ivnm5QGf8nb0jEYvQz4gGwG2+zrmHptSeS3l5aBB8IoNmNUD+9M7CE8769GIsWDRd8JRZfqKJ3puti1f3C6sLj3nV9czW+zPr89bOBwANxd+qV5Qb6Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609032; c=relaxed/simple;
	bh=fS7wsDAzrtHJN2hwpIgAezeOla1QZDCm5R2/l0auZA4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ayshX8XKNp8g1O5XjaxwEcENVgyp23tKBY6EUwg0Q+4wB7he3wN/DyPs1HaMRYuR23Gh8MS3yOLqlbAb9414We1M4m2219EDud3W8z/+el3ibgCyUk2Ps2MFfGzXnCbecDVotlhL/M6T6nhfWpPBv+FtysRwuEzc5HQKOCqtbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M6PVO937; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M6PVO937"
Received: from github.com (hubbernetes-node-af6095a.va3-iad.github.net [10.48.153.37])
	by smtp.github.com (Postfix) with ESMTPA id CA735E0AC1
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745609029;
	bh=qGgQcs5cYhqlAwObxLJ9jMeHdFLvnLkq0sD3PgG1Tp4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M6PVO937/DSBcbiHMfBrR6rbh8vSpCYnfRYfp5ACeLEqsR3wcuzAFgA1DEA8TKvMC
	 1S5NJbRYGjk4BUzl2TgaC5qbJ7c39AjjHLlreXxsYx6/DMJ9fb7xWUFqz+/eshWR43
	 rHqKe0pKwfWgZTX/SQ0VLc58ylESy9cY6e1vb+I8=
Date: Fri, 25 Apr 2025 12:23:49 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957156/000000-a762d3@github.com>
Subject: [bluez/bluez] 693274: pbap: Support calling pbap_init() after
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

  Branch: refs/heads/957156
  Home:   https://github.com/bluez/bluez
  Commit: 693274a4a67c07ac1c9cc0dcc195816e05e6c398
      https://github.com/bluez/bluez/commit/693274a4a67c07ac1c9cc0dcc195816e05e6c398
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

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


  Commit: f87692e4cf1e0018ff96a030094a607b4d1d3e5f
      https://github.com/bluez/bluez/commit/f87692e4cf1e0018ff96a030094a607b4d1d3e5f
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

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


  Commit: 97af61e4e6b9ed696b000cfc2ad12058d5280de1
      https://github.com/bluez/bluez/commit/97af61e4e6b9ed696b000cfc2ad12058d5280de1
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

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


  Commit: 50c1bfdd8822d5b66949874b2fd6233ff39226f9
      https://github.com/bluez/bluez/commit/50c1bfdd8822d5b66949874b2fd6233ff39226f9
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

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


  Commit: a762d3a54c6dd548bf737e2a54c822ea4b089352
      https://github.com/bluez/bluez/commit/a762d3a54c6dd548bf737e2a54c822ea4b089352
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  Revert "obexd: only run one instance at once"

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/693274a4a67c%5E...a762d3a54c6d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
