Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95046288537
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943890; cv=none; b=MFpkJ5sqqNO/lLodqs0Fh1hh/AAYQt9LdgNujbrwZztaKVDY4f0eKkOfRMggQfKv3Onw1XghctNvyvrIIE3Ob0qibE3H4LV1L0psZrN8emjzC03j54vKHahj/L/1ONQhyc8o0jmPKJbwEczp1yGKVHHxsvQtbF5JswLtXcmkRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943890; c=relaxed/simple;
	bh=96Ycw1shRUn6gJvmez8nvwSs3GZHmZd0h/960o5CiGo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q4jXg7jwUVHyLvepsniJl/3fz+ucOLcoF+ptcMUa21VWGG/VjvKkkSGnY2jcThAG0oNKp4PgXdNwUu5Quh0C6pLfX6cRDGHISzsvURwEz00Ss4U/xooYG4vqe33gZJGCGzfynmWuhRHBcSysnwQ8YrKI3IUnUbI1FfvZJQigDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhhAi9Pw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhhAi9Pw"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88059c28da1so6182916d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 02:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762943887; x=1763548687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dbIkJfvy+nmQltrfJ4zUcbO/oTOWEatoyI3ZrAvzci4=;
        b=AhhAi9PwbVg2LGR1bu6oKATF2QCTXKNOPgIWodXpAy0eIAXCRiK/PaqbWT70bcnTZf
         QT6jRtLgKW0FSLKNS1l7WB44y/uoOGHLUVo+qWbG7UmWfiyu/ye8jSFZqzYYEPymK4Zo
         cGPedvxsWp0sqIfLeghIQ7kdAyxnshUumsASQc/bM/f6zG2c87BkIMZDxd22Goe1hAV3
         L1PFPDcFDg4gjB/3Mf1/8VsfxeFe08ULheEAg9FmATkwouQtXQXjAY3dzUUdWC8CClgD
         NJWlO9XyfVFJdu7GLxr/pebaaNjDsJBIy/T+Ix7z21AuX6e3aQE9xOFDI7ZHi/A720SI
         FFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943887; x=1763548687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbIkJfvy+nmQltrfJ4zUcbO/oTOWEatoyI3ZrAvzci4=;
        b=BnEn8U2ZhgClunYV75cAGuukyBNebxL2MowAsXBi/mYwU5v//qusV2JkNoRyFFVCN4
         ikVaJhJisnp+1QsEsd2cd0QNpiFI3HtysKN57k+XnED3u//sTxWA5yybX2yEPhEFJnih
         KyZvGvfNlgI1vpiuhy6ZpYhVo583JcLbQ2m4ZDHoWA3u9T+Gdrsvp/pjalOTVNa1O3mP
         cVai2m4NuA0GZbc/ipAduF1NdyOgpdMr5p9xxdo5L3/KLPuGMxxiPVFl7LpjtIcfhr7e
         kaxujomB5xxs9dDcJ90ZXd6zBNVOk9GPFneglSkVg56KUMZ5pJSLmMyIxTwQrXtChNr0
         AY9Q==
X-Gm-Message-State: AOJu0YzQ2/pQjC3UCSsf65Eb9ZtBm6mMHLqjS2EzZQMHnobG+4lQZ9V7
	ZzmHIbLsbINWt1csIyHW9eRJuhjQbRHQASe7wCZlRPEqpm3/oj6HKMNdrJko/w==
X-Gm-Gg: ASbGncuGIPMZcXTLuGJvE0Kq1GPUDLsIOkeDRTV3tJOuUnuKePr3HstHT4bxhuFI3VU
	jbwyvMYtlmvr3YmsxaVNZVw3g/wclIcqP75Qgmj2mblafQzvs/uBU0yCgqYBcuHXBHIFCa8nPdu
	5xwM0GbUCN2om8rOXe4rCNdXImZVbcZ/x/B1rAGfWVf0cdjLFFax4New+AGkmNmNWMukWkrtWWt
	Ppp3AJgZs9MPecUxZCM7hbMGO00d8FnFxuE0SNSLJ0kfo915vWEJ6FBR0JgWnU1SXg8vODDnBH7
	onZGIGo4+GVkLb65K2/H8RTvt+Ifi2MHjLZ4GIuvqubOTYBGyaW5/4rhmH4hpplPewKgdA5bTQJ
	RzJhBFNdpZzr2LZ8k6+dxiydKAhlr4wqwfZrAGr1h941BTHgtMWaGCRLu6alySg7u+k1hx0aOO9
	hY2EAL
X-Google-Smtp-Source: AGHT+IEDlb0PHs5jIcaM8NlUmPfgs3RffsTVEAPMkjHM1z9xsXQVFeL4aldYE8N7il+vdB8sqowXjw==
X-Received: by 2002:a05:6214:4107:b0:880:4d8e:895c with SMTP id 6a1803df08f44-882719d7508mr36101696d6.40.1762943887216;
        Wed, 12 Nov 2025 02:38:07 -0800 (PST)
Received: from [172.17.0.2] ([20.55.214.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238baa0aesm90310836d6.60.2025.11.12.02.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:38:06 -0800 (PST)
Message-ID: <6914638e.0c0a0220.1c8f9.5024@mx.google.com>
Date: Wed, 12 Nov 2025 02:38:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3986627965371273969=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: [1/2] Bluetooth: Remove unused hcon->remote_id
In-Reply-To: <20251112094843.173238-1-13875017792@163.com>
References: <20251112094843.173238-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3986627965371273969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022417

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      27.65 seconds
CheckSparse                   WARNING   30.90 seconds
BuildKernel32                 PASS      24.50 seconds
TestRunnerSetup               PASS      491.71 seconds
TestRunner_l2cap-tester       PASS      24.03 seconds
TestRunner_iso-tester         PASS      54.42 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      113.43 seconds
TestRunner_rfcomm-tester      PASS      9.66 seconds
TestRunner_sco-tester         PASS      14.70 seconds
TestRunner_ioctl-tester       PASS      10.45 seconds
TestRunner_mesh-tester        FAIL      11.73 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
IncrementalBuild              PENDING   0.90 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.896 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3986627965371273969==--
