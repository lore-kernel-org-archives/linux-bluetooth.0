Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC65A11F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421693; cv=none; b=SAa6TCxITN1ErPN4AgCZhWqiwPPbmXWvbo7MBUP1iK99RZPMTmYYq6CjdEw1VGsYzNa7C8McgppWHaLec9EhXoAIYTqm3pm+RoVrDHbbA5mHQe7297A8XzLKJ5IkzP0K7oTaMqfM13UASvhIhRu4fdHSFqlH430kZswm7+oF0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421693; c=relaxed/simple;
	bh=dmrp3DxaauAUZ/VbBCGeqDSvlZovAOR9Jc36WDStW4Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R6TGktOeXeK4ngypgFaD+CWbfUmrnu0CatEefkhe0/sG99mJICbFxiT6ZjjdbnKaLhgIRRusFmk/Sz14seYvl0AlpyztnXxxBMnuyKK39+4rbQw64w13pu6MNd8Z1y02Aj9UlSqQxj0p5IwnwYskU6vRPWzIJF3tSuXLh0cpa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxVxu7WA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxVxu7WA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690c1747c3cso8552336d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710421691; x=1711026491; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=enlwGoHu8FYPbtwDTF/8z765+6A8NqY9Jl4yRzOW8d8=;
        b=cxVxu7WA/zu57Q2uSkyU5+5HveOxqj9egxD1BHUyyqPmCWFlSjI7bD3sR6JiF9vvbp
         hoehpK7jpHko2Wo0hHA9qzm1ER6xjj8SscRpfYtxPBEv9SokykuDJHifhml34/MS/PUM
         eiDaSM/B7ErMC+NC2IGlRGdDNC/JOfYusxi5g7X/kLgTqSjYGyKee2u5tfeC9MwkB/4q
         7imHOL3qJE/ljehSNIlMz6VWRH1/0ICRnUXXoduXHzJ0XiQWqDDUpylLuUFzPN0eih0J
         Kza8vKJZRDRzwpKlrIrhoBj/q5FIJj907T1jqx9DnlhCCbCaovRWXa/DSrdChwYpdLzy
         7C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421691; x=1711026491;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enlwGoHu8FYPbtwDTF/8z765+6A8NqY9Jl4yRzOW8d8=;
        b=vlMtdvPx8Ge8CooC8gGQ88adf05i6B58Yh63h28Dx4R/OxEscaI9Djus8SlCKnxwt8
         epZn2rMf491f/W16p1ZIo8bz4ijJsyXL9oyNOYCRp9WbXzNurLzDySy+KAKbe3XRllYv
         8cvGcOpEQzfllCDXq05+64sQhkabiGr/w/pSOLRxwKMkpqiOdmT0KFHMp+KHYX4E6Ed7
         85AMla73LqduS4eoQErWTe8E+ixZGWMzycj6k0f+aqbj9YxNKkaKXrWI5JNSWhZsYq7+
         CK9bKcbEwAziIxDPZ6c/zBKmuLP4qM0DJ5NwIqLVLjt0WkbhOcckJJmmgfh/g9N6MYKP
         1sNw==
X-Gm-Message-State: AOJu0YxkeR8BDKXFk/yUfpI8skbyJuTeRW60bb8qIoSytBPgU+IrCacf
	jnDbQFbRWKzLj4ITCWKg0oyL/uZjHXLtaNoljdAEGCiXRRjvd8VUDTbgNBQT
X-Google-Smtp-Source: AGHT+IFP6WFxoYlIRt+MU7fs+rmTjxrLYQOa3M8WBLBdE9KL2E0wySOKaxfEC//4aGP4E2zcAuTxeg==
X-Received: by 2002:a05:6214:1792:b0:690:d6d8:d521 with SMTP id ct18-20020a056214179200b00690d6d8d521mr3109631qvb.23.1710421690629;
        Thu, 14 Mar 2024 06:08:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.238.214])
        by smtp.gmail.com with ESMTPSA id jv3-20020a05621429e300b00690c9256676sm427977qvb.49.2024.03.14.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 06:08:10 -0700 (PDT)
Message-ID: <65f2f6ba.050a0220.f2fa6.1059@mx.google.com>
Date: Thu, 14 Mar 2024 06:08:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6122080281355162866=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/1] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
In-Reply-To: <20240314122952.1867-1-neeraj.sanjaykale@nxp.com>
References: <20240314122952.1867-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6122080281355162866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835311

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.19 seconds
CheckAllWarning               PASS      30.79 seconds
CheckSparse                   PASS      36.74 seconds
CheckSmatch                   PASS      99.34 seconds
BuildKernel32                 PASS      27.54 seconds
TestRunnerSetup               PASS      513.49 seconds
TestRunner_l2cap-tester       PASS      20.10 seconds
TestRunner_iso-tester         FAIL      30.73 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      108.19 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.88 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      26.55 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.208 seconds


---
Regards,
Linux Bluetooth


--===============6122080281355162866==--
