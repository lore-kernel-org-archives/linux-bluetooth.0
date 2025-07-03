Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFAD8836;
	Thu,  3 Jul 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563111; cv=none; b=s3G9yPpOj9ccoFJ7eTd/YmixinF3VkRpse35orhrGAL8hnVFheeFXmEoTHYTwCx7aymsPe7I/nk4lb6Db+nqYoQuXHtx/08vlySBr9KTMbu6xw+wKTU6SYNnf3yfPsPSy5choLT8tLyliWy3lwAJuJfLm4JLogKdCdKXgns9VZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563111; c=relaxed/simple;
	bh=BE+WJb90yGrtRx+9Kh+Fn3cdFMRStjbkXXcyLxhcqXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=INaHjpkAR0a/enTUpcJX6c5dqvRfoudF/r5orIdRnwBc/aViNAlahM7zFjzbWxil+nzIKcbXGHspjZKkhAP5lrZPpPIM1Hgx8gvEhpEZrRIRL92kLihu9KNw4Tpy5gA3OBEvYGsvWQUJ1HY/YCsyDD0KXU2xU1XcfsQwaZQQ3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 590FC41C7D;
	Thu,  3 Jul 2025 17:18:24 +0000 (UTC)
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
Subject: [PATCH v2 0/7] Bluetooth: Fix typos
Date: Thu,  3 Jul 2025 19:16:54 +0200
Message-ID: <20250703171815.1011001-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehtrhhivhhirghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtohepmhgrthhthhhir
 ghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-GND-Sasl: hadess@hadess.net

Found using codespell.

Probably best taken in through the Bluetooth tree.

Changes since v1:
- Added whether typos were in comments or log strings
- Fix typo in typo fix ("btrtl: Fix typo")

Bastien Nocera (7):
  Bluetooth: btintel: Fix typo in comment
  Bluetooth: btmtk: Fix typo in log string
  Bluetooth: btrtl: Fix typo in comment
  Bluetooth: hci_bcm4377: Fix typo in comment
  Bluetooth: aosp: Fix typo in comment
  Bluetooth: RFCOMM: Fix typos in comments
  Bluetooth: Fix typos in comments

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

