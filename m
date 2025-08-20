Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A72609EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700508; cv=none; b=kZNw2umfsxkwjuqA5FukB9GrLd71yOSJAwKyYaHi057MAX6q5Ghc/rE+ZB8jG1/yFtUcClsz6g+KaJe07LxHgoPNBWP8X3W1b6kkdxc0TYhJJglxcuXCuXQR0tyk0XmU59tL5u9vl8IItJ4vX4w2K37mJ8gUQD9UKY8WCxQ5nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700508; c=relaxed/simple;
	bh=0bdAVfwnCm8XcVWrJwf7bEyiYAWlapMjbJ1lwzV9NH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpEanYaR/mvU+Rlr0TwxOj8uX2gJ1A/WalR/ZG2/rVPhQmS0ZJQqSAWUbpNJmUCJi8/oEbvWGKEm3Ze/ja6DPwYUe6TAO215hFQ5yMcmprwahaDH/F4K9Ap8ovViypkfCVVIjO5U/Ux2AvzCxbnFV9TkvA0GqrdUrYUI6hwiiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 449B6584B8D
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:16:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B02844418
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:15:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] tools/tester: Fix fd leaks
Date: Wed, 20 Aug 2025 16:15:45 +0200
Message-ID: <20250820141552.800720-2-hadess@hadess.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820141552.800720-1-hadess@hadess.net>
References: <20250820141552.800720-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: spam:medium
X-GND-Score: 300
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecundevohgrshhtrghlucdlfedttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedtvdetffevtdfhudffgeeltdefhfevvdduffetjeejhfelgfejjeekhffffeduvdenucffohhmrghinhephhgrnhgulhgvrdhtohholhhsnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtrdhrvgguhhgrthdrtghomhdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

tools/tester.h:314:3: leaked_handle: Handle variable "sk" going out of scope leaks the handle.
tools/l2cap-tester.c:1957:4: leaked_handle: Handle variable "sk" going out of scope leaks the handle.
---
 tools/l2cap-tester.c | 1 +
 tools/tester.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index c473c6cc6480..208772527c47 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1954,6 +1954,7 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 			tester_print("Can't enable deferred setup: %s (%d)",
 						strerror(errno), errno);
 			tester_test_failed();
+			close(sk);
 			return -1;
 		}
 	}
diff --git a/tools/tester.h b/tools/tester.h
index 8964751102d0..9df600f900ad 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -334,6 +334,7 @@ static inline void test_ethtool_get_ts_info(unsigned int index, int proto,
 	if (ioctl(sk, SIOCETHTOOL, &ifr) == -1) {
 		tester_warn("SIOCETHTOOL failed");
 		tester_test_failed();
+		close(sk);
 		return;
 	}
 	close(sk);
-- 
2.50.1

