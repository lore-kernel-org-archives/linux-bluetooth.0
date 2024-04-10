Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FF15EFA0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760060; cv=none; b=X996ieV/IaezsdRk5hzeVWcYc1SB++tds7LqTxl2PwniZDUwE9YF5xoZzqG4ehLu0W/NBZZXEScDhb/C2cLQLEYSbF1XcT3eXTgfuG1GTKsFzFI3NJZyuj8G4GuGp5SW8v9Us4Bc1qqtNyeaHE5I6GybLcbbvYl6gkxrF6oLD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760060; c=relaxed/simple;
	bh=1Grbk6ysEsRRbHzjGMEZZQxb8tyblX5Rf9kl67KAEdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQe27QgoS4tZpPHM6M2RynvAHE0PIYm+3nvs760Ws6fntR9pp0vIPpq6Y7E+7hMswGrmP2VpO2qc5A1qONj6sQmvIfXkCHCm0TYZC60hzYMAWscPWdC1i6REmg80GatgexxBoroQ44RzJs931tBUlFvmzHLMAMGFAv9ri+WH2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lieL8ALE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lieL8ALE"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8129797fcso92378631fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712760056; x=1713364856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8y+/mJ215Nd7c77xSXbdERWO3/7zXbLSBwFV2Ljzfk=;
        b=lieL8ALEHSXOUyKZ/1mYMftTg359x8el+InMQKq1JEpT9Mi5q0uFTAwA1fGP1FABcO
         I0lXCsW7LRyRKktEbD8FZfRLLYPdTaK3psDwYDnSCid56fLhqQ+bj6j0GwSscxzwu3qe
         Fvfavi1mI9nI89ZpDlQlDgD5wzYY8BrO0udBS/7VOoumWXvVp2KXzFi8rNOj8hbA1jN6
         m85Z4tgcdHqLm9PHCYZAlG02fwxpuXIDNt5JNdtxNZtPD2sljA/R9H8XbeoN/A+u0IPq
         WP935o8IdkqBuicHV+ef67TqapgkGxwN4LLDZdvaZcG5Vhg7vsqvEIb2HHysPzs2RFV+
         z51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760056; x=1713364856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8y+/mJ215Nd7c77xSXbdERWO3/7zXbLSBwFV2Ljzfk=;
        b=H16kn5BZqyVFVhyM4NGRNvbZX5kk/7wVxf9oWG1fDgl2Jel5LKJsDVby7lealb0YoH
         trAcjLA8Y1VhaKISXTiKsQUr1Z+QBq/HHIRjQqYNJqkWxhDeREjx+4YvQvfB3FoEqgfp
         Vq8BdmUHp0ZGLW7H55c1eiXwjhC6Vethkww50IzikK1NlOz2QpH1H8aq7am9cF+s8ZH4
         oyWzpTBz59ApxSQ3p0AzCZQy8ESQOWBImAfdntNbmyzhSyGkKiglQnjl7kbd2ki035kL
         Vp+NFplDXWt5kUpn0XfoUcPAlbtNA6VigjNkfvMOoQTrjY6pqllkJrrdVdtsCyHWqob3
         Om7A==
X-Gm-Message-State: AOJu0YzT1E4biYmEF7bajJcehCMlbXA4n30ZqOSk8rLCZVX04GvniqJk
	I+pmer0ouEYVHJuATnFHId7nWThDNTYPTeEOvi8s3g7MNjNNfaTfKZeVOQIMoIGSzphX+9PEPfy
	KakxyvJXFc6MeZ8hC9frcI2crfP/KlGz3
X-Google-Smtp-Source: AGHT+IEC/wgsbc47ahOpoJFLx7sfKlAv5AKpppITb4Z0HnOVgGqKTcvsfwG7a+bVOsbVNSXTpTaGIW7w2Fflvzqdt8c=
X-Received: by 2002:a2e:a7c2:0:b0:2d8:3cd3:35d with SMTP id
 x2-20020a2ea7c2000000b002d83cd3035dmr2342838ljp.33.1712760056150; Wed, 10 Apr
 2024 07:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125806.12682-1-surban@surban.net> <6613f1f7.170a0220.836c.1ac6@mx.google.com>
In-Reply-To: <6613f1f7.170a0220.836c.1ac6@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Apr 2024 10:40:44 -0400
Message-ID: <CABBYNZJsojUqyYc-ywcASyRZ2_NWyO_54t0o4Sk8dMuT9KbzbA@mail.gmail.com>
Subject: Re: [v5] Bluetooth: compute LE flow credits based on recvbuf space
To: linux-bluetooth@vger.kernel.org
Cc: surban@surban.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Mon, Apr 8, 2024 at 10:05=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D842=
452
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.01 seconds
> GitLint                       PASS      0.22 seconds
> SubjectPrefix                 PASS      0.07 seconds
> BuildKernel                   PASS      30.65 seconds
> CheckAllWarning               PASS      34.59 seconds
> CheckSparse                   PASS      39.10 seconds
> CheckSmatch                   FAIL      35.16 seconds
> BuildKernel32                 PASS      29.28 seconds
> TestRunnerSetup               PASS      528.76 seconds
> TestRunner_l2cap-tester       FAIL      22.63 seconds
> TestRunner_iso-tester         PASS      30.74 seconds
> TestRunner_bnep-tester        PASS      4.67 seconds
> TestRunner_mgmt-tester        FAIL      110.12 seconds
> TestRunner_rfcomm-tester      PASS      7.26 seconds
> TestRunner_sco-tester         PASS      14.97 seconds
> TestRunner_ioctl-tester       PASS      7.62 seconds
> TestRunner_mesh-tester        PASS      5.77 seconds
> TestRunner_smp-tester         PASS      6.78 seconds
> TestRunner_userchan-tester    PASS      4.93 seconds
> IncrementalBuild              PASS      28.60 seconds
>
> Details
> ##############################
> Test: CheckSmatch - FAIL
> Desc: Run smatch tool with source
> Output:
>
> Segmentation fault (core dumped)
> make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error=
 139
> make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
> make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
> make[2]: *** [scripts/Makefile.build:485: net] Error 2
> make[2]: *** Waiting for unfinished jobs....
> Segmentation fault (core dumped)
> make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Er=
ror 139
> make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
> make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> ##############################
> Test: TestRunner_l2cap-tester - FAIL
> Desc: Run l2cap-tester with test-runner
> Output:
> Total: 55, Passed: 51 (92.7%), Failed: 4, Not Run: 0
>
> Failed Test Cases
> L2CAP LE Server - Success                            Failed       0.099 s=
econds
> L2CAP Ext-Flowctl Server - Success                   Failed       0.103 s=
econds
> L2CAP LE EATT Server - Success                       Failed       0.103 s=
econds
> L2CAP LE EATT Server - Reject                        Failed       0.091 s=
econds

We need to fix these tests as soon as we apply these changes, afaik
you said they are expected to change because the credit changes, so we
need to update it with the new credit logic. Also it would be great to
add a test case that covers the broken behavior where we dropped
packets.

> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2
>
> Failed Test Cases
> LL Privacy - Add Device 7 (AL is full)               Failed       0.195 s=
econds
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
