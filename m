Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513291DDC5
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617363; cv=none; b=J4ykWT0ZdoITermNh075bqbHd+O7bpneobzjDMgW7O13Ln95Jmm+Gfa6upKFVaE6ua4KODji8DWWnkJTTBmP7qeAiUgqkrC7MnsdH5xX3IikIFd3YlufWwkY8r3T6BksGCnb1VRRFGxUg9fQXEtPizWrlCpXkkTegx1FqrFF8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617363; c=relaxed/simple;
	bh=wrvvdj3rD7qyyS+dlBya6Rna7OFljeoAtz/hqyPhH8Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s/VlBYrPBTYiLDDFWBPDNqpjy1tCVvpLUfAZBlC5RvLyXN7Htnlchj7eK8Wyq2ap0iq9Td7B/rVF9HJhjhaNEJrsHRuIHL3wyhQbgYoj11mzMh/y9UKjLh0Ok6apnWRpeTrI/UGa2pLOvdV59dsyit+tP8CmxAAliyEWmck4HMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbbkSWyL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbbkSWyL"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f06c9c929so69393285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720617361; x=1721222161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SiFiswxrVgUbUKbEHGh+VVkDc3YFjidwemnKfYat1iY=;
        b=VbbkSWyLFauQyAcszrmGUDMmgRMUDgg4wFB/L/1EPC8dDVjjFWE4ggrzd9B1cc/W+8
         +/Zg18j7lfsnYAp9uV9dui2JrzCHwtkSOg1jyP0PnfDZEU/67nRZ+pZfk3gZ4iHh/dUK
         cy4/zZIrXBFYg8+jEP55F4FITctkriFKXu1sUvVTx2oRMmtdECrpJ7pV3bgQf/nnld2+
         Xf7Eo29gG9wwj3lavJc2QvBrU7WpPmoOQjRv2lEbYajgpQdiCdU9+quhEpS8zTovevSg
         lhGZaT0n4W3FwDoONeTmNgLy5gExPlY/HjdpJHYu8sAOFQ5WrJnVNoOBIK+3wEhwE13C
         Anpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617361; x=1721222161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiFiswxrVgUbUKbEHGh+VVkDc3YFjidwemnKfYat1iY=;
        b=t2AbDJJXmdx0o16lP4GckIj74MKpcQ9bvkjuuf+y8iX1t7EsazIoYL4VxcdonYAf6B
         PEbIneswYZhaCvSZPqP3JbS/QCZWRrNKN0/ZbsPCHpjND+tOUw3wWyl0VQAyMNyFZ6aC
         CiTbk6FZdq8/yRifB8pw2UuT3HgYSxeygZ2fxh+sknLFmqX5mLRpW1kpM6TprkAr2D9E
         IeapWBaWfoH6NuQ4BP9yKO+8wmyUzoOGZwudB8oAjaBloRiIOf53/dMKb4FXCOw/I0v3
         fM8gyBYW0HTV3ldOc4znKVOt4nohMBgsfIVpOGv3g1KB20VcMlwLRlKf1ZCz5IzRzj6l
         PwfQ==
X-Gm-Message-State: AOJu0Yx1V8+/x5eMzPg62O8iOWvSjOS/1CLklZhYXsoOOk6vuRqIqZ5y
	63vR3OU+uW0bhe/dzbXe+SdIljFeNrtyRsT5ULuV2VcH0w3GreIIsc1K/g==
X-Google-Smtp-Source: AGHT+IHXlaCVpH2EYEXI8tOW9xXolgdpF3nCzQHvnQnl8KlCVWBoy2q+GxoTMHHdduIztgQDXCrcLA==
X-Received: by 2002:a05:6214:5197:b0:6b5:7e74:185 with SMTP id 6a1803df08f44-6b61da12202mr67259936d6.30.1720617361070;
        Wed, 10 Jul 2024 06:16:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8f11csm16881616d6.104.2024.07.10.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:16:00 -0700 (PDT)
Message-ID: <668e8990.050a0220.4aad7.6d70@mx.google.com>
Date: Wed, 10 Jul 2024 06:16:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3400949687002984066=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Fix warnings for suspend and resume functions
In-Reply-To: <20240710123426.935122-1-neeraj.sanjaykale@nxp.com>
References: <20240710123426.935122-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3400949687002984066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870105

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.53 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   PASS      38.44 seconds
CheckSmatch                   PASS      103.44 seconds
BuildKernel32                 PASS      32.49 seconds
TestRunnerSetup               PASS      531.52 seconds
TestRunner_l2cap-tester       PASS      20.31 seconds
TestRunner_iso-tester         PASS      37.02 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        PASS      115.92 seconds
TestRunner_rfcomm-tester      PASS      10.37 seconds
TestRunner_sco-tester         PASS      15.14 seconds
TestRunner_ioctl-tester       PASS      8.03 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.21 seconds
IncrementalBuild              PASS      28.18 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btnxpuart: Fix warnings for suspend and resume functions

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202407100518.06Xxq5PK-lkp@intel.com/"


---
Regards,
Linux Bluetooth


--===============3400949687002984066==--
