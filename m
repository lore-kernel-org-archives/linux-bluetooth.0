Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AD374190
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918518; cv=none; b=J4GnOAU8ImlomG1C2ZhMV/4jbwqBaaa28hElginvucjNHNPnYMocPW2aOIcpPdJqEia/Frc9Twr2o8Pr4B0QuqEktLN9ykgRFvwrF5pFu3nqX1CikyWStd0WRRiZbuVrMpxHsqlvg8ikAKCEO1hs4eUqGyH8rbS+ToaLsX+jeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918518; c=relaxed/simple;
	bh=pms70F7v8yGX9l/L5/vkoZlkGenpZHqJUxSa0HwY1Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU4sMxa9lsKw5+XkI7SLAAS4Phu8frrLtdIworIFdKN0YVRJ7/5jPCSflOaLdKODRuFaOAMAdAvUGgISPA4qnjhhmakEhvfgxUrlKEMlP99FCc7XLxZeJKi8hj0VoLYzYuTVNAaLOlgcd051obklcDhhMELdTt55R29QZ6gfJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 58E93580199
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:55:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 547293EBC1;
	Thu, 19 Mar 2026 10:55:06 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 1/1] adapter: Fix "Failed to set default system config" startup warning
Date: Thu, 19 Mar 2026 11:52:06 +0100
Message-ID: <20260319105457.1381098-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319105457.1381098-1-hadess@hadess.net>
References: <20260319105457.1381098-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeikedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepveethfelveejffetkeelheehueejlefhvdehteehgfeghfekgfdvfefhgeekieetnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepheegjedvleefgfeuvedupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhsohhrvghnshgvnhesrhhokhhurdgtohhm
X-GND-State: clean
X-GND-Score: 0

When using a stock configuration, there will be nothing in the list of
configuration changes to apply to the Bluetooth adapter, which since
5e5b46c5c0cc ("adapter: Do not send empty default system parameter
list") would throw an error, as sending an empty list to the adapter
didn't generate one.

bluetoothd[3291147]: Bluetooth daemon 5.86
bluetoothd[3291147]: Starting SDP server
bluetoothd[3291147]: Using external plugins is not officially supported.
bluetoothd[3291147]: Consider upstreaming your plugins into the BlueZ project.
bluetoothd[3291147]: Bluetooth management interface 1.23 initialized
bluetoothd[3291147]: Battery Provider Manager created
bluetoothd[3291147]: Failed to set default system config for hci0

Fixes: 5e5b46c5c0cc ("adapter: Do not send empty default system parameter list")
---
 src/adapter.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4e5ff219fe8b..04568dae6e98 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4963,8 +4963,11 @@ static void load_defaults(struct btd_adapter *adapter)
 	if (!load_le_defaults(adapter, list, &btd_opts.defaults.le))
 		goto done;
 
-	if (mgmt_tlv_list_size(list) == 0)
-		goto done;
+	/* No changes from defaults */
+	if (mgmt_tlv_list_size(list) == 0) {
+		mgmt_tlv_list_free(list);
+		return;
+	}
 
 	err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, list, NULL, NULL, NULL);
-- 
2.53.0

