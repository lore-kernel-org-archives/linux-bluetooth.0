Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED31BF24
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyddiC5+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3018C433C7;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413118;
	bh=mt/cAQdRVMGpUk5mi/AqEYZMGwI2MZPm2Ce6zyWCPO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DyddiC5+g5NoxlXF12dRRJvzHHVzoMXMMBtX+X5iMU9/pBDM+nTdAy6d+sSTwcM41
	 c37b6dl8/IEkKh+D/wQQwh8unPfLUCAVfc5f6DldH1ue4UUTLJHdN9fsja7wr/RSL7
	 hfcqri3MM9/UHyxo4bHnnlYI6g/l/Kyg4VxduuVaaQHkSg5Rv4X3iyUXn04gknYgRG
	 We9UNbNomk0g4hSL6EfwnmZ4qEmx1SSQSMzwYtROStnum4jhHrLRVIJxRO/zDn2w80
	 2jnZSvSZloIFO6zKLbJQqw/2KVhEMwbZB3V/EFY9v0ZEa1nWRIswnh+YHxWv6G52Rd
	 G6fq96WAMkTRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B67C47DA9;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 13:52:04 +0000
Subject: [PATCH BlueZ 10/10] build: install dbus-org.bluez.obex.service
 symlink
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-autofoo-v1-10-626f6b54bd06@gmail.com>
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413116; l=1158;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=fbR9nv2+W1T7EdTJDnrPWv8eu5ZYYznbyAyGjdmqMMc=;
 b=lntGRy6vfw67/RdyRn1wKOmw5nySnByTOkfOJaLCbTRo4gN+JWUSU6NuaI4j3n8Tnb8BkPHeT
 +K8fPKrZ3NgAtdzq5O18S9R0GPvQImUsVDZ/ACYA5LenKGiZcCRy69f
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

obex.service has an alias(dbus-org.bluez.obex.service) which is created
as it's enabled. At the same time, the dbus service references the alias
itself.

Thus the dbus socket activation can happen, only when the service is
already enabled/running... Which defeats the whole purpose.

Create/install the respective symlink/alias, so that any user looking
for the dbus will start it.

Note: we need a hook here instead of LN_S to create the in-tree file,
since `install' aggressively dereferences it.
---
 Makefile.obexd | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index c2b5c6d7a..363295d0e 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -3,6 +3,12 @@ if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
 
+install-data-hook:
+	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+
+uninstall-hook:
+	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
 endif

-- 
2.43.0

