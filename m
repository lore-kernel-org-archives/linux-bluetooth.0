Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98621802B
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394214; cv=none; b=iAlKCpJPLh3mapAlP9TaaNDh1t3VHVe53D6T7G+sV6Q1lfnphKf8fniNAp+AwvVFkMocPynvt12r10VRRJwX4gPCqJmJyPClaBQpZGwXZpAFqowlE17rzdW+fK7XDFlN0msbTiqQWLOtjZAFG5wvcBlmCSrCH8MuVF558XIi2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394214; c=relaxed/simple;
	bh=4gfOe9rD1elxtcFQGSgQUJ9/LTQntEIwDmJtQtI4q3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ij0J5kLP3lrOB+T7AX3LgAr239jGR7UlbbWsJxnCCRXeBB4t/+G0QKN7UFxVNQoOvoslGVPRntjQh95BtQfVgVyFSYayIJp+ta7yToUYJQ+M9mZV/HRuwiB7IgXaYWoDve0dj9Ve9eJI+tVROzNtMwpp7B2xWf4+vAaiLqBq/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CatiQbog; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CatiQbog"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-71871d5e087so3999728a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722394211; x=1722999011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxGosLkSr3OiRo9IjP+/slcZZ4rGMV2tS9OyodV2CNA=;
        b=CatiQbogHQ3uLrs8au5VF4veRO2lGvLVgjMz2IcoiEDQlishtc9WlCfiIjQzcE4eaM
         kpEEqJfqDDXZSn1Uc/z02CPBUmU1JAYHIm2+xFYar99J3e4lDUI70E2BqQZGod5X4fXV
         KO/q6Y6WI+s6YcQdXXx3BtvFs+4VjTT0xMUw5ATuM+UkKPisQkSYn5MkcR5gM9ghMYZ/
         RX/e4Wuu7NANrM5zdjE9EdQSGwyvvRd4p2YIIxY9lK6GVtltSvYUw1WQ6ijRZWO3HfQy
         eHemjqiersRpwHzAJS+0PxtMirh0VI+ixa4654TlMKyZOV9EJlh5Jhv5PSqWV0FVGsWA
         SGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722394211; x=1722999011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxGosLkSr3OiRo9IjP+/slcZZ4rGMV2tS9OyodV2CNA=;
        b=WlGFEHmqjXyh59ncDmEYsSA7VtGyq1AlOzzuH0UK2wHtPkJkNMu6Fhl/SU1f6xxk5/
         ra2qZuFCWm6QTy8ACX8TqHLTMyBfvEfR41Dv6hHumv1h6RlJBIrrlO8I7E5+mIZ9yAvN
         PsO+einlT3pQdHHOOSFGfg6OfA/Ka9znIqP9tIbMuCkn0lKmEYg0VNsoga226xvXdVbe
         JafX9HBiAhoXyXPRb0uiFluxVkPVcXSneFC/hY4lWHL7FWc6IjBIMkHJCzHC2q1fimNM
         H3D2SOjX8XBHI9tzbufsCJQykacNNMkaKmw/dlOgPcJR2IwVed/tBeQDfx7M4BUhJL0p
         xl6g==
X-Gm-Message-State: AOJu0YwMxt4sBbkBxb7VgHQCLyqpAFuyTp5VrLGKvZwqPc3McQKqovt5
	VFjFrq6AdXwndD+TJPsHIZr+uE8q3qG+z5d96PVpTcxw7MYbdR0Ut3yjgZz54gw=
X-Google-Smtp-Source: AGHT+IFXJ7ZMT3D7q30VUD7ncVm3Q8sk+4hdomaA08wLadJjuK2VATeWMk9mKDjsHuTUkXSAjlhCZQ==
X-Received: by 2002:a17:903:2291:b0:1fb:8620:c0bd with SMTP id d9443c01a7336-1ff04817f70mr148443615ad.15.1722394211314;
        Tue, 30 Jul 2024 19:50:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:65a0:8110::c? ([2600:1700:65a0:8110::c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d37d91sm109200995ad.115.2024.07.30.19.50.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 19:50:10 -0700 (PDT)
Message-ID: <1e91f3da-9e31-4f14-949b-25e718cb6541@gmail.com>
Date: Tue, 30 Jul 2024 19:50:09 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID
 0x13d3:0x3604
To: linux-bluetooth@vger.kernel.org
References: <20240730220824.224298-3-bearodark@gmail.com>
 <66a96a28.050a0220.81785.560d@mx.google.com>
Content-Language: en-US
From: Alex Hall <bearodark@gmail.com>
In-Reply-To: <66a96a28.050a0220.81785.560d@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm confused on why TestRunner_mgmt-tester is now failing, it seems to 
be a test on the

patch itself (and on v3 of this patch it did not fail, which has an 
identical codechange).

I do not wish to resend an identical patch and waste CI time if there is 
indeed something wrong with the patch,

but I would like to be advised if this is a spurious/unrelated failure, 
and if so should I resend the patch? or is there a mechanism to rerun 
these tests

On 7/30/24 3:33 PM, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875239
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.60 seconds
> GitLint                       PASS      0.28 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      30.26 seconds
> CheckAllWarning               PASS      32.87 seconds
> CheckSparse                   PASS      38.26 seconds
> CheckSmatch                   PASS      103.58 seconds
> BuildKernel32                 PASS      29.18 seconds
> TestRunnerSetup               PASS      532.97 seconds
> TestRunner_l2cap-tester       PASS      24.24 seconds
> TestRunner_iso-tester         PASS      37.44 seconds
> TestRunner_bnep-tester        PASS      5.00 seconds
> TestRunner_mgmt-tester        FAIL      110.67 seconds
> TestRunner_rfcomm-tester      PASS      7.70 seconds
> TestRunner_sco-tester         PASS      15.18 seconds
> TestRunner_ioctl-tester       PASS      8.14 seconds
> TestRunner_mesh-tester        PASS      6.16 seconds
> TestRunner_smp-tester         PASS      7.12 seconds
> TestRunner_userchan-tester    PASS      5.19 seconds
> IncrementalBuild              PASS      28.22 seconds
>
> Details
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2
>
> Failed Test Cases
> LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.175 seconds
>
>
> ---
> Regards,
> Linux Bluetooth
>
