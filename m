Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE94328243
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101226; cv=none; b=bxb4TvuG+IQy4navSnaH1L4ceTR/VWpMpBRPAkvMoVrLaW3rdFFjS/jCLKwhhYZ+G4ttBaEe6d7gxHU7LZ7mZJuYlrJPzL49/0FKfobCCD30sTLcRI/JUVG36TNRDc1K+UF8YsPkU9dVSj2PHHJaP09Lm3Zt08tEyjeaVAXrqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101226; c=relaxed/simple;
	bh=TXPzKmLNE9+b2p0NWp2yqih8QLHYxdMzLMy3RrbbkIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ2lvxHxFy2rEEPf1vhUJPOkDqgKOa8H9eCkhStEMQEBxsh6/Uvfz7XOqb6u4CP8GwMf4V6Eq/O4VH2wtf5t/lFdY+K8d3b4WkG+7FWa3FKrmn9aYeQGZ/QC+52RJDDBUmK+vTjyjNZn8/WSy8uj+WYs+r/PEsEYz1bQmls9JkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A732444E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 17:00:09 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/2] doc: Update .gitignore for new daemon man page locations
Date: Thu, 22 Jan 2026 17:58:58 +0100
Message-ID: <20260122170001.122052-3-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122170001.122052-1-hadess@hadess.net>
References: <20260122170001.122052-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeijeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffieffueegieejheeggfeukeehgfehueeuhefhudejiefhuedtvdelleffffegffenucffohhmrghinheprhhsthdrihhnnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugeptdetjeefvdeggeeggfdvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean

bluetoothd.rst.in and bluetooth-meshd.rst.in moved, so the generated
".rst" files moved too. Update .gitignore to match the new location.
---
 .gitignore | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index f8e4ad686065..27c9b8b6eb65 100644
--- a/.gitignore
+++ b/.gitignore
@@ -150,9 +150,9 @@ tools/mesh-cfgclient
 tools/mesh-cfgtest
 tools/mesh-tester
 mesh/bluetooth-meshd
-mesh/bluetooth-meshd.rst
+doc/bluetooth-meshd.rst
 
-src/bluetoothd.rst
+doc/bluetoothd.rst
 src/bluetooth.service
 mesh/bluetooth-mesh.service
 
-- 
2.52.0

