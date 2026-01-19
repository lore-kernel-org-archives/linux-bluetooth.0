Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59535B148
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826156; cv=none; b=TO++wcTmaTHAhUSvZ9hF9HXZ7KEurOPBfRH1YAVSqbzilwthT8xp26ZI+uijHHy4ly1keYJm/7cfbDbj5QYzoWdCi0ouRulblfDD/V+bHfvDSGfcMic58IcLAnWbfANivm5LgO0ke/hUv8m5slrKkmAmyFSmMZlsA98rWicqmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826156; c=relaxed/simple;
	bh=eV6VMsTN4L8jFQKbM19Rs28sHS0f0Aq8F0TNeWDLEhs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HOKfPJtYgR5LCu2/mEoy0hztv3ZuZAJXTcvPCHQGqF8TDHU8LT8UcyJlbfKhFJuA20WXVe9QGhwsgaIC037gddihljY3DtmiSBq55H/temDQY0CpDJnLe8TIODACqQTQn/n6qTLpL/x2c8CFuWcbEFgE7CUhNzaDa8GAP7V7Sb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAA2A442AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:35:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] More CONFIG_PM* simplifications
Date: Mon, 19 Jan 2026 13:34:58 +0100
Message-ID: <20260119123537.2611794-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeetteetvdetgeegvdettedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Follow-up from the earlier "Bluetooth: btusb: Use pm_ptr instead of
#ifdef CONFIG_PM" patch.

Both drivers were successfully compiled with CONFIG_PM disabled.

Changes since v2:
- Drop btmtksdio.c changes, there's a fix in bluetooth-next

Changes since v1:
- Fix "defined but not used" warnings reported by the kernel test robot
- Modify commit messages following review comments

Bastien Nocera (2):
  Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
  Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's

 drivers/bluetooth/btnxpuart.c |  6 ++----
 drivers/bluetooth/hci_intel.c | 10 ++--------
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.52.0

