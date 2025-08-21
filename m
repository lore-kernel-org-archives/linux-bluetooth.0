Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF031A049
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781144; cv=none; b=l6zKB0clQ2cYjGMPssB+pn5OnwTmQcu9xo8xs5HaOLyLekfKH0+zje6vpqCdE1qrmWJouJHuHQEm6gpOKHu/my1Cucm97PYB8srbV4epfgActbwuTeULP1agTLCP4oUG4CZpqtOYwbF0mflHxA+21PajqjJzJOD1lu6hc4JyVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781144; c=relaxed/simple;
	bh=l6fxXRdjQraG8Wpf8pTZEQ5PwEbT5MLkYNJHE4Ot1gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqIe3BrI3MppSK2vO+3vgxMQ3a8NtdAYBJJQZiYX1OpRJ0UM+t+4uEXAFmDSaBBcgr4ffQvRTiM8EkQMMRGOHFGsnUu5s12oMFs2sXv2LU/z5ciZPX86mSwWhXfKE3xV+lLJ/4RYidcOOLtrEvmvnDtN/ldUGVipSG3O7Xo3r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84D77442FC;
	Thu, 21 Aug 2025 12:58:54 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH BlueZ 0/2] Fix DualShock 4 cable pairing
Date: Thu, 21 Aug 2025 14:57:20 +0200
Message-ID: <20250821125844.963198-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshguohhrvghgohhrsehsughorhgvrdhmvg
X-GND-Sasl: hadess@hadess.net

I wish we could have full cable pairing support, but this is better than
this whole plugin being unreachable code for DS4 controllers.

Bastien Nocera (2):
  sixaxis: Fix official DualShock 4 controllers not being handled
  sixaxis: Initiate pairing for all cable pairing devices

 plugins/sixaxis.c        | 6 +++---
 profiles/input/sixaxis.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.50.1

