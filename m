Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152F1ACEDA;
	Thu,  3 Jul 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552764; cv=none; b=OqF2DOInTrPwztAcnsVpTud9y9iaiIjK8SOAR5DEFD73lEG7gcfYPj+mcpYAGRpN6dfq1jkDGgHJBrxMKmyg9FfZfh22ePCFp96DcabLirdPN21ou1LlqIMM6OKdf+C0Erk9rzKct89PetLaZIC0gbausbfXPCw2nRCCzBxhvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552764; c=relaxed/simple;
	bh=gK6Rezoy5G7rIm2NebFso/wo9lCfGocYaSadtr6VE6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QmYKNgbsrykmOVlVWwLPnMmwgiIXzzk4gq+q8GRQE93zavnDwaS9BCPx6oXrFo9PSVnu1S+r/Fp2L82SAaKFdUpx3q/W6Lgs2pTjrVot1RozJBx8DJR1vn8tiSBVsY7wL01i4nBlmyLTlQsBoI+NxT59sBr5MbqY1wZxt6rguto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3495F449B8;
	Thu,  3 Jul 2025 14:25:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: trivial@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bastien Nocera <hadess@hadess.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <kees@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev
Subject: [PATCH 0/7] Bluetooth: Fix typos
Date: Thu,  3 Jul 2025 16:24:28 +0200
Message-ID: <20250703142542.985248-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehtrhhivhhirghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtohepmhgrthhthhhir
 ghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght

Found using codespell.

Probably best taken in through the Bluetooth tree.

Cheers

Bastien Nocera (7):
  Bluetooth: btintel: Fix typo
  Bluetooth: btmtk: Fix typo
  Bluetooth: btrtl: Fix typo
  Bluetooth: hci_bcm4377: Fix typo
  Bluetooth: aosp: Fix typo
  Bluetooth: RFCOMM: Fix typos
  Bluetooth: Fix typos

 drivers/bluetooth/btintel.c     | 2 +-
 drivers/bluetooth/btmtkuart.c   | 2 +-
 drivers/bluetooth/btrtl.c       | 2 +-
 drivers/bluetooth/hci_bcm4377.c | 2 +-
 net/bluetooth/aosp.c            | 2 +-
 net/bluetooth/hci_conn.c        | 2 +-
 net/bluetooth/hci_event.c       | 4 ++--
 net/bluetooth/hci_sync.c        | 2 +-
 net/bluetooth/lib.c             | 2 +-
 net/bluetooth/rfcomm/core.c     | 3 ++-
 net/bluetooth/rfcomm/tty.c      | 2 +-
 net/bluetooth/smp.c             | 2 +-
 12 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.50.0

