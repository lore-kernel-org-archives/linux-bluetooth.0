Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EEE282F21
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810042; cv=none; b=Ry5z4yEPPgsGtb+0iYBWXZ4Wd6VGtmW/aNuNpza3rwvgZ64Wzf2tkTs5AtLoVdwjG9tcwBDDAsmwcLOsCGAiNIZmHjfFMEigdXxvT69/uAaXWNbK4C3OWhivh3Dls9kNE8yqjBqoZ7gJ7Jpn/IpxaxK9974+x1rTGOr+NmQ3x1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810042; c=relaxed/simple;
	bh=rBU9zYp5o+oxzyG4Dkcn/1TYawLVipBvhYOkt1cSA+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MvmywZ5cEjAfLB14dNtYV4o+vnixYIz1HP5hxXN9QxXuexbyuNZeJsk/7TxtsjjuKwuA9UKI0AcuM20omdGx2AsSGnjh0dnhNo399Nak36ONGA5bS1LALrWlTnNb29+1abk41y1UDHPnmFmdHJYSR8jj5+gD6VIxYR7Twpa9Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4h2xbL9; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4h2xbL9"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso9886666eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778810040; x=1779414840; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=72B6X5fHOatiVcwSAR49cmfIIYlrqPNqMUfzeNkk5Q4=;
        b=S4h2xbL9jO+PtX3PuG1KRBE5c/FGKiCqL1MLuFt6hnclN0tfWyNNQzb6lp7Cj476HD
         TNcVEyWBG+Zrhd15ZcQXkWiSgIQaWdBv7XVJqvmJH0byX/z4XnrX9k/x6DR+2/m9qU1P
         EOmgG/byYoj63yqqLXeBy8fUzqmgBiU5jbrGeXYqBdc3qAI9xsTMTgDPGgCbg/6OZH9s
         o1YVAFKQE3M/UfjysrUkRn954d1aVxscqg0Z20HsfJiGsP6gauEhUboth01gLurX6Onm
         6nnsnwnhT8PlYw4oQvFLbCvuxevjQQiiO/HR3NK41Xo2fRg4Z1nySvAF/kHMtNetzVmG
         dpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778810040; x=1779414840;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72B6X5fHOatiVcwSAR49cmfIIYlrqPNqMUfzeNkk5Q4=;
        b=ZmYsMiiBAtfahrYJ71+NF+7YIlIaA4CIPREg3+mS12aHnSt8P3T5tIx3eAoziCE5xQ
         WO+VEFLGfuijM3m9JTGRXJZUR29EBKitcAuDa1tuPy1wOUNFuuSqWo1nKkO7xREb6WYn
         CORZPPmmalg+eRcx3d/KBulqDx0ur6BxGNzU+QzjHEGD3mT3S+6N3IfxXx5+HZ6hjGiz
         Sh8pA3QdV3In8LAcH8Ir31cqk75xcqAF0n6ypTHQA7S0Sm8QY2elAI2HJ+OiBXGnKIFP
         n3zAkxLfYuNyOqaYTTouMBQa3YpFX7vYTy+vjOPBPEJKifUtv1L8APf3OSMMMu+1OcIE
         QU+Q==
X-Gm-Message-State: AOJu0YyzPrJA0HPBqjOQM4I2EqIavzQLedKNbtI8nBSxiICEUKpVvo+k
	zCnOdz+s2lv0Hy0bvnCsVX+2eaz295vUpVb5Qs+TGIXos8DWBqSg7U/3ZAxUZw==
X-Gm-Gg: Acq92OHZqgA19izgwayWkI+AOojtLEKD639bOAoJTXfFQBkcE2XiMy8KO06zKl5YuN5
	Fm9BSuATzGozMDrA3pobuNcAHbHfy4tQSbxlOnKRP/pE6MzqQf0NJdz8CFSd/PIcm4LnRvhUf2T
	1jgHBDFO7eZAq5mPZl9S/z+5oekmbhKeixMJALx4xQPDzWqJZjBO+Sb2MbfmGkxqDJh/S+YY/NZ
	BwnrhsyPYAf6LYXnfiO8QlkH3q63l/2tegV6mdWlvNAzJllEkMKNbeGBgP7Qn3ZRxVoIC9xAvSA
	2y/7p/voE/MLVU2MV9GaNcLjPgseF9Fs47URF68OWrdkMYuaADplukAh6CbcwSRwW+oS/H8e7px
	bUQ8sKMdo+hjPFBtfV/3o1C2qkn0H6IIYdhsyoscAzzvgQ9IQ7n0j6/ywR4TCk2HnrcTU3sogg9
	x4VvxahrOhX6MeY/mJ0ckBFL/bb2S4t44RJhI7Ie9QGAM=
X-Received: by 2002:a05:693c:2b0e:b0:2dd:2ad3:f799 with SMTP id 5a478bee46e88-303982ac821mr976883eec.9.1778810040057;
        Thu, 14 May 2026 18:54:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.180])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm6140592eec.17.2026.05.14.18.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 18:53:59 -0700 (PDT)
Message-ID: <6a067cb7.d08db960.4b0d5.8b69@mx.google.com>
Date: Thu, 14 May 2026 18:53:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1028256654266954969=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: [v3] Bluetooth: btnxpuart: Fix use-after-free in probe error path
In-Reply-To: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
References: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1028256654266954969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095065

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      30.47 seconds
CheckSparse                   PASS      28.77 seconds
BuildKernel32                 PASS      26.72 seconds
TestRunnerSetup               PASS      586.50 seconds
IncrementalBuild              PASS      25.96 seconds



https://github.com/bluez/bluetooth-next/pull/193

---
Regards,
Linux Bluetooth


--===============1028256654266954969==--
