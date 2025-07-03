Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACC2D3A71
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533010; cv=none; b=hQlpFCYJBUuLQ2jIdHwfc5qyp35MTSOhwOTES4ro36RQ4IXgGfZ4MIksTrYmr3yZYLO+ACCCB4VgdWFrmSVL6ojYQYOZ9HGy0Hl3s+aZKsGYF5ayXX18y5NucNYi8Oa+5KkxbwNIpzQgx1LbB9V0N9owe+GqSuYT/tRyYDWP0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533010; c=relaxed/simple;
	bh=gVEY2LGQf6dip6y8rlBiMZoWnSJGDm39aOsLubM5jZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyT1NGmeYoPNlzAvvyH6GE6bXy68IrcFhfnTjg9deGrPQFEKGPnAMjk9JsIuV2iCTPvV6WSN1J1HGDx5cHck6rdJlJpj810BH/cdgVVb8R6QuejkREk3giQGdupDAuje3IcJy8MG9XEHTrWRCmA1it+QNIFMqwPi3DYcVh9ccEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DC6D43189;
	Thu,  3 Jul 2025 08:56:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 06/19] emulator: Fix typos
Date: Thu,  3 Jul 2025 10:53:14 +0200
Message-ID: <20250703085630.935452-7-hadess@hadess.net>
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
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 555f55e52772..cc844fc3a8ec 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -273,7 +273,7 @@ struct inquiry_data {
 	int iter;
 };
 
-#define DEFAULT_INQUIRY_INTERVAL 100 /* 100 miliseconds */
+#define DEFAULT_INQUIRY_INTERVAL 100 /* 100 milliseconds */
 
 #define MAX_BTDEV_ENTRIES 16
 
-- 
2.50.0

