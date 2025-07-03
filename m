Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447172D3749
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533009; cv=none; b=K/HCdP3XZcclDzgXVWwjpJQvw5WAl7zNVtwkVWP6vEiqdPDBGz0jjwWdVqtJll8yA+UcA+NZP8S+E0h0GvU7bC+oc+uPLVvc3UFs6knoLlEB7J5yFmgkLXRmc9dYBfU1ysABzzokGixHfrqOGI2FgQWLVWKSok6FqB2fNfy+kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533009; c=relaxed/simple;
	bh=CTGnynzG6O05g3pHTINf+bzUfuWL4k27kBPN4ghcno8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y85ikvSdLzRKNWDn0S7UyPvL6LU3gPkAKUCFviPvIweC+ZWG5ppA3zfxq7Ft5mxEmqBye3I3jie+vUL8c9RxprqB2FsJTTh5BVe9TCQwp8dVQtiuIl2msVs8L5LLpva1Qqjg58ZBs3n0V/B5fLscREOpHw16nlzNzP2qGEkXnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BA784317D;
	Thu,  3 Jul 2025 08:56:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 03/19] attrib: Fix typos
Date: Thu,  3 Jul 2025 10:53:11 +0200
Message-ID: <20250703085630.935452-4-hadess@hadess.net>
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
 attrib/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/att.c b/attrib/att.c
index fa53c90aa863..bf98fe2d8627 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -74,7 +74,7 @@ const char *att_ecode2str(uint8_t status)
 	case ATT_ECODE_IO:
 		return "Internal application error: I/O";
 	case ATT_ECODE_TIMEOUT:
-		return "A timeout occured";
+		return "A timeout occurred";
 	case ATT_ECODE_ABORTED:
 		return "The operation was aborted";
 	default:
-- 
2.50.0

