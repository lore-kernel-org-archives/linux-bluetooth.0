Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF076025E
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575006; cv=none; b=n56TtpDFaANh24yGcbcw5VyDWxUYknnAUzWoMDzTzi4qF2YrC+ZjB7ljWJrmU1dtNLVsyofSP2PFDuHlk2UMm3sH/QXuewsR7MLuJu5dGo3t60A/fXswKvyBGhb9wTmYsU1kyUdqK0zyNtgFGa2bOXt+0wFJ9Fi8jEUpo0c2jC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575006; c=relaxed/simple;
	bh=eUrD68avvK5bzl5WLHSRo/gXw91wfozNsqbh2x2LYVQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fEtgaTsvhdffGcDnwImYmyJFxOp/GA2C3bzCFAj9nCDPtHXlcVPDbR+d7eMvB74tNsjISfauxPvSGK+abTte2vuLIYV828Y/j8IilEuiMkQvw6Y49YdpTC52v/LzRTGpXcYLOcc9gB47RXmZopoAtVGngx76BF3uPx9dUGGh26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiUdpy4o; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiUdpy4o"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42e8758fd52so36079031cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709575004; x=1710179804; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbAzHrFGSCpUYhmm1Iz/zkkQKGoscr7Jtz5cOEgeFVQ=;
        b=YiUdpy4o7jgP7JKuyaBnA9MjB6cbvhhISaZWdTHhRKPrZW6G50uk93U3kSGtPKbttX
         7tB8uHnsnzkBAn31uXHi/+TE+lxCIHoUR42YTvjX/iKIZNDp0LPmSMq2Dx6B8DsJp28d
         0NYtnN8O7Bp5aZ428dHsqEjdlCJNetGmeTzEmmy6zV2xHMe9GBikzDSQ3BqwkkTfKBUV
         xdl4c9VxA7HlqB+0M9s9KzNHi0ryAUS/4JCfpG//+lom6qvKJM6IFnb4HuQ763YK6hfy
         JCF7uBIrbl1Ww9Vfvg0s2XwoTTUQd0J55oGJBHkFv3TB8bNjWayr/LJeeQwh8y8q4rES
         MfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575004; x=1710179804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbAzHrFGSCpUYhmm1Iz/zkkQKGoscr7Jtz5cOEgeFVQ=;
        b=am8klRF9hQzj7TBZwO35wfJRxDe0JkfqaKEz0ZIzYQzcrFsm+yM+2gYnrpsVEMSv4S
         Mz8wmIqat130llu79li0t4qIhCDWZBk5wCeBcOZCAh4UbI1FmTeS0AjRy4tYlJJW/buA
         p9EXXpDFDbT1x3b1LJFPyCQuMFOo75gvI8/wSRdFYZOIwhzHGIHlTWuddquv9w5GVbEG
         ZYIaqzV0W1nGyGSbyT/49yn7aKSz6MqzzoEHxzshUWKQC1YJDutpoWFmF92TSMedehuQ
         OPa2BLxo2RRZTquOGuiPmV/Pd825zMIv+JqTctpAVZnxykwC7hMR2ceMNNtLfKY/FWAI
         LjRA==
X-Gm-Message-State: AOJu0Yy2I1Y2V9e1wBNVpVcGxLdveM1gtoceYWz5Y5+PZHMG3+gNmTqP
	vf+wS5/5fulrRKbfBrS0GCQxhA/Vbvv0A/VdJZ9dBplOETwb4IcVggzvxzQy
X-Google-Smtp-Source: AGHT+IFIuEm19ZazPT3UXnxMHl84H2k9IRILUaqexy9ahToMnqs2Z4lNyJukAuo5u9IzMhnprzKBHA==
X-Received: by 2002:ac8:7d42:0:b0:42e:d694:f89 with SMTP id h2-20020ac87d42000000b0042ed6940f89mr9647043qtb.51.1709575003678;
        Mon, 04 Mar 2024 09:56:43 -0800 (PST)
Received: from [172.17.0.2] ([65.52.217.58])
        by smtp.gmail.com with ESMTPSA id f23-20020ac84717000000b0042ed2e8add6sm2981580qtp.75.2024.03.04.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:56:43 -0800 (PST)
Message-ID: <65e60b5b.c80a0220.f8bd6.b9c3@mx.google.com>
Date: Mon, 04 Mar 2024 09:56:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8479627790509204458=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
In-Reply-To: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
References: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8479627790509204458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832171

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      28.12 seconds
CheckAllWarning               PASS      31.50 seconds
CheckSparse                   PASS      36.84 seconds
CheckSmatch                   PASS      101.40 seconds
BuildKernel32                 PASS      27.66 seconds
TestRunnerSetup               PASS      508.70 seconds
TestRunner_l2cap-tester       PASS      20.25 seconds
TestRunner_iso-tester         PASS      32.80 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      113.13 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        FAIL      6.11 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      26.54 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.104 seconds


---
Regards,
Linux Bluetooth


--===============8479627790509204458==--
