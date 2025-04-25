Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079C189B80
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602247; cv=none; b=djirbxutwQxcmqvCTWDFRNrp0r6y46diWxc35AxCa4uf5aUInlaPDaozilaE4Tz03z4TE+j8+AyHwdTlUGEY7tb9FwxrSgTBxN0oMVUwnzCj6AnAcugGRUvH9h6NK6CGTvW4BHaVMhwfv9Eb6JWT12Y2Z9cTIEkn2qMwc/1X98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602247; c=relaxed/simple;
	bh=/+i73R+04cncB9t2rOZYN/RgRY9UQtzYQ0Oxui02FWI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YFBjJjw/NhQIwOOTa9cb1hLATrnnTUGt1Ciqbtcg8vwEgRNC4FZiFLqzSuCPq0gmwcfRjvScOAYPbrUmhKoBYflHQUyf8MJFTHyBp2rd034BsEvWhenQ9iK+nTGro6kHmUiDtLjd3Us0oABQu66NJF9U9L7XD+sei9BcHXJGg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AZFu1rvm; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AZFu1rvm"
Received: from github.com (hubbernetes-node-a0e7df4.ac4-iad.github.net [10.52.158.25])
	by smtp.github.com (Postfix) with ESMTPA id 2151D700368
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745602245;
	bh=k+8d9/iu9Y3zJjH6Rm2CJeJWoOt38r1pl+yWOOj1KI4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AZFu1rvmfyMrK3nLFnHv8WHVpuOAUiLkfoOBRvbs58EcWrPWLkT0v4HF2lmBvZCub
	 ebISw0UMwJIWqStKXEEB03sEYlxaGH3zbAqVfXvMmnN7kLPTGmqBcGqECDDRkAdgAf
	 bRJd2juqW4xv42+cXmVgnS3x4IwhkMaTzpo8HPTE=
Date: Fri, 25 Apr 2025 10:30:45 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957129/000000-b8068a@github.com>
Subject: [bluez/bluez] 1ddc62: pbap: Support calling pbap_init() after
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

  Branch: refs/heads/957129
  Home:   https://github.com/bluez/bluez
  Commit: 1ddc62fa5cbe4aa7378b772fb8f9cf97d2551385
      https://github.com/bluez/bluez/commit/1ddc62fa5cbe4aa7378b772fb8f9cf97d2551385
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


  Commit: 61f5836a9a738d32eac9a3da67e5c46b218fb887
      https://github.com/bluez/bluez/commit/61f5836a9a738d32eac9a3da67e5c46b218fb887
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


  Commit: e4829a671a616fdc99043dc1d445f57a25421bc6
      https://github.com/bluez/bluez/commit/e4829a671a616fdc99043dc1d445f57a25421bc6
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


  Commit: feadad7a76f9f8d5a4557321fa3f0592de10b747
      https://github.com/bluez/bluez/commit/feadad7a76f9f8d5a4557321fa3f0592de10b747
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


  Commit: b8068a1c6ef32530d05bf892dd1c027ed1aeb2ce
      https://github.com/bluez/bluez/commit/b8068a1c6ef32530d05bf892dd1c027ed1aeb2ce
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


Compare: https://github.com/bluez/bluez/compare/1ddc62fa5cbe%5E...b8068a1c6ef3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
