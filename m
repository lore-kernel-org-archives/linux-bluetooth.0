Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73C33DEF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818570; cv=none; b=SszEsmkKNYHdCi0XjRier+18sXoqMx83j6e5L1IrXERnndFAR7fAYe5j+JGxL9w/mvqN14EUqkHjatLbYW6GD+aHNLBSppeegJbTTeSlqL2pfiAVit33zCVV3hZG7pGy0JzpDcIEvtwqT58IAnNm2hJDXFtziOxZ6/MQ8so1waU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818570; c=relaxed/simple;
	bh=cJDpQlDqfGYY19l9W8qZxpjDDe8n17gW9QYefk8wMyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WjzNBJICcrYtCIzAZmmR+WR9kDhXywv4e3X/At2eUIH7JygVdIeLFsnWZx4ouKTE9xWONH29kZjbKVxRl7b6KeHC0w+ypKPZ2glLy/npQsVLkL8Y7OPmCd3CKmM6ZxX1nbqYbcF4JggKlxJDu3O9qtlTAh5cD0ntYH3Tsf7eT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 338BD4334F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:29:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] More CONFIG_PM* simplifications
Date: Mon, 19 Jan 2026 11:27:39 +0100
Message-ID: <20260119102911.2465464-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeffeekueffgeeffeeghfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Follow-up from the earlier "Bluetooth: btusb: Use pm_ptr instead of
#ifdef CONFIG_PM" patch.

All 3 drivers were successfully compiled with CONFIG_PM disabled.

Changes since v1:
- Fix "defined but not used" warnings reported by the kernel test robot
- Modify commit messages following review comments

Bastien Nocera (3):
  Bluetooth: btmtksdio: Simplify dev_pm_ops usage
  Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
  Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's

 drivers/bluetooth/btmtksdio.c | 16 +++++-----------
 drivers/bluetooth/btnxpuart.c |  6 ++----
 drivers/bluetooth/hci_intel.c | 10 ++--------
 3 files changed, 9 insertions(+), 23 deletions(-)

-- 
2.52.0

