Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689F25C70D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581890; cv=none; b=nGhIX4YNj45aIE016tk+qgCpWZV6IPtQx+tC4DvbU0GWL25RZWLQvgOBhOLoKcW8GER6wJOJx6zuqYoJVn8v6ZEYTSd06TuPJ5RFOsF1ezetDlqHhHensfhLb5vHBA73MEW2T6SFLlnXQCMgx0RjYPZjUAWWndI3zq4lX3PJl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581890; c=relaxed/simple;
	bh=4+GUXERG9f81qlKj7AZfcSv0XyMMoKl4K6+vqsKkldE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw2Gp/DX0thwuZtMZiS4mKr82aQV3+j4SCVcXQL0YLDPrZB1GHQdJRU9HB3cNiFfFYrO8hyx9uSiE11t4K7y3JYVqo/rCT37cHsxa5Jvc7L+z20T+Df5PUZvjZS6jlR2UyKPqxaCTEAVcx+j+YvAcdqYkeQ5K6Ni9J9/zVAYtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 321C01FD47
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:51:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] client: Fix missing strdup/memset declarations
Date: Thu,  7 Aug 2025 17:50:30 +0200
Message-ID: <20250807155115.1037982-3-hadess@hadess.net>
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

