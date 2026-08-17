Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8643B3D1
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983668; cv=none; b=lcNZKxfWbmokoJerdtCb1pbgztEgjpVzNLTq8oKCMWec47adlMbSFr1C5+j2WesnLkj7sLoWhM+y+MxbAtOaHK/nSexqVD+2xVA4o/9TAMp5ZG7f/Hi/UbPT0rT8VwxHYnASkmDBNAmuD5WgepLv1ItzihHE4P6QJ03Wv4W+5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983668; c=relaxed/simple;
	bh=uuC1U82a1MV0uLg8QRPRcudfWcnD1qivCC+pnYXkm84=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VS4tiPH+FHBuMsKkfnmxQzKs6l2QSQg8SX+KKDRuYBhRrYxjZJEOCzHPcWJyV00CChqTy0uLbRfK/NYcdemHOykjIAob8MtjSk0dgbFhdo31zYJ/JScU9D9Qmzbbe4SFwVEoEDTr7ovKOed1jaqs1vSpgeJyNCz8pIZDt6b23Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Di731VzN; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Di731VzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786983665;
	bh=KqatuTFBJlwJHS8AvjdNtTcGXaoJB9V2MWNZU9h6hCY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Di731VzNnCnaH4lmwW6gb20Lb0RmE8zj1e0xPcqcDjWD9aZOfyxfY6l2F+pm0mV3L
	 W41YIG8puY9fW9qtXbe1ciF+08ky8kYQXaY5pwza5M1WssQZYV+Fb9oXZmjFkN+6mo
	 Hg5l9RajLbAiIoGWiKyhIHfvt21npiMSTt0jhUvM=
Received: from github.com (hubbernetes-node-a5b6146.ash1-iad.github.net [10.56.206.56])
	by smtp.github.com (Postfix) with ESMTPA id A74428412DD
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:21:05 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:21:05 -0700
From: Paul Menzel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147292/000000-03f0f6@github.com>
Subject: [bluez/bluez] 03f0f6: obexd: Reference count the phonebook back-end
 setu...
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

  Branch: refs/heads/1147292
  Home:   https://github.com/bluez/bluez
  Commit: 03f0f67b8b04b464cb99f8d8f2f7e5543508be35
      https://github.com/bluez/bluez/commit/03f0f67b8b04b464cb99f8d8f2f7e=
5543508be35
  Author: Paul Menzel <pmenzel@molgen.mpg.de>
  Date:   2026-08-17 (Mon, 17 Aug 2026)

  Changed paths:
    M Makefile.obexd
    M obexd/plugins/phonebook-dummy.c
    M obexd/plugins/phonebook-ebook.c
    M obexd/plugins/phonebook-tracker.c
    A obexd/plugins/phonebook.c
    M obexd/plugins/phonebook.h

  Log Message:
  -----------
  obexd: Reference count the phonebook back-end setup and teardown

Stopping obexd on Debian sid/unstable with *bluez* 5.87-1 logs a GObject
critical:

    obexd[10687]: Terminating
    systemd[1804]: Stopping obex.service - Bluetooth OBEX service...
    obexd[10687]: g_object_unref: assertion 'G_IS_OBJECT (object)' failed=

    systemd[1804]: Stopped obex.service - Bluetooth OBEX service.

Two builtin plugins use the phonebook back-end: pbap (pbap_init() at
obexd/plugins/pbap.c:962, pbap_exit() at :1002) and irmc (irmc_init() at
obexd/plugins/irmc.c:446, irmc_exit() at :473). Each calls phonebook_init=
()
when it is loaded and phonebook_exit() when it is unloaded, but neither t=
he
callers nor the back-end track ownership of the singleton they share.
plugin_init() therefore sets the back-end up twice and plugin_cleanup()
tears it down twice. A gdb trace of the shutdown path confirms both pairs=

of calls.

The dummy back-end tolerates this by accident: phonebook_init() bails out=

early when root_folder is already set, and the second phonebook_exit() on=
ly
repeats a g_free()/NULL assignment. The ebook back-end, which Debian buil=
ds
(*bluez-obexd* depends on *libebook-1.2* and *libedataserver*), does not.=

Its phonebook_init() stores three GObject references in static variables
and phonebook_exit() unconditionally drops all three, so the second
teardown unrefs objects that were already finalized. The registry and the=

address book are effectively singletons in evolution-data-server and mere=
ly
gain a second reference, but e_book_client_connect_sync() hands back a
fresh client on every call, so the first client leaks and the second one =
is
unreffed twice =E2=80=93 hence a single critical rather than three.

Put the ownership tracking in one place instead of duplicating it in ever=
y
back-end: phonebook_init() and phonebook_exit() now live in a new shared
obexd/plugins/phonebook.c and reference count the back-end, so only the
first init and the last exit reach it. The back-end entry points are
renamed to phonebook_driver_init()/phonebook_driver_exit() so that they
cannot be called directly by mistake.

Assisted-by: Claude Code:claude-opus-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
