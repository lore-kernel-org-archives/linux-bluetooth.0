Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669802D3A7E
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533011; cv=none; b=X9cjvxKx24vWRhSek4dVCK9YIcUTHXjQfxywGo90ee6PHBiHj4gNjaRYRSl5VV4HPxgQ+WT7n4dDniG15MJdZ1zRwOHL/HAfaAMUoRmSOKxzR1OsT11uXPsfwN7CbH+iC57/TFXdu12C5cPs3q3suTKlxkz/0CugM3wuzI7DzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533011; c=relaxed/simple;
	bh=Uhc6nRFZeZ8QjpMsqwK6rty4d1oaDfGsqH/m3JFRdzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOE5BLrMUb1Wd2p85x9JTiNm7yocB9FC/NjLRlPIV7uy/B8tFTLkK/N8Z+OpuNFbmLlEwUCJQxgdExGhX2iO7y8arbbTKjQAs7lhL+haQ3YXL9RwIxI2vbdRHM9kR0oVN5NgJ284ty5i6N9xHaha5YRJebbOsso25RJYDP8hOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A02474318B;
	Thu,  3 Jul 2025 08:56:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 07/19] gobex: Fix typos
Date: Thu,  3 Jul 2025 10:53:15 +0200
Message-ID: <20250703085630.935452-8-hadess@hadess.net>
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
 gobex/gobex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 07e46627ab39..0e33ececfc93 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -304,7 +304,7 @@ static void set_srmp(GObex *obex, guint8 srmp, gboolean outgoing)
 	if (config == NULL)
 		return;
 
-	/* Dont't reset if direction doesn't match */
+	/* Don't reset if direction doesn't match */
 	if (srmp > G_OBEX_SRMP_NEXT_WAIT && config->outgoing != outgoing)
 		return;
 
@@ -1105,7 +1105,7 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 		return final;
 
 	/*
-	 * Resposes have final bit set but in case of GET with SRM
+	 * Responses have final bit set but in case of GET with SRM
 	 * we should not remove the request since the remote side will
 	 * continue sending responses until the transfer is finished
 	 */
-- 
2.50.0

