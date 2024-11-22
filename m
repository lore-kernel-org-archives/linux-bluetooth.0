Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B2376F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732249133; cv=none; b=SDlzPOYqnkTIibnLzmy3HA7RFcFSM2/R1fJcQSkqIKQCVuZJtJ5hJFlE4Y/FV56li9wEod/4+PIN33/6TS/Kcm4ef35bOcHU5UwGPzCNl2BhqKi8Ah3GqSHJeccOJ4tkl9HsS8VIIpBIYlQPgtzFBnqaSfFJ+keX/y9S3lnreXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732249133; c=relaxed/simple;
	bh=FJzlTsJwaaOGB4t6x79ZuEs9JmrnDE5TjAwvKuv0TEE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PieX5YmC0N/LV1jC4N1K05XjbnkCw8NwMwJb+hrQJvTtcWQvEF5onM8M0vo03kTBdpjkHzi+1mYTqUjQu6cf3OwPqXhX5D1kWS/NqQCB3rxaWmSI/ol03rpsnqMMlvyrfagndlGwsnzjnDuJCzD4u2DrnbSvCh/kj52tj5zwkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKUW2blx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKUW2blx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so25302b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 20:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732249131; x=1732853931; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FJzlTsJwaaOGB4t6x79ZuEs9JmrnDE5TjAwvKuv0TEE=;
        b=PKUW2blxNv9XFynQXbuKSt0XHpZMshAtD8ZnxawiACVX//LQcKjvViJweRipgsIlYx
         YZrZmZ/QGT6sfa6mfNCn7uL9fp6VL4fzJAc+xkc1KjblxgrLjEP7tcdjtSTus0yHK+0Z
         ciUoIFVNcZ0kzDfKqdYx8YkToziQABA01M9MIg9169w3SQSAzXRjhuOKwToKlLv4QM0z
         AS14xyxNagaHYnsiaq6F6enI4ys4fSItb/j2BcYlK5h1QZiWn1FKNVV/Dj4FZ2EGdC/i
         u6CJmg3WXHkLvRyAQtuWlYxQPr+UdMz5y5xJ3lIp3kHOEwqJg35YG0mfcmKCHl3j3mDC
         jMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732249131; x=1732853931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJzlTsJwaaOGB4t6x79ZuEs9JmrnDE5TjAwvKuv0TEE=;
        b=vsOKtPDjlH4kvqVun4XevAd2BtWO0HFpKUc04Hb5csAmS+59hhVhPCliTsb0bN6mcU
         63+rdYX+sazBnGA47ilGg1/R+rb2p/hyP4LgTu44egkIWtBDGCosSezrUWEh4JTxSXr3
         CuYaueYYr23NrUP92z0YanA09fv4MckPnerOWSgwmuOU2SFWmGXJk+34WY5Hkf58r7UJ
         Bn06ongrlOKc3Kw2Kfgt5J9z2GTl5yZQ9NFQk4rqwNd68BrL06mhqH1gm91bAtUm44LH
         45iwlcnViqwZKAkafVozaX1+EYDrDXTg9wn2aR6DfkBQPIU1TkB731Rcfir9jEmJwuo4
         0KVw==
X-Gm-Message-State: AOJu0YzocanDJwKDsH0amRrcnSK0pscCPxeIIBbXnQgMsUYL6U5xg2ny
	tRWpnVR3lsnoahXkjdaXFSEULRqU3FyHJ9V3E2EbWkkXJ/Or64zhjUbV0Q==
X-Gm-Gg: ASbGncs2QBifPpuqN8O2jz4wraulYMl0CcsdF99Llqe6KQ28lnJO20QSdrgn+gMrMsC
	huVoIVaEPPoyC2rsvxrBJau5UsD92XA3FojrDkaqaKuUsieJ8oHJhIrukgLK58H1dLHgNV1ythr
	iB9M4qWtf+x5Oi7qdVM5C4T78iixe0cGmetGsiAPWUy51M7mX0dm2+yhN3OEKZlJtWwGc4sLCXb
	bsODZFsUZXl/tDzaYAdkwiN//wZD068/HrHCFU4QGhJJiIemSkVlfA=
X-Google-Smtp-Source: AGHT+IFI+YyLnIuLsYQB2P1Uz0Ztc6vsMGlTNr6xJDktT8oBLabCNeacmrBSSJHU+RaF3ozvRNBRMQ==
X-Received: by 2002:a05:6a20:3d8d:b0:1db:a33e:2c6 with SMTP id adf61e73a8af0-1e09e420a72mr2251054637.18.1732249131322;
        Thu, 21 Nov 2024 20:18:51 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba27dfsm6397245ad.111.2024.11.21.20.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:18:50 -0800 (PST)
Message-ID: <6740062a.170a0220.2f3b46.3c1a@mx.google.com>
Date: Thu, 21 Nov 2024 20:18:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1588064847071947133=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, j.alan.jones@pm.me
Subject: RE: Bluetooth: btusb: Ignore Nintendo Wii module
In-Reply-To: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me>
References: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1588064847071947133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:185
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1588064847071947133==--
