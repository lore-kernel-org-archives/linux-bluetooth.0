Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDD1E8320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771382804; cv=none; b=detNDqkonDS1RlpB5/R/+HkLA7mgtQGG+gi1tTY6a/01DOFLVK80atwO/AofF3Euw/YUoILYkwWp2E356/fICsnoHhZsnG/Crma3weQbXtAx/b4nT/PPKYLkAMNfH2b8oviryTkuJJsAPKsQx90uW5/35KsgzwCndsbTavKTVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771382804; c=relaxed/simple;
	bh=pich2DwztV+i7u1zdWjOVKPMP5i62Zu45sWQdGGJnyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbkTITTqscaRaClg7IZBHH5e/pPPGAJBVys1spsqJMVV2CuI1AkJrx8TGe0by71TwfBDs4p4tmHLVLAqVyqmxpfq0s109MF9Qzim3TzAXp0MLxvoxmXrIrcA0F1e97hWKkQvtsVLHRSx0KsQF8owDI8EhNqgIrNCEKVhzNySTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=uzFBUi9Q; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="uzFBUi9Q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1771382801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1JZpWSWUxSVAiPEo/ysSZ1OfIrlU7FMNpUGrHPvHbY=;
	b=uzFBUi9QLCjMLQmNXwZnPr3MGtWGhIjpLUm7yOtozbuq44hETx3GxaLQsSto31pEP8po8H
	AS+xxXQfQC9uohjq+Mj+KtQYbU1BzkfG1+Qd9ptMwMxWPNZiTdEakKRfwzW4l27gwIEUu1
	8irVy6QB/nDcIARk9uDHzyBPcxc0Ijk=
From: Ronan Pigott <ronan@rjp.ie>
To: linux-bluetooth@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH BlueZ 2/2] shared/shell: gracefully recover from failed input initialization
Date: Tue, 17 Feb 2026 19:33:00 -0700
Message-ID: <20260218024605.70890-3-ronan@rjp.ie>
In-Reply-To: <20260218024605.70890-1-ronan@rjp.ie>
References: <20260218024605.70890-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If input initialization fails, back out before waiting on events that
will not come. In turn, we can go back to initializing inputs for
non-interactive invocations, which fixes printing for non-interactive
commands and the zsh completions that rely on it.

This effectively reverts commit e73bf582dae60356641a32fc27ae03d359ec4c47.
---
 src/shared/shell.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 873a14176af9..b9fcc665fcae 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1640,15 +1640,22 @@ static bool shell_quit(void *data)
 
 bool bt_shell_attach(int fd)
 {
+	struct input *input;
+
+	input = input_new(fd);
+	if (!input)
+		return false;
+
 	if (data.mode == MODE_INTERACTIVE) {
-		struct input *input;
-
-		input = input_new(fd);
-		if (!input)
+		if (!io_set_read_handler(input->io, input_read, input, NULL)) {
+			input_destroy(input->io);
 			return false;
+		}
 
-		io_set_read_handler(input->io, input_read, input, NULL);
-		io_set_disconnect_handler(input->io, input_hup, input, NULL);
+		if (!io_set_disconnect_handler(input->io, input_hup, input, NULL)) {
+			input_destroy(input->io);
+			return false;
+		}
 
 		if (data.init_fd >= 0) {
 			int fd = data.init_fd;
-- 
2.53.0

