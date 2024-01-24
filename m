Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822013667E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139867; cv=none; b=m62t+z2L4su5DzHYn553cOcOt8L/MuLVhV+RzvAlsATt/hTiNyG8DguiePzkF+1Y3uIKHFZ/jW2G6eNgNTQa6P/qyYOUMqM7j/xEo8bdvQZzBK8YMBANWf3GgLE8kmWmgPLIpe/6XDC+qSWCGIEDbHRrJasQFlu4MojVfDWt704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139867; c=relaxed/simple;
	bh=UlYvPDgls3Riarzl+AWR4vttNiWHQDn0S+ENNSZXsR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDuJWKlEKHAWVqb9JYm4cmk+pQD5hXaRoCjIf/fAT9mHMJ82hf/L2K9CvqSuOguDqL3Yzjc/WXncCYA7xY8e8eZGwXwd6uvWjoUzYNZ58BKhfA4F/McBLedB6NZ6gUzRaNj6R64gWltU1quylCkT1kVytKeFcQRKhyqDcehvnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ36zdHI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ36zdHI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B100FC43330;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139866;
	bh=UlYvPDgls3Riarzl+AWR4vttNiWHQDn0S+ENNSZXsR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KQ36zdHI3pTX2UiPIZ6R3VrKLcLLKIqNKX/mx2oRR+FZBuHpcyGHnSWefDxQQJoNp
	 wEtdNdB1vxhnS4Bl7iZTr3ywp6DWqVYArAhI8j0lXgSiOTRdCyIkmFHi7BA+Ensj9n
	 QlDVCfNTI2ITqhtU1H6R8SpwitTQ0cc1eVTsbo0D/GOSU5yd/yvNcyrxLaB8D333yz
	 sN4Uh7ybnqZyRCVFa3C7alG91UDraLJ4SLCDXeNqMUM86bdXZfjFaD3CDvLaEV4nHn
	 IsSHclEOU9s8TS4VEghKme0HFPGuoxkoxQ7Nr+hfNlOuYrrr90pTmK+HqSZv9OBJB4
	 2pPbgsin92IXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1CC48285;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 23:44:03 +0000
Subject: [PATCH BlueZ 9/9] build: ship all config files with
 --enable-datafiles
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-disto-patches-v1-9-97e0eb5625a3@gmail.com>
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
In-Reply-To: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706139864; l=1705;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=WcwicGjaSO+V6cupapMGhMCvR7ck7Ya4gUcQRwXNGwI=;
 b=a7Fl0HIZ57bBn2edsjUAYUYgph+/lnsbJ6+I/euXHaxIcekgg5QE6CMNN+qUfThTkJhT5VgN0
 oydUmZUnW/3CFlW8h6AuNWgal8HQus2gHr/AhWI9P7o/5FyWVR8vCeH
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Currently we ship only the dbus/systemd policy files and omit the other
four - /etc/bluetooth/{main,mesh-main,input,network}.conf.

Outside of those files, there is no documentation what the defaults are
and the other possible options. A number of distributions (Arch, Gentoo,
Fedora) have opted to manually copy those into the package. Alas this
does not scale and leaves other distros at disadvantage, in a sense.

Note: we need a custom install target to ensure confdir and statedir
have the correct permissions.
---
Some distributions do toggle some of the default values, by patching the
source tree. Future patches will add support for more maintainable
configuration handling akin to `man sysctl.d`.
---
 Makefile.am   | 8 +++++++-
 Makefile.mesh | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index e738eb3a5..9c19cec49 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -31,11 +31,17 @@ AM_LDFLAGS = $(MISC_LDFLAGS)
 confdir = $(sysconfdir)/bluetooth
 statedir = $(localstatedir)/lib/bluetooth
 
+install-data-hook:
+	install -dm555 $(DESTDIR)$(confdir)
+	install -dm700 $(DESTDIR)$(statedir)
+
 if DATAFILES
 dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
 dbus_DATA = src/bluetooth.conf
 
-conf_DATA =
+conf_DATA = src/main.conf
+conf_DATA += profiles/input/input.conf
+conf_DATA += profiles/network/network.conf
 state_DATA =
 endif
 
diff --git a/Makefile.mesh b/Makefile.mesh
index 63f085de1..930262d53 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -3,6 +3,7 @@ if MESH
 
 if DATAFILES
 dbus_DATA += mesh/bluetooth-mesh.conf
+conf_DATA += mesh/mesh-main.conf
 endif
 
 if SYSTEMD

-- 
2.43.0

