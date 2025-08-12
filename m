Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48532BD012
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985652; cv=none; b=u22o74GxQZXhwmwH+3Z7wvue3lUAS+U0geXoTQltwU6u+B5qGHbwVYiEpAlhKO3JQcHxtVD4XIQiPaRzc+mGOwpK02p4Cw9sIwJBYkXvKbxWJdpIGt/MKi+e5WhRJUqPo+xncH6WGYtrJw6sgLKQk7WnS1yst2Gg1sGvIuazFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985652; c=relaxed/simple;
	bh=Q1fQp9X9BNwddPrMHx3/XXmNyRItbUqWhnxPKaG/JLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqx9RJR5Rky97KGaUtd/qF0X3ZIOmMoxWPgNfMhl6T/zQQLWNs0JoTgPrF3Ec508JkzYgXyu154ct2zeqsuQX17k2jjGu2fXb0m9qNP7RyXg3og39oOrosXZqzrdaGf8Ls2JAU6G+XlAj9KxcFsby+LbofL6At9vwrdmkGurH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6c0ukcY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6c0ukcY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so47951245e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985649; x=1755590449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z30P+f5Qygg0SsF1nLFRQVcOl2/0c+b0qwmTM2suohM=;
        b=C6c0ukcYh3+mEfYzMSlqSWmtzjqtwlkFTwD3a5ybGeQhWL8n1Xc7sdpzAn8H7Hn8Yd
         bhFaqV1t6oQ6gzmIzLbpo0T+CiPFH/srZJ0sen+5lOTs4fm4ky4etLXk4bvDrm69LhmL
         haPdcc8WII4zJRR5xYqCH3/6JcpmvOS6VcSDHOe7aRMpNFWGgOf5mhucz/Ixfs6Biz/D
         813cfoOpppfUoMuo/79RGO5yU1ncwwQ1mlxxh48/emFIYrcRTUVtrMqe35U7xxeGCehT
         w2LqkhdftCksaMq0lcxeShHOjyOKuWJ45/MihwXjpG7klQNMlzWd1kySataAEn1+yrx7
         enfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985649; x=1755590449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z30P+f5Qygg0SsF1nLFRQVcOl2/0c+b0qwmTM2suohM=;
        b=QOJGtf5LhbLc8L5pAHJBa0ydehdRlRvW24Oa/XZ+raJ3ZuRImMYUhIQHCC0EV77nde
         C83P3Wfvo4X1054alkYMy8f40Ma4OcIVppmGxz/k5dmDQ+j+3pwvh66VllC8sbwOrG+Q
         5DhQyr7sgiSHB0Go32DzssSeS33ggG81dmKzzTUWEolM3qV6bqDnMBTRC+bLsI86uV8M
         ESq6oqPW4RQKbehxj3QoveHLZOJ1oemysY1q8Wx42WxEprGdBPHgACi8Wgw9uF/UPdIx
         LwEFXqfkOsSOsMlcnvv8L3HGcVhBM5FNew4kVatETTLsKdnDNxJ/dDfr4wuyjFLpaoEB
         f5bg==
X-Gm-Message-State: AOJu0YwYq5PvGOUs9U5v8kUEEW3N+xeCM76OLdrK6WiNe+kcnEvxbe/Q
	PvqTYRpHL8k0iuVOj8tTw2SYuu5VUZtNK+AUEEnPnAE95NXGSqiOyqB6Mo40l6ThI4g=
X-Gm-Gg: ASbGnct2cr1NNX+t6t9bkIwgKKk7Pgmh4QhcV682YwtvO1AdcW4dweGd2Jxpabn/xFj
	HsDYzE/S01JjaV2hF36PMasyIkWz4tKRBtqZnFj8uKfKblLU1qmi4/xLTgoQqDgxdmeVP6oEFOr
	BATFVy+gmwhCZ3CxUZDSt0wWojcdol6ZfGWHIe4p8cOJ3GYRF/4PNoPBdBKJnC01MSMBz3Def9X
	Mi7Y4Lykv1PvtfkmZbHD8yB9C01zz5yuGtWnMO5pA1EEnfp5ZtkGW1tMdCmsyW9t7rkq1THStGR
	SRRCtqJExUXi46n39+d9vWuw7KPmDy6VhJi0W7tUz64SLsR2O/CPhgN4AljNAR8d7q3rzaScSHU
	3b02hfDNG/JLGWQSyoKL/aByBYK/UD+uz
X-Google-Smtp-Source: AGHT+IHKde1qIMpioZt+hmGSVBJtzd3QhemkskRrMpi0bBcBVbzZ3bktUCckOV41TLe7A7JRk8gh+A==
X-Received: by 2002:a05:6000:220f:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3b900b81c2dmr12255165f8f.59.1754985648588;
        Tue, 12 Aug 2025 01:00:48 -0700 (PDT)
Received: from valor-verifone.lan ([195.138.223.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0b2d2fasm32721394f8f.50.2025.08.12.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:00:48 -0700 (PDT)
From: valorcool@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com,
	iulia.tanasescu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	Stanislavs Nilovs <valorcool@gmail.com>
Subject: [PATCH BlueZ v1 1/1] Fix memory leak when adding GATT Characteristic
Date: Tue, 12 Aug 2025 11:00:44 +0300
Message-ID: <20250812080044.131526-2-valorcool@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250812080044.131526-1-valorcool@gmail.com>
References: <20250812080044.131526-1-valorcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislavs Nilovs <valorcool@gmail.com>

Commit 4465c577778d812702d752dfd2812e25a2f69b31 has fixed a segfault
which may occur during new GATT Characteristic insertion. However, the
cleanup exercise isn't done before returning.

Bluetoothd address sanitizer backtrace:
=================================================================
==88967==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 768 byte(s) in 6 object(s) allocated from:
    #0 0x768d1f8b3ec7 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x59f0cac1ea07 in util_malloc src/shared/util.c:46

Indirect leak of 576 byte(s) in 18 object(s) allocated from:
    #0 0x768d1f8b3ec7 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x59f0cac1ea07 in util_malloc src/shared/util.c:46

Indirect leak of 114 byte(s) in 6 object(s) allocated from:
    #0 0x768d1f8b4097 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x59f0cac75d6c in new_attribute src/shared/gatt-db.c:222

SUMMARY: AddressSanitizer: 1458 byte(s) leaked in 30 allocation(s).

Additionally added an explicit check that current Characteristic handle
is not greater or equal to its value handle. If value handle is equal to
Characteristic handle, then second "new_attribute" allocation will
overwrite the pointer in service->attributes, which will also cause a
leak.
---
 src/shared/gatt-db.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b67bf89f9..02b49e94b 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -969,6 +969,10 @@ service_insert_characteristic(struct gatt_db_service *service,
 	if (handle == UINT16_MAX)
 		return NULL;
 
+	/* Value handle can't be the same or less than Characteristic handle per reasons above */
+	if(value_handle <= handle)
+		return NULL;
+
 	i = service_get_attribute_index(service, &handle, 1);
 	if (!i)
 		return NULL;
@@ -1009,8 +1013,11 @@ service_insert_characteristic(struct gatt_db_service *service,
 	/* Update handle of characteristic value_handle if it has changed */
 	put_le16(value_handle, &value[1]);
 
-	if (!(*chrc) || !(*chrc)->value)
+	if (!(*chrc)->value) {
+		free(*chrc);
+		*chrc = NULL;
 		return NULL;
+	}
 
 	if (memcmp((*chrc)->value, value, len))
 		memcpy((*chrc)->value, value, len);
-- 
2.48.1

