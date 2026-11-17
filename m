Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944614;
	b=TJArRrkxptpXoW/8EsFmk+O2cgN1Utjc9cICGTsQwTwHs0jQyjlEtCorO+hMnM7yFEhz
	 rH43Q73CD17cxHgaqJEiTPTRSJ39rDGgHgfIAoxjey+K9whPwYAIeDdMFXi8yGqY/j2dv
	 qsiyYepJMk3aMHw3NNcZ1h6qe3aOycPMuqmH2xIjqNqA6xNUFClf6lMpB1U66+aKCqmcL
	 h/givsZnzMID4fYbTe/BUjk5IjJgTA5J4i3RIaD6npVxHquCkA2v8SC4toac3RDt9HyM5
	 effrs30Jj9ANDyj/pwlHO93oRDzcM6F1ROAlvotxL1GHBngcJ28u3FCxr0Nj4dJtWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ATao21Ac7/TbRs0f1hf32Dxdlt5to/Ujumg+BevnNVY=;
	b=PHmt5HnBShKuiy4rV0igsCP9Taj3B4xE7wsqMzM8IjDGWawMJiA8rt46TblaIaiCd0z5
	 U5Cuhka56b6qFcOx0dkyPz7e+B0eYuXGcrmeiHxkk9wcDvCnER8YCsyHqncP1Q7eVSuap
	 rr/yeerobxRiwA3RIhCW0wylTjuiYTMrMFQiWZg5rNGrqUyWzFK9hZBPg0cnb+ZaM+pqn
	 XVGmwHpCf0FMhOAUtI2c/Hm3KTQaOQlZu2I8ByNn8wg3C6o077GA3Kidcw6ZdR+CL2IXQ
	 Z+Bl+gLx1vf0nkNrM6nN+SBlFqtP70ZLdHsRT5UBWm3bZHGQEeO3tMUlxi/+aaWPjeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHJ6YCDl;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773B606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 19:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0773B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHJ6YCDl
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b6b22be970so80309b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794944613; x=1795549413; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ATao21Ac7/TbRs0f1hf32Dxdlt5to/Ujumg+BevnNVY=;
        b=YHJ6YCDlQBYhtgfM4uwELJS2mPMlCkjuoQoXcWki2P9/yyNwNIXHzgSEhqOpeDkiPc
         spkrEB3C7wPOEDTJ3p8Pj33Gl3o7HhoCucQib2EoJxtiTel+7GzXRbrATdW0sAne2GiC
         y6Q/gsxGnrxnAQzEdt3qZ5HAse8YGpvpVcxxDhm1ODAC8NMBRVnonXftVHs3j25MoQjm
         ch+afH06zVFw5xhwJo1ywuEVGG1EzY1Bkudb2RbehUAf4gN3JZI75HVT6fXPS1WBAXXp
         yedXPgKRuBOx/JdUBr1cc1bPxPWv+HzjrakbZyAkvlba3Qly9NQTaigsUSAtt+D1nykF
         ZlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794944613; x=1795549413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ATao21Ac7/TbRs0f1hf32Dxdlt5to/Ujumg+BevnNVY=;
        b=TsxwU2wFWUZL4UzEb5UqqKfayq3Twg0vvCfwW/3QAD8njpX6PLQ7w14Yj0oXUvRBBI
         y/QSSXVKALxjfmjByCH5CN8E4AHlaJrrNGzv88+8Z3fKs8X7LwQfJkckMj6uJC/gyePd
         2LRcnyKEYCnESVGKgc7qD1nZ2FOllLMln5u1nkg+i5+N+kOW6x2QtQ3jWUbq5qBYSAtY
         MSSwTL1OdLyBRA4EypP792FRSrZK68H+rrKvPFUjz+1F0ZlV0PGZzM+NJduliLEILrcj
         jwJRRD2Ebg3qjPEhANdlVuY8OcEvf5ig9rZBUXGl3WnW4i+WWC8cDEZg2ZzcnvjVy99F
         R1OQ==
X-Gm-Message-State: APuU4Z8wuLjjx9injDas8E7rkBiwiPNzJ9DC2Tuy40EdYxFBwbt+xIrT
	LKQtqBa7r6p1YUdyg8Dq9j8St/WELvUQZCnQ6bwwqclMBerNdFNislNAfXXQkQ==
X-Gm-Gg: AYBFou3wvisyB6PXBg8Go3M6gQ/SU57XaiXvHopRG9yzktx4ASOIYG7FQwQR+Boj7bT
	d+oHs+BGE1fekhIF2Cr7Sk8iCHZwJS8XqPSgX5Ihk0ZZ8RD5dN6P13mOLWhGAToro+w+WFwgJ9g
	LADNY1ceWjjS+FoXfMyQ2Kr3WRy2nv0qtTGVEUvUtskQiDDXh14elq2R5lT7Dp8j9NpB3/eK9H2
	5DFRPLlP0ayLljUdJ2kFCUypNgMKb/9jIykeU6kp3QEoQp/5BL1dn9mKkPsjEetdKm9q6XHvd2Y
	gkjHAB8/TqqWRY/usYu5WD10PS2Edz4bN2u3838+jBkZNK5ScQksLrmoc8iB5kWTjSLAFtFkpC5
	pjnVrcs96A1kZq9iXIgy3mJFrZvFBS+jnbyUvyvGNkPyEOo6pVfonAGV5OIyfqmQHNDHnYfd/29
	qAnqZQgAg73p83ZwN20T48kPunsq5xgNfPWNSXo323QG3dmo9qoQwYmWjLCVkA7Tns1U/cHLzA5
	hn1J3PAWzPYEJELUvZubuBgwwWC3dGnzDmchau3sw/vp71it81oHVzUyMRVf0RbinlthQJysiWE
	YaCXVzd6x+RPbrRrv3xJ085mLyfrgivl0KX4MqEq
X-Received: by 2002:a05:6a00:4098:b0:89f:b166:bddf with SMTP id d2e1a72fcca58-8c5d578fadamr155233b3a.58.1794944613275;
        Tue, 17 Nov 2026 11:43:33 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-138.us-west-2.compute.amazonaws.com. [3.42.157.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb453e48sm82735b3a.39.2026.11.17.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:43:32 -0800 (PST)
Message-ID: <6afcae64.63fb8281.1a6430.2080@mx.google.com>
Date: Tue, 17 Nov 2026 11:43:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8937356594615386958=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [GIT,PULL,v2] Bluetooth: btusb: Update Qualcomm QCC2072 and WCN685x 2.0 firmware
In-Reply-To: <680aeb35-74d2-478a-a1da-4d70983b7431@oss.qualcomm.com>
References: <680aeb35-74d2-478a-a1da-4d70983b7431@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8937356594615386958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To record the empty patch as an empty commit, run "git am --allow-empty".
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8937356594615386958==--
