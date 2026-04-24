Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B7386C2C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022025; cv=none; b=VDw08QCXpM4u3Sz2Gc+QRHVB9Anh9OSDLAoO47yFmzc5IMd+uKrXj4Ig8XYKA1bDEbIYdvJcyczFyZ5F4JW0DLYrzsvvTijxEg80oOnu0IYKm/iiMTr4EB1/li+735+5lRIrGHEHjhTVm2VmUzXRCMs7XJ3INjBcHYAQVRcwlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022025; c=relaxed/simple;
	bh=4cZ97BGx4ddEsnbPLYBmAWOBWHfNxia6VC/OZ8P0Wzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD41lvB4p8cEd2431HU2X12wrFSp/mNBDkXW3OQnv4ElECg0e9o467LZm51/Z2OaHyRNP5sTF+2NRH2VcO6MLkvRPjpgVUjTrxxjElgyYIkE6D2ceNPo2W78sYydOC2Q+z8k99M6d963Wcs5MU21md2MCKgYyAKIG4Gf2kGrv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88D3A3EBEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 10/15] build: Only build profiles if the daemon is built
Date: Fri, 24 Apr 2026 11:11:13 +0200
Message-ID: <20260424091324.3097084-11-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE4fwvglj1stUpqbfNOHgbX9pBEbBFXfBn+DQ4MiAAA6Q5/kgmY6sH9Wwik1ceYLp6ZNgfTynQHBkQ4N55lyQu4yW7V3nHJyk/iilnZtTxZrqQt0GkMVUUvcdSDhQ/I4N0PSGb4UvWo71F8G+un+/Zry4Qu718gJ7Tc1UFESpRs/KnFyu+QdCxtlRBx+YBGSmskVeXbdXm6PlGkslt6AZjsbtBecG/FMoAlwgc27KEpaEMzn5WZDvunlzCnmcJc3y7KTB1b/TPjvmtdlfkTY0qe3MmA5mFjVST1KD1dS2cnveNKU91CrDhd4MGiADuFUUUingjVS7GXUQtIFa0rmXsTN0v0vZ52LCeFaKO7gQo7hjm9Eq04RwUwk0D4bZYMDLC4luEOStHwNIgT91cn5qDWTTyxSCBGuBqp9qEKtCIu9nvrydOCtn4cZ3rZ56huyfAJEo1m62PKwbZ0thMrauOAvEpd/I53ZTtlB5+rSc5uu6obgPNRHbfitvhKaVPv3WkevHO69fQ4qJIp7xEBP4Lgyp5l1uJj+vIzqmepzpuJLw2U6O/zof3b86VRgg9NyMavcqz+PixD+smEfi9k+/E2278fFAZ4tdF93CFbUncaQJKq27KEs71eDJGxyfdCN0W5+OM1OIlT5QBYrE28FDapGPoHDCuXa4mc9Seqy2WDPQ
X-GND-State: clean
X-GND-Score: 0

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 586b69459d8a..b00e378d04ca 100644
--- a/meson.build
+++ b/meson.build
@@ -263,7 +263,9 @@ subdir('gdbus')
 subdir('attrib')
 subdir('btio')
 subdir('plugins')
-subdir('profiles')
+if get_option('daemon').enabled()
+  subdir('profiles')
+endif
 subdir('src')
 subdir('client')
 if get_option('monitor').allowed()
-- 
2.53.0

