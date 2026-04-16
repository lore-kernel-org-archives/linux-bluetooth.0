Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5137BE7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348635; cv=none; b=r0+O2u8wyEDqVmsKguH3uVrUIJkxSn6AlCW6rzmvh7hWYKHqzqN16gIPIAViT6bhktMnmswQjnTxf2rXjl6QkVrpraTTTJHe0hVY0qBUC+Q3eGL+BGmVHGO3PHnRCXCgpgAovHjd7w49ANSE7TxQPD0gWz6qSq+gRPQRVdxikBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348635; c=relaxed/simple;
	bh=o91MJkW1RUChyOnjgkdfhvWhgGribNwytdjvmt0aOB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgEICeQ0KQJLhBxEbByy79WDNZDibUqC9zl2Q9bAnKm7a7JnOz0OzlxzXmdKOBam2c3B99M1vL9dflVQiorS/fDLT37VZyGQnladbgeS54xxT6HBBWQJ0XQfM8ZIRHb0SvkiPPRfd9GosvEmNWXG87H3cXo8BlvFXn9kqQqao5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6627F3EC5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] shared/queue: Fix warning when compiling ad.c
Date: Thu, 16 Apr 2026 16:08:41 +0200
Message-ID: <20260416141021.3970323-3-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416141021.3970323-1-hadess@hadess.net>
References: <20260416141021.3970323-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTFlf8FcLg8mwAwyOlsxAOYUOXqQFCBXYPQyC0gepPHxDdFwUcVwGhIhLyDNV2czXtx3xiOodmDXgoPpS/QQoNTewVP8RrvcGnKXAWikM5BvRWaHOu0ZMbbWunVkuN1RgMm5ssA/limjLtsf8wVyHVTUJKu7kBZorS7CeXje8su57sW6Eq3FuCAY+M/3m4VLiXLI/xnuXtR7ICfnZ8HPUfDPzEfyRtzHSrwM3dszOukmrZ91UvBsV6gH6HMK4viZtMoHmenBhG3qg11uJSVT92Ob3Ny4uzhUep5EZYnTzuGRiLfPynsKlC4tkEB70DD72zO3Y5+XV8SUq7I5kqocnqFzpgIchiTYk6ZZLsSxhr7QD85//piuWfQwoVnMVnrCIJZypG4h5r5df1OMHl/ipaaqb/LFxpILulD1+8QKclmIWwWQRvDpMFRqSJMLVMiqgu3A7YLn54D3i2vsAgJFdwBaBX2dinU/cIKQtS3SdF2aK7TI29XGzSUsUyOrG6s0AkI7LFCDevhgCQe6Vsusmn7woRr2FXJCOVmh9BLVxko/YCvC5Wg7KnIMTxgYxtbomuLd966j0zj5h9Mu4x+JfBJp6/XwQFg7zweNb+qUiQeLX4RZ9ikbZ5PN9sKue7oc+EMAu6+Bjrn9JqDtPLdebs0XtSvFJY3mm8zTSz6+Ds7A8Q

Both ad.c and eir.h include queue.h as both use the struct declared in
this header. Quiet the warnings with a stanza that means it will be
ignored second time around.
---
 src/shared/queue.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/queue.h b/src/shared/queue.h
index 122f4eaa6c2f..f14b83ecfdac 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -8,6 +8,8 @@
  *
  */
 
+#pragma once
+
 #include <stdbool.h>
 
 typedef void (*queue_destroy_func_t)(void *data);
-- 
2.53.0

