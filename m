Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061D142912
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850233; cv=none; b=llrqvyt0gyDAGsY9E1x/nT7bQOLPXq8/qW4xgMnNVhtLWTgrLomcW0i7KukS8zyuLmb93EUD8JQaYpgbMCZWoMIPCaSD3ACf4e0qJpIKmcjEtHT0zyaTPh0CSGlac5OmN1lgEwHPTPRgbjqz97DG2eiPx+oZ1n/0MVedDKYc9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850233; c=relaxed/simple;
	bh=d1o3XOd5RyFGZH2VnJi5Sb7N85gZFU73tOOQkeoxsig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PObvqe3yBwEf7GwfmTXPnoNAIUWkaEQoMYKFFLYEPzql7UU+tp+AyiW+jIMcOnJhY8u5tohLiHy3ua7e4g/bBGfFdCLogjiWH7ZqfSJ+puZbwvMCmr3hx2DuzYpdT4Rst2ht8dpzgR54vdWv+1L1OBtP9ZlFcmt9vpJXdrZFSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F13FA1C0012;
	Thu, 16 May 2024 09:03:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 10/15] test-runner: Fix fd leak on failure
Date: Thu, 16 May 2024 11:03:14 +0200
Message-ID: <20240516090340.61417-11-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def65] [important]
bluez-5.75/tools/test-runner.c:877:3: open_fn: Returning handle opened by "attach_proto".
bluez-5.75/tools/test-runner.c:877:3: var_assign: Assigning: "serial_fd" = handle returned from "attach_proto(node, 0U, basic_flags, extra_flags)".
bluez-5.75/tools/test-runner.c:955:3: leaked_handle: Handle variable "serial_fd" going out of scope leaks the handle.
953|	if (pid < 0) {
954|		perror("Failed to fork new process");
955|->		return;
956|	}
957|
---
 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 908327255ad7..de0f2260480c 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -952,6 +952,8 @@ start_next:
 	pid = fork();
 	if (pid < 0) {
 		perror("Failed to fork new process");
+		if (serial_fd >= 0)
+			close(serial_fd);
 		return;
 	}
 
-- 
2.44.0

