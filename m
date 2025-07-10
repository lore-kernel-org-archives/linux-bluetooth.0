Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170312F56
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160685; cv=none; b=dMhxISlCqmNq3yKAs1hfNJNnUYuTLUz8qZo6xoT8aRnzrZEqvczChRVKg3qniKgdk0XGpyBU6xRNWoGwjIoTMzSOJ5djj+Ed/ccAjuZR5ch+fl1tpoBQWUn2x2+tAsNIhwggFrEEzhyKG97wedgv/SRfbOXBma98mc3uXxcXUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160685; c=relaxed/simple;
	bh=P/4EPdPdxSJGBWD5atB9vu5ENZ/Ad+pDT309NCyAbSc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r6Qkdf3U1LDnmRNXDygnmgDidbbl0Al+JFigzfBmDJ6Zs6LreVCR72W3oRhLTT8KODKX8YD1A46UPNI0FP0W2tplq4/UEiiFypisEFBuMEQMMXyat57zMBELwMQ2T4DCIVUQUsAXIUlANCTozuIfuJL/sgauPbUWXExTdgl7WPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CKx+01OT; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CKx+01OT"
Received: from github.com (hubbernetes-node-7e9c2b2.ac4-iad.github.net [10.52.211.53])
	by smtp.github.com (Postfix) with ESMTPA id ED47720BF0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752160683;
	bh=Gj4LPMjgHp5FjaeJfAvTZaLtEhjHyBbzTYdJ/p5PnTI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CKx+01OTOVR/b66guyrzFcslpBGL8n8lMzhpX2bIEzOlGoeZQuk7eRAtaUnfI0yTV
	 +jQIVzs1LMi562XkjiMjRx9IXlf0zCm3Ihtz0vESoP9w9TDa7Hg/cJD0Ix4PoUZ2sZ
	 XJyqAVh9jneLTae6rLThquw2tHQLvE34qUNnsRr4=
Date: Thu, 10 Jul 2025 08:18:02 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/784607-47a4c7@github.com>
Subject: [bluez/bluez] 1c6f08: obexd: Remove --enable-threads option
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 1c6f080d7f408042acee779b47cfcaf9dced1594
      https://github.com/bluez/bluez/commit/1c6f080d7f408042acee779b47cfc=
af9dced1594
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M configure.ac
    M obexd/src/main.c
    M obexd/src/plugin.c

  Log Message:
  -----------
  obexd: Remove --enable-threads option

Threading support is always enabled in dbus since version 1.8 released
in 2014:
=E2=80=A2 libdbus always behaves as if dbus_threads_init_default() had be=
en called
  (thread-safety by default)
so remove the obsolete option.

Note that we also require glib 2.36, which is newer than the version of
glib with GThread support built-in:
[Since 2.32]
This function is no longer necessary. The GLib threading system is
automatically initialized at the start of your program.


  Commit: 47a4c73cd5530a36c430d068e171d357c0f66a81
      https://github.com/bluez/bluez/commit/47a4c73cd5530a36c430d068e171d=
357c0f66a81
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: fix not adding stream to global streams list

stream_new() shall be used to create new avdtp_stream, so that they can
be found from global list.

Fix one case where it was not used.  Fixes crash when unregistering lsep
and then disconnecting, due to stream for the removed lsep not being
cleaned up when SEP is freed.

Fixes: https://github.com/bluez/bluez/issues/1325


Compare: https://github.com/bluez/bluez/compare/784607f89c9d...47a4c73cd5=
53

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
