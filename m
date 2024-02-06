Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AA1C283
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258923; cv=none; b=fg07zYyp2Txeegh05cH1z9bACAGjwBLVNHeBaWDJhtdJ1sjR4hPWFAPZfSuKRbkxTFslIfo2Y5bi9uMBmDSloxtCXHiHwzPI1oqSLz7AY4sn8TBzHjBTi+yPswnaY7YGYwON622OIDO5fiTz22HHdjbOqlX09l4SeX8znFiQ8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258923; c=relaxed/simple;
	bh=2gD+UeIhNC74u8XXxHunkeiz09ZImZJ+lnK6iKxCPb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRs60tpIx3/QQrKbahRlPCwVmawAX7JUcioxBEPbWJ0vYWw2EBRtTKPdxrp8C++Esz3i8GdnaBTQzIa5nAC6uUEo1YVytQw9Gv/ELqZRwVjbjCt4Ek8UFECuBEAGtLaGGRpIuPf92uv/ltMfH0bmKSaAuC4B7b/su8ksAvm4bfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHITtSbg; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHITtSbg"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso3041489241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258920; x=1707863720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdbWku3dFjLXvK8sQDBJRr6eWjve+Kmhmgss6oqKgwA=;
        b=jHITtSbgpQPQrgtZevm1SDttSL1eQgS00xQn7OdcLvOYLSVRaggXwKc6q4L2VjgyCo
         98GC4kuhQR04/uZOaWlNLlZToMAb4dHWjGD/Ms4LmCdxQoV0zewJKE0xvsNBNDTpwCq/
         62snX7n3yMt8qUsGz9u8i9+Oy+ORVH2TDV/Xx9vcWUoFEMdiPco5Mbjufyvjrzqwh8E2
         BwcjdEMHPBu4OrGXht/bxwn49JUAL2YKlb9QTRaM/VlwILD9W+k/bzZaYWVANoZW/1fH
         7hyUP25iwXI+0wuR8ZnHyUsgjecM6LGcvXb+wHHpgRtm568vu/cFK1/1lI4DRqrwXVsy
         dPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258920; x=1707863720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdbWku3dFjLXvK8sQDBJRr6eWjve+Kmhmgss6oqKgwA=;
        b=oeQz+rivK8SgHzpvq+a4eGtNqIsT0j6WsJGBGI4vFy4pkEcGNcFah/WeYZp37cd6cb
         A510ICFFOpdgeD5ne5OrZA0ZK9GsO4YjzZjEt5++wNf/gECKKwZsgpLWV4DVdPFrfDfh
         BtiL0yyXDgyGAqeCsWhkTz5bt3rSi4RjXNhLC27diTstbfe+SjH+KHPzYELSgIulkugP
         RKvs+73vcWl6kyiCywMfPvmpKz6mPDU7x2oJ65OezI4OGZ2rkZ0y+nmCsJQrzhvz6a6x
         MRbSXqP/hOsezSGJZV5dASM+pC1wUgzX1d0PXpIel0pQxBxKsa7hHGVYKFgBeIRZ3vwE
         2xjw==
X-Gm-Message-State: AOJu0Yxb6eWlxtaQnxoWViJBvWku8vj5dAs+oc32dfMt6Qsk9mgbtCq6
	uMvHujMTSnpDIR6LVve0vjSZWti7GJXezk2SKPQappxYENodL788+pazFPMt
X-Google-Smtp-Source: AGHT+IE5936fkyOXqj5HKKHIQxm/78nPJ08H2rQHnphMoXaOe8KYPxj+T0S2UPGa0cUPn1IOvwSuSQ==
X-Received: by 2002:a05:6102:3592:b0:46d:3368:971e with SMTP id h18-20020a056102359200b0046d3368971emr1088622vsu.33.1707258919750;
        Tue, 06 Feb 2024 14:35:19 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l7-20020a056102316700b0046d35339f2bsm322432vsm.3.2024.02.06.14.35.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:35:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] shared/bap: Make bt_bap_ref_safe check if the instance is attached
Date: Tue,  6 Feb 2024 17:35:13 -0500
Message-ID: <20240206223513.2783330-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206223513.2783330-1-luiz.dentz@gmail.com>
References: <20240206223513.2783330-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_bap_ref_safe check that bap instance is part of sessions
list which means it is attached/valid.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4722ed1a1b27..804352db9c41 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1033,7 +1033,7 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 
 static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
 {
-	if (!bap || !bap->ref_count)
+	if (!bap || !bap->ref_count || !queue_find(sessions, NULL, bap))
 		return NULL;
 
 	return bt_bap_ref(bap);
-- 
2.43.0

