Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE74CA260
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193437; cv=none; b=S35y1WdkEnHnJl+5Yz6YODgeW3czI082TwLfO7faJ5wcgDCzNUiBIRwb7KFcP4fLhzxW88DqBSlwmguT5ls6X4lNFDzge9k2R0jgUCkMZ8Nxu8pdN6RW2X35ML1QW6hJBIR/5dXabI7YtAEgY30c8PNMT91mGAtFMLAw/k1bv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193437; c=relaxed/simple;
	bh=WeXkrwj1eKPUkIMFZWA+VWyBwYWwD2MdTMvvr1D0Vhc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aKqccRjIvPP7Crvgs2SOawBzRE6eUAc6IHg/x00KYeHsHm4uSkfb50hpsLzU0ZoZppb0vcEJF5kATw71VGLcKOEusv3VA3KUV1jHiQHrkYowMJhzij54hHnRfUlXZTnJO1ZYEJ+2xlvcuLuHVNoF6KaFBcZZRPwcR2bvuOWQWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6tqKL/f; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6tqKL/f"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1353c2f35cfso12016559c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779193435; x=1779798235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RjrXqsdjWFnpe6d2e/n4UVXak4p7V9orzz2MFjsZPb4=;
        b=e6tqKL/fYsKfCzqiM1RUhRM0thFP951NxMGgrb1L7+FPqx03wtxnv7uriuN5ByVjOQ
         agNxqROFgAK4FJw1CdwmajQCKxFyPosweOCc5hObudkl+eRWiVtRGsqwG5lJanAc42Je
         4xqlqKy2J9IqxxSnA6fepojc43oB8OzbXW+bO8ZIhaP6UzxtDonEQl+mM3gVJIqoiy+Z
         A+/CM9HNV/sEuNzjcljvHsy5+SobK6Fsq5jq6Kygtcdt+OQSx0SrFZeEIWbfQLNenxFu
         pxldm//poeQuxVGj86fQajh32Jp0r9lSY/NyNAUEUFOOnQkysfJnOtr3p5b5P+2BfogG
         YiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779193435; x=1779798235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjrXqsdjWFnpe6d2e/n4UVXak4p7V9orzz2MFjsZPb4=;
        b=p+ejPraJ0lfVLff7o/774GMsL5BolHUcFrBWLSIrN2DatO4FR2+4siYELbmzFYsuxJ
         Z0w1qK8KZKi5SeLGxlPdlZw0nD2ffZzg2EG/14ujXbE9wmud+KA7iCQ+n/G2BpUE4qN/
         d8xncgMJBHeY4SVAfOROuOyEddk28sgIMelEaWyGs10rouRdI/genQJ4F6M6c0WNHjOa
         DjWg8/UdjIpN0h0e2MqMSB2BUFDE2tTr0k8AYRzxbyRQnug9WVIXO9+URxnCsUuRck1T
         B1JEHkOsVo06XtCNTxhE+IqExrlWAL4+BOMp425ZYcQWT1W54SxAI+y/cpSHRxGdeDDq
         LoMg==
X-Gm-Message-State: AOJu0Yxoljwk+cSk0mci9tfO9LLNjv9iYusnGnp+mroMujcVpDq635Ya
	fIdoPw6Tk+tngCgeQBqJEgf9vTN69DcB7oqzu27nu7YIR9ByVMh7XiYf23KzfQ==
X-Gm-Gg: Acq92OHBJVtf442x5ciGKksnC5DPT0VvX6oso184Lm9KX7m4cpSQBalqAFQc6alv2CC
	LSK+wxBokXwSovE7cA5KzMamLZz3EAeRaY+2R+1LzdNg53AhCkJ6n9IT7Bya2K5xk/ByFGSxOtb
	mbc9M9BsFS/ufykEBPrAfBHNxYaTrqeuuMEZFf73Rr6pjP5mOyBaQ8OfCHhducPNCSwJE4+78id
	JMrB5bYAmSHMw9p1PRVunihxeHcDm7Gogn7dcDYwsWZHnB7niQ46WMrgkylP414NhpQ9IXwRGzt
	ZaFtRXd9qztT4gY8R/0Tb+xLma6iDTCSCj/i3YXiv/KNqN81b0EJYjqlQfh8Dwo6zzDiVxLq41z
	vZWciDP1t6zSuDPEN7SZMaDeJBwvqdppsHV3fPeQ/4Q8uUQafmC/LJ3Hs+D5t/DHn5fugzSRx3Z
	fsFrS4jLjE2yIdKQt0Ig8SShGogOcX9g==
X-Received: by 2002:a05:7022:250e:b0:130:9f2d:ff99 with SMTP id a92af1059eb24-1350473a5afmr8718092c88.20.1779193434976;
        Tue, 19 May 2026 05:23:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.177.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm23406373c88.0.2026.05.19.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:23:54 -0700 (PDT)
Message-ID: <6a0c565a.4ede001e.7a438.1ab3@mx.google.com>
Date: Tue, 19 May 2026 05:23:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4097450477707795828=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/2] client/btpclient: Fix GAP unpair command
In-Reply-To: <20260519085016.188744-1-frederic.danis@collabora.com>
References: <20260519085016.188744-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4097450477707795828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097183

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.44 seconds
BuildEll                      PASS      20.92 seconds
BluezMake                     PASS      495.39 seconds
CheckSmatch                   PASS      250.90 seconds
bluezmakeextell               PASS      127.61 seconds
IncrementalBuild              PASS      498.62 seconds
ScanBuild                     PASS      709.32 seconds



https://github.com/bluez/bluez/pull/2136

---
Regards,
Linux Bluetooth


--===============4097450477707795828==--
