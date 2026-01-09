Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB33590CA
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951385; cv=none; b=O+J3j+eNSjNys5nrP/rSLdz0OhKf7urPddCwz1hC4jkTcrc94HHHqorYNGri20NizZT/JlQjzLeJl9IWkVy4lO8Ga60UbxkdChPRUa85iNbh/emlsBcnNSuWDO4hbVu7GlNax9T4iWxOe6W6oIps5Q7h7xzKpgKBJABBwvI8bJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951385; c=relaxed/simple;
	bh=CPwAkvT6YO//5xwK7yJ/fvVe4+ZgQqK3Oo2fYYKKwi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxXjxeR4q+VJ8FQ6CqZzsa168nJ5w7NBeVmdUFQDMifgPfI10QD1n2ZQdAL3d1jzsTh1Kzk4MLGD0A+mLW1Z61VUA+lbzr2Vf08P9CsYpyMr289TEKivXLoMl67B965uButRFjk+o4w9FrqEA4WwOC3PrV6H+K5ZJ63ngZg1zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D36B342E7F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:36:11 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v1 3/3] unit: Speed up unit-ringbuf test
Date: Fri,  9 Jan 2026 10:29:02 +0100
Message-ID: <20260109093602.1224918-4-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109093602.1224918-1-hadess@hadess.net>
References: <20260109093602.1224918-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupefffeeiueefgedvgfejhfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Speed up /gobex/test_packet_put_req_suspend_resume by not printing
debug for each of the million of iterations of our test.

If we carry on printing this, then either the terminal's output speed,
or the debug capture from the test suite will throttle the test.

This reduces the runtime from 3.3 secs to 0.007 secs.
---
 unit/test-ringbuf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/unit/test-ringbuf.c b/unit/test-ringbuf.c
index b1cf51115a41..0e348a49b8c9 100644
--- a/unit/test-ringbuf.c
+++ b/unit/test-ringbuf.c
@@ -57,9 +57,6 @@ static void test_power2(const void *data)
 		while (size3 < i && size3 < SIZE_MAX)
 			size3 <<= 1;
 
-		tester_debug("%zu -> size1=%zu size2=%zu size3=%zu\n",
-						i, size1, size2, size3);
-
 		g_assert(size1 == size2);
 		g_assert(size2 == size3);
 		g_assert(size3 == size1);
-- 
2.52.0

