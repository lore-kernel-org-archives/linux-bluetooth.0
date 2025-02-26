Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0AA1422AB
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534736; cv=none; b=QJG2pjH/lytFpPKRo7D+SOjKVZBCR6rGnQTsXVX+Dgh+qQpVQtGoX319F1rk3wckH4D//H/hYRx5uzqpDfDGJKBnxEyB2qwIKX54Vey3usEULQTG+438h7X/x5ZOQexX0YQyywYzSyyhG1QrppqtECHX9fxf8hEvXvBF5KdpJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534736; c=relaxed/simple;
	bh=IFCwjra6ceEwP/dPG3nzBA8FR5vZ9+FsRsGUHjrGk4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zk0j8MafwcApP/Xfbe4d7Ouxrz8cGa3etRztV2yBlhNuiUNbPSaEe2c4iJR5cUdcfJ8673v+qufaipIIeZ60RPk10TCVBVJj3ksqQ+Z+GHWMnW6T/0op3s/9LL+rjvR+7IgWB/fWh4uYuHYgK0wf4i/KZCL8eqwaPqR2yZKvkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaQk4Br2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaQk4Br2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 159C2C4CEDD;
	Wed, 26 Feb 2025 01:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740534734;
	bh=IFCwjra6ceEwP/dPG3nzBA8FR5vZ9+FsRsGUHjrGk4M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eaQk4Br2umwWSD0rMaYFLXse5M7X7OUoW3DJBvnI2JJ4xlBtgbuipbyZbDVCJoqrn
	 +kVJBYiF8shtt2YnD0UiQ3clgXjYji08uaXiWvDEpNDFG9o4QFuEecqhtSfNhLdc8w
	 tYKOAULsDxqii6OePXyLEiA2tf1nPqbQOg+9HagZBUg63supcS+DSIIKMeAXuwNVtI
	 ow4KZ9qJIc//LK0KfdVswYkfWT3slygV0OV+Ujzjgk4w6U2nA2u3goGGoejZ2i4NGO
	 mwOrGFL8+4CFEEOQm5A0kgeOzZ5ZZtLXESa2g0XA338IrR3txy9FXLyx20IBNNwGpv
	 bnccupM7gnFiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDBC021BE;
	Wed, 26 Feb 2025 01:52:13 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Wed, 26 Feb 2025 09:52:06 +0800
Subject: [PATCH bluez v2] adapter: Prepend the new added device to the
 adapter devices list
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-leaudio-no-media-v2-1-8d4dd95513ed@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAMVzvmcC/3WNzQ6DIBCEX8XsudsgIP059T0aDxS2uomKgWraG
 t69xHuP30zmmw0SRaYE12qDSCsnDlMBeajA9XbqCNkXBilkI6RscCC7eA44BRzJs0WjtJZKnA1
 ZDWU2R3rye1fe4TEs9IW2xD2nV4if/Wit9/K/c62xRuPtRTdamJNXNzsOoWN3dGGENuf8Aw9xV
 f65AAAA
X-Change-ID: 20250225-leaudio-no-media-634423086ea4
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>, "ye.he" <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740534731; l=1417;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=9JsiHCZlCs1D1DvtBuitQVccssm2fR/XGb53thZYVIg=;
 b=9EUdayr3IkVnxQI/LXm+4Hux/gRp9UC29tJ2pTA41aAG3dD9ltIEwzuYAszzOA6Ildcxcgo6e
 f0ew38HEoBoDm+VJ7sgfRcXgPLefzVtrIyQRGKLLgNXJ+qKTx5lhV1A
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

When the DUT is paired with a mobile phone using RPA multiple times,
multiple device contexts with the same bdaddr will be cached.
When we query the device context through bdaddr, we always get the
context at the head of adapter->devices, but its status is inactive.

https://github.com/bluez/bluez/issues/1095

Signed-off-by: Ye He <ye.he@amlogic.com>
---
Signed-off-by: ye.he <ye.he@amlogic.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2bb94cf1673e85710abf1e619fdeee9c9fa0f087..d675f0b1575a21bc345cbdb003411cf188fdd314 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5243,7 +5243,7 @@ void device_resolved_drivers(struct btd_adapter *adapter,
 static void adapter_add_device(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
-	adapter->devices = g_slist_append(adapter->devices, device);
+	adapter->devices = g_slist_prepend(adapter->devices, device);
 	device_added_drivers(adapter, device);
 }
 

---
base-commit: 0845b8f6ef2ac004b1c953cf4fe4ca3458cd8e36
change-id: 20250225-leaudio-no-media-634423086ea4

Best regards,
-- 
Ye He <ye.he@amlogic.com>


