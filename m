Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922921DDA20
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678381; cv=none; b=Z/W62B6/ASUdU5BTmR2f3O/ULeAiogK9cohDEsD06fgz/tj8f8YFjj1JhmnvPRmuyg99eVZx3TxQOZ/k8VNlAdPBNE4kR5tOu4ejOqz3CJ0Vi3K7XnTR1wPcWUkRlnfHJARSKv/gMllwnuaLor1YQySO5QIHeM67wmSdF5G4Pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678381; c=relaxed/simple;
	bh=Cv2pppKLSBzZvErdeBp4+24Y8wFf6GNoW5zwbH0tJ90=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FGeKvbBUaionaw/6JWTv98T5GWkw2sMM7rcqmXz1SEBMlghBahZZveYssrN7JrNiQYAZJNpE0dNMfEQKadrJqMPQHaSR7t3NIVFBbvU7rAQZ29hNeAa/bc1EcjodQV8Q69MXmKdgXVu7VUOhAW5lHWhBtSyInq7FFsHiFiVFeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+sHdvOq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+sHdvOq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b148919e82so46639085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 05:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678378; x=1732283178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PWjtB38wOx5hPXDOkH6apQP/JaUnl8U/6xq8isP+DLA=;
        b=A+sHdvOqoHJS3KQI332V0acJGJBlvQ+TDs0egisCLIR3GQ09er5XVpt2Z4i1MBk6GT
         Fgm59kPflb9FO5Vik/+6gtrzO3nQkUkPjtISJU4MM7cGFUw9b/P9i1YmXflYzOAra5cw
         xaZ7L06smF9mhh69nsLY/jD2bG3siyT1YOkAgfF6Flfuz43djant8RN59M+pcPKQoxoV
         NVIlav5qOmBosrDDw8kGahJ2Na6+bwUhyF95E7IjkkvEWftIuVMASPs28vMg4NTuITr0
         0J46Jx4T5jc+cIvyvP/0yTI9vwHcH/LnBRgX5idca2/uWhUOO/YqlWJTRi737pRl3qYS
         pi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678378; x=1732283178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWjtB38wOx5hPXDOkH6apQP/JaUnl8U/6xq8isP+DLA=;
        b=wjcbAtkOzAEMweFWhRAJ2tJdNHg49nikybENlMxbU5u6lf+5/Lk5JDPiCLwUrNx2QI
         hmWFHCQbwW/T22g5/cFfmjrCA5XZyIxHu4cTN6vYWIJzSSHC0cL1mI8b5tZI7KEu6GJ1
         l7UYOR1tWwzPGhFadO7SL/6LDi/++WyohAqVkPRofBZWyqkqU/t7TD5vreDwAK+nCaWO
         QVbFKqU7WqsgM/mj64x9VgdWzPVXrhr0I/TSdusawBq8bt4k4Nmej6gqMI4Apu/Npq3F
         1bfgfFvaS0Pw+RsnAT8OvIPgjutB4j9kCdOAY35/aAAKTDDYZJb4Js4lNfj6T94p0Z9Y
         lecg==
X-Gm-Message-State: AOJu0Yw5lRihG8TqQmvmnlTYzbzwLf9/oU8IxWcvL3e6QGxJB5lvfa0a
	aGuxwbx7qi2JNnn3XXdWi+IlASKEATh5V4GCSlSnl/YZnCJ2uWcbEgHNaA==
X-Google-Smtp-Source: AGHT+IG1RAjwx+3cH679B0KKX34MO+MCH42K1We4nc3lXZvsJZxVXvL4ZujMpAARE2WHYXWOHBr+VA==
X-Received: by 2002:a05:620a:17a3:b0:7ac:abb0:2317 with SMTP id af79cd13be357-7b3622df8f4mr421658385a.37.1731678378195;
        Fri, 15 Nov 2024 05:46:18 -0800 (PST)
Received: from [172.17.0.2] ([40.76.119.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984531sm159878285a.22.2024.11.15.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:46:17 -0800 (PST)
Message-ID: <673750a9.050a0220.23c208.5d64@mx.google.com>
Date: Fri, 15 Nov 2024 05:46:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2461319306978907893=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhal@rbox.co
Subject: RE: net: Fix some callers of copy_from_sockptr()
In-Reply-To: <20241115-sockptr-copy-fixes-v2-1-9b1254c18b7a@rbox.co>
References: <20241115-sockptr-copy-fixes-v2-1-9b1254c18b7a@rbox.co>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2461319306978907893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909980

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 FAIL      0.68 seconds
BuildKernel                   PASS      25.03 seconds
CheckAllWarning               PASS      28.08 seconds
CheckSparse                   WARNING   32.00 seconds
BuildKernel32                 PASS      25.33 seconds
TestRunnerSetup               PASS      452.91 seconds
TestRunner_l2cap-tester       PASS      21.30 seconds
TestRunner_iso-tester         FAIL      33.60 seconds
TestRunner_bnep-tester        PASS      5.04 seconds
TestRunner_mgmt-tester        PASS      120.99 seconds
TestRunner_rfcomm-tester      PASS      7.93 seconds
TestRunner_sco-tester         PASS      11.58 seconds
TestRunner_ioctl-tester       PASS      8.54 seconds
TestRunner_mesh-tester        PASS      6.31 seconds
TestRunner_smp-tester         PASS      7.28 seconds
TestRunner_userchan-tester    PASS      5.42 seconds
IncrementalBuild              PENDING   0.40 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2461319306978907893==--
