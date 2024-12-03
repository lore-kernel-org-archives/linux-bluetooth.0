Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816C1362
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262988; cv=none; b=UEurRcEcg9s5ciYg1W91C+PXIT+dI92Z1xD3ewaMJNvaMUjMpSJlQ8YL0oSnx5sjHJrw7DgoH794lLU5+X079JiaB4RJ69ws8D7Io11EzU4aOq5Q3AbXf2X7J7UIBmtlaoJZLYF0IN5N1ihq/dcnNbrB4RFm6WjWONyQZDP4Yuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262988; c=relaxed/simple;
	bh=xDfr6YNn6Ops2BRHIm4MV3l28ghJWSixUL3TS6So3Ks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P6lao6ds8ZNOL5WivHXl66wQZeOrUbTOYAX/SFOj+n2mVuzQXZ5kDf4CVsKYbT+Ypmo3r/mwn2mYvCyI4/UV67Z92SnKKl9ScYTBwmc0+GQgs3h+4/PBo9EHMoZ+gy9yOBOXQqVqcSgUY9um0JUJIV6aCct+rVQqPkq023qgYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpcB8BAc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpcB8BAc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46101120e70so51121491cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2024 13:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262985; x=1733867785; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xNR+ItroUuY8nnLBf7gQ3/5G3b69kfPlGV6cBXdHKHs=;
        b=bpcB8BAcmhfzr9onKAT8muBQfMzrEiHWvimQYeXojagp1CEC9VmGN2foWvZwzl6I01
         gsajL/Dv219rKQvto5Bcd08bljMROhtIVcVVuP/9koUIe7UY1KUlM+1t962fBbnofpGk
         SKgxmAavabd3v/LlP8mppel4o58U8w9s0v+JR29vWFTADVVLQplOMYvhvEwot6XxOEYR
         +w5NTsj1bud/sLyuPX+KQB/A1hrigZNSJhllsQrq5arlIya7qfvYxw5dCAauMl8mr1+7
         FjIZnHsb3HP+c315Qtr3/xjVn3h3dBr0mqBcdzI785/kiCLyUIIste5Sc/RINGMqs5sz
         8zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262985; x=1733867785;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNR+ItroUuY8nnLBf7gQ3/5G3b69kfPlGV6cBXdHKHs=;
        b=qvBuaH2disdkNHXNfg/2vNbC65Pbxn6i0k4qQFT2ibp1Di6hIEltopd47uItInI7r6
         4vZtn62iyO5Y6kP8/XJbUD4RN0gGnmczQGG1gKvE0jxTDdHbL2QiTRyvioNy6YaK5bLk
         XZKq57Enqb5l7Xneioiz8wuLgo65KAla37gac/Qpx73hJ176N9iZMhkkxWdNCDdKBcDZ
         nyvE7yMOosK7Iaz5nWZTiJKBimui6MapLAMgLQREsho9xISMJ7YPXTDUveRgVINbjhxp
         IJZ6HdDPDuqJwrRm5Te+jXEYVsykKmjVw/asLwxyM2W2pJQ6yvLPZHnf7C4oQbDl2UJK
         Aj5A==
X-Gm-Message-State: AOJu0Yw6S7mFI15Pv4PTYIH287xgunzHQtO/E9VURk7B0ROTsBFoRxcy
	7h7fzPmEn+haeV2HrzI1TRP0T3jP/dKuwsBhNLdm9+mOSF3JVJv91VOcNg==
X-Gm-Gg: ASbGnctll/dS+1uusg9XpERFX7i3x8jAQnTA99nqkEY8MryIRI5mJSDBiC2jeewLOKE
	9ftf5DjMMrLYZq6/pz7PneOrdWirvLFXVpXKbbE1MDKn44GFw71VOTa0XNi9+5KXYlEC5y7JFmv
	VgAppU1PH3o0Z6d7xaKtEgwNx+AzLv4B3rT/dvp0wYeh2p2OZmunZfiCvgykiaRxI8XPuEFpOcq
	tKF85FPRqGWpUEqc8z+eqy0FiVLFtFmFpH7kjWot0DaCorxH0SkqjPc
X-Google-Smtp-Source: AGHT+IEYBCEICo7LnJ1kabspnHFscH5xnWqU5G66Nnss/bfC4QHwXEN5xJson8Mbf+o1feu0SgweNA==
X-Received: by 2002:a05:622a:1a2a:b0:466:9388:84d6 with SMTP id d75a77b69052e-46717c31580mr26358441cf.21.1733262985015;
        Tue, 03 Dec 2024 13:56:25 -0800 (PST)
Received: from [172.17.0.2] ([20.161.76.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c405729fsm66118581cf.4.2024.12.03.13.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:56:24 -0800 (PST)
Message-ID: <674f7e88.c80a0220.21392b.5db0@mx.google.com>
Date: Tue, 03 Dec 2024 13:56:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8044346782926274157=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix sleeping function called from invalid context
In-Reply-To: <20241203211435.194301-1-luiz.dentz@gmail.com>
References: <20241203211435.194301-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8044346782926274157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914334

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.01 seconds
CheckAllWarning               PASS      30.01 seconds
CheckSparse                   WARNING   32.40 seconds
BuildKernel32                 PASS      26.08 seconds
TestRunnerSetup               PASS      449.76 seconds
TestRunner_l2cap-tester       PASS      22.51 seconds
TestRunner_iso-tester         FAIL      31.42 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      123.67 seconds
TestRunner_rfcomm-tester      PASS      7.77 seconds
TestRunner_sco-tester         PASS      9.63 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      6.26 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PENDING   0.45 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was not declared. Should it be static?
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8044346782926274157==--
