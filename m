Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F9214A94
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748460726; cv=none; b=tQJI3ps9KkkcQEZYdX1qgKhg2j8Q8p8+c7zzEkgECFnUQrTlQJ6XsJL/l919UVwBsI0xrsopZLgXv6L1amZfX8wJy2bqIA7pzoY1tpayVQXnuMmcLUG7zBibiPaprgpNRHLR7ym2AeF7+Zpee+kZl87Dc7nSf63fMIbbvg9zIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748460726; c=relaxed/simple;
	bh=IxP3zGgvApfb4shEnUH7wwAIE3bU8gdIXIFotdpVQUs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T+ILkQwsPcIESsFjNxV4nQSX2VbSPZb45sqUSWC0FQfNpe1tf6vKtsvmL4lkOThgtVo3T6Pg5zDRpDnCr5C6v49I8jhNpaONW7KWMLJmwtFkCLx5uZPmu7cHtO0Uigla80wYDnudKIYwPRvZIy2qLsiF4psU67unpfCZPcR/ZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O96olZZG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O96olZZG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so2913156d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748460723; x=1749065523; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2yoGif77Y0XzigKwzybJeYT812sU3aCgUgTtTwU8uJc=;
        b=O96olZZGzqxq3cPhBveCyrAZBZv1klkEsZAYdZCSOpjMXaqCdtoojg5zw45zwZStEn
         liRc5QkYuRHfvO2bssmwNN6xpdn97qU6bVAO4RaIb+I0N4cSwRFuqRm+Xe2dotQlx4n9
         VpexK79zSF+xrA9pLwgBhUqwDWMoZNazc2ikjNK0kJfhcOxcVHFNkFLy4adNqepIzQMS
         lMtje3r/CXeUX9wsK5vic7+m66JuptGyrUMh8K2pGt87NBv3c0a5BRqlI0oNR9pfcTJg
         e95mJFl/2VwxjmfnmVSRBEPZZogYH8t1fObzF+K8S24BiSAzczMkLzf4bhHD1ehKslPW
         2lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748460723; x=1749065523;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yoGif77Y0XzigKwzybJeYT812sU3aCgUgTtTwU8uJc=;
        b=q4RrDFi+yxx4vWUZ6N3bIh6jeEnZjbA6m/5In4v6p/OlewlxbCiLzK2m+S35UjgzKk
         kUJfKO4wJc+vDj77aFVCSmZWiZPErjcln3O6wcTVljV8QGoy2poImIxbH0+I/nZ5Ud3D
         CNiie50pLxp/Nt9dzn0GWb791VGizFH+rnbTdT+kVHi703/pPZbqv4ritrxOWyANG1hW
         1ZI5TEniBOqyMblJMWeRrRGJG9Q9ZIZp6S1x2Ga9rLonih/tMBOXw+HeJUsga74T7bxe
         nOfuzFY4Z0ofwjfTCfsnxjkvgbwkQv/aPUIQZPN5k9cBK3RUySPWzof4DqSDMJSdGzxf
         JFsw==
X-Gm-Message-State: AOJu0YylLRe7uPq4nS1pIVRETXof+iR8P9kMpRdx5yKbSfGguLf1zXWH
	+EVxcX1vEU3ZcParHtdVbJQWCCgh0oN9zc+I+3NZCelA9cvUJ4kllqjW447Adg==
X-Gm-Gg: ASbGncuJ+f25fX0I1yrPD29W+3WcwNQwqnkY0QYxLb/bOEfpR6b/9WbeE41rh1AVAmR
	vhOzUPX3i6nCq47suo2Yp/AoA/WR2T8P9LNOe7WHt+KyEBAW93SE06UV1NaDqT8EhVoX2W9tcfL
	kaADGWd/w4LVPyolKTrMp0F044BHFw+63h6xvJY2wiRHaEqfPOQomfElpAUwfE8J1SZtWwbn1Ev
	WafN0Rb7oT9AW7h08Kmuq3aO8XQeADa27l07OGEbqNJMtnCoDj99L2z6iSiFg0PGaebp6rEVFuA
	UKNAPF62uWC4vT3AQvpxxVE5uLbbgL+vQb/pyEV6XKHrBHhDAVpQJPjYFD4nR7e+OJw=
X-Google-Smtp-Source: AGHT+IGRIOC3zmZChFfWRO8YO6ZCyugRj+yj4Fb1A85l9Xky7Cz9MB3Ll7tSd7HEZ5QsnPvUwlqJ5g==
X-Received: by 2002:a05:6870:5d89:b0:2e0:15a3:3b0f with SMTP id 586e51a60fabf-2e86207100amr10893740fac.31.1748460713370;
        Wed, 28 May 2025 12:31:53 -0700 (PDT)
Received: from [172.17.0.2] ([13.85.44.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e8e1722a6bsm369221fac.13.2025.05.28.12.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:31:53 -0700 (PDT)
Message-ID: <683764a9.050a0220.377023.2086@mx.google.com>
Date: Wed, 28 May 2025 12:31:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7310102834092956990=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION
In-Reply-To: <20250528185311.540919-1-luiz.dentz@gmail.com>
References: <20250528185311.540919-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7310102834092956990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967104

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      26.47 seconds
CheckSparse                   PASS      30.16 seconds
BuildKernel32                 PASS      24.50 seconds
TestRunnerSetup               PASS      459.26 seconds
TestRunner_l2cap-tester       PASS      25.15 seconds
TestRunner_iso-tester         PASS      39.53 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      132.26 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.14 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.16 seconds
IncrementalBuild              PENDING   0.43 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.164 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.200 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7310102834092956990==--
