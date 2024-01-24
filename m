Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C17CF24
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113210; cv=none; b=b29l7WwGO8czTCiYy0G9jioJp7JSjdoBE9MVvztlUDQ9YWfx6rynuU41nvSOTAnwFKmi+/1On7Rxj2Ta1QRtep23mDIA9TOwwL8mT64LYTKE7yMLTJpsRm+1bQuKaUzYueRKmvGReLBR7ug1+GjpopRxiqFhVs0cVvzM8VNzvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113210; c=relaxed/simple;
	bh=mt/cAQdRVMGpUk5mi/AqEYZMGwI2MZPm2Ce6zyWCPO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Td8WaJKeUk8BdniSTlv/kIag4r2p8uzJR5Yus+T4ZKH4pdCOxigPM15+9egsXKYxIjqCdj/hKRMdoNq0FOBMTBm2303BP/4ltKxzaX8AakuboCGtklpxQYzO2Gt1EghwzciDAGhHoVIY3TQJWPz/nQL4GUwkeP1NwFdbnKhgP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCaLWdeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCaLWdeb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93931C433F1;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113209;
	bh=mt/cAQdRVMGpUk5mi/AqEYZMGwI2MZPm2Ce6zyWCPO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YCaLWdebPrOv3Uhavx1VE8hNdF8fjD7XOccpYU9Zsdr4DmK2U6cMkq12grBwBe/95
	 ptp1OClbV0q9xK16sV0JPk1qOBahB+lKq/8OJzUKq7kxCcKzRn29zaswLdfFTcyXk8
	 LepisMT/urcV+3WHUOTFVWGOQASDdW2+LjHSHphpoO5CPrS61te92wysNNpH/LJnpd
	 9AkxuDLMKiXwtY3J07hMbTxILIg07joW+wl5lSE6aldOsaerWVVXbtkohGd4F5l7p0
	 BWhUhXvrKUM98rVxRXexUuxYsP4xX5J7Q+Uk+4HaKdrDBzknQbn2Ng7bm/lQTxDNye
	 G+Pe3sAmnCn4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86121C48286;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:20:11 +0000
Subject: [PATCH BlueZ v2 6/6] build: install dbus-org.bluez.obex.service
 symlink
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-autofoo-v2-6-a210f20aa2f7@gmail.com>
References: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
In-Reply-To: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706113208; l=1158;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=fbR9nv2+W1T7EdTJDnrPWv8eu5ZYYznbyAyGjdmqMMc=;
 b=7+IjkrXQNVb3h8u9JdTKomQWY65njHFNRhxiSfCXMEb9MH4lByR/ro5trZ7/qXHQNwobV8mgv
 whH7cqBNPwDD61XkF7Qbyi0W0r02hhgD0AdniwJZRExIP8P87EIhhZI
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

