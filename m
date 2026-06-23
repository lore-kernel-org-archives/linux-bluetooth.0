Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF954652
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218775; cv=none; b=Lt1aGbRSTC09dyXZgDqYiWjIFxw429JWHDBW7ZXiUfGGR+5j2xpe/VDKOBHHwBmiLLKSw3SHD7UHPK1STEFDusrjtLZY0YIN6K3WFf48VhzdaDjcZLFNOqfil8FKv8oVZQeZLUofzhiC+eplzXgKAgPrWQpN2g7MGFfUzEbRMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218775; c=relaxed/simple;
	bh=m1J1Hxl6Bi6iNwUOjuK8EcITJ10mHnRQmRTC28V4mfg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WQl7ENwBph6KLyCXzqdPpz0zBs3Mp7+HBZQJeudaISbd7UzZNGhVL/jMZz5Z6N+6YSm2/mUZiE30+iuzcx4s5zvawD0ewtwFd7Z+NU2MFd3FDUZTRVLD71AmKBJ4Nt29gQzaovG5oHydMnEQQ205kiDtkX1eWN39loWaHuzbo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCwqHRe1; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCwqHRe1"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bc806fcf8so6327722eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782218774; x=1782823574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oWNHdYI9FHYfXEDwW2Ya3EftLN79Yj0AYTnb0ObkF/8=;
        b=VCwqHRe1eGUXJgfntBMcJ/NCzVjHq16IIHj7d9eNqH04o3EgetuJQJpSdLHHSAX5Ru
         P7VvEnZAjmWME37aMzFKCp0/QS5s52vpFpGXfcZHMa0GQY0s86XOuNb1Vh3om7cfmHsG
         dLIx28ZdExo0KNbsQfJ1Uc580HLk23HVw6UnLR3seIgshQGdypFgKkYg2w3N8FP3aziA
         KXka0ybKrzIi3BGb8gS2QkIzysRVcSjqLOHYjltBI3Q67icMHYVoYlg37z1CkG0rC4kA
         GqKtOk2T6uOHUbkPX+GO9O5I6SsMzGdvohjhL6eOWBoDgOf30B6Au3ROa0/LOVPqh960
         dPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782218774; x=1782823574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWNHdYI9FHYfXEDwW2Ya3EftLN79Yj0AYTnb0ObkF/8=;
        b=B+tVrVu9SlwXb0KWL9qqX2z/RgRMYX2xbFptFT6L83hRPJkwX8YuU701gIhbkFhSHw
         0Wrjqbn4V0LnbL6JIHonudSNuds/put1F44iMorHFQ0BOxdggry8b5Styh6F6JJFmF+v
         4xHLqQoO6Q6PRu6SZh90HgRFXDmHbDyeFMU9wUDcq3fp4F91L9z7myUXQVwSBGH8so1f
         0EQt5ICOCfNXlDFOai+xJGO5a/qPKWnftf1H12o3KG2jYgw6w5hf1AfCgcoBna+U98mD
         XxxBiFpaET54dPjG3OFa+hkqoq6ld1B45P8VzqT+9yrJDiReMzNKDoxkUdY06SW2m8Yr
         ntKw==
X-Gm-Message-State: AOJu0YwwgAh+ng/yFAucMRRIXSdoBwCHnYzi5sfhJeQGejAnhZT7uVuV
	eKHnkErnT1e6FDUp0g29U70+ognJRMDWyr1x0TwnIjoRDa1DQGFO3HjBA3kVtg==
X-Gm-Gg: AfdE7ckJGe/9o+BxDeozC7Ff5Fx1djb5hmZ1TmpKemvFUWbPIq6TdBzZ8/t7a4Yi1cO
	4OKbMfXXbh+1xrB1uNaAlN8nihcgHHbKjvU1b4+NqpXlPuKHVDZGco7HiASj7IGFV1gFK3cR6L7
	E0acwkz/PmF12ONflHm8VdG2mFYET/ZgiVA5aiWtb2istFnlOpxowAXgO6+/Bxy8ORAeoNhLTCF
	zYQXY003fUyxWwHGnZHTw8K43BgMsvEtc4BVjalmXybPKuodQwA+hdPZIY4yQpGxPjVLvAtmFPU
	35vp/dTviANWb6cnoZ1WQcO8i4xEXhoRxFNYd5d10ubn+Ix9715X8jRDqrFJ2+ASPLCq4E5w9wV
	wUYY68roojPH2LomPo2l//BI/7AH2wp5u7MJjYq1Ub7CYjqfyEBz0op9QqgbqMQ2Z+AHF1lxv0R
	y1JhPrGm6cGG0eD3WP
X-Received: by 2002:a05:7301:9c88:b0:30c:4058:3bf9 with SMTP id 5a478bee46e88-30c58c181famr2175626eec.19.1782218773762;
        Tue, 23 Jun 2026 05:46:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.1.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c44ec51b9sm8710768eec.29.2026.06.23.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:46:13 -0700 (PDT)
Message-ID: <6a3a8015.db4aec44.3b9108.77f4@mx.google.com>
Date: Tue, 23 Jun 2026 05:46:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0700028680537097344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, monesss315@gmail.com
Subject: RE: Bluetooth: btusb: Add IMC Networks MT7922 device 0x13d3:0x3625
In-Reply-To: <20260623114937.6385-1-monesss315@gmail.com>
References: <20260623114937.6385-1-monesss315@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0700028680537097344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115344

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      0.17 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      19.93 seconds
CheckAllWarning               PASS      21.83 seconds
CheckSparse                   PASS      27.75 seconds
BuildKernel32                 PASS      19.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      417.08 seconds
IncrementalBuild              PASS      19.35 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/339

---
Regards,
Linux Bluetooth


--===============0700028680537097344==--
