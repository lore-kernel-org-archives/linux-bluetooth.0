Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804E20B33
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546767; cv=none; b=baeWFn/90azbVVsL6uc0Pg9/3VusSK5ltRYkrfNsMnjD8TptE5IZJkG+uCDyq6EvEyHgtlTGfnieSsA/6ywr3wMHvkSeqSAxUAZC6z35fEA/jvFLqkMOg8YdyERU26HeTqGxI5xmlYIbIlmkGGit6aJVktrZjAm70nllurMCB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546767; c=relaxed/simple;
	bh=KWaWL+YveZzHd0HaP66+95JBxen4vF1dtXg/5RkX9Z0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P3CnQtrZ/fFwxiPgjS237b4ian4f5riJfGn/MVLq7K5MxJSUfio4qlF6/xs0UqNIi6ukptxW7pTX1/ahbV8Z9AEsPwPEJkMgesvJOK/u4nL3mD+c1wt8ZI96UIq5yZDB+IcHXao2XC7ONBE2EX0/WuTbAVFHOn7Aq6/7g/AarGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjYMMlEI; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjYMMlEI"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47299367f78so451840137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709546764; x=1710151564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QXdB3iBUaWpMyH61RwQEXawCDjdlKRdw1eKQgj/ezg8=;
        b=AjYMMlEIgYrLwh8ilLxmYgdCiLgQP1Aj2F4wwHPaKD2kw60SilINySqp/CwpCArYfa
         SwjOdmXXtijsr19Aa8bn16JZTFkiKUcxjQtGPjfGgqYt+oJ9YgbLbAinOI3PSBRPtajh
         Zc1G/aR+SnvLzihV3zGw8+mtXCnhyUHS/BMZRq1+ERetOcK5kpLz6n6zMWDY2+mF2fwj
         fC+h0RVtgDBwuZd5OaK8iv0UrVLS8g9qVRD2nGJDwFkknbH26zsB6XB/VnfMPgQ9miua
         aGYXXM3jjEeUhtj7xU6FPlT2mAK2LGMO+Qe/x/+st6Zl8rN7VX75Lcl+qPiZlD8isjRH
         v1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546764; x=1710151564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXdB3iBUaWpMyH61RwQEXawCDjdlKRdw1eKQgj/ezg8=;
        b=mV6ynCpUSAxAg6WOSWdFeC/LBCli8/VjPYzlArbyyHq0NTSNItI/ZiFmQMrW1nqnBV
         2GQZc8bJtf3FPakBYPMFGCLMceW6+ewzU5EVuPrLnth5gXzxujLa347IN72bzZRvCduH
         AnoF41z99APTaDmy62MDRaPW0wyzCaJxMbPGUK4y4+rKXeZvgf30aMU8ovvda1TNxgVn
         6fuUQfbOcyo6yvrr9//ZJcRPlpuLDYOEqkRWbn8kiFSkTYFFr3pKuzRKWh3QMIuERjRJ
         H7ZD7KTrIYxSFHm4qQv9IoiR3cBDab6tATwpQq+YDvwif6QilWDSaYVv0cKgSowf7fuR
         Oleg==
X-Gm-Message-State: AOJu0YzZohTnpURZIXQwFkzKGm5rIgNw2XC+wMcTtIUc6A5Fmm7ubYky
	qAvnGq+mFRUjoNdP65YmRL91gHJhhINKkVb836dA87zYAQf9804vXAJRf53l
X-Google-Smtp-Source: AGHT+IG3uBEGDqv5rIBoyNuNzEvjFgxEYPQ2xzEZeNF8GBoHeEYzF/Yir/1LTRNB4aKFTQkCI1X9yQ==
X-Received: by 2002:a05:6102:32c2:b0:472:d37c:16f2 with SMTP id o2-20020a05610232c200b00472d37c16f2mr299546vss.12.1709546764511;
        Mon, 04 Mar 2024 02:06:04 -0800 (PST)
Received: from [172.17.0.2] ([172.183.154.97])
        by smtp.gmail.com with ESMTPSA id oo8-20020a056214450800b0068ffe48ea51sm4958450qvb.36.2024.03.04.02.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:06:04 -0800 (PST)
Message-ID: <65e59d0c.050a0220.41730.23ce@mx.google.com>
Date: Mon, 04 Mar 2024 02:06:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8242600668374373766=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add support for downloading secondary boot loader image
In-Reply-To: <20240304084418.32042-1-kiran.k@intel.com>
References: <20240304084418.32042-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8242600668374373766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831982

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.04 seconds
CheckAllWarning               PASS      31.83 seconds
CheckSparse                   PASS      37.81 seconds
CheckSmatch                   PASS      99.10 seconds
BuildKernel32                 PASS      27.04 seconds
TestRunnerSetup               PASS      496.04 seconds
TestRunner_l2cap-tester       PASS      18.40 seconds
TestRunner_iso-tester         FAIL      39.05 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      112.05 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      26.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btintel: Add support for downloading secondary boot loader image

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (81>80): "[16.571945] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed      10.259 seconds


---
Regards,
Linux Bluetooth


--===============8242600668374373766==--
