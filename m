Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411F3815C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918518; cv=none; b=lSRtuQwwK3mKUy9auuYRNnO1t41OJl2fB7GdqzzpRp8zMy8njXwAAahWq/X5SfHI//GLB0z4giG7B2L5IUDFzTvtiDgQcyZZuO/liUYKv6trnpygoxlEcob7Z9Odq9jE3GFyjVoR8MO1XL7fDV/oY49ZlrVAisobKQq2rM6xN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918518; c=relaxed/simple;
	bh=Wkyb8/tg6FQRySseZC8eQB8w7p+JlM3YH9VJrI/1544=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFH4seLyBxm22meD1Y5qgsIbm+cg7hq2OlzTqU/4cUm55UhA3XwD1O1rTbbEd2WxlHP5z/zqtuXZIgOT6j69XfDfhWa1Powf/DVdpNciuJlIOR+sMggA3vOi/ZgMBuXTfI5KR1vIDdx3jpjbMnfXcbOidW1NQ7ePm65Ak19uMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5C2025802FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:55:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CADE53E982;
	Thu, 19 Mar 2026 10:55:05 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 0/1] adapter: Fix "Failed to set default system config" startup warning
Date: Thu, 19 Mar 2026 11:52:05 +0100
Message-ID: <20260319105457.1381098-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeikedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepgffgtdekffelheekleelvedugeeijeejtefghfettdefiedttdfhueduudekjedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihhnthgvghhrrghtihhonhdqthgvshhtrdhphienucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeevteffgfehfefgleekvddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsshhorhgvnhhsvghnsehrohhkuhdrtghomh
X-GND-State: clean
X-GND-Score: 0

I wonder if the original report swapped one warning for another, or if
the problem didn't happen for the majority of folks due to command
processing in hardware specific drivers/firmware.

Regression test added to the meson tree:
https://github.com/hadess/bluez/blob/wip/hadess/add-meson-ell-wrap/unit/integration-test.py#L215

Bastien Nocera (1):
  adapter: Fix "Failed to set default system config" startup warning

 src/adapter.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.53.0

