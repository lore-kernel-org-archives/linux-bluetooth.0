Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B32D0267
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993929; cv=none; b=jy46xWpmQe/5QqPgAX3cwFR6r8PkgHJ+ozGpngfyciAVkco94jrdijbtEGUKZ1/aAsMPX90LjFU0TarLcegxkGrKCl2CTJtgMAhRz/HEHxhlGjtbRXIYFdHSV8FZ514mnfx+UyDH5Foxu52d84BnHXu0zP8yxMr5Yb8wDavTPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993929; c=relaxed/simple;
	bh=iWPaSXOTko956EdDF6nIy8L8I8aIOCV6eECNiT+6HxU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u4KZRRewwjSO+BSPRPlXReipRe8ANPiShhHKLiW7ejzEKwTCHnfKNDM3ZXCsVMhD492oVdS7Xil1gippdKCxIwtxNkC7mQCDiN0V5lMKLfKcwRxNnASQh6CSYIiDARoSolXp+nmcnJf4gqdSNy6QxFGheR4h2HokqY8iLqH/7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bQd5ojlM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bQd5ojlM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759993924;
	bh=iWPaSXOTko956EdDF6nIy8L8I8aIOCV6eECNiT+6HxU=;
	h=From:To:Subject:Date:From;
	b=bQd5ojlMtnZMAxm7/pVG7AqIozk6RYHm4AIOWA4STddXOWToesoEBlQmk7rK3CM4M
	 hUbLe6CG+5W2+ckWtWscGjaP/vDCUu4byLS9JGLrnSYEqG045RCzb/Gs4uTZ7h206y
	 i5bAw7OvZArjn8JrNYnwteRIDNwQigjn+UvcYw+vf7JGPez1oBVJmpz/HkdvbutI7V
	 p/EXLTzXC2mRbPWs2FO6LgZB4hskk7uEpxAxs7/KfvYbaFxYiiaDtgYE7ZTY1BB9zX
	 OTqivmltxyktZgzRjBBVvhNgxKCNugjiKYR2kZtF7q9qLUi6P9Lulfct1FKJNbHc7X
	 zSeZElBv4dgXg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-AB6e-1eE8-0E0E-15D0.rev.sfr.net [IPv6:2a02:8428:af44:1001:ab6e:1ee8:e0e:15d0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9ECDF17E0125
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 09:12:04 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gobex: Fix abort for SRM operation
Date: Thu,  9 Oct 2025 09:11:59 +0200
Message-ID: <20251009071159.359476-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The OBEX Abort operation currently triggers an OBEX session
which prevents further OBEX operations:

obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
               0x50e000001380 registered
               /org/bluez/obex/client/session0/transfer0
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=4
obexd[327475]: obexd/client/session.c:session_process_transfer()
               Transfer(0x50e000001380) started
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
               ref=3
obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by user
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=4
obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
               0x50e000001380 unregistered
               /org/bluez/obex/client/session0/transfer0
obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001380
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
               ref=3
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
               ref=2
obexd[327475]: Unknown header offset for opcode 0x10
obexd[327475]: obexd/client/session.c:obc_session_shutdown()
               0x50c0000010c0
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3
obexd[327475]: obexd/client/pbap.c:pbap_remove()
               /org/bluez/obex/client/session0
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
               ref=2
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
               ref=1
obexd[327475]: obexd/client/session.c:session_unregistered()
               Session(0x50c0000010c0) unregistered
               /org/bluez/obex/client/session0
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
               ref=0

As its highest bit is always set to 1, and so its value located after
G_OBEX_RSP_CONTINUE, the G_OBEX_OP_ABORT is part of the operations
constants.

This has been tested for PBAP and BIP-AVRCP with Android 15 and 16.
---
 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0e33ececf..df80d79f3 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -382,7 +382,7 @@ static void check_srm_final(GObex *obex, guint8 op)
 	case G_OBEX_OP_CONNECT:
 		return;
 	default:
-		if (op <= G_OBEX_RSP_CONTINUE)
+		if (op <= G_OBEX_RSP_CONTINUE || op == G_OBEX_OP_ABORT)
 			return;
 	}
 
-- 
2.43.0

