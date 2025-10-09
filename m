Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AF2367D5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994255; cv=none; b=b3BWZNhAD6hXyqB9gRZFsINIwjepvM3CVFirD2hi+cOgteTdzZq51Yk0Z4ggWzT0v4NlzVET6ML6Amw9pVrUQ8Km+ZO8AwWZjazOfjArPN6Suz8H1apOOLsn279jIT0yqVZt3X6TuYz333AtoQwN55EmAJpltXOmSBxl9g6T25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994255; c=relaxed/simple;
	bh=+dRlqEXFi0ODynm6xdOjE+eAbg7mtnR57ygzsiZ+aH8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W0PiKcEjI9tcxo22SYKZtFQeDEbGvCDlR4T2IXTRnOLzfo6nkhlRKNqVC3vBqzuNAX2X8ceBGR72aXPBr1RSAmLlQwEqaO3NR7DZpstn4H7ehxSpLmQAU195BHY24n3AGdeegoYwZOED9Ka/MbWi1ggdUQScpR3pQgYMk7e0U1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ht4u17/p; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ht4u17/p"
Received: from github.com (hubbernetes-node-2202043.ac4-iad.github.net [10.52.125.49])
	by smtp.github.com (Postfix) with ESMTPA id 86071640D5B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759994252;
	bh=XJuWQQwI6Xz28E9SVOpBvA6KaM/zRxtwy4yedPnPHi0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ht4u17/pcZ8FL3pmgRu2ZeC9aTDFuRbup3w0BUhWNCSwNQm0szVBIZnTCgdrcn582
	 WIuQxw2Ofmqnc73q+j6Mm10bGhs0WiM/2JWoplEGX7Tc7gQt3cBCxObPcslNkKJdUF
	 S7wK7XUrPFcvrqoCpq6NHDMYdTSbcdZouDmVibs4=
Date: Thu, 09 Oct 2025 00:17:32 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009611/000000-b659e4@github.com>
Subject: [bluez/bluez] b659e4: gobex: Fix abort for SRM operation
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

  Branch: refs/heads/1009611
  Home:   https://github.com/bluez/bluez
  Commit: b659e42a7c6a5c383d626d89ee7d6514a102194c
      https://github.com/bluez/bluez/commit/b659e42a7c6a5c383d626d89ee7d6=
514a102194c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: Fix abort for SRM operation

The OBEX Abort operation currently triggers an OBEX session
which prevents further OBEX operations:

obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
               0x50e000001380 registered
               /org/bluez/obex/client/session0/transfer0
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D3
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D4
obexd[327475]: obexd/client/session.c:session_process_transfer()
               Transfer(0x50e000001380) started
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D3
obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by user=

obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D4
obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
               0x50e000001380 unregistered
               /org/bluez/obex/client/session0/transfer0
obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001380=

obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D3
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D2
obexd[327475]: Unknown header offset for opcode 0x10
obexd[327475]: obexd/client/session.c:obc_session_shutdown()
               0x50c0000010c0
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D3
obexd[327475]: obexd/client/pbap.c:pbap_remove()
               /org/bluez/obex/client/session0
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D2
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D1
obexd[327475]: obexd/client/session.c:session_unregistered()
               Session(0x50c0000010c0) unregistered
               /org/bluez/obex/client/session0
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D0

As its highest bit is always set to 1, and so its value located after
G_OBEX_RSP_CONTINUE, the G_OBEX_OP_ABORT is part of the operations
constants.

This has been tested for PBAP and BIP-AVRCP with Android 15 and 16.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
