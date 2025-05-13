Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0091EB5C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129594; cv=none; b=ucOpZR7o0dLUWjOhxkfLHnkLQKbeOb9g8iGvPryCaxlVYykaUEB1to/NkfV7E5ESOe1GF4ULbnmXBkWdTO+BR03SwbTSM5P7nX+h26UrKr/apH7BxZ0CLZ5knByhB6Ax4mebBTiHbXqQt9KhtHUP0SsXiguyvLNhxUnG7NG6ZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129594; c=relaxed/simple;
	bh=AxB7sTgXOBozactw/ZymKYNjFlYDuxylHvoHEVTQ2nc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SOt/+o5tVMgSOiJh8wT5j0iukVL5ngbITHVUTjXnrC9OmIyfIitlhML2O1QTiv+1LjrXz2WsJprnWLqoKvMH5pjklfSst9S21Vd/Npv/2N7e6ecRGSKQVYt02SHLOVOrmhGNh27XNyMfFJIjHb6vxeeBe9YZTBtJMzMRgPNGQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HL3SP2J7; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HL3SP2J7"
Received: from github.com (hubbernetes-node-b6e4a19.va3-iad.github.net [10.48.134.41])
	by smtp.github.com (Postfix) with ESMTPA id D713C4E10F4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747129591;
	bh=HKtJeGJ8g3OTDxFw8Ys3T5wVyAslSTfwOYzcYvdrHjQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HL3SP2J77Ve/0PdnlUIt4xiZHHF1/hTFRWu3VmiXd4WyKwNDJ/bkTRk3blOkBtmoK
	 tgbOc9uyfMVaZLID41KLErb4PSnV8XN95y/9DaE5k2ECrBoO32FIy9+JrNEktCdW0S
	 Cye0aNOVyr0xN5/noxRT4z/4epNpb8ssDmyrCpJg=
Date: Tue, 13 May 2025 02:46:31 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962345/000000-919b57@github.com>
Subject: [bluez/bluez] 23daea: client: Split installing submenu and doing I/O
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

  Branch: refs/heads/962345
  Home:   https://github.com/bluez/bluez
  Commit: 23daea520b85766ff17ef71f9ddcc3c19e7de5b8
      https://github.com/bluez/bluez/commit/23daea520b85766ff17ef71f9ddcc3c19e7de5b8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/assistant.c
    M client/assistant.h
    M client/main.c
    M client/mgmt.c
    M client/mgmt.h
    M client/player.c
    M client/player.h
    M tools/btmgmt.c

  Log Message:
  -----------
  client: Split installing submenu and doing I/O

Split off installing the command's submenu and contacting the management
socket or the bluez daemon.


  Commit: 02b48b0db76b2b17dcda6c0d7cb3a390bd06a93b
      https://github.com/bluez/bluez/commit/02b48b0db76b2b17dcda6c0d7cb3a390bd06a93b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Install submenus before contacting bluez daemon

So that the submenus are installed even if bluez isn't available.


  Commit: 2e4c40031d46b0b6e16145f9d2fb6fea6e3e71f3
      https://github.com/bluez/bluez/commit/2e4c40031d46b0b6e16145f9d2fb6fea6e3e71f3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M src/shared/shell.c
    M src/shared/shell.h

  Log Message:
  -----------
  shared/shell: Add function to handle early help calls

Add a function that would allow tools to exit after handling --help, so
as to avoid the daemon waiting to communicate with a D-Bus service that
might not be running.


  Commit: bbd1481471085b8c0f2680833813569755305a9f
      https://github.com/bluez/bluez/commit/bbd1481471085b8c0f2680833813569755305a9f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Fix --help hanging if bluetoothd is not running

Exit after printing all the main and submenu commands.


  Commit: fda5c34a547aaf2d247b53d7e2e545ffcc19e9fb
      https://github.com/bluez/bluez/commit/fda5c34a547aaf2d247b53d7e2e545ffcc19e9fb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M src/shared/shell.c
    M src/shared/shell.h

  Log Message:
  -----------
  shared/shell: Add pre_run menu callback

This callback will be called every time the menu is called, and can be
used to make sure that, for example, a D-Bus connection, is setup for
the menu to use.

This means that it is now possible to install a menu without setting up
a D-Bus connexion, but still have access to that connexion when the menu
is activated.


  Commit: fa27bda2434e28dada83f9eff74c125b59411ffb
      https://github.com/bluez/bluez/commit/fa27bda2434e28dada83f9eff74c125b59411ffb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/main.c

  Log Message:
  -----------
  client: Port "admin" menu to pre_run


  Commit: 703648cb41013edb20a20bcc4fb10f8b8dfc4b5d
      https://github.com/bluez/bluez/commit/703648cb41013edb20a20bcc4fb10f8b8dfc4b5d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c
    M client/player.c
    M client/player.h

  Log Message:
  -----------
  client: Port "player" menu to pre_run


  Commit: 0825b71a6eec0a51374387bdcb243f9063563422
      https://github.com/bluez/bluez/commit/0825b71a6eec0a51374387bdcb243f9063563422
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c
    M client/mgmt.c
    M client/mgmt.h
    M tools/btmgmt.c

  Log Message:
  -----------
  client: Port "mgmt" menu to pre_run


  Commit: 919b57a6deddb84591b11fe0a83be71be4de2794
      https://github.com/bluez/bluez/commit/919b57a6deddb84591b11fe0a83be71be4de2794
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/assistant.c
    M client/assistant.h
    M client/main.c

  Log Message:
  -----------
  client: Port "assistant" menu to pre_run


Compare: https://github.com/bluez/bluez/compare/23daea520b85%5E...919b57a6dedd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
