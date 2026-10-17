Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F079367F26
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266041; cv=none; b=Qrzial/0WeAcOij7UcAdIwmF+O4jxtnRRrjZz0tqjbbb0Q5Pv9r5aVAqMAYn+JWFyofL9iq3TKOgo1AwVPSUnp3hArlgmx1uORG/u7s340g8/RDMRIJNAm9VA+srq1iStGxKZ4lSjI+xz5fLvrKQTbaqQqoUrFF8P3W5jHNH+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266041; c=relaxed/simple;
	bh=WKBghXHnI7cO8HgkZ1wO9oKdoY/M6fZpyMMUYVrImFM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tx1eZ1ItL7BioL7Tw8H/48VH2vb4g4sB3E3GLuOKf8avBHJiAll1KsyRvgRPzPbfLrtQTlztckmQXUDxVRtBo9ddBv9CM/SmaOKQzNIk+QLcXHx+iz7QxM+HNP2CFTkOcVdM83R8mD3T2rDUbMCJE5F34Uc9wFsm5uUbWNFFF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egCBv1KC; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egCBv1KC"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15943c9c005so706570c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266039; x=1792870839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WKBghXHnI7cO8HgkZ1wO9oKdoY/M6fZpyMMUYVrImFM=;
        b=egCBv1KCmQodwKoamX49AT3MW/oXvja8u5wSnigUJyMdO1xqjGksJMEgFT0yXbINZl
         YZenHqrDV3+byp+nM0+cO8TbDNtdxSIv1NlXtBxdZ7L7UmrC7Qi1fUWZwDWHzpeJbyC5
         KZ/CHRpAb1W+/pQPueGaVbx2r1bRBz9RMQo+NyzlSCp3iZYAwJppzP264QCZZCD/jKT/
         O7nX7dcEsFflTxI4IowomoIAHKwMC+dpaP+aNqwJyNX6rzgYC+R4fqVHqFbEBtYxWFQz
         uPXbSwc04JE7LpbATh9EXKPK0YnXaL20KwBRmIr0a05Bi+PB9Tq5IBYCEurogFQaintX
         CjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266039; x=1792870839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WKBghXHnI7cO8HgkZ1wO9oKdoY/M6fZpyMMUYVrImFM=;
        b=Hdb0MrwlOlFurHu63fpm80hpdBlh8lDhaxiioYU/LD/9yKzGCe1ayTnaOK56sXOmho
         UFW3ahhmArCi25K0EOpXDHnKfU6eHLBcLCiacLrtPolt7EkRnqmMMgUleA2LLGhcn0mp
         eT3VtFOT2WwMbse1wUFMVETtJDSRlnH31sQ0HFptQhDYB6n/tXqalXw1hsH820hueGkE
         5u66ySPk4PWk26cXLMR2yrNHkjkBHrbRRqlVfGbXW2ojJOMz/G5uSqcYedQWcrEE/vRA
         i2R5ESjlNJ8ZTv6lenTAy1B65qg/emX1z1UrxklVkpIEBnzJBkOUiYA/IAZsnV8xGiwh
         aH6w==
X-Gm-Message-State: AFq9FYLROh0gcK5Z8J640ljXAra2nW8NWkuH3KFtVvytzHfmY7D4j+7h
	CiQM8zIXSaRDmO9VkV+ECjPWRSQukPuoBs+0gknbmubCnkXzcZXyKJ3AX/WCug==
X-Gm-Gg: AYBFou05F1HKfmI3B2kDIKV7Fx6x73TFbYmSwOSFbf1Oy6OeSGxxyGBR4x6kH68+neN
	c89+P523CkZkEAmJm0K8/u24e2yyIuNBBlP1oIxforVXDc8nEvbHjJNVyY4W3uXKgo04O5e1l0g
	rLvAM0Ijbcro4yxJqbTkZXsMW/Jwq6MPQ7XM1YF1Y14lJDeJJF5GzRux5WxWbWB++vUpSfPEbW7
	XlywB40vwlagUYwmC0eSN0z/osPGhkotxjlAfw7s1KtPoRvBc/Qi2NGZkxIsfDj6FcdqGQWFE8n
	yVjYezomdsGqEqZGtfGlvv65qC/FIdBU230rZHg38Rm+0F0u7f4ByXVBA8GZu3Y1XaVxZeiJE7M
	THuWjlHmiZCNqZO3zXrkJ4Ss0lxPrZHqmZYV+8IHTh05plsBTIVKwH7cMKTX5QuMMIvZetovVZn
	nOZT/KwvUvoPIllkt9WCvuxnbK66CHo6AQ5a7CONppnE+Gfq52rluETs7jvSc/UKYcYWZm3Qxu7
	hc=
X-Received: by 2002:a05:701b:450b:20b0:14d:cb67:afc4 with SMTP id a92af1059eb24-1851453e5c2mr5345609c88.41.1792266039017;
        Sat, 17 Oct 2026 12:40:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.2.200])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ca95700sm15858184c88.23.2026.10.17.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:40:38 -0700 (PDT)
Message-ID: <6ad3cf36.e8a50b02.358f0f.c64c@mx.google.com>
Date: Sat, 17 Oct 2026 12:40:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8582478484150403092=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wonkru-dev@proton.me
Subject: RE: [BlueZ] build: Do not regenerate internal ELL headers with external ELL
In-Reply-To: <x_EJuUS4KOJ6yHSe5ZA9ec4KemaHtdtTbgUuuJapF1iyjOWRcoz0WkTMwRnZD2b3_dY5baLu3artXUCE52dZF1lo5xAn2_sU01Di8oPiuUE=@proton.me>
References: <x_EJuUS4KOJ6yHSe5ZA9ec4KemaHtdtTbgUuuJapF1iyjOWRcoz0WkTMwRnZD2b3_dY5baLu3artXUCE52dZF1lo5xAn2_sU01Di8oPiuUE=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8582478484150403092==
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


--===============8582478484150403092==--
