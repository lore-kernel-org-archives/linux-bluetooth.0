Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E763446A8
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372653; cv=none; b=m6PKdzxJv1witPZYidCZTBy/N4D880dv1xuuhVcG7nPbjuu9V10NWnQ3HM+74MMsRoBlvVHRbgHO5Aj60+MEQbiXJDVop8UtFQiewP7mwfVij5VcmMAeMqTKjKTPyEdtURH8j6UvR2Yb5gVYfp3FyKEm8jGSduWYYrprQIkcSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372653; c=relaxed/simple;
	bh=pDHfmMjYJ7FkkHTWva55wxqOq0R5ghYemTb6odUzTcg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YVJgQcfGyuuldcmkZvEuqlwYU+eNnwvyVfJf49jVeQ7jDMO9QAhXF7yAf0JOy3SIx4bUwO6xGapfTVphkTgxtl8BcIVKCecHWW8P8+4m/6E1kms1SD3OU7CcFRdttig5k9geZQa+bQ/epoVQ2k+WxGL7r4WNW0wMLWi5JsclHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrPKAbc+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrPKAbc+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so193314a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372651; x=1762977451; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uisvvuEid6r76NZ9dx/7qHUfHmXwD0Cg/pWhBZgOh94=;
        b=hrPKAbc+mRPfMN2QjgXohGB9J7Tb51fVxzWf9PK4QjdbxrDkDDopvB21zyQ68UJyJ9
         drcLD8uz/ziFNXLKARz+pnl7LrmBZI0ZbuHvs0onpDFhrvk+g1GJrt69UnfIXLPTecqy
         /y+ukZWKUfpI718XRcQ/5QDHk8mfTIoudEenWaTnjlsPCv89qU8mNw7znnVI2ePD9LqI
         S8SL2j/BhQDglkbxg0GiuWHj8g3K/dHSFNz3qkL9CtW5IRccPWqFLnQW+xLuaMz2Erhy
         dBTUj+aoLe8paSfa3fwMRf8v+dCvl7Goh0nUJXMyVeoTzbD4X6gn+5TNl1dwfpxg2wul
         mJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372651; x=1762977451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uisvvuEid6r76NZ9dx/7qHUfHmXwD0Cg/pWhBZgOh94=;
        b=nqmaf34qgBUnaRb6g59TeER8JHi9h6AlgNzuMDfLuQdGbfo9OJhf+TxCHfhcffrxDh
         vOohMkspm7YnHCEVkECBFDzyZY7AqhhntenaW+JBezLc9oR3hs6Dfai5GDuCZKl6sBDC
         S3GlgIKw4vu+mKL2taoqFHItm2GwNBoxqKjXtNEc5KaXkth67LyaKGc6IyQnBSF6IQOS
         C1w+9s9esympqQIeqQ+d7Z9SMko07tYXsTFnL5gQcEPMj5P5T/CdeFpir5UPUCA663XT
         cHfcFM62ahzt/Z2bCO/e0IS+gA505DEYTwcgtPFHgygTlWqasGHXuPKNFqX1sasuGzHD
         jjBg==
X-Gm-Message-State: AOJu0YxKZ5N/CZDy82ToWjRzd1X7C+PomWxfh6vwoOlbT7WpH7cuBpR1
	I4tKSGudrzf/AyWZS+03nwYo5nnWX26kvoVdbXdzup1B/mEE2xyWTeaOxPnyBA==
X-Gm-Gg: ASbGnctckzyGtOd1qNAz2yYJT6sfkdygJNLV1MMQhB+BZ+PFTYhhoCQDOOKWlfeEcim
	ATLI5bhNVehF1DtMv1eXI+yaltWS0TRgCC5KH6ck3n4DvlSvOeEuTNxXA+OS0IH4ng4gR0LTI02
	XgAiZxUm/7dNLBRRuD+JGMCRcPi28v57Sj9dSlqN3Tg501HVL5buYJ52d9Rl6PwRQNEkouyQ62Q
	6r3qiFiFh/r80pH/x17N60A480qI8fkCg2YPoFAyeE0eIOBjpoTI7PAO/7Ku/YNEFEEcTZ/Dx/y
	mbn+5E3XkAE9Y0ppqbWGJaWGv5oYi9eLxyCYBdOMtCpfpV7bWbWBr4AssFFto3BZhrSqvNdvSlT
	LA8hDxYHgpo3kysXFQjbWAQRQKZZ1pVsoJqyM5xs/WU62gIvsGV1ta9rJ2TIUiVy2uG3uid9b3y
	KRR7p+EQ==
X-Google-Smtp-Source: AGHT+IG2oZ/gHVshI/9EUuy+gilDOBxvamqF7C3RacpO5oGpmaMBYwryHBKNGceMZGpUM4RBUsV0aA==
X-Received: by 2002:a17:903:41c3:b0:295:59ef:df84 with SMTP id d9443c01a7336-2962ad11325mr68432615ad.3.1762372651356;
        Wed, 05 Nov 2025 11:57:31 -0800 (PST)
Received: from [172.17.0.2] ([128.24.163.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc1907sm3473225ad.99.2025.11.05.11.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:57:31 -0800 (PST)
Message-ID: <690bac2b.170a0220.2748e1.2236@mx.google.com>
Date: Wed, 05 Nov 2025 11:57:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6531573623676637842=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rpthibeault@gmail.com
Subject: RE: Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF
In-Reply-To: <20251105192839.895418-3-rpthibeault@gmail.com>
References: <20251105192839.895418-3-rpthibeault@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6531573623676637842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020056

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.14 seconds
CheckAllWarning               PASS      25.12 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      22.63 seconds
TestRunnerSetup               PASS      454.63 seconds
TestRunner_l2cap-tester       PASS      23.58 seconds
TestRunner_iso-tester         PASS      91.87 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      112.40 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.16 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        FAIL      11.54 seconds
TestRunner_smp-tester         PASS      8.29 seconds
TestRunner_userchan-tester    PASS      6.42 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.142 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.116 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6531573623676637842==--
