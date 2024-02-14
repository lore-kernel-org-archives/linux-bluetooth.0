Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292ED13F018
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948095; cv=none; b=IB0U0UM6Sc5UvS7ZM+YAMDBx0IZNjnqL6mi9iz399dpyGns9X5mVY6QQWCSOGE9dXYwHBuT6MXHt1UpFaB2XZd2S8Y/w7XQmCATb2k8Z2GNedUSf6aoV2wlR7WVDpaKP56ycBcghBuKKmPx9ShqcUCHKRspBDycwOWhGXGiqVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948095; c=relaxed/simple;
	bh=QJnN6/Q0YpDS2ZB48KtZY9zuzZ9BzMPOx38uuHOHJkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoKBjtzpS+5lmrSPMpYUTGfbr711XJfDDkLVJonJYKwVXB2pxv5C+6He1K31J7nP3LyhKx0e89oTQ19DGeyWxYXQ81JITf5Os3Q5V6n7FpVrqtT24REgbuXMsKf6YcyQ2+ahU+XhTGOuoSsA7eUS6xKtVn/PAlSwWoq0/Ir85JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYYO10rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYYO10rq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB83BC433F1;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948094;
	bh=QJnN6/Q0YpDS2ZB48KtZY9zuzZ9BzMPOx38uuHOHJkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YYYO10rq0hAJvFbMIpP+2Lp1VV83v5mtjURhybodG2G82jdg6VumOvoc7hN01YCI2
	 nR48a2GpzdiVrveNQhju1ru7ZUnGry+MdrNvREzK/CCRhuaj26bBZDLG1FZWvx16Xa
	 fUrjVf1hg6n+lxHkO9mSAlrfuI7T/JoppGWajOjwL/PsAqaoSr5nePFjpa3NvXoDH7
	 q1wybs8ydthinkyjOulogO7eB26WH1gnPf347CAYWnodO+V6tM1lRyzL0Hue7G+Dkc
	 5QrdkmeeufL/BUFtE97HXIeeGyvvoHc6HO+x/IhCmHCns/UsW2XsAHfdKGH0KSS2pc
	 MHjlHw2bphkjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18A1C48BC3;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 14 Feb 2024 22:01:24 +0000
Subject: [PATCH BlueZ 1/4] build: fold separate install-data-hooks
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hook-fixup-v1-1-0e158ffea140@gmail.com>
References: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
In-Reply-To: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707948093; l=1454;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=dtWLnKx4leNFwGkNegEX6jHOWak1uw7hhMJRp7odx88=;
 b=a15wcEhZlDXS2x+YnXiC6jYEavgqJFnrZQDLJJZaNx2A1aQgVDE21B6mzOsaAxBBERGk/zRTF
 xr2E1X5IsRQBzrWABWapgjToDBoLNY6FqtzU8AfQidxy0sFSnqhULTX
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Autoconfigure throws a useful error, that I've missed previously. As-is
with two identical hooks `make install` will fail.

Just fold them into single place - not particularly pretty but works.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Makefile.am    | 9 +++++++++
 Makefile.obexd | 6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5207c172b..e67551761 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -34,6 +34,15 @@ statedir = $(localstatedir)/lib/bluetooth
 install-data-hook:
 	install -dm555 $(DESTDIR)$(confdir)
 	install -dm700 $(DESTDIR)$(statedir)
+if OBEX
+if SYSTEMD
+	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+
+uninstall-hook:
+	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+endif
+endif
+
 
 if DATAFILES
 dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
diff --git a/Makefile.obexd b/Makefile.obexd
index 81456544d..b91ca6644 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -2,12 +2,6 @@
 if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
-
-install-data-hook:
-	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
-
-uninstall-hook:
-	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
 endif
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)

-- 
2.43.1

