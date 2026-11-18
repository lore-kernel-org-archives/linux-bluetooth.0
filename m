Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010735;
	b=mygkVos9WO4hYIyjj8yyBursu2B3QZBNt0eP3R/P9Wjz4a5YoPg9a4T/6RxJd8SoB0I1
	 QZlUKlbXljOtnYg9aqrZDHn+L/U5uA92kwdEjAtZzXpQbTAUXtXmduYXXLAzBs2T9aozH
	 XUNvOYSpSW9YNifRTfUj/eiawVQ+LXydSwGehDk9LoWuqPurU59ecylcqd8Ot1xr+Nyse
	 SZU3GdcLUvdOROpe65X4KmWgmasIWkWiCaY1Cv4uqTuPaTDkMWo9mbFDIQVYO3C4B04UI
	 ZN2tLwGp4hv74Cy5k2YgVN2itcRwiki6JjE37WcdDWmxCuKv5fq/fAvQQBpSQbLGbeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
	b=uzequrneQnHBQhuqnBxm9t1HOBHjlJbyi20Suw1qMW9cYnK12RexINM1dbC/jTDpdwTs
	 zxfYgE5EY44Mwshi49xRb8Pl209NqG0BWlxeSK967k4w7GpZGGQ83upxwCL65ZuJaUqnG
	 KdUibCNqtmIkokZHe5TKa6u3QJDFTdAFleYUv/qvAQfzvIEbMqa6n6h00eTXcRijpUr/2
	 DbUYf0UQ6o+tNiCfuBDTvTAI0Fu+cDGlxIJOtYtsxHpsJbCdaHWMSPzGAMzV0gmlzx3kf
	 gSdHtoi0yeKheOhver3XKlOSxY8aNTEJuU5y57kR1iTqmYP9xZCKZIqYMdqq4vA+/BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVkjMZ2G;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844D60A381D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5844D60A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVkjMZ2G
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc91ddf447so382121137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010734; x=1795615534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
        b=WVkjMZ2G6DYHxTBiYy5aghiS61Pu6cH6cMOa7BajBVrqIq7rjJGxMPJm4rhdiyo0P6
         5T2pyWePUMxRz7BwnVK/Ons2QArxp54TLcQtHYyKTTZybh/ocDPzGxBd++EZDqKmF5H6
         qobCUbcL/y/qaVBE8WAa1BFfoKBdpTRAGJZWq7i12rkpG4l2V/V83TOcHoxe1yUQnCqU
         FLgepI4U4TDvkHXsEGb3BCUxmGvJw9dOO2/bmpdhGVyEbEJUhq44m2RjQszX6+cXjSqC
         ppwUMHAE3j+LipUyKTWxBytH6bzpEknrx8Sh5TU+y4+hBML8arSPZGM0awAsB9BoBqFH
         6Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010734; x=1795615534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
        b=gZ7dACHpw95DVXxEIoYWId7xWr4LybgwSjS6kmLOeBPoNBfA06Rh12/UFK4s8R5Z9b
         Pf4jiaOGQ0Avom31epPDrQoAbMgkA74pkoVWB+zVY2y0lISxu/KladZu8XbtZDWWOLgF
         cE4SSF7AvU+VQsiZCAAhiFc8I8S5VUtQ+RO1QbALjGKAzto6qsbtkzqrUi9JWAImNwBh
         J0d3qF7Sh6LEWNdttptTTMt6e85URe/C6oxZmfhQcHfQ2Wx57xjiBtPmRhzasKzQbNMJ
         cQbFeJwEYiHYP/IE2l/2YmvZ965DORNp7m0YAvTWVBqP1lLAod3Z4883yLnUzYm9sFul
         brzA==
X-Gm-Message-State: APuU4Z/gL8Xxsccn/Uwith6bhzRXgOK4Zg+bm18eHQ9O/brytXh2qbbY
	lFv5uYZZDrdi+j+pw8hib1zGepXGatvqtJMBc3xkjM5vwcfGHZSo7J1aRRxlG9Oj
X-Gm-Gg: AYBFou2Z6CsuyKF3Ay/NbbCOvVVb58Ez6pCE/JSPmr9rmr8CbyWN2C3zwOMdCqZwkkb
	jAct9gKu9V8C1L+x9JswgwljrBoh48EFOgD1GmrYuZgVdDQ3zEea+XEyX9n1J9yYdIbamrnyh2m
	zYxjrKaZZ36hndMuRWoPE3usZLt91lyLaLmCS/vVxRi/TVZSFiNDtt+9TORU1gZCFw/BlL8+P5s
	WuEL6GYe0aqw/JXzpvJE45EDBIc3Fv8p9E4po+BbuQTaqyu7Zs/8g082j4HuZXB9/NJ8dIv/I5u
	ZzWrqw7D0pVCespeZ9JqYOv2CK2+RIONtLqrpFjhbndwSESAJ33uxp/qVV+Mzmuf3zIuvw6gazN
	NZ4u3x+jkDGctW1u25Sfc91OSpN2Sf6tgobPFu2PxetetiM978fbedWp1sY5udHugQeQkbzzEZk
	foabje4imusrIMT5LoWuwENgz4lAWU4SxoLptJi79E0BlX/OraxsVxTE3ABlSR6el9nPnJVq1GJ
	+XK3mY1cf4zoOpESSm+Q4Y5xW/L5kZtYE+ta+sjLW0yZ9MP0+50GKHAJfNrxUysmMZQWq7XxKTo
	ft21nkNlcDiQTPHHkcn6EQJzlbPYadezHBZwlV+ktwn2aCTK7EMvNpcEqHQUKWA4DUWXYLpyAig
	kNHO1pH8insoRVrmnASOAzkVD7QzXi3c8IdIykRSI65NIo7fJGc9f8iDL5/YaZk188+Dr0ueqE+
	WIWCU=
X-Received: by 2002:a05:6102:290b:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7d6ba3b91d7mr855053137.6.1795010734013;
        Wed, 18 Nov 2026 06:05:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller
Date: Wed, 18 Nov 2026 09:05:18 -0500
Message-ID: <20261118140518.59878-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_remove_adv_monitor() frees the monitor when the controller has no
matching handle for it but still returned -ENOENT, so callers took it for
a failure of a monitor that is gone, and hci_remove_all_adv_monitor()
stopped at the first one leaving the others behind. Return success since
the monitor was removed.

Found by the sashiko.dev review of this series.
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5522d4397682..024960e9af66 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2134,7 +2134,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	hci_free_adv_monitor(hdev, monitor);
 	hci_dev_unlock(hdev);
 
-	return status;
+	/* The monitor is gone, not having been known by the controller is not
+	 * an error for the caller.
+	 */
+	return status == -ENOENT ? 0 : status;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
-- 
2.56.0

