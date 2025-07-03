Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EB2D46AA
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533012; cv=none; b=uWXhwftNKZO9tZdKS7exSaxhBJQNBP+9hmWSyn357pDDRE7M8MYg2MU0VxcwbEULb9RXJxkS0YLHXnlCLJVtcu6c+MS9XIHyFSWrr3onO11uGf+jjzeCd4BAI1yPhbcYPyL/7NS6+c+WoWKZoAUHfAy+oUFk0YwYVk3LBxub7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533012; c=relaxed/simple;
	bh=eOhe2SntyotvFWQU7rQZmIkFwdvqLc7KN7GtV/xCVO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTqIRYYfX63g0Wkyy8mK4Tju17At+8uqxEhFwlpW6LCK2RRNjsq82vvsrJJ65SJsktBi+Qaq4Xd8Rbhzb2s7hUQi5IX7VloOYXEw8+zAgY7HOMoLubCb6xJIa3daZpNqyXv5RGU0toFFY/W6rgaKzUECsCiO2b8NKcD0Rq5U6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B2F343190;
	Thu,  3 Jul 2025 08:56:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 12/19] peripheral: Fix typo
Date: Thu,  3 Jul 2025 10:53:20 +0200
Message-ID: <20250703085630.935452-13-hadess@hadess.net>
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
 peripheral/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index ff1354cb48d5..2c5e037b9f70 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -105,7 +105,7 @@ static struct gatt_conn *gatt_conn_new(int fd)
 
 	conn->att = bt_att_new(fd, false);
 	if (!conn->att) {
-		fprintf(stderr, "Failed to initialze ATT transport layer\n");
+		fprintf(stderr, "Failed to initialize ATT transport layer\n");
 		free(conn);
 		return NULL;
 	}
-- 
2.50.0

