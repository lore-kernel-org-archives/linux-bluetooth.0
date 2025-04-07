Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300642222C4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056133; cv=none; b=quxSmXLS5I8jao4EKsUfNbVECz9k0QlTyNTqnBNNfV3XnStp8p/iri8BSj63YjaFlHrcmMH0tFhAewEd1prD2J6dN75KdgwpHoDY9QzhgSjIs09N/Z56SXpLA8to9UY1ahalxsjTwgyrp76jsGBVBjtVtuMkZ6wkNTRu4yA0EQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056133; c=relaxed/simple;
	bh=rtFznkee/hfiJclSoLZHUJ06b11xpiXnJ35OAR/6dV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9u+X4datKj2jVbnP7+CGJXeuR3BnZ4KtgtoRsxVYkcQI6jr9IfAdeqmS2GScpsAph0+YBn+/rA+EHp0EA6lw9pBzfvWSMPuSHAhXHkHU6FvANHof5l7ejgNqUdGSovFoLnJbzq96gw2EY5UpDx70TelpYBx+K83kP9zp1CAAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk0TCWZ2; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk0TCWZ2"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85dac9729c3so323743339f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056130; x=1744660930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhOLzS/aTB7p+rCSf6gjBGzekkXKtABaMGKHSe8dHUE=;
        b=Fk0TCWZ2+igi01Ezd599ULc5vMZgK049VlelTjPSbE+ycpsvP8RRcc1vpxq0lGYl+z
         nrEukUs/cV7AAJa7vxn/S4RsriteGW91+Fpt6TyoTZFeAGmSnP/S4od4EobzYJkgAHtO
         BYZPTR3fkBKHFatqS2U90AMHGKlirqgcNY4pL+JAUT2toxWsa6cwmULOhtRrz7KjoCzg
         nkAanh20lq2SUVXt68X3dkKysFidEtyMY0L+WYGsCi2Kr30KYMJ/kUK7ggkwJiIiuQDV
         CJ8oJimkh0R6K0xOyQsdr5SuNDEq7ZsCIGhU+OjsqEyVE/eViWtZ27xvbklQeGfKba4c
         Vuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056130; x=1744660930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhOLzS/aTB7p+rCSf6gjBGzekkXKtABaMGKHSe8dHUE=;
        b=WwvRqmC5PUH05w7gVSkYTtUKEyYZWmDkLwLGuFw14pVmFFtcaDj9gxRSkTnm4CanEk
         lRA1mDzFiXi+OTRxt0YtHS8T2Rq3o2ngWxrkdT8nVg6Kavskn5clrPEqw2Bxh8IyIXNd
         9hqFgCXasb9W3gEcv9L21k8+TVqEbERp21MM8O15g5oVxx8WMquCDlprQh2TJHsj8o/3
         2Y/2p9bCGkGHokCKcn6e6KSkgM53ZInKCFLSgKe3Dx3dsK9xhhRjxUcEeP+vvz6TLcPZ
         nNq+eQlzoU10elPi6BUu78WLMYYESrBxbL2iMBtkj8mI0aNoReT8pBc5jpzKQJgGamjM
         zouA==
X-Gm-Message-State: AOJu0YyH6csaqgjLJskWHuIL7F414CDcNfA7PA1sLJ+F1+NJonAqw9ga
	oEPU2q8ZrbfZCTISCAjbSKXBTCDKHpooJ4QLHAxn9luCZVIfj2XsZGhw0VsB
X-Gm-Gg: ASbGncsfHSrtwUEfAdwhGoafLfmaAJ9b3O1RrQvOGPps75FYiIG3qYaSHJGIuECY7jn
	iH4CzQyojRIfnSuuipvIeHx06XQcyoGavsgw6iD/7Uch4AzR41nSECctYz0NhIVZRMQcbNYJPoE
	q3dn1dy4fRV+XDMTMxkOhzWXvOSH1jbwl9d8st4mAQFdO9pIRuueGM3uKmhOp+y2P/Yo7281Bwd
	MPWyhcR17DSCDPUhsd0Hurcnpq5IwjPKqgSlv/onmB336x3VRk51IJwGpITNWvMwDIMW7qmRa8N
	wZppKVa9THXV5SNnVv+abPR48bEPjvxvoxtNVETMxcCXSkWKYYBPCxehBS5HMzg7n/l+0wUPI8o
	BiMCwThV6TU0+8Q==
X-Google-Smtp-Source: AGHT+IGhB9HrKv4I3bFsg9iIwaoSWL2Mn+mPrF6FWAStG/0+KyTxXqMIu4ryoDSmDB6pTFUR1VwJ+A==
X-Received: by 2002:a05:6122:181b:b0:520:9688:d1bb with SMTP id 71dfb90a1353d-52772ede57bmr6997386e0c.2.1744056119554;
        Mon, 07 Apr 2025 13:01:59 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 11/15] shared/bap: Fix not sending ASE Notication in case of Metadata update
Date: Mon,  7 Apr 2025 16:01:17 -0400
Message-ID: <20250407200124.881534-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tests such if metadata update requires the server to generate ASE
notification on Update Metadata operation.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ec23e882f389..76f221102dc6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2162,6 +2162,9 @@ static uint8_t stream_metadata(struct bt_bap_stream *stream, struct iovec *meta,
 	util_iov_free(stream->meta, 1);
 	stream->meta = util_iov_dup(meta, 1);
 
+	/* Force state change to the same state to update the metadata */
+	stream_set_state(stream, bt_bap_stream_get_state(stream));
+
 	return 0;
 }
 
-- 
2.49.0

