Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42A2D46BD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533014; cv=none; b=JBp/9SKnyT/MtX2nKIRtNCqnC0NYMymhQaiT+F+tFfCPIY7oev0dGZy9zE8MiY9V/yiL0odNKe/vVZb/s4/FEmfrWmutDc7HLtb4va21ndq4K9bs4RfHwj34mN8FfHGDP1mAb/4m5ncj/i/cJ47HO0qZQ3bGaOi/BNf3bh6dgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533014; c=relaxed/simple;
	bh=rj0x3p7XmQeXtATSTZr//EozWZ9w7eiOBsEIsgkyYrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUJpRsQv7ymfnROIIBF7SpXYzNwiJkKzlTtTnxJeUAlX+mhieH8JECW6rcJo3h/ZTe+FZKOtAK8lvHBQ5XWLvlLhgIogW7ecS4elUvB7hHE4hPui/RgDTKS+tb5XHcX1XcjXKBo4DpcgLp8AledhFoYDsRK1Xg/E1H+CYT5IM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5E9843191;
	Thu,  3 Jul 2025 08:56:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 17/19] test: Fix typos
Date: Thu,  3 Jul 2025 10:53:25 +0200
Message-ID: <20250703085630.935452-18-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 test/example-gatt-client | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/example-gatt-client b/test/example-gatt-client
index 38ca97eae580..f9fca82c9eea 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -201,7 +201,7 @@ def main():
             continue
         chrcs.append(path)
 
-    # List sevices found
+    # List services found
     for path, interfaces in objects.items():
         if GATT_SERVICE_IFACE not in interfaces.keys():
             continue
-- 
2.50.0

