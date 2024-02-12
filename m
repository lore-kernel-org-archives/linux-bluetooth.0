Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A5481B7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=iwHy5SC1PPuh1CDboVliZ8FYZjNcVFfmjLSmZf1Q5LB3y2lPRigMX6nwfF+/KOc49ebAJXMKK5NxCCKZgfqkmJ/XrH4fF4OvPFdBY/GcqGuFU6s8x24ApdP9mbd9iT5cpV532A7afS/uStBy8xUAhZZPPrxeDxAeoHm0sZNPn6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=86t49+zrMpop3+LBasTQDP6WPhep6F5sBzb6VCO3Wq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmEs3zmzKMOQcxy9DIAkdXPMQlMcGiiJXleHsv2q1f/7LxMfm6skbXkjdmaNoSjsg+iKTMXwekwPW6QwI6dH/CvrFyu6iTK3JtoTZCHGC34bAq39z91QeLOS837jYetYQXRZefDqK2jzdHHCe3+q55pYKgsjHlWcdGKKs98j224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G47AdXp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G47AdXp1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B6A4C43330;
	Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768160;
	bh=86t49+zrMpop3+LBasTQDP6WPhep6F5sBzb6VCO3Wq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G47AdXp1Yx8Fbt/rIV7md4ZSXNgcComT5o1jTeCmOSP0rHKWPT+OVATCr6t7lSGWA
	 zumZ7ScSiTpsP/z/SnkTIg7Db3xQ8iO7SWhOG6mJ+qABblwWfC62SoRG42iv3lG9sq
	 l+TlnQe9ayo8pyt0lacPSAbqLvspECFwpAqrk9Qc7P06XOUqBczNc/AZ7Mxn7DJREq
	 s2pLcWORKw2bEHxBqMGbCjqxOM5snVbWcviXt2GY7FfFa2yvQkIvyKSy7LPwRZ6p62
	 +lUOcVCvvUgfsbDf+1DXqIXVWmcBmxaO6PD07+h+x/eiTPPJhD7geZKVWRpOsAy6TN
	 /I2zSMtT0XQ0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D7C48BC4;
	Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 20:02:44 +0000
Subject: [PATCH BlueZ v2 08/10] build: ship all config files with
 --enable-datafiles
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-disto-patches-v2-8-8bab1bd08f4d@gmail.com>
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=1705;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=ukSb4msDR5fjqRG8A0bYJ7QVffGjcQu3Z3Tc8kb10CQ=;
 b=xK9CkzK5fzFcBBf720C/4yHCdPEbAhMR5/IPP7H4Utn9Q6IxtCEuQdWid5wFzg/1UgK7/n5nW
 erVHcLvEa7xDpk2ornXWv57kq853YKNOtRfvzMBeU1DNOQM2GP9fqBe
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
index 2b1b9acdf..2cbfed2db 100644
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
index ea50383d2..e4c9fa6a3 100644
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

