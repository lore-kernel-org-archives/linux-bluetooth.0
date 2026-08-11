Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA72EBBB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446348; cv=none; b=tyQitu83xhDoNVwS6Lr6MFWqU/xAm1a9TyaV+bZHdgsMJhNG+ylzIS1NIJM8fwlvHaIv6jewMwSFzbPpF3KIdeezM1sy8lQcfYsqn5pZhe82SBOOWbrJFN9GkWgBWyRB2WEk2DQbVd/gFFweG7CGTy7fCJce7sEClxsXr8+BTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446348; c=relaxed/simple;
	bh=9ZLFLmIb4XtfYfi8yry5f4CYpaJugH3Td1wF4f3/CNE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rTV65pQ7phMuHoFQC2axBWJqMKnO2JTOowbBfiaLy7NelNvizm+Z4wSI7f/xezH73zXv1bdwVroBhSTf1vVLF+Os44UfMFfmMvKL5N98WV/f9aQ19/B0MVFjoyRV7Z/Fb3CbzZnk6qGilGVcw6oj4IqqdH83uT5LBd7HHdzaoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJe4Nkyk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJe4Nkyk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caea3f742bso47178445ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786446346; x=1787051146; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LtJ0FlrjrhCujSR7QCF1Euu7B6F/UZWkp9olaYwhEzw=;
        b=HJe4NkykFQE+PvfjEl4ShyGSQZ1aLwRuYRnFwMmxgjFuVDPZuzF4tr/2FtbzkvAcGy
         09eFSrUtfclOPTMj6MRDMkJaop6rLlGU6Yr0IsROWvGhf5k/IyAx2tadEAR4zacqMQKB
         AaY5lZbA0AK+DYY1L0jNM18bgXG7lMDLJaNYMBZT10H+Ywyda0s3v60RgmUy6SVKrxwk
         BLdYjhpsQZzwEeH9u93pBaSTNNCU6Yqjnpe9f3g7sPpyasUdwYjTvvWkstBMXo81+OIH
         XmIqAarVn8WI7xhIrewhhdk+Ue2uoVApo/sh1ReZfunj8UdG7eIc5e9OS773pEoXVEci
         Xvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446346; x=1787051146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LtJ0FlrjrhCujSR7QCF1Euu7B6F/UZWkp9olaYwhEzw=;
        b=bzYxZPA8DnGZzZhpM1j726DV52p1+VR9k9Ohk6nBt1IurX1x0LzA9CmeNL0Qkg+9IC
         jyhZQ5z10UkA6r36hdVFrYa6DN5ZMHLf8tCmzOvkD5Bfjt/kGWcrtQIPr49MSBiCggCN
         SjUieCCEx+KC23KrwjGRA6ylcnzftjzTSSzDdiIaYuYI04CNhepspb/wT/9wxmn8YrBr
         IXAhoZ4CucqZlHFm1iuKzrjtSsB3hf1suAPw+lRCEu5eD3VXIvzloLD+Loow4FdvayX+
         cQ0LTswpmvqnqMpEMM1xjUb0VqCP0QHrPhK5ONE/VJuSFgvD0dymJujQrOWpn/3fKeEu
         UmjQ==
X-Gm-Message-State: AOJu0Yw00ulaCXzOt53s04JnDM62TxOQL4HYbH+McwGJpFke8MIuDjRi
	0TW/TD2ErRGRvpZy2H9prPSXj1keYagbX+nBdDKnFS1soOEOZ6UrO545oYXllQ==
X-Gm-Gg: AR+sD13A5Fg0v81Bq1HfqSd1652qmG/WOkhFue8BT54Sw/0lTLqC2rfr49FuWOcFMc1
	ZyNldlPomruE82BdgZ5DAYq23aHlXP4TdYA9bZSc02kEJAQLsXdC03AyyOJx5P39Po72nQdvQHa
	MHxwEFO8pfqETUMPAf8YtUGAY/B7Cbwpi8ReHUZfPqiMI4Hq+jvrmNcWofyAQcfyx7BsrMH6LNh
	rm0Tkqq0/cknNscDHU41DKe7rXHhr4u1XAR71ANODBOKsnSxnm5zwjm3CPoH9AumdInpnMqw1T2
	bUZmsx1+8tkRjwtRcCN4VkLRWJOL304IdykLJZ9LxcHXI0IF9zgKFP62zSXFgKL62ZXwMcnd0TB
	ntg1lHvZIq5ba++jSw9S9dn9I/DJ9m/R+q6IFK5uxv5VupM/ziBr++AL7QzqXzV+DlCI9Hr1Ae2
	ccw3C30ecJTFrTXTdb7CVFyOvBvqQ2W1acD/pBpvhtzNgpDWMq/JwDz2php6oRdhd8hY8=
X-Received: by 2002:a05:6a20:2587:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3cc2ba57880mr2645758637.22.1786446346188;
        Tue, 11 Aug 2026 04:05:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.22.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c6404acf8sm3974087eec.16.2026.08.11.04.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:05:45 -0700 (PDT)
Message-ID: <6a7b0209.d76d81af.34fca0.bcf5@mx.google.com>
Date: Tue, 11 Aug 2026 04:05:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7037896213964781949=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajithpv.linux@gmail.com
Subject: RE: Bluetooth: bnep: refactor deprecated strcpy
In-Reply-To: <20260811094932.86448-1-ajithpv.linux@gmail.com>
References: <20260811094932.86448-1-ajithpv.linux@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7037896213964781949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144013

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      3.21 seconds
GitLint                       PASS      3.54 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      21.03 seconds
CheckAllWarning               PASS      23.13 seconds
CheckSparse                   PASS      22.89 seconds
BuildKernel32                 PASS      20.37 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      378.17 seconds
TestRunner_bnep-tester        PASS      16.23 seconds
IncrementalBuild              PASS      22.84 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/571

---
Regards,
Linux Bluetooth


--===============7037896213964781949==--
