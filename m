Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BF2B9C4
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973726; cv=none; b=tXD/2cK4qm7IFjzPuI05PkH11+albTGE/LYj6m4hqh2k9lXYWJUWyVAjeNmyT/H0Z6u4a13DCCfzYIFiYYIaz5JeCWiMGqGFJGUSf9RJ8Wdgx9S0ZFPaKCL8ZViJyRGyxMroILYKte05XsXHkLza/Sh8lhjOSDc0SVrJLBf7luE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973726; c=relaxed/simple;
	bh=cyPWOj1KEF+2WiItaPLqshT1eHuvajLlghCSRO6BpS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7lPmsn7rvvRfpOO9gnw7FnyOFLGUFIox0CeWZusLOdN1ts1DnEUrjH8uXmqiATARTu6WZbSUCB3vBsm4BrCzmJmJ71ycPWR9wnivJh8KKBYJkwuSupj5NIDZ8EsT5aqIHZ/8ORwenD6Zl5SNGBREKmaJhpzxmJs+2eWUtB518I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Alh1ixFD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Alh1ixFD"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso1028428f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 May 2024 22:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714973723; x=1715578523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxkjGOljRaGAprb+ggqTdJz/Tpg3zIQxD4Vf5Lj8kO8=;
        b=Alh1ixFDrYJRnPhlt4+BC2XDMqV9i75ebZdQWojqBkDiDnYzPdsoKC3vbIs12WUfuU
         T/Scqy+UgjVIZ46irYfbH++nLsZlTbErb34VutDupEcXePERWcEPcsztAs+HWG8YwJF0
         xhwivQnpzttO+7Ar/p4JoNPnAoCsMdeN5AGXVXOdlkpuQT28sflRyjIoAY/ts6mVLBOo
         /LhcY28NsE7kJz66RaEPPN99/BDkruXsx1/NtREynEFOWym9VjrgD+5dCHq66qQaTdtr
         DgDj4n3UKz6R/8xqVWXAt+WBaIvCPEbqOE3uE7h7l/UrfbajvaMLLT2lIsmWXo9RLm2X
         3YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973723; x=1715578523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxkjGOljRaGAprb+ggqTdJz/Tpg3zIQxD4Vf5Lj8kO8=;
        b=knliLWX/Ip8Y0pnvGVSK3A2G9A09iOVEp2GOZUlJJKO9ksqLl4e/gf+ykrMGq1r96w
         zyV+Yx4A/k9jRT3dQZmB4vAiSUcT3LidRr8D3POw+kYiscM/Ms2fWkIUJuA1DZJStVco
         rtJ1E7vxVqp4zj6AvQ7jYppspFd2+sawancPaK1ycK1YREd5juCKjttOGG9pAxMsRcwH
         moY2CxliOK/DivI9KFMRkaCjlqb5TdxuJCqDwqGetLrU7W5D3OOyweKI8cjRcxUHgQD/
         Bk6jMA65AQCCdi+8t57MMlIWKkbt+NGKPiwBN9VVW5BWA9R7hHcBwPqzYfPBFm4kjbLp
         zdcQ==
X-Gm-Message-State: AOJu0YzVSyOOb1suhLXBm7sUQ7HojLDjB5IPC0f6NUVxqUNfwuetP7Zj
	XCXow0yDt27BbYF9Bu6m3Gi+4XnZwApcBvpc+mJq1E9JWhZrMTVnNKdgx3SuwHE=
X-Google-Smtp-Source: AGHT+IETQCieJ66x3Tj8gXfMqlmq7XG1HJJ5halx1lHR6RMmArk5MFW+7wCWo4PYGpwz2qWl+DOi6Q==
X-Received: by 2002:a05:6000:1541:b0:34e:e5c6:521d with SMTP id 1-20020a056000154100b0034ee5c6521dmr3452909wry.38.1714973723060;
        Sun, 05 May 2024 22:35:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4d8c000000b0034e65b8b43fsm7737542wru.8.2024.05.05.22.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 22:35:22 -0700 (PDT)
Date: Mon, 6 May 2024 08:35:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bluez.test.bot@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Markus.Elfring@web.de
Subject: Re: Bluetooth: qca: Use common error handling code in two functions
Message-ID: <6a1123f4-b062-4a17-a0d1-83f9382611b8@moroto.mountain>
References: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
 <6637526c.050a0220.13e1d.c41a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6637526c.050a0220.13e1d.c41a@mx.google.com>

On Sun, May 05, 2024 at 02:33:32AM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850522
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      0.60 seconds
> GitLint                       PASS      0.28 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      29.70 seconds
> CheckAllWarning               PASS      32.31 seconds
> CheckSparse                   PASS      38.38 seconds
> CheckSmatch                   FAIL      34.98 seconds
> BuildKernel32                 PASS      28.68 seconds
> TestRunnerSetup               PASS      518.82 seconds
> TestRunner_l2cap-tester       PASS      18.36 seconds
> TestRunner_iso-tester         FAIL      35.11 seconds
> TestRunner_bnep-tester        PASS      4.80 seconds
> TestRunner_mgmt-tester        PASS      111.01 seconds
> TestRunner_rfcomm-tester      PASS      7.26 seconds
> TestRunner_sco-tester         PASS      15.13 seconds
> TestRunner_ioctl-tester       PASS      7.67 seconds
> TestRunner_mesh-tester        PASS      5.85 seconds
> TestRunner_smp-tester         PASS      6.82 seconds
> TestRunner_userchan-tester    PASS      4.96 seconds
> IncrementalBuild              PASS      27.54 seconds
> 
> Details
> ##############################
> Test: CheckSmatch - FAIL
> Desc: Run smatch tool with source
> Output:
> 
> Segmentation fault (core dumped)
> make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
> make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
> make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
> make[2]: *** [scripts/Makefile.build:485: net] Error 2
> make[2]: *** Waiting for unfinished jobs....
> Segmentation fault (core dumped)
> make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
> make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
> make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

:(  This is annoying...  Are you using the latest release?  The released
code is working for me.

regards,
dan carpenter

