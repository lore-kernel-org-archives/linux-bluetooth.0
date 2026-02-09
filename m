Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF124C676
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669265; cv=none; b=r9YlFijo8+NSZ8CvY0s2KEEZZLOJ7cNDAAiA386ZCjdrlHhs3BnsUFJ1DXiIq3BfAZtm0WgiEAIqWYbq1dlVKPUo08Dfwfs4LDgWDg4+ONdxPj7xCJ7qtPPDfBZd5+a+JJ59x63TT96w1P4k+defWXyEZ97fc4PwpbcUy+0JyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669265; c=relaxed/simple;
	bh=VvhC1qOv+DiHVpUkxkaObXF9WlCf+KkLBRxcn4ei5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSIkRVxShj24/Sjmfde78CGLxEoFx2NScAW4wXwj/oNDgMUUELu62lJHYGtNei8rlAT07OsHV4ydWjARr9ltojZfNMDlPHzaM2CG3JfTObSDonTicvunIGyIzn7T//o6ArlVe84b1584y/96Yol47Svm/BcL1vmO/bp2wcgXUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8C42D581290
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:33:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFC15441B7;
	Mon,  9 Feb 2026 20:33:25 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] emulator: Fix compilation on big endian systems
Date: Mon,  9 Feb 2026 21:33:13 +0100
Message-ID: <20260209203316.3050687-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209203316.3050687-1-hadess@hadess.net>
References: <20260209203316.3050687-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnheptddtfeegffevteehfeejvdelvefhvdfgtdfhieeigeevleeitdegvdehfeekhffgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepuefhveduheeggeduueejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrvhesihhkihdrfhhi
X-GND-State: clean
X-GND-Score: -100

Use new helper macros for byteswapping constants.

This fixes the build on big endian systems like s390x:

emulator/bthost.c: In function ‘bthost_setup_sco’:
./src/shared/util.h:43:26: error: initializer element is not constant
   43 | #define cpu_to_le32(val) bswap_32(val)
      |                          ^~~~~~~~
etc.

Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
incoming eSCO")
---
 emulator/bthost.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index d09ad1e76c50..37865f61bc52 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3562,18 +3562,18 @@ int bthost_setup_sco(struct bthost *bthost, uint16_t acl_handle,
 {
 	static const struct bt_hci_cmd_setup_sync_conn settings[] = {
 		{
-			.tx_bandwidth = cpu_to_le32(0x00001f40),
-			.rx_bandwidth = cpu_to_le32(0x00001f40),
-			.max_latency = cpu_to_le16(0x000a),
+			.tx_bandwidth = cpu_constant_to_le32(0x00001f40),
+			.rx_bandwidth = cpu_constant_to_le32(0x00001f40),
+			.max_latency = cpu_constant_to_le16(0x000a),
 			.retrans_effort = 0x01,
-			.voice_setting = cpu_to_le16(BT_VOICE_CVSD_16BIT),
+			.voice_setting = cpu_constant_to_le16(BT_VOICE_CVSD_16BIT),
 		},
 		{
-			.tx_bandwidth = cpu_to_le32(0x00001f40),
-			.rx_bandwidth = cpu_to_le32(0x00001f40),
-			.max_latency = cpu_to_le16(0x000d),
+			.tx_bandwidth = cpu_constant_to_le32(0x00001f40),
+			.rx_bandwidth = cpu_constant_to_le32(0x00001f40),
+			.max_latency = cpu_constant_to_le16(0x000d),
 			.retrans_effort = 0x02,
-			.voice_setting = cpu_to_le16(BT_VOICE_TRANSPARENT),
+			.voice_setting = cpu_constant_to_le16(BT_VOICE_TRANSPARENT),
 		}
 	};
 	struct bt_hci_cmd_setup_sync_conn cmd;
-- 
2.52.0

