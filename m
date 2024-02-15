Received: from mailrelay2-3.pub.mailoutpod3-cph3.one.com (mailrelay2-3.pub.mailoutpod3-cph3.one.com [46.30.212.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC813DBB3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037648; cv=none; b=e2A4/HCsci4m9YaOTM1XNcCpPPtvxNemhF/hHogLcv/OR4Dj398IHYkEomxI77KwTfSCabIJz5LVKjJwXELddMYqjct62QkGFdRhdKNaJqN9eOPrI0ZVubc+NxHWpbMpRp7LZVh7F+e8WLYXBrTDOHY6LW9+tscx5TJOWnP0gdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037648; c=relaxed/simple;
	bh=Rj60xn5WCQmWQYI8uUH9FW2yhzQ2GQOupFd3gImwjpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tX16/OMZvBdw3b01DKgho1VN20cEbX+ZAbn1LAzUpvpax0Yoyvv0faBbFX09WLVceOhb6JuvfVcMon/xOmNfJwXCu3V/gySMsEaSaToquGnTwHYiTQ2nE+It5DyCXUPreeskO/JmxWSxGaMV085lXYZ8o/YFvyUMss9xz30LJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se; spf=none smtp.mailfrom=tjernlund.se; dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=auT3V9ec; dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=5KoO7Z9S; arc=none smtp.client-ip=46.30.212.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="auT3V9ec";
	dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="5KoO7Z9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=pohyeC8WXlhlvsBHnuwYmzERV+vgZNCv2i7CzX1P8bA=;
	b=auT3V9ecCYKJXyafVQfbeJIvJgh2+1COlQ5+qV0Qjuxh8DGEv+Df4HKLL0o4515V7k8YUIw5IqGSq
	 CS0A+QwG2H+nAt44oTeN6RQi0npvZCuXopD3fXjsDwHAfl0PuJqdswK0aL+m+mgTDApOeAnE1LdIBB
	 alY9lBlaro6haLK5tQuKnBWdKxZfvnMPmFLIXRazK1cv4Qf1FT1CPGcm+21qLzk641HdWKWS+6HvrD
	 vejAsEcYc9QEckT4AUtJwYf53ojH6xwbuglsqLXd4Wbeb+S7WMWFWnuviPtrNSDZxboYkB9VFZsV+g
	 k5r9TJuNEbQQ13YaGM/v9WJz2blICzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=pohyeC8WXlhlvsBHnuwYmzERV+vgZNCv2i7CzX1P8bA=;
	b=5KoO7Z9ScYeDY7ts5dOf9H0WHiRop6w2bmbdgTyAcUKH7FIBTV++t9uT/WXXzW2Gg07ugv5IuTEma
	 Waw75OlDg==
X-HalOne-ID: f2f1f58f-cc54-11ee-b96d-657348328a86
Received: from jocke (c188-149-162-176.bredband.tele2.se [188.149.162.176])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id f2f1f58f-cc54-11ee-b96d-657348328a86;
	Thu, 15 Feb 2024 22:52:52 +0000 (UTC)
Received: by jocke (sSMTP sendmail emulation); Thu, 15 Feb 2024 23:52:52 +0100
From: tjernlund@tjernlund.se
To: linux-bluetooth@vger.kernel.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH 1/4] Replace @exec_prefix@ with @libexecdir@ in .service files.
Date: Thu, 15 Feb 2024 23:52:12 +0100
Message-ID: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The programs are installed with libexecdir prefix, make .service files
match that.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 mesh/bluetooth-mesh.service.in      | 2 +-
 obexd/src/obex.service.in           | 2 +-
 obexd/src/org.bluez.obex.service.in | 2 +-
 src/bluetooth.service.in            | 2 +-
 tools/bluetooth-logger.service.in   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mesh/bluetooth-mesh.service.in b/mesh/bluetooth-mesh.service.in
index 9c3ff01a3..d82043020 100644
--- a/mesh/bluetooth-mesh.service.in
+++ b/mesh/bluetooth-mesh.service.in
@@ -5,7 +5,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 [Service]
 Type=dbus
 BusName=org.bluez.mesh
-ExecStart=@exec_prefix@/bluetooth/bluetooth-meshd
+ExecStart=@libexecdir@/bluetooth/bluetooth-meshd
 NotifyAccess=main
 LimitNPROC=1
 ProtectHome=true
diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index 03d09a679..614ac090e 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -4,7 +4,7 @@ Description=Bluetooth OBEX service
 [Service]
 Type=dbus
 BusName=org.bluez.obex
-ExecStart=@exec_prefix@/bluetooth/obexd
+ExecStart=@libexecdir@/bluetooth/obexd
 
 [Install]
 Alias=dbus-org.bluez.obex.service
diff --git a/obexd/src/org.bluez.obex.service.in b/obexd/src/org.bluez.obex.service.in
index 14c16d3e3..e53e3f7fa 100644
--- a/obexd/src/org.bluez.obex.service.in
+++ b/obexd/src/org.bluez.obex.service.in
@@ -1,4 +1,4 @@
 [D-BUS Service]
 Name=org.bluez.obex
-Exec=@exec_prefix@/bluetooth/obexd
+Exec=@libexecdir@/bluetooth/obexd
 SystemdService=dbus-org.bluez.obex.service
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 63e157587..356b85056 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -6,7 +6,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 [Service]
 Type=dbus
 BusName=org.bluez
-ExecStart=@exec_prefix@/bluetooth/bluetoothd
+ExecStart=@libexecdir@/bluetooth/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
 #Restart=on-failure
diff --git a/tools/bluetooth-logger.service.in b/tools/bluetooth-logger.service.in
index 5657c8d84..31fabe8d3 100644
--- a/tools/bluetooth-logger.service.in
+++ b/tools/bluetooth-logger.service.in
@@ -4,7 +4,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 
 [Service]
 Type=simple
-ExecStart=@exec_prefix@/bluetooth/btmon-logger -p -b /var/log/bluetooth/hci.log
+ExecStart=@libexecdir@/bluetooth/btmon-logger -p -b /var/log/bluetooth/hci.log
 NotifyAccess=main
 CapabilityBoundingSet=CAP_NET_RAW
 LimitNPROC=1
-- 
2.43.0

