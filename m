Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9851E1A3B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319975; cv=none; b=eB9x11JSeUAvxOrrEETFoV5KVypUoROvhPyon7nBrESVCOM5oJaO5DdLhfWWt5epD214lZsSHtKY74rHbIVl8DtM8bdWdTM55j1ay+YHkzbxTdegGWZIomIc+C/q8/uWIykPEJBcPCqgdRfwp1OAsTCsuKtiqyECK1RH5UHdPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319975; c=relaxed/simple;
	bh=IvbB/wjdh42efpGf3jzaXg3qIp6zSv7KmLvz2aV0XJ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TSRHsjrvmbsOzf8b6/x/3cq5Rk5u5JFzbsJ8DZ6Ctob7wtvaYrR2QQqnbdpzXx/2YRihibaprKeFMZPy0QAHLW/CsvVm0+r2jio7wIZRWTstenGqcvNzKL48JiIRueq5Y13290pch8a8FoDQYFAA99P5qSQG3FO49TjS9Riz47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQxMIKjT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQxMIKjT"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6844074e7so516696385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733319972; x=1733924772; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IvbB/wjdh42efpGf3jzaXg3qIp6zSv7KmLvz2aV0XJ4=;
        b=iQxMIKjTavsJsibo9ikSSjOkQZRha1GFX3qSYE3Bo27/kFEqv35l/nCa/39o8MZKNQ
         BUvsGY9yFc3SjB554hDNU+qbzhedgyHbx4SEjptTDl4TpxK6lwG1yGwYdo6MYn2C1U9l
         +KPAMqfX2LS9U0BFQ3dHL4Q1Jt9GASj/xjhiBA+A0T2L3KoUo6chpzqsEDQoNbI9VAaj
         KErN3+ATnPXqwN4YtQ3eyOwJuh8bPNQXtaRVeiOA9ilcifSgA1xTHLzQ7weOmNie2Qb6
         L7TTIR9Fo5bO8cmVfBeaXI3/GA+dQEcfvF/DrD9bDRBlaRwwR8249PL6GboYSxoPF/TD
         iX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319972; x=1733924772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvbB/wjdh42efpGf3jzaXg3qIp6zSv7KmLvz2aV0XJ4=;
        b=itzSC4J8YsZJmZsx2S3QDJaMfcJgumNFq93nVRvmD/NxZdnH2inTuT0JqJhSI+SVKN
         hFbfGuP2mD5/Fn5+B/u4bmV9SHt1OLNvmDhQdTAH/WDMODEt2MoRM9nvPJxaM33RnjxB
         gz+8InDLbDnovydQHyN/6mLzYvceA08vENLJflmk5HzfWZLEV4zD2+tBa+A7QA/FsPeH
         F4QE09yee4FR9L/ZouTZSE+QyRtNCZO3IqoWl2zEuWQ27MQM3k6vTVnGU8Bw1rV9deF5
         B7ljMkpFvflYGKWrCGfRE2VNLT78K+xNUwPfinC1KGAcl8pKqcD9AySCzfcgKVKn9Rp7
         OeBA==
X-Gm-Message-State: AOJu0Yyluze+t6nGEn1aj97nlsp3RgWFPJi2HRJatkJg1DwUI91LD9Si
	r2+ZsrMEUWYXw2Myaqkok8WaH+VFNCmaTHnbV/yXxXKoG9Y/YKRaIENlOQ==
X-Gm-Gg: ASbGncsixQYpRTCR1+28s7BUp2je3AQ5NEyMr6FAYzs6IT07b6GV9vCvVkwpBLE3RzY
	P+uPR+98cvu0DQ2VgOsdIYIxolJyTtwI27BzguVx34YrOw2/fZuiGNjHmDGjP+Q+reue/NE71Ca
	9VPghafEQ8vRvod54N25u2c/mMm0dY3LURwDfB6yuiy6cFpW3YC7sz1set5zlwBHkmI1mab5ZMr
	XiO65JPQ5FqV41Ix7CdPjvBd0p7k76cCyKd6bsUiiY+bMK2/Yl15QLB
X-Google-Smtp-Source: AGHT+IHnMPwcVTLe0vqdWNWiwbNHI/TBaXTTRSNaakYlUIkIJ5Rg0gUKbNw00yucixAzFGw7z3Djlw==
X-Received: by 2002:a05:620a:4481:b0:7b1:3b33:521b with SMTP id af79cd13be357-7b6a61eae65mr778539085a.44.1733319972180;
        Wed, 04 Dec 2024 05:46:12 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6848981a5sm610529385a.0.2024.12.04.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:46:11 -0800 (PST)
Message-ID: <67505d23.050a0220.11acc1.3f5c@mx.google.com>
Date: Wed, 04 Dec 2024 05:46:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5664883182669223247=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20241204131706.20791-2-quic_janathot@quicinc.com>
References: <20241204131706.20791-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5664883182669223247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/pwrseq-qcom-wcn.c:293
error: drivers/power/sequencing/pwrseq-qcom-wcn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5664883182669223247==--
