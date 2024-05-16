Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA14206C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867768; cv=none; b=tKJ3e81ljv/WbrdfSr1J8DgTYXe6Mx0MORGWpvF8+gM+UYIRYp/G1ij+fUGMeIoTV3kgqOz0MwWUkuILOo4N5Ie46aOGNDSzXiX3ClKgIWi6Yn8XUoOWyrnDPCZHSk2NGh15cDvc4Sofe+X1BjBBXtC1+sgPANxM1xmUf9HLvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867768; c=relaxed/simple;
	bh=ttnsolruL6V9quYJerw/8nA0i3LC8FXkACVopDvul5o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h710q0UFy3kM3Dyo7b3hQvUjxj+nK8SRaQWRcoUaERutTZPTxy/WfEYYI+dbJiGZ6ltnVltTRXuLmLJZq0Us6PSQauh85E3YfY64cy+W6nyAQWN2s72iiPS89uQhrhiM0n7b/4vSAxuTj0qNKmxC4atduIa1j6iOMCGvS6/bUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrJJsmui; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrJJsmui"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c99d0521cbso137725b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715867766; x=1716472566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oNu77HggVTGAEM59gKkiGqq7i0Ta24I3s2th+sp0Azo=;
        b=CrJJsmui/8zhxw46U8ptJVYzhw3Lprrnc9mlT8cFV21cckU8FkGLO/SNlalrQQ6apO
         7mLoVqQdoqO5N/cPzevwgPosTcOX8zMuf650zFkN9vrqxURWpGgZ9NT8/8PMv2b5oZea
         xH9yde1K+7KZeHm5ow0cXHtSYnn6SgKHLTVT92pP4FOogmw6b2bVciD1mlSwLUbgvxtV
         gzZ/UhtHmZi8aJUK4z5WPv8wTZNN4Z6JdiJs9vhG5AqLp/7ffBMhhbBNbwCsJaQYsF9p
         EdQexhuAFR19RbiN83V8SBLc/+WLF+C2HzPhguHUj1Cmsp5oeszrPHRR9ptzWsQfp6iw
         omJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715867766; x=1716472566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNu77HggVTGAEM59gKkiGqq7i0Ta24I3s2th+sp0Azo=;
        b=fnNsFOAqvhJq8OlktzzSc43nHOi3rn9DBpzGBiodn/kBdOkhNndlG9etzOZKo8U0SQ
         4CoiSnplpXnKXEOue1/9/e8NbQ5yzAsKvKcoIfQyZzgkXFBDbdxj0fsWxfhz2CykJ1aH
         RCi3ryN1idlfzOvVeL+Uh9uKFg+T6TE9hN7AuzG0das8LsNP83yzRg0phXkUiLNumRCf
         UN0dCmt279Jhmj76DLV04MBipeNLwv/EhAawfULAAft3AOnt3bqGJzRfjZex7UUseU6v
         2FcNxREDryZPeryxgAvR37wqSAhIK/V6/d/mfqK3LKzFP50aUM2fT/v8OwTYR6cGGuFF
         VTxA==
X-Gm-Message-State: AOJu0YyANRw/2Cb03QHN29qdLuXF6a3gnB1H5ur8mppVI79TwA1JIzw+
	8qxQEow6Faps6Z6TWYtMRovSv9XIE0xIByZNmCuSpkeO/6vZiw2I5D5i+g==
X-Google-Smtp-Source: AGHT+IFTEp6qfHNokLHwtGgbAYMqtpvgMwGq7SMwmeIpH3Xr86jjUBEWPU/YcipUx1Nkoe8yVWjjrA==
X-Received: by 2002:a05:6808:2b02:b0:3c9:6ba0:e98c with SMTP id 5614622812f47-3c9970d1b29mr18079774b6e.52.1715867765257;
        Thu, 16 May 2024 06:56:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf31179csm797039185a.105.2024.05.16.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:56:05 -0700 (PDT)
Message-ID: <66461075.050a0220.7de29.a5fb@mx.google.com>
Date: Thu, 16 May 2024 06:56:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5147543772234895591=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot
In-Reply-To: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5147543772234895591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853715

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.20 seconds
CheckAllWarning               PASS      32.74 seconds
CheckSparse                   PASS      38.39 seconds
CheckSmatch                   FAIL      34.86 seconds
BuildKernel32                 PASS      28.97 seconds
TestRunnerSetup               PASS      522.19 seconds
TestRunner_l2cap-tester       PASS      20.38 seconds
TestRunner_iso-tester         FAIL      40.83 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      111.37 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      15.22 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      28.19 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
35: B1 Line exceeds max length (89>80): "https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#t"
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed      10.226 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.783 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.159 seconds


---
Regards,
Linux Bluetooth


--===============5147543772234895591==--
