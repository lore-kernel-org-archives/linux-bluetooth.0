Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8623D9DCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227753; cv=none; b=cCXkODT/XxniO5/+sJL9o8EUjzuyQa6vECkQ/fdtP0shabx5hTJ9GNUwvlsOQtqCywBaYIstEzt4HokeoAzOaNo9gD/Gyxg/P16jsdQOlEItKy8Lt/tjKx+O4SA0KDvt426LFJ+3avD414c+bP5o/3RjxLYRoXhLkbtDaBwAflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227753; c=relaxed/simple;
	bh=C51c2FMaeT0t4Ry/dGlekGZo7JyOeDt+HVYz333zwJU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WMA79BKnCv/2QoVSlwEQlkWfIzEiC7PJYAN3p0sCvAQqVoS4fnz4zU+BW5a5cY1LPWnFJiE06cWxbbqMK9Yy6hPoOevVtNoMZ1wYgTfeVl/m/ejpwnjS0RcxHRCs4GNiqQ5+aUjO1Vp90qZNhZB4hT3b0xhqP45JtAMXoxWWp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7772441CCC
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 11:15:49 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/1] tools/btmgmt: Fix btmgmt --help hanging
Date: Wed, 11 Mar 2026 12:14:12 +0100
Message-ID: <20260311111540.2170373-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffudfgkeffjeekieeivddtfeevvdelffejudfhhfehueehueefkeefueethfevfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepjeejjedvgeegudevveevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean

Another one of those. Wrote a test case again to avoid regressions :)

https://github.com/hadess/bluez/commit/81dcf1794b510a41c7b9b6ec53376cb5322b0bd2

Bastien Nocera (1):
  tools/btmgmt: Fix btmgmt --help hanging

 tools/btmgmt.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.53.0

