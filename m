Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152C377EA7
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590495; cv=none; b=q+KVetFvugaImfbInvwVkxG2bUGpw6x/6F06xISQlZ38mjWlcpTRW07UOAkTCRS0zcSSQmqTfS8xhHJNWdPtpNiI0ew0PpDqGl4waWQK8EGrslTtbMr9W3MHyE7hsGUOy6ntzUfqoLa+KF8sQsCnr9XGe4yG3S/UyBLWwztQJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590495; c=relaxed/simple;
	bh=UwtBRHvWoqEZ7hLxkjPNk4yoGjwytYHlH+wCHPsNduE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B1YdVZBZ5Z67f9UE23wqtQKOV16f1E1LaFJuaO49oBJyDj6rn87WdIlxxndtB7/dIcHoH8qvUT+ecyXdtY1AGurNOJbdxd9KOOqqkUvTjXntcwyt3MKGGj+xEfAlba08Ico3Es++3EokVzy0o81AtL8qSFWH77OOCGs3HMwm1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InN2+nAL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InN2+nAL"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso50667475ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787590494; x=1788195294; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dy/ExOyhuLzyNdsRROALx3mweHwyMxV0zKvIC0pHVzE=;
        b=InN2+nALGEpex6CXsGsW2/upCzMwz7vL5GWS1TfB7YNySq1wGVrQyB4esrL7fReQR6
         yINzLD/Jisbbmu/bHiyjLidLyuqm2bfYqitFZRfyXG0+gskAbeT+ebla8gL6XPHfxTdZ
         8OgM1lQ2qo2Pd5Jci99ir1drYFwg7X9U11qO0JEx9/NoSfR+Xn21NESZ0n5S2tTnPgP0
         enTUdaVb72CQHOYzbwwF5aeuW8UntwnXwHJNPT/XmlnUkuF8F0+7yyqLf1jUPGD26dVt
         GeH7bNp6C3yQzSTILHCOA40d+4Gj3Myviac2t+etlkluNhsIeqKw+EySn/SMe70wtsuv
         yUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590494; x=1788195294;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dy/ExOyhuLzyNdsRROALx3mweHwyMxV0zKvIC0pHVzE=;
        b=Pr2sgIDKvhk1VJe/VuLArP6+m07HxfKtvSDa/nJqBZX4d39Zrf0wubWhTXN+OijHUt
         KSEuorq4Gl0zmcfX/6Qctzx+fzL3um/6e/1EF7u322S5rjjjgvO3oOUu0e3mf8yRsQ94
         v84j6DN0VwWQEUkFvZMZhGmHiqLvT171TcXv+0jHw3rekMKsQBoT/EN1Cl2wxAgfCZBv
         77PuBGEOYrg2bhUu81kZSUd0WpoecfRwTujL89+PgymcGabYqgTLPOGWRm+uiCM6kKSG
         XGw+Vu3pzmTFCd7rofcDQtA1JgkUlK0x/6+qz1UhY+OjinDDm+kydoooAVczJILdSTY2
         6Orw==
X-Gm-Message-State: AFuF++n/2d3E3u25ToMDAD1I3cHlFDGF4ZGCr6QfkVfey9D3iEfnD4yu
	eZparQAWszFRfu04yMyfeHuLNNtVI9RDv8JiG5vbUOHGd7Ajx6fx5jEwPuEVyA==
X-Gm-Gg: AR+sD11D2O9CHuLI4rd1afgUsDXzp1GrwUtd3o7GLMWW74TQniCkP6Fih1oV3U5KNnh
	iTADHxAAmONeIVm9INLwbzkwoPNcaX/rCuTnp2jXDn+2GmgxnXNatPjAQXK6w5OuqtCZaIr5KEC
	H1sZYbt/XmjLF5RfNbTnD5sCJB05QH8DXX0iORPhchsUDLbk198YSLx4zIGzrgyMBbKdgvZNIGk
	F+jL816D2iQZImu0wLpY7/S+GxSVanQo4i9vruu36mjrOevu2F6kETQlCAcPc6RaCQwvdokvc9L
	EX31gbT/RY6W67Ocq+L8UzzrrA6LD4mKsF2/UVlTYrsn9eNL6+ZgropeNQL84pFqTZ92I/cp7wx
	6aF+kFmC4mwRJXw/sExXbPaISgB2tGPTc0JWlu2H9i9UJa9cgFCBIXSPBB1FAQ5HZ2YiEkFXvyH
	JT9o9PushoDIwbNaEJbZrMQlLnjKHO0KnsfFuujrzb4EjWO8Hu/d+gU0pJEwtk07xO6LCp
X-Received: by 2002:a17:90a:d605:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-395df5e8fefmr37518469a91.16.1787590493683;
        Mon, 24 Aug 2026 09:54:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.139.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm26503463c88.10.2026.08.24.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:54:53 -0700 (PDT)
Message-ID: <6a8c775d.d2cb4adc.3b4790.495a@mx.google.com>
Date: Mon, 24 Aug 2026 09:54:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8906070072589230575=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: [v2] Bluetooth: hci_codec: validate vendor codec count length
In-Reply-To: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
References: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8906070072589230575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151041

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.91 seconds
CheckAllWarning               PASS      30.87 seconds
CheckSparse                   PASS      29.80 seconds
BuildKernel32                 PASS      26.96 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      511.79 seconds
TestRunner_l2cap-tester       PASS      67.63 seconds
TestRunner_iso-tester         PASS      107.24 seconds
TestRunner_bnep-tester        PASS      19.71 seconds
TestRunner_mgmt-tester        FAIL      225.37 seconds
TestRunner_rfcomm-tester      PASS      25.88 seconds
TestRunner_sco-tester         PASS      32.26 seconds
TestRunner_ioctl-tester       PASS      27.28 seconds
TestRunner_mesh-tester        FAIL      26.95 seconds
TestRunner_smp-tester         PASS      24.28 seconds
TestRunner_userchan-tester    PASS      20.92 seconds
TestRunner_6lowpan-tester     PASS      24.71 seconds
IncrementalBuild              PASS      26.36 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.260 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.264 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/646

---
Regards,
Linux Bluetooth


--===============8906070072589230575==--
