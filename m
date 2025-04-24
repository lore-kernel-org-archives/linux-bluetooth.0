Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9E284679
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511105; cv=none; b=lpcAEk13DwKCBtnF4ZvEwy2oxnsLLxxH6xe3HoX2mSNqsQ3441D6q3RmtHcme4x/f644N1C1ON8JtIYWMqvLugY2ZUPpwez4BkzbuiWgwiprRQPIYaVKLMMjSGLxYQqfdNaho206exOLQrB+veNJvqVChFOsSrDfnY7ose+2Uf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511105; c=relaxed/simple;
	bh=odqxKj5ld20EjV3R/ey1WjH3DY9tk9XZKtZ2hjFQ9uQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bVLIjDl2uKt8Mlb2LKwwIVKT5VSFLyBQfpZ2BMY4GydvMPE7IXTAROC8mm0CaGoucY7n8+b08kQLyMnLXwdMZEAM6O0z4+rpDNdyuYQVD1HBQGYLEVaSYtOU4sTU7en+zbMW83K/kuH2kpEtoC/vhYx4A5h8m2GHe8+paodYG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lZ5ErMuT; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lZ5ErMuT"
Received: from github.com (hubbernetes-node-eaaf49b.ac4-iad.github.net [10.52.211.57])
	by smtp.github.com (Postfix) with ESMTPA id 76CDC70072E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745511102;
	bh=xJZr0lOJ9N7A2noEpo86fOtNIGQBVHxsAgDAA4gERx0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lZ5ErMuTwuFx8Iq54/KAxh6T9vuAt1E0E5UZ/FKKrqeNP77OTHwheXZxI2XMSatxf
	 xMsydITPKeJYDEn8FacgJG4u3TINT7d2RyQWG1i2hB5Kk9PNqww2nH9D2Ymaff5DQI
	 sDLnzwXzq9iqgcCKHs3NeAp0aqoRHzEH6LQ6OkuY=
Date: Thu, 24 Apr 2025 09:11:42 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/956257/000000-3e0c4a@github.com>
Subject: [bluez/bluez] e43e99: pbap: Support calling pbap_init() after
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

  Branch: refs/heads/956257
  Home:   https://github.com/bluez/bluez
  Commit: e43e99d1d30eb70a67f6c8b5a983e45d9a1522de
      https://github.com/bluez/bluez/commit/e43e99d1d30eb70a67f6c8b5a983e45d9a1522de
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

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


  Commit: 0fa4ecbe78f50a476fdbdcf257468ecd2fd27e34
      https://github.com/bluez/bluez/commit/0fa4ecbe78f50a476fdbdcf257468ecd2fd27e34
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

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


  Commit: dcd6c02f34ee7e92627a363a70eacb460ccd60a9
      https://github.com/bluez/bluez/commit/dcd6c02f34ee7e92627a363a70eacb460ccd60a9
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M Makefile.obexd
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    A obexd/src/logind.c
    A obexd/src/logind.h
    M obexd/src/main.c

  Log Message:
  -----------
  obex: unregster profiles when the user is inactive

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

Based in large part on the wireplumber code mentioned by Pauli Virtanen:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52

Other services are likely to need similar functionality,
so I have created a gist to demonstrate the basic technique:
https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e

Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 3e0c4ade6389e70d86e41f4b734bb3558b499ac1
      https://github.com/bluez/bluez/commit/3e0c4ade6389e70d86e41f4b734bb3558b499ac1
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  Revert "obexd: only run one instance at once"

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/e43e99d1d30e%5E...3e0c4ade6389

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
