Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B42620E5
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575483; cv=none; b=nPNer/jdQO+S592WRAYk0/0TqW0/oEn0D5I/4fG5VLpU0OQSiwHRXoQ7uSYTctY0APhLPvJmLSNg6NJey60EovY5qYj6zFBM6OlSvf5aIrKVpYGarsB1/wvSo4k8lW1p+7QcL4n7SddPgCa7KMmQdwgon6IBKLgNTBgcWM/fqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575483; c=relaxed/simple;
	bh=4+GUXERG9f81qlKj7AZfcSv0XyMMoKl4K6+vqsKkldE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbSzL6lclu5vRLEkuuXbf5+OJIo8X8FDfwbPqBuM+RiCWWhsHVJbpz9atMxx9S9ebgba3+kuZXoxS5M3Dg1m39T0rtb4gTex4/k4xr/TY5EzAiivbj1jIlIbG2HsCoKhl0uWGnFffUXw22fNuNshF+Zh3xvnosNXfDIDyWlyq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13AE741D11
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 14:04:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] client: Fix missing strdup/memset declarations
Date: Thu,  7 Aug 2025 16:03:02 +0200
Message-ID: <20250807140424.937218-3-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250807140424.937218-1-hadess@hadess.net>
References: <20250807140424.937218-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepteegheeghfehhfdvkedutdfhffejjefgvdevgfekkeevleetheekhfetleelueefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

bluez/client/display.c: In function ‘rl_prompt_input’:
bluez/client/display.c:112:24: error: implicit declaration of function ‘strdup’ [-Wimplicit-function-declaration]
  112 |         saved_prompt = strdup(rl_prompt);
      |                        ^~~~~~
bluez/client/display.c:112:24: warning: incompatible implicit declaration of built-in function ‘strdup’ [-Wbuiltin-declaration-mismatch]
bluez/client/display.c:119:9: error: implicit declaration of function ‘memset’ [-Wimplicit-function-declaration]
  119 |         memset(prompt, 0, sizeof(prompt));
      |         ^~~~~~
bluez/client/display.c:24:1: note: include ‘<string.h>’ or provide a declaration of ‘memset’
   23 | #include "display.h"
  +++ |+#include <string.h>
   24 |
bluez/client/display.c:119:9: warning: incompatible implicit declaration of built-in function ‘memset’ [-Wbuiltin-declaration-mismatch]
  119 |         memset(prompt, 0, sizeof(prompt));
      |         ^~~~~~
bluez/client/display.c:119:9: note: include ‘<string.h>’ or provide a declaration of ‘memset’
---
 client/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/display.c b/client/display.c
index a590a1388d26..95b734c91594 100644
--- a/client/display.c
+++ b/client/display.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdbool.h>
+#include <string.h>
 #include <ctype.h>
 #include <readline/readline.h>
 
-- 
2.50.0

