Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AD16ABE3
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314576; cv=none; b=FwFE84cIe6D7yVRp3+7FTtYQ9r0Bc2jewyh0Nvq5bEqDCjXoS4rPkrlmm2xF8fyD/quESCMfFpLK8UICQh6+OO59qU7TW7Rg3dtVmSck7GkeFn0EdherSMQh1BBdZovJzBW0DA9k4NcRZz9q7fW3SrYyexXnpn0+WiYxA1jTxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314576; c=relaxed/simple;
	bh=hGXtXTDC25LlJ1gh5vVDvSx1MjSAY+fwu7k2fJrhy/s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DPY1PFVulGtJF67GlHwO103+XTsQAefl4yCDVfoRt90547ZpQ98bcfj/9uRs2pZ4n+XOG9Nb97UWdPHQjwj473jJGyp9gVEjUKY8SJm6MGRyEtcGBV+Xe408+EumkQYz2VXjQwfTASFHgB49ZFJOs4bTVtwKSwLA2sMlZh+MkpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMoiYNxG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMoiYNxG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a5580333bso109744185a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712314574; x=1712919374; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBVEbcn9C6ldOYz3U3jkzHznc6lP6/AZDlHwfSDY1ZQ=;
        b=jMoiYNxG+RpkKsnRcqHx1TaTeeRMOeetQlb3r+W5wMsV1QEICojQ11Vamzdu/7zKFN
         lQ6sYaiVtDQq/M3mmJn8lgHaMYdW5ib5vLBTp5wiV9/g6ieiYIt1eCwF1zxmX59AmDgY
         lhg8k45PTfun4VTUWfAy6XYkxZoIzkIl+n5gyHyV9G9yIMDh7KzmjYzs85bCKoBjvOzG
         aFLdOmGVZbWVsZ+ibXpMPz62c0jPQqHL0NcTISU+J6ZPNBW6IX+COJ5Yfz3IzsVlObQm
         pyuvdTkYM86wnQHfaPNxA9WGMJBUF9cMkacPZ+PteaGXfHORo5GT+IiGFSnsCMbKoIyg
         wIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712314574; x=1712919374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBVEbcn9C6ldOYz3U3jkzHznc6lP6/AZDlHwfSDY1ZQ=;
        b=UqZEKsHXPogCcLGJupkk4eaMYjwEcvR+tbSp45jDgBnsKdlmtvo7vYrorBhmwENcdv
         TOyAWWO3TG7A+gNZ6iiUpKCcn9KHf36ASF3YwGFVwGyk1bXcJXf79l6GQKOPLDVDUMo7
         0Qpq45UTW9W1P1vPS8wRPaUiEheKDt5achQTOLAjbCVZzsz3XLbPRj28XXN3hW5VSyLr
         qnOE9tecDUevzaUTHA9uAr5fONM/CsOPa5++kTVpAWFW6a4tXbDOx5nKyrYdM3+j+xVB
         4NX+6tG0VHhqEkxjChLR67xhkHTM+bVmbUuv86HV+ceLagbrGQr/2Qg8CEaQFxQ4ccPF
         v+8g==
X-Gm-Message-State: AOJu0YwKHRRJouqetwuiXpyMW2LB2F+Q1V3jrUixcQPVV6UcukERGeJn
	96jdvn05YEGub/ZM5W0b/AzanapTrDkmYnOKoWO9aN8gi2uLDe4eKe6kUQl1
X-Google-Smtp-Source: AGHT+IGiIE/RrsHbm1J3b/YLuO6vuffauB+u9Qgo95h2O91Usx7EH13rOut95KCEPlCYIziiW2CRKg==
X-Received: by 2002:a05:6214:3007:b0:699:132d:5206 with SMTP id ke7-20020a056214300700b00699132d5206mr1062032qvb.14.1712314574112;
        Fri, 05 Apr 2024 03:56:14 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.13.143])
        by smtp.gmail.com with ESMTPSA id k6-20020ad44206000000b0069942a53f46sm198099qvp.53.2024.04.05.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:56:13 -0700 (PDT)
Message-ID: <660fd8cd.d40a0220.1913e.063c@mx.google.com>
Date: Fri, 05 Apr 2024 03:56:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8361413508640581481=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v2] Bluetooth: keep LE flow credits when recvbuf full
In-Reply-To: <20240405102551.114999-1-surban@surban.net>
References: <20240405102551.114999-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8361413508640581481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841749

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      4.42 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.80 seconds
CheckAllWarning               PASS      32.38 seconds
CheckSparse                   PASS      37.79 seconds
CheckSmatch                   FAIL      34.75 seconds
BuildKernel32                 PASS      29.16 seconds
TestRunnerSetup               PASS      516.52 seconds
TestRunner_l2cap-tester       PASS      18.25 seconds
TestRunner_iso-tester         FAIL      32.46 seconds
TestRunner_bnep-tester        PASS      4.62 seconds
TestRunner_mgmt-tester        FAIL      112.20 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      7.58 seconds
TestRunner_mesh-tester        PASS      5.68 seconds
TestRunner_smp-tester         PASS      6.66 seconds
TestRunner_userchan-tester    PASS      4.81 seconds
IncrementalBuild              PASS      28.17 seconds

Details
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
Total: 121, Passed: 120 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.168 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.157 seconds


---
Regards,
Linux Bluetooth


--===============8361413508640581481==--
