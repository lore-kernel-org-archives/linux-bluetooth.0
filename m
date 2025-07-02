Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216932F4A1E
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473441; cv=none; b=u5OpE17DRfhT32AZr17jIEmi7BDGOk0f5CbVpkeGb/+rNkSZIWKW8Qx7LzZW4eNhyaF8q2pL4cGtTErRitAzXMXkr8jCDuGKoJBHXmLJHXvZ4VF8c7HghEj+Cg0hmN8+2BBbyFHyG6biYMEH2wWYcoQdxEUrzJKdXpiPm8pRI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473441; c=relaxed/simple;
	bh=as7dBlSgsDU34WcZwi9pAnKDYkTIOl/VW/XK+Dg4Dwg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzRdCyjGPFHGMNkKClDNbhI6NnFJ8v5I9Nhnkp/sZcEcCwC+V+WsVh6y/GjQYGBUWzR8DNeCHQl6929TwafAzSZ3UPFp5NwQ8Jop195EiDl287f1sO+YQZ0Cjjd1EK+q1+5O+bPRU81mSmdd2p+1L6jwYHtprcBduInoQC4m1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l81IbYNy; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l81IbYNy"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e9a284c225so2169719137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751473438; x=1752078238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JidpwyheK+hWopPybCwIXOG+0YPslBVn95pJLHaSAQ=;
        b=l81IbYNycWhDhXMKnFYD8D05kHZeWYjY0Czn04rvGJ6wpinwk7Ab56r7rw7shag1no
         /yqexJqcvNgGNGKSGSrb+PU6NMIvYhcINlGgqwAW8rVvjyp7jZnrWf9cBDceVqT4IH8t
         Rk6rWRSLALpn7jGMEeTIBtS+Z6saH1xZLilsK2Ktpod3qGYzzgya0DnTOYuoIPGwgrlC
         oYuHG2KfR0/YZTiKmwri5jXnjWKuXExr8ctvo7VtQl0JJ6E2CI29BHjNWj1GtHYNRK8G
         4NNnLRfnnmW7IMIeLg7m8sBXaKRv03tfLIT6XlcmYDOUURAGVpirVfeS+X41/8HFCihc
         noWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473438; x=1752078238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JidpwyheK+hWopPybCwIXOG+0YPslBVn95pJLHaSAQ=;
        b=aUbbsI3Y6wSHfu+T/g5vqKmq6euKt9pmFo+TMewjYOI1R6EW7QWFK4+lGTq4N1pR/4
         PPxzVCpPV5cT6ilTwaGuj10BfuxgNS1VrgIXhFLFyEbTwXY0Rjlky31KDpiGe4gSOPoa
         M/e1S1v7Vi0roWaE8iFryx0jChiKjgN8T2eXMI5LkhAehUpyuAY50iJtsBmzTcDH/i2g
         prDBNAO6ZZYTtdv3qGhD7KVsxGtecL7SZBB5iTBzKFSMHLo7Kck8NxgwXaFcv6FBmGbN
         zZNJYKoZzONsbtJRWJmozQ8SFPqAuqmHz1CbNrTdd/xoSBZY+Ae7WxqaKLGSur/l2sjP
         hXhw==
X-Gm-Message-State: AOJu0YxsR+OjdxfPLnm8RWBcuJFo1pEKH2ly3inr0C7IsZVY9iTaMj4B
	AutVIeKkiK9R9WbbxrYdgo+07MX98Tmoo2VSTInWJZD7PSVZlH9KxSma8mnQCada3cg=
X-Gm-Gg: ASbGncvX8s5AUrpPWpYm77td1m5ptEO6DAXicybzL1X+FyhnVPCNU61c54vP4T15JIT
	FkcNZ8SMgDkj8g8+WrVnN7CqKTrtsElDj2rg4de8Nq/Pqc1sHoURgJ+xnvHFwvNNA9nPdsAQHV0
	p1UvdtGAcxA56lbP+khtsJNGnEsNHcHNqmF2z8Q1Cvoe5YfwHSXAAQKHMbbb9up+axL8Nozts/2
	BWOCR1fCNoXyCX1VOfP0yXIRvBg0MZGGhpxrLpRqDBBpkRPbJu6fbkI1Fw1bCC9+uH9lu5a0Z8p
	NjyLUx+kQ/Rp0XzFQqOv9RNh+vflx6NBeUMyMVpqvr/TunBQorli5Soz2/6Yrb7a0TBykmuOdSn
	s7oX6D7YRelgOyaRq1iBwW2P1s6p8YQI=
X-Google-Smtp-Source: AGHT+IEJYJwZgh/Cej+E5Y5ZnIQ6ERIi53aBIHTiKis/On6YKfUMTY36YvZOnc/u0pUSfnGVB5/OmQ==
X-Received: by 2002:a05:6102:943:b0:4e9:a2bd:b456 with SMTP id ada2fe7eead31-4f174758ac1mr250174137.12.1751473438384;
        Wed, 02 Jul 2025 09:23:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1c458c2sm2476733241.13.2025.07.02.09.23.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:23:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
Date: Wed,  2 Jul 2025 12:23:52 -0400
Message-ID: <20250702162352.1374119-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702162352.1374119-1-luiz.dentz@gmail.com>
References: <20250702162352.1374119-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the usage of HCI_ERROR_REMOTE_USER_TERM, which as the name
suggest is to indicate a regular disconnection initiated by an user,
with HCI_ERROR_AUTH_FAILURE to indicate the session has timeout thus any
pairing shall be considered as failed.

Fixes: 1e91c29eb60c ("Bluetooth: Use hci_disconnect for immediate disconnection from SMP")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a3a4ffee25c8..8115d42fc15b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1379,7 +1379,7 @@ static void smp_timeout(struct work_struct *work)
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
-	hci_disconnect(conn->hcon, HCI_ERROR_REMOTE_USER_TERM);
+	hci_disconnect(conn->hcon, HCI_ERROR_AUTH_FAILURE);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
-- 
2.49.0

