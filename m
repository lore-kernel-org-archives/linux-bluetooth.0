Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1717207E1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816860; cv=none; b=tbnIGfyr1m4TCqysaNpZrxMuDUrmoPCs/JzxObfLUk9xGaLBTKL8H+I7BUW7BtR4yum95J84XGRiKaXRhCx1MAm3j0+PFQBHG6b4Zf3okRPF00RTbsXmBuibYmV9zMSnCzMKr42eBy3kJtyf/c0dG27zuDcKWN7a6kwwnycJUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816860; c=relaxed/simple;
	bh=LwGWH03r91qzpKpexNeC/bcB2a/e8ZCCPLI/Bimhz50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dqso9lg/Xftxx3kCvk1jAgVnWtL7NwUkHf0Jr5kyfcj4OQrW68F7O0GoNKGkNRjXHsXzv1dFNaGeRhtPJAd9Ul6T2QLvrV9hHtpxjNpSkOLTdcqaqnmkP3F4HwMXQGIprf72r9mSxtrQI6qooEzYRfmwiPZ1wlCUmTJp7YOX1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from a.d.7.c.3.f.6.7.e.2.2.8.b.5.4.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d45b:822e:76f3:c7da] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u54ZK-009SGS-2P;
	Wed, 16 Apr 2025 16:20:54 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 2/2] obexd: only run one instance at once
Date: Wed, 16 Apr 2025 16:19:36 +0100
Message-ID: <20250416152039.971257-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416152039.971257-1-kernel.org@pileofstuff.org>
References: <20250416152039.971257-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obex is a device-oriented protocol, so only one instance can run per device.
But Linux file security is user-oriented, so obexd should be a user service.
Tell systemd to only run this service for the first non-system user to log in.

Without this patch, errors like the following will occur if you
use the "switch account" feature of your desktop environment,
then log in with another account:

Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001133-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001132-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 0000112f-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001104-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001106-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001105-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00005005-0000-1000-8000-0002ee000001 which is already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered

The above errors indicate the service completely failed to register, so this
does not change the user experience beyond removing the above messages.
Specifically, the first user who logs in to a multi-user system still retains
obex access to devices paired by users who log in later.

This is based on a pair of recent changes to the FluidSynth daemon:

https://github.com/FluidSynth/fluidsynth/pull/1491
https://github.com/FluidSynth/fluidsynth/pull/1528

This was discussed in the comments for a GitHub advisory available at
https://github.com/bluez/bluez/security/advisories/GHSA-fpgq-25xf-jcwv
but comments are not shown in the published version of the advisory.
To summarise the useful conversation with Luiz Augusto von Dentz:

Obex requires access to the user's home directory, so an attacker can only
transfer files between locations the user controls.  That may be a problem
if the user who runs obexd is different to the user who paired the device,
but solving that would involve pairing per-user, which causes other problems.
Bluetooth connections can be initiated by peripherals, so switching user could
trigger re-pairing and cause the original user to lose access to the device.
This may seem reasonable for file access, but for example users would likely
object to constantly re-pairing their Bluetooth keyboard.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/src/obex.service.in | 6 ++++++
 tools/bluez.tmpfiles.in   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index cf4d8c985..42d2185fb 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -1,10 +1,16 @@
 [Unit]
 Description=Bluetooth OBEX service
+# This is a user-specific service, but bluetooth is a device-specific protocol.
+# Only run one instance at a time, even if multiple users log in at once:
+ConditionPathExists=!/run/lock/bluez/obexd.lock
+ConditionUser=!@system
 
 [Service]
 Type=dbus
 BusName=org.bluez.obex
 ExecStart=@PKGLIBEXECDIR@/obexd
+ExecStartPre=touch /run/lock/bluez/obexd.lock
+ExecStopPost=rm -f /run/lock/bluez/obexd.lock
 
 [Install]
 Alias=dbus-org.bluez.obex.service
diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
index e69de29bb..05b8ad65c 100644
--- a/tools/bluez.tmpfiles.in
+++ b/tools/bluez.tmpfiles.in
@@ -0,0 +1 @@
+d /run/lock/bluez 0777 root root
-- 
2.49.0

