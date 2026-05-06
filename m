Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D5480DC6
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077957; cv=none; b=PTi+NozstCbrYX+2RoxR05FxyDg4/Ezut6w4iuKwhqtjlvnCZfo/vnsfeM1pxQwGia55rGolDEjDkE6Sj1NWChEn4fOADktSflT9/LiNrg7vLVdresI/9q3YT4hhJWX6Z+7ym7LVASabQHS5bD8E8iBPbND3tofeG8uV7DkqCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077957; c=relaxed/simple;
	bh=OI/GaC7xckbo/xEsjljyB5vHgE2qWXm0htfSz7wYx/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJnwx9SONrbmTsb5xUGCFNlOIIlyTJt8TzruK8WF9yGqt4Lsp4jCyCw81qAec/9l1IWOFh1J5hcgOAJbEVykalMu94cYwkrQiAkWO3edKtiKnT08S9TLpiTYbBqyzRnVpMZJRz0yVgNXIWg3lVc9GGA4pFXpTn6zWYzMCixLpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E4283EC96
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 2/5] shared/util: Add helper for "cleanup" variable attribute
Date: Wed,  6 May 2026 16:30:56 +0200
Message-ID: <20260506143220.3076135-3-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506143220.3076135-1-hadess@hadess.net>
References: <20260506143220.3076135-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGBd12g0S+P9lDrek3Lu1TMcxc1ymS8LOX81PpNQTuTlFXG2ZHerlA0Bdrj4w5zEG1rmpxYW3irZ+dJlcxnb/51gsY6IR6I8zt9DbkOlhtmXDu1gmbd6XUFf6hfCSpczKv7tZl9zO0xEU4HRFMnj3Ceo3+wT8NHTI+BD+sbEbPxdZq4Dkh6tsc9xTaQbbJ6CBvWnwMjlEHOVivGFRpd8+sm1bbVXJIRO7C3nhiqQTfkBouttIyYSQTwgD4LUWPC7i/WJeSvkDB5Np7L9ADrZUsaspLtOYBtnmR5k8n+tt6s/bGjAFS/1fK0ZuLEZdBQHlp0lhfIEHMEG0OfnT0s7Wbomq16AY0klTc8teDvW3VW+J5pWZ89hXKzi+/bkWPGnmreTImaot04iHt3MO8OQ4bmT2699xcK8upoE/Eg4kc2YzAus8nwOs8F0KTXp2LtZEN0K5RDROxIvV5UG2vXSkUxSpcV7OHr+OoG6lxItOs/XP/cnRfapZw7jhy2YoLv9UWjhhzO8N4LjJa0g9tnL+MyEH5Qkx3bwxvbq4FZltXnCaNekt7s6AXWtT3/rDxPfBJLGM4Rq2grAuR9X3sr/HUC+SdayMvINVveM1FFXUmWBicDlaQzmb/k0I0rNCneFQa+0kIS4l4OryBSp/j6fbkWLG7snjo3xQQWD1RWb1HiVg

Use the widespread "cleanup" variable attribute:
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup

It is implemented by both GCC and clang on platforms where bluez is
used, and can help reduce memory leaks, while improving readability.

See also:
https://systemd.io/CODING_STYLE/#memory-allocation
https://docs.gtk.org/glib/auto-cleanup.html
---
 src/shared/util.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 67629dddfaa9..1660b6ea5149 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -93,6 +93,14 @@ do {						\
 #define newa(t, n) ((t*) alloca(sizeof(t)*(n)))
 #define malloc0(n) (calloc(1, (n)))
 
+static inline void freep(void *p)
+{
+	free(*(void **) p);
+}
+
+#define _cleanup_(f) __attribute__((cleanup(f)))
+#define _cleanup_free_ _cleanup_(freep)
+
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 char *strstrip(char *str);
-- 
2.54.0

