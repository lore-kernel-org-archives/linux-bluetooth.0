Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A931F943B
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708213; cv=none; b=TYqlI9ZtP1Av/RwV4gmh9BFJrlNQ1vloaEaDsaloj7f4KhC+nzCgI69jded9PcNCe0SqDkZc6XKw+HjoABGn2xJNePv4ls2XbLVr825e5LSJf3s1Mb/ggRWNvipK+qTOYQd3b5vtPCdtHbuNIRH5atEinzt4fx0vK9FEvsRpI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708213; c=relaxed/simple;
	bh=TZQVNoevke7eCJcdgDHdlXODz789NNLjkRx2Ta+GExo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/s8pQN98boaLgrOcllUbwjQqOAyhnj4ZpxOENiPNeT0YbGy2/KdIfOba3LqVjwtLpeSY/SpQ1CKAD15tSmpxjm//FCXyAnN0ZvqCJXz1GO4GiMpYy0jYhiM+i7bGl4oYKpONOivx17LZvQyTgT2E0OOOaeD8dw1XbhhAWnMwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85CF6E0009;
	Wed, 27 Nov 2024 11:50:08 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 2/2] plugin: Quiet start-up warnings
Date: Wed, 27 Nov 2024 12:49:53 +0100
Message-ID: <20241127115007.1303616-2-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127115007.1303616-1-hadess@hadess.net>
References: <20241127115007.1303616-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

It's not an error for a plug-in not to start if the hardware doesn't
support it. Quiet the warnings that require specific hardware.
The messages will still appear in the debug output.

bluetoothd[896]: src/plugin.c:plugin_init() System does not support csip plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support micp plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support vcp plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support mcp plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support bass plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support bap plugin
---
 src/plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/plugin.c b/src/plugin.c
index e6d05be4ce08..00d3d7b6a0b5 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -50,7 +50,7 @@ static int init_plugin(const struct bluetooth_plugin_desc *desc)
 	err = desc->init();
 	if (err < 0) {
 		if (err == -ENOSYS || err == -ENOTSUP)
-			warn("System does not support %s plugin",
+			DBG("System does not support %s plugin",
 						desc->name);
 		else
 			error("Failed to init %s plugin",
-- 
2.47.0

