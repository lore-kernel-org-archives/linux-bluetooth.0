Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B27629BDA7
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942340; cv=none; b=I1mYjP3FP3mx4SpMGvpajPa5r70u7iBuKoEgTXWQYtshe6Q58xVbhC9nK0MGUCO1wyikDm30rwvSGSFI4pCfvJq8dJ3H6HnqISVrdY/V1GNv7N8aQdgD8jfEF7U6ElTK5awHkvd+jyXY2gWcqfqjnzz9AmgC6MducXrFEXRNtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942340; c=relaxed/simple;
	bh=26NX/SnFSkjC60zCbqhJSdW2CrhnJQOXI7GXSSM/aqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfzM7hsStElBQVVfFzVtnTyiYIzXtyPpiHfDBJ2u4QY7InKgQ844VElSF6jp0DSTs4m7E+5CKgRQfLm8nsx+0vOQSgpAPXm1aUYjtiDgMLLlC5/TqIP7+4RCuWUfIVM8Gr3ZVvepQJOjEGk35Dk+pdz0jzELCMp8eN4+FNOcI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F2A21F687
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] build: Add ell subproject
Date: Mon, 11 Aug 2025 21:53:42 +0200
Message-ID: <20250811195850.1775759-2-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250811195850.1775759-1-hadess@hadess.net>
References: <20250811195850.1775759-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefhtedtgfehvdeufefhfeevkeefuddvtdevjeejjefftdegffeludevjeelueetkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Add the ell library as a subproject. Rather than doing like autotools
and relying on users checking out ell in a particular location, or
install ell as a system shared library, use meson subprojects to build
our own internal copy of ell if the user hasn't installed it
system-wide.

Note that this currently points to a fork of ell with meson support
added, this should be switched to the upstream repo when that support is
merged. See:
https://lore.kernel.org/ell/20250807134859.930870-1-hadess@hadess.net/T/
---
 .gitignore      | 1 -
 .gitmodules     | 3 +++
 subprojects/ell | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 .gitmodules
 create mode 160000 subprojects/ell

diff --git a/.gitignore b/.gitignore
index d23a06af4b53..3da0ac680152 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,7 +35,6 @@ test-driver
 test-suite.log
 coverage.info
 coverage
-ell
 
 lib/bluez.pc
 src/builtin.h
diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 000000000000..53881e4d8e3f
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,3 @@
+[submodule "subprojects/ell"]
+	path = subprojects/ell
+	url = https://github.com/hadess/ell.git
diff --git a/subprojects/ell b/subprojects/ell
new file mode 160000
index 000000000000..08bc5f26f210
--- /dev/null
+++ b/subprojects/ell
@@ -0,0 +1 @@
+Subproject commit 08bc5f26f2108a778a25222fdc60b931310ad68d
-- 
2.50.0

