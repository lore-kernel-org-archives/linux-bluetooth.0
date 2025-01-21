Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650571B87C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453908; cv=none; b=l5r2hZ01Lrz/L+tWE5ofNHKAhI9eR4v2HVt0Fu4Xy/HGkAYJYlWt5ZK0Oz85tWgK9mjOnv2FNUxcEuyJPDf7zIZx5w4Gt9ouyhHDDVRAGEpqvo2pR70kulU2JrnnONcblg+wPyakxkTvtxcp9rY8ks4zVR/820lqFejEnuPMous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453908; c=relaxed/simple;
	bh=OYjv1AWH0gWhrAkVHJDjuAGy1OfogNbmTEm1/B7CtYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fhhx91g6n34yEeTmb4I6pk+XRsjWLCgCjcijA0ct4vNTyjeSJBm5CGyjgMzJCv1bBFhx3rgz1aZRggnZPbMnEn5VkKsM1VpUdFmkiwDb4LbIC74297Y2eAyWHjOStwDlKUaP1ItMqDA6NKJkHbE5NMj+ebuDkwUVZppTQ0qR02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXKQYO1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXKQYO1K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6450C4CEDF;
	Tue, 21 Jan 2025 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453907;
	bh=OYjv1AWH0gWhrAkVHJDjuAGy1OfogNbmTEm1/B7CtYg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AXKQYO1Ka49khj5P5AaOWHlhnt1L3tI5UwesySMnZF9b9fdOK309YSywnv1I56uWT
	 pST1t/04eVdKwoC9TJDVHDubKSElC4kIGrmrxJ1VbsrigbkqWtUJejfXIBv9k/2bEV
	 x3grH8kvZmd0nJsL1PZRhRSAAYjqQP4IyaDvzF82cRdRPzPAc7uziIRxrfQQTUQqIl
	 jTk+14ZPwo8v86rrXMm++7DnOFM1Y5NC3gXplPOvhb6g6k+uLZkaKDHF//x5koTBBy
	 Ox6Ow3DwrfqfFCv2I0t55vEpEE/kqlJPoF/SXqixNAxw++UKxwD/5Y3DK9g3PzS+e5
	 IplOMJG2LcYFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE15DC02182;
	Tue, 21 Jan 2025 10:05:07 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 21 Jan 2025 18:04:57 +0800
Subject: [PATCH BlueZ bluez] gatt: expand the max GATT Channels
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250121-upstream-v1-1-7b6e450747f7@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAEhxj2cC/x3MQQqAIBBA0avErBPUkKCrRIupphooC6ciEu+et
 Hzw+RGEApNAU0QIdLPw7jNMWcCwoJ9J8ZgNVlunjTXqOuQMhJuasNe1rpzBsYKcH4Emfv5VC/1
 60QtdSh9UKOYYYQAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737453905; l=1410;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=2whhUph12UWbt4IQDLgB95XDZYci4SGZ4RN/aFjNA2M=;
 b=1rtdRJBFOV6QCrr1IYnyjOf5XQxxkKr28ZxFFMvYLbaGoq52vYS6xyStxBHaED7uYT7j+FqEj
 Ip7vLASbNSPDWqAG9RwbR4KGFDQets5LQtnmbLetL/7BqBzs2bbxdbS
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Fixed the problem that Xiaomi K70 mobile phone takes too long to
connect to CIS.

L2CAP CB Connection (PSM=0x0027, MTU=517 bytes, MPS=251 bytes,
 Credits=255, Src=0x0056 › All Connections Refused –
 Insufficient Authorization)

Ref https://github.com/bluez/bluez/issues/1033

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 src/main.c    | 2 +-
 src/main.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index d13ada2af..e2243c824 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1119,7 +1119,7 @@ static void parse_gatt(GKeyFile *config)
 	parse_config_u16(config, "GATT", "ExchangeMTU", &btd_opts.gatt_mtu,
 				BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU);
 	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
-				1, 5);
+				1, 10);
 	parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client);
 	parse_gatt_export(config);
 }
diff --git a/src/main.conf b/src/main.conf
index 60ab60edc..95de56003 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -264,7 +264,7 @@
 #ExchangeMTU = 517
 
 # Number of ATT channels
-# Possible values: 1-5 (1 disables EATT)
+# Possible values: 1-10 (1 disables EATT)
 # Default to 1
 #Channels = 1
 

---
base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
change-id: 20250121-upstream-fab070351ad3

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


