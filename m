Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78132882A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648021; cv=none; b=Xf/DAYF8+AcKhDAtYH2CSySq6Cr0I018/C6r/3lpytyycAkG0kgtRGsJ4oX1FH6gPn6MfV9cmQAjTGoiOaNhgSVoLUXC799EHFPP+CPed79gohxFqZ9dSjjF/EAE7UEyWRquiKJmglVMoFavu8/WtjK6/qi2EAV3B/YsuR+1ojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648021; c=relaxed/simple;
	bh=nZ6/O//8GuWKkWlHadAqtD1rYTY2/y19e9Pdwq363tg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DuvR/1XIXIp6CudW81Ab5huTd6lV/gUDe2X1zcy1h5vKUsBs4zLGnXN039k0YY44rGVzdoArOUgEjxWKLiHmniRcy6vvzMSiG+t4MVMDyhrDSORxNw5U6EkCV8tCycp3NDkHifNMn0xF7By2azokI3FnyzJhpVzOs8QUZ4EyKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tsgf1Ogv; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tsgf1Ogv"
Received: from github.com (hubbernetes-node-3fdec41.ac4-iad.github.net [10.52.13.31])
	by smtp.github.com (Postfix) with ESMTPA id D51A620C37
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749648018;
	bh=sCY/SGm7q4nD7BozjYHH6bBR7tPpmjxqqKX7hMMPjeM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tsgf1OgvJ6v35FyX+Zbm5QXm0fZL8d1G5Q3tD6nDn3nEmkQ9wsFQxeeL7+EeHvYsW
	 rIrjAyyGEEQUPkohaCbUUBISJmMIbUJub0by0Fsiv+OAsKTdqb0TR0nSXtAzmk2BQ3
	 qfnlTcB+yAa74UzjON5kHs6NWqU8Au44576u2w+4=
Date: Wed, 11 Jun 2025 06:20:18 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970848/000000-223573@github.com>
Subject: [bluez/bluez] e178b5: obexd: Pass at_(un)register value to logind
 callbacks
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/970848
  Home:   https://github.com/bluez/bluez
  Commit: e178b5cd7471c69ef34604355bb66adca26ab088
      https://github.com/bluez/bluez/commit/e178b5cd7471c69ef34604355bb66=
adca26ab088
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    M obexd/src/logind.c
    M obexd/src/logind.h

  Log Message:
  -----------
  obexd: Pass at_(un)register value to logind callbacks

Logind (un)registers callbacks that it calls when the user's state change=
s.
Callbacks may also be called during (un)registration.
Clients may need to handle those initial/final calls specially.

Pass an argument indicating whether this is being called during
(un)registration, and modify existing callbacks to ignore that argument.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: b5815edd2703eb54edd0916fd44af8865255ad12
      https://github.com/bluez/bluez/commit/b5815edd2703eb54edd0916fd44af=
8865255ad12
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: use the public DBus connection

PBAP must not use its own private DBus connection, as it needs to
receive messages sent to the bus name of the public connection.

PBAP must not unregister itself when the program is exiting, as it might
cause a long delay.  Unregistering at exit is redundant anyway, as the
service will be implicitly unregistered when the connection is closed.

But PBAP must unregister itself when the user becomes inactive mid-sessio=
n,
so systems with multiple users logged in at once can share bluetooth.

Use the public DBus connection instead of a private one,
and explicitly unregister the profile if appropriate.

Thanks Pauli Virtanen for pointing out the exit issue:
https://lore.kernel.org/linux-bluetooth/ae15a9fa4bf0bd509dd3d44f1f364e241=
e50956c.camel@iki.fi/

Reported-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8=
e69fb47535f@collabora.com/
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 2235733264a4196f07882aa5398410bf169d4dc8
      https://github.com/bluez/bluez/commit/2235733264a4196f07882aa539841=
0bf169d4dc8
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M obexd/src/main.c
    M obexd/src/obexd.h

  Log Message:
  -----------
  Revert "obexd: Support creating private system/session bus connections"=


This reverts commit 237d818ef294e22be87fba69b3cdd79c75c201e7,
which encouraged the use of private DBus connections.
Doing so caused a bug, so it's better to remove the temptation for now
and re-add it if a legitimate use case is ever found.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/e178b5cd7471%5E...2235733=
264a4

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
