Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35F233704
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568302; cv=none; b=GF3zwF58NGHXQz3CXO8HD5iZ4cM8R9N2vRuOUd2eVF99t48nGndKNr3DmvNKcfCoAL6afzRrktkfyKx/Kt6unBuFD+fyuY9nNzvdZgDVKUQDcWOoDGAJJ37hnF+t9iM68zUMPIdsvWs/JWOgTZztLjfmLnSjciFfoaW8sJoQ9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568302; c=relaxed/simple;
	bh=fBrDQNFvfipGEDXoM7CFKP0uD9EAqI9XJM0qZ0Mu8fY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ehTTc7A3TCFGucg4BlDtgccT7eYS9s0LlmnR2gIYKnRHesaFBzTnmvyAATEmttd+CWTCRY5YyjKXmRfyuIW/qIpT/4ikj18uwqw/TreciFEmyI4lzgh3xIdpZIb8+8HwlinehgCVwtbrOfdRE9DEg/q8mvPgRLZY+T7yuv/veHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03CAA442B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:11 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] More CONFIG_PM* simplifications
Date: Fri, 16 Jan 2026 13:50:41 +0100
Message-ID: <20260116125803.598552-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupedtfeevteetgeegvdeuiedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Follow-up from the earlier "Bluetooth: btusb: Use pm_ptr instead of
#ifdef CONFIG_PM" patch.

All 3 drivers were successfully compiled with CONFIG_PM disabled.

Bastien Nocera (3):
  Bluetooth: btmtksdio: Simplify dev_pm_ops usage
  Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
  Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's

 drivers/bluetooth/btmtksdio.c | 12 +++---------
 drivers/bluetooth/btnxpuart.c |  2 --
 drivers/bluetooth/hci_intel.c |  6 ------
 3 files changed, 3 insertions(+), 17 deletions(-)

-- 
2.52.0

