Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105762798FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146742; cv=none; b=llYPAjIwlJwgIiscyn1tZv6Sa95oenFqPBKHvK7hNn1OP1R4KNwXz39BJY+MvEuozvEAiLfk789ttFrMLMbhzOnt4vSiZ7IFDmnn8iR4uEOh2Vw0LoT+nYo5wLyhvIhSMOt8BvJu/XoYOAv2EafCrnrLJQdyvfLcXeC+1fZTUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146742; c=relaxed/simple;
	bh=M/ckX7Sbf6xxlzGF764mBiDvTlZ9rolplt1fn+nW09w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfEWOslj/uYRh5g/jyaG5/4GzkNfB7PG6b43vmzN78uWMH5t3ZgeswhzNKfoS8V1dI8pHBKzilHsb6dvu/5LJ55fFCHXijdLGhANCKarwUy2KtsVTeP/ZeiTV+HsDkF6BGMwZjniKnJrMW7g+Ldoi30Ah27c+VjZS8a/gPxXbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpKdORkr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpKdORkr"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61c51f57224so2260642a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756146739; x=1756751539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKTukt54OlgBBbvmn1OmDvOPJj6lLgF4l2F3AP1rSB0=;
        b=QpKdORkrHwqX2FSFWG57OjEGHgzbUKFB8MzVqYcYz3oLURVPeblg3KEi6rbtLAqw7i
         cAL7tF+c/dAcqdAZPfBYxm6hdCqoh1ibEodk8mF9S7hhgCVzMuAl5dsoXi+qWSmKPzs0
         K9rbUPkfbETap5MlpRT0AJ8M5SD37OxF2fBG83qBM6gOn/xL4KgB61XQc7obFJIMyyx8
         n12kz+TiYlGy6V11khp3VjNehMjVaW/6jdhO2Ec+SLNUxt/42sOzaNG4uhOI752gdflh
         GnuSqETPhRMYEXwVNS6oGMNWvq0bHzAMCOjA9bpQKJ/IGJ3EiABskVKdKMN++JGK41Ng
         RZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146739; x=1756751539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKTukt54OlgBBbvmn1OmDvOPJj6lLgF4l2F3AP1rSB0=;
        b=NAFY2m9fYnEs0/Jk7gxWI7hm/sseZ+lVJr7vgUiv1RVBx69IwnzxM6CDl+2gMlUAE9
         qjeT37yDgE/rDt2zw866/kae9mMRGq7y+QyxP95FweDWmOfzPWUOB5VQ38y6PEE36teA
         XenvoB5u10At4+0joH2/QyN0+e/uEcYQbvyS501ncGB8stFtBXam1dbnylJf7WUyoKSM
         jNSt0Jx8PBtP8C0wh29z+3Yb0lPoA89ZjtFNCPrjwgJih7DWhSJ3CKdbFC9AgsTuDRWI
         YFJ678U08Efstq3b9+hUUEH6C5MLeIIG0wzLc4C7YOutZJ8QwJc4rjtZMTE+2mziI6UX
         XZ8w==
X-Gm-Message-State: AOJu0Yx4lk24XC9XkQn6DGe0eKtkN+OvNgUMa1erg7vS4P3KW8Xf6fjG
	LhVegS2Giam82Ct2nouwopz0R+Zqlq+kHONKKLI5aMWe1vgC1dBH6n1jPxhTsPwB
X-Gm-Gg: ASbGncs92kjezPPZDn9nLJAMeSGFOlY2ZZz2+24QhmxivCoNj0mNIZL0fRoySoO90Bs
	EuS82bAYGJRgXpEMJST9W8UeJr+RXl+JhPfQOQ/b11dJP6CrjVQLmINxvzbQRxKOrlVtlMx4L7K
	TBVZYMr1C6R1Df7XiThN+1dSQm7ER+gRLQEXuHiG3la5uYRxLSKhZf7ggbgxXMoK4WD3RzAOAgK
	AWV1yEu2lCCaTcatOqlfDkeYG9LPsTbCJ+nSJWVRp5WNuh6JG8K/+dPas75tTD/8m4aBIqvJIkt
	qOTU3IcEg8wxyaA1/msMYdk5KGFfFGudtBA/bXkFQ4jr/WX7pnvB4B0OwbixbjqrDuTo8SP3lEC
	E2fwa2TnDYUFiE0xLjC+qw0ASIQ3WrYCUEdUI1cdBhMl0T/kgJOS/q3pr/oNvktKzzhNAAav4KI
	BQ4v8Tln+LR58jjVEC6w==
X-Google-Smtp-Source: AGHT+IERT5aPEFqS0//8J94iVBfGK/R3teWuwsEUlHsXwjOGhshbcMDM7MhJMbWakSkBkHcjuAYg1Q==
X-Received: by 2002:a05:6402:358b:b0:61c:5884:815c with SMTP id 4fb4d7f45d1cf-61c5884fec2mr5457537a12.10.1756146739220;
        Mon, 25 Aug 2025 11:32:19 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119ffdfsm5505328a12.9.2025.08.25.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:32:18 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: hadess@hadess.net
Cc: linux-bluetooth@vger.kernel.org,
	Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2 2/2] lib: Add missing includes in bluetooth/hci_lib.h
Date: Mon, 25 Aug 2025 20:31:59 +0200
Message-ID: <20250825183159.340527-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
References: <153fce6357dee9d70a04fb4a6c19a975e5c710b4.camel@hadess.net>
 <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compilation fails when using bluetooth/hci_lib.h without other includes.

> /usr/include/bluetooth/hci_lib.h:21:9: error: unknown type name ‘uint16_t’
>    21 |         uint16_t ogf;
>       |         ^~~~~~~~
> ...
> /usr/include/bluetooth/hci_lib.h:182:27: error: ‘HCI_VENDOR_PKT’ undeclared
>   182 |         hci_set_bit((t == HCI_VENDOR_PKT) ? 0 : (t & HCI_FLT_TYPE_BITS), &f->type_mask);
>       |                           ^~~~~~~~~~~~~~
---
 lib/bluetooth/hci_lib.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bluetooth/hci_lib.h b/lib/bluetooth/hci_lib.h
index 2cb660786..eeb51411a 100644
--- a/lib/bluetooth/hci_lib.h
+++ b/lib/bluetooth/hci_lib.h
@@ -17,6 +17,12 @@
 extern "C" {
 #endif
 
+#include <stdint.h>
+#include <string.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+
 struct hci_request {
 	uint16_t ogf;
 	uint16_t ocf;
-- 
2.47.2

