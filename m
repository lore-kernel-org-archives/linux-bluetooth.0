Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB13396FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667420; cv=none; b=Sl+2A2zU3L6QJv3/YEZ3LS8+uWBzy2n+x55V/0kkgV0N4rncaHNhGELv8H89mEN76Q7d4dy9LUtWl7ilZKl9nNTyDaaQvvJjCEV+877UmkHizjPJ5rTL0E3QyrAHUfBpNaIEJTbfti3eyBrJqT4Jdr9hPDQM5MFwX0JC29bufjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667420; c=relaxed/simple;
	bh=8Q+2IFCl5s2cmBLUywD/SYYRnHlAyLkb8+79ldLv90Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hdKO7z5O2UsavusZf/YNW0SlfD2UvQ9PNdJiiaCnQfU1ExWWApzWiTlSPfw/u3K1YyZJrk9YLy2EtEgJBEvJ/p37DZj4GErHYNDNbEnMy1Au1DwM3ValukcoGtibbwnBBaJtLs8042gca++9oDxJQ393DSPBOs6K7u9caUYComM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGSdftiN; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGSdftiN"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-940d25b807bso256333139f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761667418; x=1762272218; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PwPXwAsSh96jNK7hc7fvZuZyAJLuaLhlGiWJkmUQy0c=;
        b=BGSdftiN0LDSmJNa02CaRedvPrSeBTuZjEXNiLaK0cignVtqQh1o0WCUu7VosErR5h
         i9/edqQmFZnS/FL+DmxvE+5vEFxduQPvyCUVNB76zPJ5yFI5HV/HfTVwrUg+fu7hbp+M
         Mu45RauuMenWDC8om7nPKu9+6W7ZKceMjolV9Pce5eN0XW4YTOSwyWrs85OMps1Y5b6H
         C/XlEU0a5JAPEOwz9Nr4JlvI6trDaiRPmNLx9zD239bo+kdP6LkS1z8im0iJg4Zkmn4F
         allurqbySPiGD3FXXDsE3R/p2qE+JYwZA/2Sz9VbuiHIY9BpPDKPufL935j32kMi1bI8
         0Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667418; x=1762272218;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwPXwAsSh96jNK7hc7fvZuZyAJLuaLhlGiWJkmUQy0c=;
        b=qQSTuBFmeCmrWxZ2CWpAROs8eqc+xdb+mIe93zWGBpx3gHiytzb+fuJaPnNAsA2zSy
         LUl6rYFOdi3fq2beLdRjTjxeHS2jMfPoCJbABuCIi22g2gEAv/vnywjg5cUbRmkQW5/E
         rqI752aKltNp0EwP8e9v32K0mKoWD+JES1Zk7FIu0NBZJ+CYwI/4KzwZM/IxM9cNOFIM
         E/U0kHmPEh8vW7ymO9N5y4frP1yJyu+utwvLaKAelIIxd46AL0wFBxBqebLCOcfKE48J
         /cBCRdOAyVzlA8r4INOXKUOJmWMTbAoMdYku53FQO4IXJQkky9ciHw5902PR57+tloDA
         aN+w==
X-Gm-Message-State: AOJu0YyMtYaw2gbFaYyesu6QjsbSamG2O5APeHB+YOuJd4ALNvPfJ/MQ
	eWBJBuow7T64WFJdddTykcemN4Rd5854/NR/72CJBM7TFFyVS7TcJekS7nspyQ==
X-Gm-Gg: ASbGncv5JNl0MLFBGxjY9WdB3A/dNtp4EouCvuuQfmxmLD3LKr1ozWTS754viHv1ELA
	VmthBOuuHZMeTNA445kgH0sGkZSxFqU5/66Af9N0ctmehx3yMEwYqO75HxbWnXOPQ6MrQerv3Pr
	51EoTdUgKSti3n/3rRDjU8whqDInOuZuNBcIzg0aAiLGLm7aRQhp3THgMgssH4qfmcrshfobIsZ
	Ue8HZYEbAeQKx/SEk6Q8MKehj9L4tGjTEG5yvUE8j7DwoUlOAYkgxDtjyC2fpU3l3qTt8FG7xss
	+Hzn0SW8o5gsC+7pgY8CPWtQb7gkce3nWfHRJ1hJxbcci0i07vLyilTDaRM1jtyaqwcI9gBOVqA
	q+wH27eCx+yDDDX/lFeq7VDtYZGDWzF6EvSaZd151VvOXsqj6jAMyxj5nKe5voKGsSo4JLalt4I
	1tO32bx1iatpE0qDIfRTc=
X-Google-Smtp-Source: AGHT+IHlVKJoRCROFgryuZewK1W/ANQwsqW3c3VG8+XkY+Ky7Mol1R0ION73QLGajoJLp8bgmbM8eA==
X-Received: by 2002:a05:6e02:18cf:b0:42d:84b3:ac43 with SMTP id e9e14a558f8ab-432f82b7bdemr3805795ab.2.1761667417876;
        Tue, 28 Oct 2025 09:03:37 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.224.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d420sm4536746173.43.2025.10.28.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:03:37 -0700 (PDT)
Message-ID: <6900e959.050a0220.274240.732d@mx.google.com>
Date: Tue, 28 Oct 2025 09:03:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8641449368410579364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: Bluetooth: dt-bindings: qualcomm: Split binding
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
References: <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8641449368410579364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016804

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 FAIL      1.47 seconds
BuildKernel                   PASS      25.19 seconds
CheckAllWarning               PASS      27.73 seconds
CheckSparse                   PASS      32.14 seconds
BuildKernel32                 PASS      24.89 seconds
TestRunnerSetup               PASS      501.91 seconds
TestRunner_l2cap-tester       PASS      24.02 seconds
TestRunner_iso-tester         FAIL      45.77 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        FAIL      111.55 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      12.56 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.71 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.46 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.001 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8641449368410579364==--
