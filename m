Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA7341678
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715987; cv=none; b=uhiRovYM1SRkIpt0zuhhPQnYCNcl9m2JHo7ViZlfo9umP72vK1rZ/59itbhpLgFHUPGSLlnbPXmBnYd/M0TOQNeCXi44t3u0JZvPhaz4BQ5xGrOvrcPBVoGjE33PdygWo0/AD/GAT47Zt9TAFqw0seZeT6ArGudPGm7lg4D+2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715987; c=relaxed/simple;
	bh=XrtvRW8dQZj71wLlXuytndBT+9BzifA4DxH5NNOOVqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFEHCkcGG8t4bZn+MzKQCatd8GT5JqJ0YofS/ep2L7euiTN+yO1YXHayMAPleq3Ur0M741VJIcsyWb35beVx31R6U1q1JVmbAD4Y0RkapvVXEghg4AdTtbQ9MISR5knpUzLc2RiKyF1NNPYy6EbsPMb4twL0CBdFq9/zue4XRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 403293E9B9;
	Tue, 10 Feb 2026 09:33:03 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] emulator: Fix compilation on big endian systems
Date: Tue, 10 Feb 2026 10:32:47 +0100
Message-ID: <20260210093254.3246483-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepleehfeeujeefieelvdegkeetgefgveekieegffffhfevffdtveeikeduvddutdelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgedtfedvleefgfelueelpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrvhesihhkihdrfhhi
X-GND-State: clean

This fixes the build on big endian systems like s390x:

Remove the "static" so the array doesn't need to be initialised
with constants.

emulator/bthost.c: In function ‘bthost_setup_sco’:
./src/shared/util.h:43:26: error: initializer element is not constant
   43 | #define cpu_to_le32(val) bswap_32(val)
      |                          ^~~~~~~~
etc.

Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
incoming eSCO")
---
 emulator/bthost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index d09ad1e76c50..53b12f828675 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3560,7 +3560,7 @@ void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 int bthost_setup_sco(struct bthost *bthost, uint16_t acl_handle,
 							uint16_t setting)
 {
-	static const struct bt_hci_cmd_setup_sync_conn settings[] = {
+	const struct bt_hci_cmd_setup_sync_conn settings[] = {
 		{
 			.tx_bandwidth = cpu_to_le32(0x00001f40),
 			.rx_bandwidth = cpu_to_le32(0x00001f40),
-- 
2.52.0

