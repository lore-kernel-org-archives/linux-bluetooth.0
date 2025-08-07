Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EB262FE4
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581889; cv=none; b=tDCNv7H+pYnEyh4j18vPZgDSXBmuBpRgbIpKjd727cvck4e1Kc+//acr5WYDrfoxq6pZQBzwCr5wTbhmN2D/lMR6tqDvNd3dDOidWi4XwJKF64IniZUV6cUk2F68UJJlLPeele/TB+cSYT5lYdcrp1XtFXoNS8UnZS6ey6/S7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581889; c=relaxed/simple;
	bh=EuxBbAcmIgx4BtOGv4HRIjVimBZRa64puCPkBJmjqB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L97Fm2G/waRKA1tZZUqCh+V59Seqgt8x9aqk3BuIfzKpxN9BMVEwca4LXh9/L+P3zthRsQfj3UjUKfHMalrtU61uovVR3qgf3Jgz0yutbpQvvsi2Takov//3jbzLF6njMzL2rQiYczvaNoo3tj8fLoT+oyQyw4bdojhMbWJjKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60F241FD55
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:51:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] =?UTF-8?q?mesh:=20Fix=20'buf=E2=80=99=20may?= =?UTF-8?q?=20be=20used=20uninitialized=20warning?=
Date: Thu,  7 Aug 2025 17:50:31 +0200
Message-ID: <20250807155115.1037982-4-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250807155115.1037982-1-hadess@hadess.net>
References: <20250807155115.1037982-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepteegheeghfehhfdvkedutdfhffejjefgvdevgfekkeevleetheekhfetleelueefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

../dist-unpack/bluez-5.83/tools/mesh/agent.c: In function ‘response_decimal’:
../dist-unpack/bluez-5.83/tools/mesh/agent.c:94:9: warning: ‘buf’ may be used uninitialized [-Wmaybe-uninitialized]
   94 |         bt_put_be32(atoi(input), buf);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../dist-unpack/bluez-5.83/tools/mesh/agent.c:20:
../dist-unpack/bluez-5.83/lib/bluetooth/bluetooth.h:342:20: note: by argument 2 of type ‘const void *’ to ‘bt_put_be32’ declared here
  342 | static inline void bt_put_be32(uint32_t val, const void *ptr)
      |                    ^~~~~~~~~~~
../dist-unpack/bluez-5.83/tools/mesh/agent.c:88:17: note: ‘buf’ declared here
   88 |         uint8_t buf[DECIMAL_OOB_LEN];
      |                 ^~~
---
 tools/mesh/agent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mesh/agent.c b/tools/mesh/agent.c
index 7a62f345dac7..4a2c6a0d88dd 100644
--- a/tools/mesh/agent.c
+++ b/tools/mesh/agent.c
@@ -85,7 +85,7 @@ static void response_hexadecimal(const char *input, void *user_data)
 
 static void response_decimal(const char *input, void *user_data)
 {
-	uint8_t buf[DECIMAL_OOB_LEN];
+	uint8_t buf[DECIMAL_OOB_LEN] = {0};
 	uint16_t len = DECIMAL_OOB_LEN;
 
 	if (strlen(input) > pending_request.len)
-- 
2.50.0

