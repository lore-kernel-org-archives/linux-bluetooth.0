Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D25148FE7
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=BVt6qSnSABrBgfiS35HrfOtJX1MS4hRCUV7pnvZYtxpEmcetLxDOHeuYJLF7Ww2I+hYu9LmOEMzaI3YOAZq3AngcTWugWvoMIqCnqSb9xA0jhPf7+pSYGDivi3iNRyrdpt4CqpPxPVPNTpT/k9z3JlR/w6dU+0f2Im31K2Y0Uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=Ew4oTdCkjRqvpD6DFOQabHg4hDVi6mj79yCGseCHa7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=cHFf47cJp/UEWY1btwkXdwKFKYtHR4mHCAncQro8DX4KgF11JFysAv4N3usVSxfetmmKuevgvB6Sge6jTkkbQ7kderPkdY7NVjqFhZVzgZgv+y679sO6qeedAGg/6iWAW3+vJFznV/CzDBOrqOBseTEm5s832AaFRWl26cYQCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR/IwBu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR/IwBu3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F15C43330
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=Ew4oTdCkjRqvpD6DFOQabHg4hDVi6mj79yCGseCHa7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To:From;
	b=RR/IwBu303wXkE8NZCnxAxYvQHojSzgHLdy4/OSgZSDVZ7iyraOY70RqaDvAHCtfn
	 3smqTjexoHXB4itSiLQjeeNm4C2aSYOXlUPqAX1Ctt0RRUcU46r9HQWQkviCi73wHW
	 9tNlJZiAieoIOyPxdwEIhmEkHpuDI5zFFpnMYireb4d25rSoEhjHr8PYEMQBuDGKsC
	 YmuoRGuKs2JkpVWJ7faRmtv+uMZ2GCMgKx1Z4toTwqZsiJ3bh8Hcl9zOx2H17M9dW1
	 euOJhNhohWZfi8xyIp52/tRMBiwHMHI7T0fsVtuq7jE+RPsgBnOdHpQTcHxgUFjPhV
	 5nNV3Yyk2W7Og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3790EC54764
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:13 +0000
Subject: [PATCH BlueZ v2 09/10] gitignore: ignore all manual pages
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-9-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125069; l=1883;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=/2ToIKiPlK66Ad0zCXSBgK+mSXWmJcB3cLI50N1fKIU=;
 b=tUrbANG0P3AomSxK6RYacG5aga8rSDGlk6XZIGwqP6Ffc3/pHx0CM1g019qRWCRFcVzGSUb13
 GujUUP3N/M1CppQWB23wOIDeX+B5mpW7cHU5eh2FGOFnKmwvLRS39Ao
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Drop the few explicit entries and use *.{1,5,8} instead.
---
 .gitignore | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4da95f275..a431304c3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,6 @@
+*.1
+*.5
+*.8
 *.o
 *.a
 *.lo
@@ -47,36 +50,25 @@ tools/avinfo
 tools/bccmd
 tools/hwdb
 tools/ciptool
-tools/ciptool.1
 tools/hciattach
-tools/hciattach.1
 tools/hciconfig
-tools/hciconfig.1
 tools/hcieventmask
 tools/hcisecfilter
 tools/hcitool
-tools/hcitool.1
 tools/hcidump
-tools/hcidump.1
 tools/hid2hci
-tools/hid2hci.1
 tools/rfcomm
-tools/rfcomm.1
 tools/l2ping
-tools/l2ping.1
 tools/l2test
 tools/cltest
 tools/rctest
-tools/rctest.1
 tools/scotest
 tools/amptest
 tools/oobtest
 tools/advtest
 tools/sdptool
-tools/sdptool.1
 tools/avtest
 tools/bdaddr
-tools/badddr.1
 tools/bluemoon
 tools/seq2bseq
 tools/hex2hcd
@@ -104,7 +96,6 @@ tools/check-selftest
 tools/mcaptest
 tools/bneptest
 tools/isotest
-tools/isotest.1
 tools/iso-tester
 test/sap_client.pyc
 test/bluezutils.pyc
@@ -134,10 +125,8 @@ tools/bnep-tester
 tools/userchan-tester
 tools/ioctl-tester
 tools/btattach
-tools/btattach.1
 tools/btconfig
 tools/btmgmt
-tools/btmgmt.1
 tools/btsnoop
 tools/btpclient
 tools/btpclientctl
@@ -145,22 +134,17 @@ tools/btmon-logger
 tools/bluetooth-logger.service
 peripheral/btsensor
 monitor/btmon
-monitor/btmon.1
 emulator/btvirt
 emulator/b1ee
 emulator/hfp
 client/bluetoothctl
-client/bluetoothctl-mgmt.1
-client/bluetoothctl-monitor.1
 tools/meshctl
 tools/mesh-cfgclient
 tools/mesh-cfgtest
 tools/mesh-tester
 mesh/bluetooth-meshd
-mesh/bluetooth-meshd.8
 mesh/bluetooth-meshd.rst
 
-src/bluetoothd.8
 src/bluetoothd.rst
 src/bluetooth.service
 mesh/bluetooth-mesh.service

-- 
2.43.1

