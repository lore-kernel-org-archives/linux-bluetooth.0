Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A3227B83
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809219; cv=none; b=TM4QSnhyfwosMBtDn9EO+6HwP2sFc1VbjDHrLX20xSUv86XGYDMx4MoTZVoua9zeaogX4xnN/iXs8MEVEDSTjXMjSMb7J/hxkfJUhLhZdeVxBJqFIXrvoE8IqY3dwIVlTIYemF0M4SyhfuDHIh/9Fn3VRv26HxYjcqaJ6V2aghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809219; c=relaxed/simple;
	bh=7z1HP+opAtoqfTwZWNJNfdA+wArJRlXbGpxib1kLbfg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dNxXQnWiospqmJWVscURZr+acd9ZxMCLs6hId7oLVvd2FW/ILisn1/WKv4u7EJqzOwKB/V2gk1aOfXpU5XLwDkI3eCN1wnurjXRrMrAFcjBMZ0S6mEhqbfur/BJEom/clfLhrRmxnegmNLzId/F7s3pilzUrwJCf943sT+DIzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlDeXLxg; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlDeXLxg"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso425695ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753809216; x=1754414016; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vD7as/MBDBluLir1w6l038QDKjKkVar8nHSzt5m0xtE=;
        b=dlDeXLxgFHaYAq+bzK98LZBqwXyvuEHqyQzt/TAZn6w1bM23SwlhPzafjrKgLIdli1
         7fP0HQtoAO4FZdrajkjBURS/kLW3qCX6uvUFdGscNnufTTfZx+bpFOy487o7PIoDdyYu
         wmtIFBONS+wBfk1yrJJe2MhEDIg8IVm1c5h9CtlQ3Tkaq7rmg9eAv5sy3tMPTooQA8vz
         OSSoKqpjEnQnSdr58nGKysI/hc51+pGFqGQgNB0UZt0Y+x1c7g7y7JhZDTrh33dStq+J
         gWQGRj14pw5h4c/7TRsW7sVsuu0q2B2ltwASooCQK9dyoE5YIvNjPVVEso3HWbGEdQa+
         0Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753809216; x=1754414016;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD7as/MBDBluLir1w6l038QDKjKkVar8nHSzt5m0xtE=;
        b=ZroFJuoDRDnwhfK+pBp/5J8R7OAw1U8GL8FxRJuDyyWLtUv0+NI+jVokjxFSScebmZ
         D3RuH1qB9aJ8ilXL1z79UnbkXTEID+NFFywWNZN7JmMkhM2FntTEY/TYKSgn/aLA4EmJ
         h96D6mAC9+KA43nUz89a3S+BX+Kc+nltepcR5nj/z59uaUVnKvkf+1dJBWfMOYq7hueS
         H14JRfNktB+np57CgtXHl9NIMPGXW0bfB+BqCQ7nTefQaSs5cYy5BQicvnpapEHD3yMe
         M6u6JfAFR0hl5Q0JYBF69ksXCdt8X5XA3tbUXBIuwNuikTZJfHHaBUOozSnkyrKenAvn
         WHag==
X-Gm-Message-State: AOJu0YwPp6Qo0brVtAMSDq5pBQUzk95tDPTUAGi7sSD4zal/9byrc4BI
	UDRAf8afr5OmZDISS7dLmBJnfqTNgl8FWMKgmkWYkqOSHEraBAQGKC0h58xeBg==
X-Gm-Gg: ASbGncs8EdWKKz9qt/gQCwjoXhZe6U5l7KLCfsd9qKIhoQuk+KqDxkC4JvMdS1quYtS
	1e0aj7z1L6mPsSCDrgmeM5L96BB6k/yA2C8ukqPH4vgzB/sWACvQrI1Aen/w4MpjUCD0B+h23Tm
	ankeQup/Ey7Ai1N1ryqmxyffyT6Pd9yaG9MEWGzYtvWqfCzaV6DrzuuKJLDm8XxS08EeMfsk+xK
	oimcJnHz3MigMy8Jt2Hf2JJ0a7CFLGLY/pvyvl2FLSXE2WKr2qsVC59nqL1OSKHZU22rVrpnffw
	VlGjrS4lFYK09Lar7/3fGTVUd0WcankHB94KrU+tkHAmrk/hZPG3GPXu8Kftzh6u2mKQWVdsDWx
	orbWE91JjwoaRnNAV6n9aLDpY3HOp784=
X-Google-Smtp-Source: AGHT+IEz2i1mNlA119HV5OyOVfdomVB0DHhmmciN1YF5uuQJWwsDw3TT9/KliO/gHcLSoTk/DMBwLw==
X-Received: by 2002:a05:6e02:cc6:b0:3e3:d52b:dc56 with SMTP id e9e14a558f8ab-3e3f60dace2mr4622795ab.6.1753809215903;
        Tue, 29 Jul 2025 10:13:35 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.184.209])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3daf2fa3csm21111525ab.9.2025.07.29.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 10:13:35 -0700 (PDT)
Message-ID: <6889013f.920a0220.10186a.38cb@mx.google.com>
Date: Tue, 29 Jul 2025 10:13:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4243677786162330699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/4] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
In-Reply-To: <20250729162453.221656-1-luiz.dentz@gmail.com>
References: <20250729162453.221656-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4243677786162330699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986789

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      26.80 seconds
CheckSparse                   WARNING   30.95 seconds
BuildKernel32                 PASS      24.47 seconds
TestRunnerSetup               PASS      475.50 seconds
TestRunner_l2cap-tester       PASS      24.69 seconds
TestRunner_iso-tester         PASS      41.70 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      126.31 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      16.67 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.92 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.128 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4243677786162330699==--
