Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE3327C00
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831971; cv=none; b=uGW0MoK+ccbgKoVLogzEBRdRcoJDqlj6brTc+MX1gXCJle5gAqU6wIqGrso9FEv1FRFYj2bf6Nip4pkpthZ+mozqlgKesWqnpqmu2RjQfnCjjVq7AJ5OPYjdXgrdiwcJKoKSPMnObvJo6ONmBzxxlvD0R8d8/AXxQn9Pd87kuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831971; c=relaxed/simple;
	bh=2LuFW+C9vAxXVH/7LrLPthCBuhL80N1+8/6LIs7rQGY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dc1YFuOHBv91Si6c0T6KN0BbkmKiG3vhjaJVY14UJBTNU/fQ5O4mcVUnwyJKaBas8/wWuHCi/GmMaGSB+nsEPbjJz6A8WMsW+rJ4nqNdK5bcL0xCI2LPyYe5C61+/Dmkyhm9OTpTTKLbeP9wR4he5OHpwVBBuE1rgkEzL56S/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB13643285
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:47 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 0/4] API fixes to make better bindings
Date: Mon, 19 Jan 2026 14:27:08 +0100
Message-ID: <20260119141239.2683954-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupefguedufeeigeefvdekhedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Those changes will make using the internal bluez API easier to access
from Rust.

Bastien Nocera (4):
  src: Turn available priority macros into an enum
  src: Prefix plugin-accessible adapter_set_name() function
  adapter: Fix const'ness of struct btd_adapter_driver
  src: Prefix plugin-accessible adapter_foreach() function

 plugins/hostname.c  | 12 ++++++------
 src/adapter.c       | 16 ++++++++--------
 src/adapter.h       |  9 +++++----
 src/agent.c         |  4 ++--
 src/gatt-database.c |  2 +-
 src/plugin.h        |  9 ++++++---
 src/profile.c       |  4 ++--
 7 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.52.0

