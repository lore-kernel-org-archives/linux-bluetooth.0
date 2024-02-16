Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EA148FE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=PeVlrtBCNxWYhESoyiCId83mq/7po2+fon0H40XrJVYcGmZcTiq/G7Sj2Qrgh8yNgdrNw44D8JhMvZskuTPaw4gCk1nDe1pvBgJJf96GfjOGz85FUrRB5RKfjlIjWjBMi0OJOimv5qXhqUO1T2iRmEhMPkUSd86FMYqnBIYVses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=GXYb/LVnfI3PNEx4Dbvd7HSpNf4VFI0ZKACWyrBxcqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=jf7CBoU/Y/JvIR+AT5WapiC1FWLHlr6xDH9jrxCCQDvx7Tgto9RcjGRFjfQ+kr5WP7fD6HkAmJtlEw60hWz/WHPrQgQiwGVTBHP885zfPI0MtK1nCmpS3VQHHXabsiv+vDaPAQnrMn6j9lbRQoe+e/RWhKfbPDJSmFLAMpBmstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImRxeZVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImRxeZVS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFC40C433C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=GXYb/LVnfI3PNEx4Dbvd7HSpNf4VFI0ZKACWyrBxcqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To:From;
	b=ImRxeZVSNqfpRCzpYf+Y1KwhJ5NchLgZZpFFbYj6HutzdD1qQAzMhNB79QDM65Djh
	 o7hA6vdLAj3VJvHNOV+5yHAzRVx+U+HXFXt1dZhattkLUQPp9aUf3ubywmZXvWAfks
	 9f/Lrxpn8HcOUM851ZJubbAAXwVymtRDMBijrrUrbkaGTlXtef5ArvNDj6rg9Jup7t
	 tZSnttBWOqpkEStfbpsADIx5phwnRENMxQO/Bvh7+GMNSQn4ecIyV1lvqDz+44uWa0
	 oyR5JTCnCR2ySe8iHzMReHh/Rufv/z5jm4pmAyrWnfWM9TYXEiED6bkLra/0YoSmcu
	 eKknQYmvjYQLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DDC48BF6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:10 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:05 +0000
Subject: [PATCH BlueZ v2 01/10] build: rework {install-data,uninstall}-hook
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-1-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125068; l=1944;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=2q2yJxfalsDM6IrAcp4cLj0XyQOzx84+xaZIWSPUpFo=;
 b=KIs0MYGpSZVZxqgp91M5Co68Xw66l/7yynsCkaB+9ik+QIZ6FafSLMQODc9deDgDUxvFX8XH2
 WOU3MgISlLZBIVLbg1FTDd12pjI47lCdi2wRWKFurEoPgAJ8s3767Gs
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Currently autoconfigure throws a useful error, about a duplicate
install-data-hook.

Address that by making the two target specific and pulling them as
dependencies.

We have to create empty ones otherwise dependency tracking and
resolution will fail.
---
 Makefile.am    |  5 ++++-
 Makefile.obexd | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5207c172b..450e931c6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -31,7 +31,7 @@ AM_LDFLAGS = $(MISC_LDFLAGS)
 confdir = $(sysconfdir)/bluetooth
 statedir = $(localstatedir)/lib/bluetooth
 
-install-data-hook:
+bluetoothd-fix-permissions:
 	install -dm555 $(DESTDIR)$(confdir)
 	install -dm700 $(DESTDIR)$(statedir)
 
@@ -422,6 +422,9 @@ include Makefile.obexd
 include android/Makefile.am
 include Makefile.mesh
 
+install-data-hook: bluetoothd-fix-permissions obexd-add-service-symlink
+uninstall-hook: obexd-remove-service-symlink
+
 if HID2HCI
 rulesdir = $(UDEV_DIR)/rules.d
 
diff --git a/Makefile.obexd b/Makefile.obexd
index 81456544d..0e8bc6de7 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -3,11 +3,14 @@ if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
 
-install-data-hook:
+obexd-add-service-symlink:
 	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
 
-uninstall-hook:
+obexd-remove-service-symlink:
 	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+else
+obexd-add-service-symlink:
+obexd-remove-service-symlink:
 endif
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
@@ -102,6 +105,9 @@ obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 
 obexd_src_obexd_CFLAGS = $(AM_CFLAGS) -fPIC
 
+else
+obexd-add-service-symlink:
+obexd-remove-service-symlink:
 endif
 
 obexd_src_obexd_SHORTNAME = obexd

-- 
2.43.1

