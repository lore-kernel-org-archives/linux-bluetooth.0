Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA543DA5BC
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059123; cv=none; b=CL73AeuvajoE60LcXxXl1iyqMPtyQpXjUXqkrhtyELdi2Ck194dvlLrs6p3Q3HaK1WAfEbJoOkKKNZMhXbeZKlcDtjR+whgBMpge4cU74UAxBh56Mku083qCdjYZCc6kgZMnfUbE2ARJB6Wm+UBb6TBhQY+eTvLlyvOCzlXoasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059123; c=relaxed/simple;
	bh=jOowLYw6eOS92J31irfwgvtqGp8+s62wTe/E6R6H9IM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUe548Y9Hdu+m7gEbAIxN5cgoMsTNSmTXFM8pOWx1/7YxJQmcoB6yw2hFkjamZCea+6hrc5Ftsmj/ETyJrpm5070cDD/rMlwdbf3H4S1O8Swi0Sc4VsOrPt7vhiJ/vh55TJ6xjGiWjPyDgCRioIUbf3r8A7eNeJlov90vvRAlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 815FE3EBD0
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/5] shared/util: Add helper for "cleanup" variable attribute
Date: Wed,  6 May 2026 11:14:23 +0200
Message-ID: <20260506091824.2920716-3-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506091824.2920716-1-hadess@hadess.net>
References: <20260506091824.2920716-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEalGPf43K/RkyTbDM0z1f5OCBFeFUV0Xo9oWKNEO15aeBpUaiBEr2MGTMjLI5ljdEzOjMsjzEAMV20zvrxLM4N9IN5rqt3jJOMs+CrENXeMosxYiX0v8QWFelkkTnjuIMkTdX8hAPi4ZLyhoIx96q6cPmmn+GBjwobzUZLUDQ8XdA3qgT1H/DETWVlw+hMS362QSUXJnIvn26fiJk8yhXV7PRMBmgTd2MVaWOi4sXrbTvB9A6wtNuK0uBIEt4If8yRlaWkc+e9GZ7+52j1RngOW8amDrWvgVSftlqym5iYun8YHYgWCxhX2uYGQo52H9vkOoS/SvM4JQgcvLTkqiuONIKTlqg5URRZSauczNJTEHnmdZiLLgeZi4pFcPiT6rbWWDT3qIyvYcKwBpv73QcKz75dXeq64thahMwIqcTTyAMF3P+wfI/Uy2/W60Zy36EvksjQdCC1K8Q8FOAyY43NdTB7t/Pb69qk4P5BWy8ZP1Xm5tQcabmBYEtyTr6+oGjmcLh7pU2dyFb53wORpvas3Z78YLrT2RvXlMfbp1FqbjQsy63Y1yUEKw0Be0HJ4WeS6B0BBw5iKq1fOQYjGkRuScgrGQTWMM6CS7/fpRRu3WsP6kbqw7Z4zM5Q4vkpQsswrCsTLXEnYo7g2Bs+agXm/y4v7EsO++XMQcooSSNvRg

Use the widespread "cleanup" variable attribute:
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup

It is implemented by both GCC and clang on platforms where bluez is
used, and can help reduce memory leaks, while improving readability.

See also:
https://systemd.io/CODING_STYLE/#memory-allocation
https://docs.gtk.org/glib/auto-cleanup.html
---
 src/shared/util.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 67629dddfaa9..90e3b32f86fe 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -93,6 +93,13 @@ do {						\
 #define newa(t, n) ((t*) alloca(sizeof(t)*(n)))
 #define malloc0(n) (calloc(1, (n)))
 
+static inline void freep(void *p) {
+        free(*(void**) p);
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

