Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941863;
	b=1OzXXS4XrqjQU9f1inJf1Of23gz/AnXopEUk5/ey8M4zztRm5kGwy/Ub2EyCZtoUcOYf
	 VzTeG5F3QZGdXEreDL0Qre+kTilFR3Ddty+RXdVawTjf4R2qN2peJhluKsccpQiuPuItD
	 OJu1ZH3d+2FNYivJLSZiIViReIFrXujyJuHDGEVioa+1MYCK0p5HxRtpMwToxxtwbbpce
	 3jN2jBevXBbAzOGQyTvRshJwT8RD7Qi90o4v5LLVkrZzvuKCywwB7f2YlDWFu9rJWPzS7
	 MKOIjZvB9gCAXPkHl13mMJhrOUsyogYQBTcyA9XETwSIzeNEUgSRQnjOBt4jlE5idFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
	b=pMAr9eaVUy3Sjeq5wzGYd2Hif3G0MTBlmcHE3mTbBgXfmNdUKiBS68fHm33yRxgz9AOx
	 QEoxd6aqO2uEOZQMnj91JX0n22U8XRUmhR+tibDpomACYHh4R6+BZH5FcnHIoFoMEASTb
	 s1cSkcSfablOHPINtgNVMey2igpiksNtOvUWt+lllhkFwCFL7IGEN5PNbSvcRTT2P08Ww
	 n5C2pN8fEjmJQgE93tn31vxL4WMGEYwpe6b6kosTfd3i0bl9Y3fLZLdazMrDZKhbCXsPd
	 cOLiXuNPoJ9t7XbIWwmMdSF07NPmmS4vhMriWk7q9f3IyA5C4ht8UmGAozB+rq8AKcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zaJVGYhW;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482E606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D482E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zaJVGYhW
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7d2d1b4a83aso45326137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941861; x=1795546661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=zaJVGYhWKdqyftP8AsR2TF/F3fXnH1tLGSg233yDjiPsnyz48B7Ezmu8N88VYZS+Ov
         iUsfEM5L9YYnhV6OGI/YKwudTnvnnnAh2Co7iU9oY6iTdRveMcyS9fepy/hO0gzZGuCU
         dcyqj7kh1+cdkNAj19KYc2Q7N3om3fEbe3ip/kNT+Ia97HrbQHu6XVX6qHE1qFhgIfPH
         i//L15lNeOeF57vTqCDnKp84pIcbzAyC5fUukQKHI9L0h5WlqFeXirbM58gMpat8ie2Q
         yQCqrJnUAzssgcdMdGOchaF6nK+7A7NBo1vTm+9tDuhxa4f/aXO6+6v5oauRaIX84gGg
         ehiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941861; x=1795546661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=kCzYSUNn72PDBIQai8awWi7L7SLrk239mz3yY0kFl0HFQ6y4E72OzSvQypNfFI1A5p
         pj/YwhMVSQlH5WyuNC+7PkqaCm4117BcsofDWocr/WZUt/dHhe8UD1G5CWUo83HXrQWP
         Dbui/LajhKU2x+KGRCp/1AMOikMSX4KLVfh9Kf3lpY6VMxzY180q+ryH9MQJR1//wyIj
         wB+vjSsmxNd2RULJPSLTEiBADZXFQ3ZqlgFLPVy/XPFWG3o/Jma6fB4LPiLZnh2Gw6Yj
         l46VCNVHTDxRNlfiVhJf7c9NNdatoNia8Krxkn0DTawWRN5IRe97szxtncqpP5jCm+ji
         2irQ==
X-Gm-Message-State: APuU4Z83I4t5PdKvwUHoJ7IBsF+m/Z8RHg+/IAhjkiMV1q5xKaa1M4aA
	Pc3UJI4g5Je8qGKJnqmmTJNW9JFftEnrqxvtY6KpHYh+5Ur//7li9N4cl01uDg==
X-Gm-Gg: AYBFou0n2easGgZDEaPb3+Aaf+siGBOkh/5v+g8R1clJj4G1f60abji3of41iCGMxe0
	Kxati4SMd1qMp2mQ8m/phZUckbvmjTNPvaMdKhyVMeCaRYh7LQbM7idD8PtiVCae7N/Y/qrnuIk
	KroHsnPi2S0nGNU4AKzSSXWn2wM1bZWF7aT8dwF5z05whfvMNc3yynN2Gii8dgfqqV58ki0z4JG
	yoTylEZq6IlzIXakVFWcD92fGZs6c0zS6X2XU2aisI32/JfsUWoaa7VvAvhfYO/LHmVRKlwns7J
	FXB/tpFaVQ/XdXekBWPfS/wpWW0kC4+4atCkAx/mRHQG6YzCi1DMd8L39rHrdvCAq3eaJrVzx7c
	6EjYZjWuza5mmi9PZ6imSb2YhhWQ+L/WI0IQB9pqvJmUefhSsrdVpvZn6o1w9l2OQEzhNn8UQtd
	SyJFbwhae/9ZsAQPf8cKb5JM+v65gEXVecqRkurZAKf9gO0oOWaFIcRBQXjBYj2HV/52jk+pVgh
	LFfsKLPWC9By13Je9mPFD08eawvrizUX2UjXUP0j3s6eC6QTtnFYDVPEkJIg8fnSp4MKPeuAdst
	ehF9ERUCNDVAzom2+u75lhKwnc7BsePG7fQA1ae6M5iqdAcgDp/3XyDUSzVmCFWjX5lK8mLQI/b
	O5tOnaF1iQtdB9sZdb2CtOc15SaVWPMK2o6L8Thy3qec+1a6ZEL4a6CeGAxo7OOr9YOfBUPxKxo
	cdMAY=
X-Received: by 2002:a05:6102:84c2:b0:7cc:ccb:ce5a with SMTP id ada2fe7eead31-7d64d89cdabmr3819990137.28.1794941860829;
        Tue, 17 Nov 2026 10:57:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 01/16] Bluetooth: mgmt: Fix read_index_list() buffer overflow
Date: Tue, 17 Nov 2026 13:57:22 -0500
Message-ID: <20261117185737.3758255-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

The first pass counts only configured controllers, but HCI_UNCONFIGURED
can change before the second pass, which may then write more entries than
were allocated. Size the buffer from the total number of controllers as
read_unconf_index_list() already does.

Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)
Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f1738..fc0be4ca033f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -444,10 +444,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
-- 
2.56.0

