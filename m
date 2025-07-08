Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365622BD590
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963998; cv=none; b=Y8w2g2KG1L59abv86mSCYUlnyqmMfIoTTexFkKR9L3Mzx6QkvFnJ66Ny1XbdQTVQozYRqh37SpFOoCFdbnuqYtwBQtD0CejoxIBNZbwTW9cvg1B7GAbE1gTU1qgq88KB5q4d4bFphr37NvgP9sUQKgx+76DHYheZ7vqaqbLAErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963998; c=relaxed/simple;
	bh=QmSMyAFTVLZ8KFnDphn7gFt6aI1yfvFOx9aAQo002Ro=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cv2mu6lHrHNMoFPxfJsYFLi66g9wiBTPZVedYdCxtigT1hABTmJmZQRg6mhPgvJEinmawZ9NWtmGYEdOUBrPH6JV07IS/NGSrUtsrreVtWi7Mb9JXsgoOxeBdr1SVfbhqwqARDdI5BL9li6TvhcCqmiROvphbKi1NT6qiQgulCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42DE24313C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:39:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc: Fix extra word in doc string
Date: Tue,  8 Jul 2025 10:39:36 +0200
Message-ID: <20250708083948.1822604-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffelueffjedvueefffdvjeejvdehkefgledtjefhiedtteetgfejvdeuvdfhjeeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

---
 doc/mesh-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index ff302c8787cc..6abf3cb8f0ee 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -759,7 +759,7 @@ Methods:
 		assigned to this remote node.
 
 		The device_key parameter is the access layer key that will be
-		will used to decrypt privileged messages from this remote node.
+		used to decrypt privileged messages from this remote node.
 
 		This call affects the local bluetooth-meshd key database only.
 
-- 
2.50.0

