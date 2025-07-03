Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CB2D46A3
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533012; cv=none; b=rFhACba51HH/1PO/ElEgheiJ/tzWx/nzXIdXHXUWYqb0J+6Wa2PFlHc3h/bURBgpc5zUpgQa3wPVTvnwIIrjw6YoMeIHequvKk+FSR4q/zfuUHvWp/jXzLcUwS7r3Gr1vfC5OXduUWx2fjuc4s4DJMvwQch7VnfN7KMAoXF2GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533012; c=relaxed/simple;
	bh=HuisIXaItRv33QMTLVxVzhnHoV0zrhJdPDGU64lTYiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9hjjM8X2YZGb9pz/AxBSTi9r3EqbQF0ZmJVQoLWcKm1nxjZAf8LllGcMGFqeB9xEjdXDuEBchEW+1GeNbEA+VS+uX9UOWTXq1IZ7+PCH6+TUp3Ah7+6TWjAiCxtZZIxqVklrpdErIddeYZfiMRp2dWXL7vMpg3nUCaEvWwAb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8037743192;
	Thu,  3 Jul 2025 08:56:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 13/19] plugins: Fix typos
Date: Thu,  3 Jul 2025 10:53:21 +0200
Message-ID: <20250703085630.935452-14-hadess@hadess.net>
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
 plugins/policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 561e3c089e51..66f5c04ccb04 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -322,7 +322,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 			policy_set_hs_timer(data);
 
 		/* Check if service initiate the connection then proceed
-		 * immediatelly otherwise set timer
+		 * immediately otherwise set timer
 		 */
 		if (btd_service_is_initiator(service))
 			policy_connect(data, controller);
@@ -498,7 +498,7 @@ static void source_cb(struct btd_service *service,
 		data->source_retries = 0;
 
 		/* Check if service initiate the connection then proceed
-		 * immediatelly otherwise set timer
+		 * immediately otherwise set timer
 		 */
 		if (btd_service_is_initiator(service))
 			policy_connect(data, target);
-- 
2.50.0

