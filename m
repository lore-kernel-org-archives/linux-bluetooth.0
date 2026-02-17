Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151433509F
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342585; cv=none; b=JpPWjYbCKFo0MXiJPkPAzxvyPziqf/hco5RYPDHSHhgNT9VdMw8wVQ+NLI9mk4ZprnDVgArx8fdnIlNgRGBtBna1oHNE7MSBySrRqfUfpzVZzpQtZAmb6z+pW6lUhj1LTYD+nZZltPk9LqlbVmqueFX4+PF9JCX2sUVQyqMGWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342585; c=relaxed/simple;
	bh=P75Abq4tkPAwpsSnNtycaNYcGZxR7fOmANlLfH3YcGI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iV9IRD+MGWBptIQxA2xv34r3MfjzFiXUBxFL02nnnF/6q0V61nzPIsehoEEZhWjvQgF1dWYetviFUNpfTwj2we/iCc3/hsjrHAradardSZOZiXmSVS+X6euQim34TzSC6cTr0ZbfTJ9qw+h+LdiGUumeSp35vAiqMwRT0Fwx/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lX8c/ILR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lX8c/ILR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771342582;
	bh=P75Abq4tkPAwpsSnNtycaNYcGZxR7fOmANlLfH3YcGI=;
	h=From:To:Subject:Date:From;
	b=lX8c/ILR9B55BkZR3LuAC9woek0sbuhVNsGwweaE+y5TkNWCa3t0f5NBLtSOkIZJa
	 UauDOHW20oe9ukMEzExkDokcZ9pS0N6Liklt6P2rTB0gZ9s+bQIyqoyCsO9JCJdGP1
	 9smRv2lQPUv4WUTLhNyXLu7g4P/co4T3ChQXvP5peoZN3VN0scFLV9aCSW4CSpjjxS
	 Fp6hGtGtqVGUf4emtifVqhMMx2iGiGxbX47KcNP9brX/g5VPiLeJmtXGWaiedkAuFI
	 +qh2WT8GfVXpvcm0Vk4UJraYRwrqRC4kpbFSyAtOkqhmV/txdciOQ8XoashfKTQsNq
	 vrLW9rRKu0aYA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-09Dd-F4A5-a5db-c434.rev.sfr.net [IPv6:2a02:8428:af44:1001:9dd:f4a5:a5db:c434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F6E717E0330
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 16:36:22 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/btpclient: Fix build warning
Date: Tue, 17 Feb 2026 16:36:16 +0100
Message-ID: <20260217153616.394716-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

client/btpclient/gap.c:2359:3: warning: Value stored to 'reply' is never
read [deadcode.DeadStores]
 2359 |     reply = l_dbus_message_new_error(ag->pending_req,
      |     ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2360 |                                     "org.bluez.Error.Rejected",
      |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2361 |                                     "Passkey mismatch");
      |                                     ~~~~~~~~~~~~~~~~~~~
1 warning generated.
---
 client/btpclient/gap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 15f0f0cbd..85cdad631 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -2359,9 +2359,11 @@ static void btp_gap_confirm_entry_rsp(uint8_t index, const void *param,
 		reply = l_dbus_message_new_error(ag->pending_req,
 						"org.bluez.Error.Rejected",
 						"Passkey mismatch");
+		l_dbus_send(dbus, reply);
+		return;
 	}
 
-	l_dbus_send_with_reply(dbus, ag->pending_req, passkey_confirm_rsp_reply,
+	l_dbus_send_with_reply(dbus, reply, passkey_confirm_rsp_reply,
 								adapter, NULL);
 
 	return;
-- 
2.43.0

