Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDA37144
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608036; cv=none; b=PR3iVDYz35NOevXzGzsGa2/0G8FSa+cQ1xyBsTFrFDByG2LIeS/2Tw2qpleYdRbG4IuYeSspV1S/57iszafr6b36RgcAKKV3yfPPdlmMU40d/S3eb9etSwDumGgY0TsaCR2UhyJos1iGc78RT1Dhx0ZWLdY7iQoICyjo6dLozQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608036; c=relaxed/simple;
	bh=f0hKzNQTb1zRYF8/t/V8vEdFl7GgTx6xTUMCcbRCsNI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eT/DEADzgIfcxUh9MBIDiDSbhceFjg/11DMhtCtL4hw7Y1MGXcIgaEr0pC6MWFE8VuBgqW3RHg8LdUOT8LzyQp7eOmyAmpaWl4F1VksbtgXdTD7pVR/tpF0dOqqJQLxjMswGxXzp4mwIcPDJCezWiicLi4OBlrPTFCB4bAidPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYWrXCI9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYWrXCI9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1e31bc1efso374939885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 21:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723608033; x=1724212833; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2AzOd2+tOaMxXXcY/bLIJvWg3goiBPu0sHx8nFpFAHA=;
        b=IYWrXCI9gsF1oPWk1Bpa1johVnaO0mdBRcIpus7hjPWH20wQvq4CtM5mtzAb2P+i/B
         Yw371LQ0sxbD+LFigiDGpvCchBN0LEuE91v13aDHteESjULRe/ehfJ209bTtjur3Wz/P
         u1+xM8V5NjRgTYg6RGyH0vk5COwSoIkkTo6oV56s7ob2e44f4QwVYRmOqVIEzrkr6JSo
         gHQHvlD2t6ylJSc7If8K3CORWEVhIFKP2R0pEwZ7bgbgLuKQSthedXTnoQYQISxVV6Jz
         4TH0uyj6i/eY9XjQ1cxEZXo12OPqmcIzkmPPO43GwS2nVUMPbjpbtdqCy8+Pz0qo4fFB
         rZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723608033; x=1724212833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AzOd2+tOaMxXXcY/bLIJvWg3goiBPu0sHx8nFpFAHA=;
        b=iiUTgVNW/VKH74OWbp407NWzEY+Derkwjsqyxhu089wEw8Xt59ZUgQXj8bag0B46Ss
         1juwIwxsbpNKCkx/Ag+W5bE/9jhi2bJ/DZR7XX0lGn+6MMWqzu3t/69dSeBD9K52YVnc
         A7iHP8oG7WWW/XH7EhcRH9J6qQebRI2xI9FIGzNbAZg3xkLARxinF5ZqczCUK0GeZQfU
         B/CyJyFXQDrX/OUepj3QYHb6qPdm4PVkIasGfjZukrRLORXtqLZcrX5m6t5T7G4sDif7
         ucGXI3cVCiD4KbQ9XQegXKfVlF6gJ5kxPbvnwNuIQUJPbQ7vL++dje1SuuolMYj3Cswr
         yfCw==
X-Gm-Message-State: AOJu0Yzz5FC6rH0DjuE3/NSDQ8ChBRMJ1Tl7L98XaZoFGqel6DwxwBVC
	IixDsvhriSARcB9ds4XIOuBiZvFOGZgiF716vbG8s1bBwHzXRONz9z+yyg==
X-Google-Smtp-Source: AGHT+IF457J2P/bveyGOL6sveSKHz7tOUo+cdSqpV1rt60JkphxjwAiUvhAlPowfztEDQw1EAdlr5A==
X-Received: by 2002:a05:620a:440e:b0:79d:5b21:804a with SMTP id af79cd13be357-7a4ee31aaa4mr218169885a.14.1723608033161;
        Tue, 13 Aug 2024 21:00:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e11908sm392331185a.129.2024.08.13.21.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 21:00:33 -0700 (PDT)
Message-ID: <66bc2be1.050a0220.224f89.dc7b@mx.google.com>
Date: Tue, 13 Aug 2024 21:00:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6525853739672761066=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: Add new VID/PID 0489/e139 for MT7925
In-Reply-To: <20240814033124.29418-1-jiande.lu@mediatek.com>
References: <20240814033124.29418-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6525853739672761066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879455

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.41 seconds
CheckAllWarning               PASS      31.95 seconds
CheckSparse                   PASS      37.52 seconds
CheckSmatch                   PASS      102.59 seconds
BuildKernel32                 PASS      28.39 seconds
TestRunnerSetup               PASS      525.68 seconds
TestRunner_l2cap-tester       PASS      22.34 seconds
TestRunner_iso-tester         FAIL      39.36 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      114.76 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      15.14 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      5.21 seconds
IncrementalBuild              PASS      28.62 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       8.208 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.166 seconds


---
Regards,
Linux Bluetooth


--===============6525853739672761066==--
