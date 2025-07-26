Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F61E9B0D
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jul 2025 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753513941; cv=none; b=Tp75Osem0i9MIowKUugn+ruips60GcfOM36/ZpPPVlGvx4rOUxbyFjNGm6CPxAsd7uqnThLtDYw+0oy55SPni5QMGRAESAbx1hkTM9T+lrHq+pPeKROZndWH2Y34stYQb+2uO4uJwULAmn5mxDMqFHZa1/viBAUoMdfn1ivyKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753513941; c=relaxed/simple;
	bh=d76dv8k+dWGQcaHF+vtL9ROHbvRA4KX4dfHQNscwpuM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fM2PtsaY+0HPd9rmDYXEPhp3p1JtbzvFoEApj8bfU3anNHlxpjF6uvXjcqnwG4KoEgAoRS0yVy4YmUtOmyNBoMpz36dTTs3RdtRg4apDV3GeDzXVhO7R/EUQz9laq9VbPP5eBdUGfTR7fHovM25R472Ugk9F6KVYXNvPGIeNOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7tBQyvP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7tBQyvP"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4abc0a296f5so36891741cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jul 2025 00:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753513939; x=1754118739; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A/rJDOSXV41ZPfe34FRzbix52zCmVRqKc+6fyQp3gBM=;
        b=b7tBQyvPagCqFS1O+nLZmJdrSn5DZNsy4GBjs6XHRN+hhVYEjXb7YlARMBjS+Xbq8m
         blLGfu2MXRbQuyprEisRsaub0mpSvEn+l8pCQzZcKf/MMNvJFP/kiXw2rUOozQy8j0lz
         b0te8GlizJjxhBjF+r4PIorizw+o0KLJFQp0QaPiT84OKXmyoySRQWbwTgYouZxCXGHa
         7Qpr7hUDfu10BotW9WYSgNao4/DFVeeJT9ira31ChI0uYcJ73ALSJWU9WSWdvl4n1Ysn
         xBVibR3CLi8VnyW8NinM55PJfxdQcbyC0pQwQf2ffWC4LscTTH20//CzOTbS3tpa5MSb
         rj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753513939; x=1754118739;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/rJDOSXV41ZPfe34FRzbix52zCmVRqKc+6fyQp3gBM=;
        b=Klqju+BHITZapnVK0Fn47sU0qUPISNAMhVAK2uR6ffhnSRvHlw4kGFQcG+UufyS1dl
         CZJPEfUuTihx+ECSAcO8UKWsrs6d4dM53yf1qB9d69k+Tv7ur/p/Ox1wOPJGAVFn3yC9
         zxjkomTwLviBvzLVORPuO4S6LsBMW3REmv73M/2v7+WJO6ZLCa51rRGdeqIfTYQx3z/B
         n1DwtZUzJcf1G3MFZDtXgKKK7ZCCjuzk9fOYMm/QLYUne2sojBFFd+6vh8Re/2wGnvbp
         zNT/F29VtB3Ajd+b8H5ejKuTKssxQKYSvn0zQWOrWANDa4sRldokHf2MzalIH8918oYK
         zsZQ==
X-Gm-Message-State: AOJu0YwTdouUMPjw7WG2JMVuFoo/yr7RS3mJ27hEtp5YLGDJubLX6YwX
	UKbL0KUn874wukEBiW43sX+qq/b623CAMygDZ47evnBNGyGiDZQ3MOpWlBFBHA==
X-Gm-Gg: ASbGncs5wPt4qOmlZRkcb9dztWudO/rhoNQNqycIwLjSymQqWIgcrZqG53yOn/3JvEx
	3HaMD5qBMnPWz3mP/gKJI9qyPafEh+WB9s/0cBD7jwGAV+savSBuI0Nd9r4ARC37VnM8SuRJAL1
	Fm0aiUMnthMmTR/EJI6rc9a86rNjyZ3liBTHugH93CcT+3A0RNLEav0vDbHtdIThjB0H8ZsUJ8M
	sH6JiVCDRwjrVHQUYBtB3j81dO7OkxSGuRzbBv4lD8251edNf9jj0vhOCqY3QzJ2gVFvxrGnkgI
	Hw4ydQaJN/hhetO6pWQiHoWBD5efJWHP0wQIOTICpECl0RXKBGY56OhduJpyFYF/daFp20PV+m3
	onJg68PHoXfZgE4x8izFxnuEB3tMPbg==
X-Google-Smtp-Source: AGHT+IFOnGMpDZRbENUXz2E2c3zBIdlFbX9/DB+IBwRFLw21oBG2NrHSP24q/80VplwH7SN/ugzc9g==
X-Received: by 2002:ac8:5fd4:0:b0:4ab:751e:9d97 with SMTP id d75a77b69052e-4ae8f1ab51bmr55523901cf.49.1753513938859;
        Sat, 26 Jul 2025 00:12:18 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.103.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99565850sm9084961cf.28.2025.07.26.00.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 00:12:18 -0700 (PDT)
Message-ID: <68847fd2.050a0220.c5ff6.5f7e@mx.google.com>
Date: Sat, 26 Jul 2025 00:12:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8855901503235507619=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: Bluetooth: bcm203x: Fix use-after-free and memory leak in device lifecycle
In-Reply-To: <aIR0ekNXjuLs6IWa@pc>
References: <aIR0ekNXjuLs6IWa@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8855901503235507619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986087

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.27 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      30.43 seconds
BuildKernel32                 PASS      24.47 seconds
TestRunnerSetup               PASS      483.66 seconds
TestRunner_l2cap-tester       PASS      24.91 seconds
TestRunner_iso-tester         PASS      35.99 seconds
TestRunner_bnep-tester        PASS      6.10 seconds
TestRunner_mgmt-tester        FAIL      129.17 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.23 seconds
IncrementalBuild              PENDING   0.50 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.164 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.961 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8855901503235507619==--
