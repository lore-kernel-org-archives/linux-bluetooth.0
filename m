Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142583B0598
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424800; cv=none; b=l+3fGVeEnILQ3W2dsc1RRq1RuyDO9DfNABGtAND6bPqsTmpSJ/kOmiW+wn8H8AJGt+d0g/eYHWd597e8d4lXDS5pxmKMFx7SKOHSICCEenFBlcGjpTEzrOKcYW8LJL2rWwQjwTPn1ePevpLfpI0ZIHjLelrGqMVhX1SMlLL7cbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424800; c=relaxed/simple;
	bh=JmliGm0E+MknrX9hPMDV+Lk9nEBKdWvxQ2dNfdBRGac=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JVrg8ALNwrP0yuPNpDGY0qtVpt647Hp0fWrOOneykGZdXWJh/jj8XEQZn+JYzlZaB6g0jDThWvkKiXCmjiL7EuEdz5qaQwPdsmHnq2CTQQvvUHOfFsu/3tcDwuGFmaCn1s6tw7NXmhfD4jAktBHfX5pVzmb41Urfd3Z40UHnEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzgnhhTG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzgnhhTG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce98cb8165so9848705ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785424798; x=1786029598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JmliGm0E+MknrX9hPMDV+Lk9nEBKdWvxQ2dNfdBRGac=;
        b=BzgnhhTG8pd4QAGSPUP3sOLqRRlVqn6fkiJN9+tVUsxgjx5L2lljb83BDnfArUhil5
         9K4yos83T3EYvLL1/0zd6TI0AMYKKQdlXXHyID21UomdIuiEUsBjsKAOMY+aGYAxd9Vb
         lBcsQuUkE9K2u/22FmINc4iHjzNEOz1b2syjQml5SyAa2ok8ULLCkCSOLA2i/9QxLEp2
         Vz3eV0OMTIg2zKJ2yizcxModzBm6yZKXE2dC4VPOwPNRJXrTWKC/VqHsQnNd6zrw9nF/
         SDJiwlhu/9/vWiPt32ZK/u0zhWaii6ZcRrp0nRB48eGm1BkrnZTAsMjLTEuET0zG3KcU
         2gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424798; x=1786029598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JmliGm0E+MknrX9hPMDV+Lk9nEBKdWvxQ2dNfdBRGac=;
        b=MDsIDwgL0Z3NR0KRAOskUSwQ2pvhQzpveYCk7mx3hU9YvfAjco/9kd4U7ZFH6aXObX
         Zxgr+MrlsAD9u9xndwgcWYJCdOH/7hlWuiIKZF5mckwlcaLEo8yWLMzU83vvoFiT5Or2
         tQVprE2CvtBPFBuUs3s2qtzXgcKNBY+tcrq7OjvPUBtoAGtYDDJImjGMVDYv5aoUfJpb
         6KiA9jDwjFWoITQACYp9QEbprLwiKIH99adFFaGT7o+mj4fGvSvBpo/x13vVmKFILVjJ
         2NxvaKom9nayWC93COhTRRUXjMTu8AQ0PP9f7Fe7hJVU4XJg9UUkfqyJRbr6acfQ35id
         3cSQ==
X-Gm-Message-State: AOJu0Yz7wVvIWAy2LzB18ikYUCvXUYlY9/i7/ZrJlLjLeOnXaVepo/9Z
	pV6SfFKlb1xUqlAp8ONvgUMJOLSoYbnvxIIN+NjX2z9XtHZxoJywhDMRxIgJKw==
X-Gm-Gg: AR+sD13ukZcbxw2Jh5nXvoAj8TvRbaTO2cQhC+j0UbhupWJBR1mGZaXaLuFBcN1xNfO
	YTrNhOJXKEfYRRsf10T/tVyRvlvl1fVp8MY5WdB4+UN4ewOLmJUu+x/4nWLeq7wcolPn1Y7x9c4
	1PfSSOljyd9rRTSXH1+3JOlpAAit0q7FGTUtMLyTZFUiXovEumGmMbr1pOLY6tgZcWKHhbcA27F
	AcaQHFtMWC+xq6cQIYRSUVM0nxY7rFlzW3u8vrRJsA2W3+Om9VbNzJnfQs6fis2K9jfWOR5c+pa
	pzbr/P3H282Pi46KLx8LWaF27UIe6eM/3VejI49rCsb5Jqn7pAudm54nhSZ4vKsHBgP2JHKf6Ma
	z+tAfaYSyk5PotaZqRap9HVqQSNt8cfXkwG7DZckkvN3fOzpuciGZcl9jwaMrfPt/VA7X0rqQXY
	oxUBUQKv1HYYvTu/t8HdKTP5NADeJudIFNsvt/TrVU0caBW40nj7t/3oDQ747SzXQ8
X-Received: by 2002:a17:903:1a30:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2d03e1699c7mr7019905ad.7.1785424798259;
        Thu, 30 Jul 2026 08:19:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.81.7.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dca6a8sm22648757eec.29.2026.07.30.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:19:57 -0700 (PDT)
Message-ID: <6a6b6b9d.1728eaf3.3b8fea.4007@mx.google.com>
Date: Thu, 30 Jul 2026 08:19:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1332756465679683821=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, developerimalka@gmail.com
Subject: RE: [2/2] Bluetooth: hcli_ldisc: Remove double new lines
In-Reply-To: <20260730135851.78195-1-developerimalka@gmail.com>
References: <20260730135851.78195-1-developerimalka@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1332756465679683821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_ldisc.c:759
error: drivers/bluetooth/hci_ldisc.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1332756465679683821==--
