Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575EDF60
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810610; cv=none; b=LRvpqsf9U80EHFe5mKwuV1cRLpvl5eAfFl82y7Up++cA8yRpa7l9b3VNkYFZBN9mbdByCZSgKlPpcOV5PzifyI+GYsb2gFcpDt8KeLrtVIDrKMGKYV+uy1FO1YIL8iCcIryhcbdSkMEEbqxQP9sdWMSNxdPhEtICmvwLWjcMXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810610; c=relaxed/simple;
	bh=3MQszqQDBUvy7IK5NvJmNSQjr9diKR8PtsJLoY7rVaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J0w0HJccdB2UcJqARBVInJ3cusIy5W225k/Ia1VsxmViaJwpwFpqd8RY8SZrw8yvDqyLbY2GQEzT1L9SF0mWXKwTBukNQlPp57M30omzguAlAYVkvb3Ed9T5/PeL5he7nt8TY5xVWMdh+Ms/Wfyd8HOdL+Lrm0gEdJpxy1TVrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5LG1QON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5LG1QON"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A316FC4CED6;
	Thu,  6 Feb 2025 02:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810610;
	bh=3MQszqQDBUvy7IK5NvJmNSQjr9diKR8PtsJLoY7rVaw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=d5LG1QONeSzzHOD47QksWfC6/bd7e+yNbTNWFjlXdeWAgxDEfVt4fYfudLDK6nNRE
	 efNxZbg/xy4SEpuMvAihRH/BjzjGdZPRmdgvB7mg2BSI98U5KXc2zexksl1QNjDq3v
	 BBxxXWzv0N0l+Qm5ie8y3kvhtBCp62/dDNrxPo9OrZfPH8msAXNQmE2ifrNrMBJ63C
	 tJP1zMxYb4kETA3x18Vy0VYpwGnftkiAofJrHuQjv3RaBA9AdPgF3PARwOmE/gjrg/
	 VxqRrDWWOvwzkQXQ65beagHeiatPezmbH3I/7Yj7iVL23Pk8/O9NRGk2Mv4TbqgrU6
	 CkjzbAyxXcglg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99126C02192;
	Thu,  6 Feb 2025 02:56:50 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 06 Feb 2025 10:56:47 +0800
Subject: [PATCH BlueZ bluez v2] gatt: expanded maximum GATT channels to 6
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-upstream-v2-1-ffb66c7f9544@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAO4kpGcC/2WNwQqDMBBEf0X23JRs1AZ66n+Ih6irLhgjiYa24
 r835NrjmxnenBDIMwV4Fid4ihzYrQnUrYB+NutEgofEoKSqJSoUxxZ2T8aK0XRSy7JGM5SQ5pu
 nkd9Z1UC3HPSFNsUzh935Tz6ImMt/V0SBQncPqmqpKz3ql7GLm7i/985Ce13XD0Me1nmpAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738810609; l=1511;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=fKYDsSvbaUUoFFAF0fHWpr7zgdIXSd4zmy7DhmuHQYo=;
 b=TpvwSgriPApPjSCj18DHCjJ7LeorAhTRbckJ1KdDuMcaK18wWpFju4LQi5F0ZMyCkC0L0TCoD
 X8s1vJ3fQL2BLmLoYqaNd37vhN0ohiY376vOK2JNaCvIY6ehWKDAilf
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The maximum value of GATT channels should be 6,
including ATT connection(1) and L2CAP CB connection(1-5).

Ref https://github.com/bluez/bluez/issues/1033

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Change the maximum value of Channels to 6
- Link to v1: https://patch.msgid.link/20250121-upstream-v1-1-7b6e450747f7@amlogic.com
---
 src/main.c    | 2 +-
 src/main.conf | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index d13ada2af..50346abbb 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1119,7 +1119,7 @@ static void parse_gatt(GKeyFile *config)
 	parse_config_u16(config, "GATT", "ExchangeMTU", &btd_opts.gatt_mtu,
 				BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU);
 	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
-				1, 5);
+				1, 6);
 	parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client);
 	parse_gatt_export(config);
 }
diff --git a/src/main.conf b/src/main.conf
index 60ab60edc..749ed6d25 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -264,7 +264,8 @@
 #ExchangeMTU = 517
 
 # Number of ATT channels
-# Possible values: 1-5 (1 disables EATT)
+# Possible values: 1-6 (1 disables EATT)
+# The ATT channels contains ATT connection(1) and L2CAP CB connection(1-5)
 # Default to 1
 #Channels = 1
 

---
base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
change-id: 20250121-upstream-fab070351ad3

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


