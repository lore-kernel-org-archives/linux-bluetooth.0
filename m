Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE92BE110
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156492; cv=none; b=nGiSETD0bifpKnrNaHR7ZprT07fwNkihrkbtCnerXTI1Cuq91vXOeIew3MTUFZuYafFgH3lKGvG/YRvPgfQ89cBqp1hJHR0pON25vt1KL7WC4gsHsM2BL+54XfstfLrw87PjCTEdlr/CP03L2LpPB67xPMvcaPvdjmKe7BWzXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156492; c=relaxed/simple;
	bh=P6iOJvGzPL4KqJAxyF00LSZX+u6bH5f78gmk9AikOWo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oujWV1tU3+1KDhIY0Ni6B52RNWLL24SZopDl94QFk8WitcqBZWw0u4kc0r+cfkSA5jnemljpUgjlrwhbydatKCV0ZuKnzZ+ImAvx8zihSWpq+KqAFxboxf51lsYGLU5SGv/Dujg9obJ6ErIafQTVflUNLyVCMsELRH73b/4GwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kmSQf9HS; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kmSQf9HS"
Received: from github.com (hubbernetes-node-e98d5fd.va3-iad.github.net [10.48.138.20])
	by smtp.github.com (Postfix) with ESMTPA id 3F456E0C35
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747156490;
	bh=y+b9KtDACpO+S8GepBeQBmRl+CR/mI2laLEgHq5J284=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kmSQf9HSgYKvYzbXjbw3QSqyilkCnwwJwsshlaEBaHcY3K2pGAJVe5GRL1MN1RYLQ
	 IF/79xElhJvixuBZr04dCCtAyRKcJbxVkyX5pC3CmzrYg4SFLCTJLKWxgbYOkq42gX
	 r+79r8Ut0GH5d/dKFD+DhFMQ7N/u1d55f0/0RvHo=
Date: Tue, 13 May 2025 10:14:50 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5a112d-8154dd@github.com>
Subject: [bluez/bluez] 994816: shared/asha: Don't wait for status notification
 on...
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
  Commit: 9948168cca15f8a4d68c963d2fb06506b0f6ba6d
      https://github.com/bluez/bluez/commit/9948168cca15f8a4d68c963d2fb06506b0f6ba6d
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M profiles/audio/asha.c
    M profiles/audio/asha.h
    M profiles/audio/transport.c
    M src/shared/asha.c
    M src/shared/asha.h

  Log Message:
  -----------
  shared/asha: Don't wait for status notification on stop

Not all devices respond with the status update, so let's just send it
out and assume it worked.


  Commit: 2ebf7ed224d04b44dcf03d64eb1966d526ae8b41
      https://github.com/bluez/bluez/commit/2ebf7ed224d04b44dcf03d64eb1966d526ae8b41
  Author: Sanchayan Maity <sanchayan@asymptotic.io>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix the use of callback in transport_asha_suspend

Some devices do not send a response to the stop command, so
audio status notification might not be received after stop.

Instead, as with the Android implementation, we just immediately
acknowledge the client's stop request after sending it to the device.


  Commit: b36c39102e0225d44f16ef24faf7071c6c36c88d
      https://github.com/bluez/bluez/commit/b36c39102e0225d44f16ef24faf7071c6c36c88d
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


  Commit: c0ed04ab07b88d1e1cba919e37da80cbc8b79934
      https://github.com/bluez/bluez/commit/c0ed04ab07b88d1e1cba919e37da80cbc8b79934
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Install submenus before contacting bluez daemon

So that the submenus are installed even if bluez isn't available.


  Commit: 80c810ec9e724cb58a3abd81481b96ee96c28126
      https://github.com/bluez/bluez/commit/80c810ec9e724cb58a3abd81481b96ee96c28126
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


  Commit: 773cce6b378ddcb486318e6edd458ade0f28eb16
      https://github.com/bluez/bluez/commit/773cce6b378ddcb486318e6edd458ade0f28eb16
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Fix --help hanging if bluetoothd is not running

Exit after printing all the main and submenu commands.


  Commit: 102b9f3d075b344d6c2e0f4836dc8f0abfdc3dbc
      https://github.com/bluez/bluez/commit/102b9f3d075b344d6c2e0f4836dc8f0abfdc3dbc
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


  Commit: 78f062a2865bf37b8484582cb6213ef46ef07233
      https://github.com/bluez/bluez/commit/78f062a2865bf37b8484582cb6213ef46ef07233
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/main.c

  Log Message:
  -----------
  client: Port "admin" menu to pre_run


  Commit: 9bc5142fce91223c4ec1760203135aa7e960f09e
      https://github.com/bluez/bluez/commit/9bc5142fce91223c4ec1760203135aa7e960f09e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/main.c
    M client/player.c
    M client/player.h

  Log Message:
  -----------
  client: Port "player" menu to pre_run


  Commit: 2d2bc715025caac8530982190fc4336fdfb6a50c
      https://github.com/bluez/bluez/commit/2d2bc715025caac8530982190fc4336fdfb6a50c
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


  Commit: 8154ddbdd5b2eaa5643391cca6bf2093288dabf2
      https://github.com/bluez/bluez/commit/8154ddbdd5b2eaa5643391cca6bf2093288dabf2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M client/assistant.c
    M client/assistant.h
    M client/main.c

  Log Message:
  -----------
  client: Port "assistant" menu to pre_run


Compare: https://github.com/bluez/bluez/compare/5a112d14e423...8154ddbdd5b2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
