Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75E20E03C
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269570; cv=none; b=FuF2iLPlk9Sw6L22/4QgQmv5g4WDKpZYM+l3u7pc0kXFMRX/q268dVVfHzgWGvHGrh6EyUFOmqf6CoNhZ+/jUhQG0uH1p493RL+YFRFkxx6BpImOrNEwy6E/o9ri79rbjKMP/VyRjUE9r54D8SIa9hdzSztMyrv2BPdMvb8pta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269570; c=relaxed/simple;
	bh=WYBeKD+zcZNnUz63L3ujhK4F3KC6HCuglN5U2eXY7I4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1WgY2YYaL1MtLKuiWbefwxmQbaMaUIUzY6v2F+3bJ+Wi7+vUo2coXwvuAufKW9mR52DtpCZQanU2lBX4UxHmTGLyICFN3M/T7/PrtzzOMHH8yKVxOYk5HZT6CIaUohIJTfJLt7ererrNMx/Z5C7wpYJHGJT+5IDGIuD0D2WB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br/wT5XQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br/wT5XQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c546334bdeso304382685a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745269567; x=1745874367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL7Tzq1YFE76lG1+vg1wRjKJohByhgz8Z/Gg0ylwKho=;
        b=Br/wT5XQ0UETtPe1QgHkhjdDzLzZckQu/8hNfuTBseB+CqAUEZa5pSa6c1x6kwgrLc
         NMYZgoCMfaPE6yvt3diPuea7ifVNl0tpC14T+wvutwUy+HJ9N/Xz0Dsmdy2ufR3e6OiG
         9Xg48MA8wlDs+IQIaLJ77VDHU1YlrrtJnncNjTpiSCoAN7hnQVo96e1uxQB9ijZPEmrb
         umxP+Jfrp0claiL7qS57aQtS6PyPGAbaJ2I46D6CK+7GZd47lOLEs/XMxVI3qQiSkxQ4
         uYR4UOEOsrRgLGnbqooMz55TVP+aBFocNLJF6yMXobB5U7Nt4mtRH7qn9S39BIcCkavg
         COqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745269567; x=1745874367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL7Tzq1YFE76lG1+vg1wRjKJohByhgz8Z/Gg0ylwKho=;
        b=okHJOxwqBINXQPswT2kWFftqH3vx5D83N/s+xGTqOb1+jE4Vc2X0R8rsq2IgdqhWzY
         BcUjMhhJbFc5sttxp6bwA4YHNcHwN9iHnpm5hnO1yiEpfMrF3Mx4GVVeslhxY3xgN7UQ
         FPryNUnxD1XI3Uk2mSVHWx1QIM8jFiodhr6PMvglwF+N4Y2ZzyxRohGJs0ZX2GCnXhMa
         RutJm7CNdR77BDvl/sOt/t/0AGkpM/QO4pNRHVNo+bhAMg2Uwe2gdn02i46UqyZwr4oc
         yyW1xd4NRxIUZo4dh/m+ofJapETCPisElf8zZHoUhIv1Mbi3Wbvy4AiKh3DnuiuI2MPW
         /W7Q==
X-Gm-Message-State: AOJu0YzRuhUgtONVAhcL03xei6dK/Q8+OYTQlePBCK9ud8jmjeSZxNqm
	lg5NYbrJGvLYuznFnZzhZT8nUP/ykRNPOxETTWWqz2a6qCE0l/DVE4MqWVfEqck=
X-Gm-Gg: ASbGncsznwlwuI00mEETKI7qE1wYoaVPokHAlY9whTPnHoDghzsxPKZ+6PABBZ0+UEL
	Pew/GBjJg3miTzqVHUIvKasVGzkWc7QNuI/1em8jCikugRvtxu6PhkGrflHaegD9lGwRYAhMByW
	w8z2zLn88Y6ZxcQuSSnmRPlo0dhyjlIkguLnkviJ2QRfOUo+t+xNwyCpMutJxmSZXGC29gNtNOC
	m0ap6Sml3ZuXgs6y9n8VieQ6PDQ1h4wGzUtG4Qmyd5XudlMGcarPW+Kv1+iBZ+OCBpNCqKyTmhA
	PmTvT2MiNV2xKaqJVaWsxoLd055sVoY1KWgVVpkb5hOqqTJ7p0juKUO1aA/2jQltJXAzgfLL7z5
	caJ7WIqVBDA==
X-Google-Smtp-Source: AGHT+IF+y4qkiP27yyD5qsCMA0fqCDhYAzBYNDwItLj8SlVSKVrt5WJTkTj3Uc6o7vN15dBskt3QuQ==
X-Received: by 2002:a05:620a:394e:b0:7c5:4caa:21a4 with SMTP id af79cd13be357-7c92804d47amr2518573485a.55.1745269566617;
        Mon, 21 Apr 2025 14:06:06 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87764654c5csm1913958241.5.2025.04.21.14.06.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 14:06:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] eir: Use Broadcast Name as Device.Name
Date: Mon, 21 Apr 2025 17:06:02 -0400
Message-ID: <20250421210602.746957-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421210602.746957-1-luiz.dentz@gmail.com>
References: <20250421210602.746957-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of Broadcast Name advertising data field as device name
so it can be identified by upper layer.
---
 src/eir.c | 3 ++-
 src/eir.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/eir.c b/src/eir.c
index 3e3ee2863058..28b09653cbae 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -293,6 +293,7 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 
 		case EIR_NAME_SHORT:
 		case EIR_NAME_COMPLETE:
+		case EIR_BC_NAME:
 			/* Some vendors put a NUL byte terminator into
 			 * the name */
 			while (data_len > 0 && data[data_len - 1] == '\0')
@@ -301,7 +302,7 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			g_free(eir->name);
 
 			eir->name = name2utf8(data, data_len);
-			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
+			eir->name_complete = eir_data[1] != EIR_NAME_SHORT;
 			break;
 
 		case EIR_TX_POWER:
diff --git a/src/eir.h b/src/eir.h
index f34291952823..2fe8cddf783d 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -39,6 +39,7 @@
 #define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
 #define EIR_TRANSPORT_DISCOVERY     0x26  /* Transport Discovery Service */
 #define EIR_CSIP_RSI                0x2e  /* Resolvable Set Identifier */
+#define EIR_BC_NAME                 0x30  /* Broadcast Name */
 #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
-- 
2.49.0

