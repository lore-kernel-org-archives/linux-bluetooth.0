Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXnMxy1g"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6331B10E7
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Nov 2023 23:01:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so19914345e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Nov 2023 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700895684; x=1701500484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJrUTzMGDE53zml+xdFqfI7TZGcl5DzsuApk5ukmUys=;
        b=NXnMxy1grggFxMxcGm7B+F9tOKf87XtC9GWRtUnrapnLPdowCgnSLvofnGPgxu+USd
         hQc499mAaF+lpk89cshKX9qBoIUWKew3pLGbCbbcvN1OQ7oUyGorx9NsGB4dKE5rpQHd
         QL85eQZHSzOgHAChfffKUB/cDElY4K39VgjZqwTAfdOOfoZSGEbE7+sfFw3bAtIiuCo6
         MoXarOm8vwFwEAF2oyC3u1k5aIipPACYa0/OGxu4Xnso3Qfu9iRl0u9u+/t7IlvQ8Jj5
         0znw8/KNLpXpnuoLhMnBsul1Wpq9lAgL9XOsI+wEgQQpKVHVNXlVeaA1NDzb8oYApiTE
         8hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700895684; x=1701500484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJrUTzMGDE53zml+xdFqfI7TZGcl5DzsuApk5ukmUys=;
        b=IbsUVkbOCpgH30HQ87l6Dv2qHyY13cJ4Etwefn026JaykozFyvFm3l/ls/zCHn1rNl
         3+/yGjK2Hv9xJ/2/itKlcP+fIy9fB8vB0/ts3/ZHW8cspNCGYpAIQnv3plqHzmKXw0Cr
         3L1ZoTvdtpVoy8u4961S2sx/sZTTQWwfWeYexaWcjvMsSDNJmNBQHWI/XxvVdG2HowQP
         CXTfjwTZBAlc/ux8NFEjk1AezC8D8H3Hx5x8V1sDZbTRl87FCMV2LraKZ6vGQaMmt7WM
         MgYszlFaLNn+73zc3IWjqEAhNkCa8j9RJO8r/BTRVuNLu91M2NLtAOAjL075lNha9z6r
         GzSw==
X-Gm-Message-State: AOJu0YyzQnjtRLv7GjYbkhBFAd7w9TO4ADKBEA8BXsSLR63R5Ppl9Vqh
	ZxL6Leui//3PVN79dFZRS4h2qThiDwccZQX9BZs=
X-Google-Smtp-Source: AGHT+IFDtPP9hfK1sLlQTBVezDqmmqMO7VEKy2BN36Xfg9A+rT7346TrbSAdE2jFkP7SAbR4BflKQw==
X-Received: by 2002:a05:600c:3543:b0:40b:297a:abb with SMTP id i3-20020a05600c354300b0040b297a0abbmr3987948wmq.1.1700895684147;
        Fri, 24 Nov 2023 23:01:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b00403b63e87f2sm7003598wmq.32.2023.11.24.23.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 23:01:23 -0800 (PST)
Date: Sat, 25 Nov 2023 10:01:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: arnd@kernel.org
Subject: Re: Bluetooth: hci_event: shut up a false-positive warning
Message-ID: <367e89c0-7347-43cc-a633-383e989534bf@moroto.mountain>
References: <20231122221805.3139482-1-arnd@kernel.org>
 <655e872c.620a0220.f2a0c.00a7@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655e872c.620a0220.f2a0c.00a7@mx.google.com>

On Wed, Nov 22, 2023 at 02:56:44PM -0800, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803455
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      0.49 seconds
> GitLint                       FAIL      0.55 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      27.95 seconds
> CheckAllWarning               PASS      30.80 seconds
> CheckSparse                   WARNING   36.13 seconds
> CheckSmatch                   WARNING   99.31 seconds
> BuildKernel32                 PASS      27.12 seconds
> TestRunnerSetup               PASS      418.45 seconds
> TestRunner_l2cap-tester       PASS      22.80 seconds
> TestRunner_iso-tester         PASS      44.52 seconds
> TestRunner_bnep-tester        PASS      7.03 seconds
> TestRunner_mgmt-tester        PASS      162.09 seconds
> TestRunner_rfcomm-tester      PASS      10.98 seconds
> TestRunner_sco-tester         PASS      14.46 seconds
> TestRunner_ioctl-tester       PASS      12.36 seconds
> TestRunner_mesh-tester        PASS      9.12 seconds
> TestRunner_smp-tester         PASS      9.84 seconds
> TestRunner_userchan-tester    PASS      7.45 seconds
> IncrementalBuild              PASS      25.87 seconds
> 
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> Bluetooth: hci_event: shut up a false-positive warning
> 
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
> 9: B1 Line exceeds max length (143>80): "net/bluetooth/hci_event.c:524:9: error: 'memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]"
> ##############################
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):

This is a Sparse warning.  Smatch outputs to stdout.

regards,
dan carpenter

