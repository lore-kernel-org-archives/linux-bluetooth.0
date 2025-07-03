Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9F2D3A7D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533014; cv=none; b=tPSiSmrYz6JJSKFvyw3hqundcjZ0DNY7Pz2zQv6z/1ZMFHPKJ85/Pu490WzBo4OboyZGxpvfBiHWnOQKwKfk5a4EQbsrggI38ZOmRmb3IMZcky1pLVkQeII5lV7fdR0bb80gVAdfif9BFzRbSDFBWsImCP+X5+7hAdaOyGItHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533014; c=relaxed/simple;
	bh=WopUk2pSHXf8Gy9qTiktBcYlZE6zprYRAQXkMsLQSBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzHHrixO0/kxHgYZ7xZf57VCBczHieKSBLGE8b03lFllIpU2fHyCywpfUVxBfxOGK8Vp2YyFKsJG4wlHyqi/onrMBO8JCoDWJeT9vhCCR9jlqkCIANmCeTglRicNxIId3h8hcHQfDQOoFX+ZsuVkmB8DzqG+x6MDmRTEQprZ1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11D1943181;
	Thu,  3 Jul 2025 08:56:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 18/19] unit: Fix typos
Date: Thu,  3 Jul 2025 10:53:26 +0200
Message-ID: <20250703085630.935452-19-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth

Found using codespell.
---
 unit/test-bap.c | 2 +-
 unit/test-vcp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index f65df69ef373..a7a9448e7972 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -419,7 +419,7 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 }
 
 static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offest,
+					unsigned int id, uint16_t offset,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
diff --git a/unit/test-vcp.c b/unit/test-vcp.c
index 2a6e77eb08b6..cd6d53c0121d 100644
--- a/unit/test-vcp.c
+++ b/unit/test-vcp.c
@@ -138,7 +138,7 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 }
 
 static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offest,
+					unsigned int id, uint16_t offset,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
@@ -1825,7 +1825,7 @@ static void test_server(const void *user_data)
 	VOCS_READ_CHAR_AUD_LOC
  /*
   * VOCS/SR/CP/BV-01-C [Set Volume Offset]
-  * Do Initial Condition Proedures
+  * Do Initial Condition Procedures
   * 1. The Lower Tester executes the GATT Read Characteristic
   *    Value sub-procedure for the Volume Offset State characteristic.
   * Repeat steps 2-4 for (255 - Change_Counter value) + 1 times.
-- 
2.50.0

