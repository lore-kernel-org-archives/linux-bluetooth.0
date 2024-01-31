Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B912DDBA
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723817; cv=none; b=OcXwJ29+g7kxpmBJzVmVb3BN265HydFLH1c3GqWTGpxfiEkHTjGXv5VzQP+xh67ak7T/A2y/3oUvj0eW1dEd8Se2j29ufcPM66/11Nj6jb+hzaKOnSXeN7MhrlgLZhWY8hQ/p65Lyz9fzlgpk2clKlZvKujBPVO03BLbyNfgWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723817; c=relaxed/simple;
	bh=9yk+a/TWf63TPobFgSjb7Bk5dyHIGZHEmiPUfsMV/70=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oxB2khmHG1mWQYniDxW940eWtTkIIIwaqmLwn+pEqLcOABpuoS8LpyH65EfhB/mPeXLK1HBUGH3GKaAp49vExSi3TmUvGs9twl9vJWOQGyCpbSYQZU0YbXjgs7y06Ik2rE5ZsJoUW/2hty0WqdODHzYnWLF34HGOl0RW13gXqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyb4pSum; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyb4pSum"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783f553fdabso337485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706723814; x=1707328614; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SlhPct11c1qEdw1pnLaVFHBlCrOkXzGkdGfHGECUbwA=;
        b=Fyb4pSumyYSyj6bI6TCBFHU8xXTzVqVWSDhkoNeqshURE0JK80rfVCXnMgPWtpM8qt
         iFUwf/aVXQBrMXdxzx9mRaVcF4408OULlLz6L008ewz3IselVcHhoJEUBUaj+No/q9PS
         0MH2mzi262+ETNzfTxdmeW7mlhQvwDXxcfg67y/AeKgUYtkAQweZ16TqECaJUfCznO5W
         PsV3gmhvih/490Fs/TwxAt7tGKUlyMFjO/1Syrqyzcl+GbUwChs80LVuZTYzve5NyjVR
         xNKanqs4DXj1lObZhXEDkYwfoygIAvEcuFu/BBI7l9WzBZHxFJ8GRkW3IO26uaa0VgHZ
         +OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723814; x=1707328614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlhPct11c1qEdw1pnLaVFHBlCrOkXzGkdGfHGECUbwA=;
        b=nqh+h3FrUc5qARiXhldtclEVK5QPNOYvBy48A0BUkDOF+E9PwtuyfQtR4bgxFLoFWz
         NHV3KPdSfXxUDDF4fKGIUwsnT17M/UNqDjl0WFjmeWw3RlVVJ/RPQrjLGagiX5euaq2h
         AZqSZwsi+ETQDveLWEjdElXbK4YdQzI6oKfxy3GHmthDaLQaD6I9ruRNjMMgqJbpthtn
         4dM3y3mhU5idlthSKyar5mMV0fhvTwf6PiWyjo46vBJg+tq4JekcdsubwVKQUuX5jlXO
         9lyqvBiWwCsKRhkBPTbrl4nLVWzyU8uqpjNKNjrbqTYkHgeBi5XfDCjWkJUjko+ZBXz8
         ynoA==
X-Gm-Message-State: AOJu0YwTVbVhNpruCscz2YbO55ZvZTuSqfp8tgExa7ozAY5sGVsdfuqk
	87TUq/R/yqgKmdJB+1XjDqCfag9xTigVU3dqypjL6IqacKuyDXIneWUhrrI/
X-Google-Smtp-Source: AGHT+IEzyrbZne/mD/7K+PHKmLwGX0hLePAXhw3yAmYhujzVlXOjsesQAFoDaiMFgC+f+KOInw6yCA==
X-Received: by 2002:a05:620a:562a:b0:785:158d:8ff5 with SMTP id vv10-20020a05620a562a00b00785158d8ff5mr31895qkn.61.1706723814319;
        Wed, 31 Jan 2024 09:56:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVPCGaKjNhdCM29eVmOVuoM7nbGayH8Xizy9/JkiO6YH8r6MdWYqh2P7z5Q2/O5ME53ztOsdHQ0hSqk3eflaJKG4GVOyQ==
Received: from [172.17.0.2] ([20.55.46.116])
        by smtp.gmail.com with ESMTPSA id mu12-20020a056214328c00b0068c6d56d4f7sm768809qvb.92.2024.01.31.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:56:54 -0800 (PST)
Message-ID: <65ba89e6.050a0220.1abba.3a4d@mx.google.com>
Date: Wed, 31 Jan 2024 09:56:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3425687986174423797=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
In-Reply-To: <20240131173002.834951-1-luiz.dentz@gmail.com>
References: <20240131173002.834951-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3425687986174423797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821810

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.93 seconds
CheckAllWarning               PASS      30.77 seconds
CheckSparse                   WARNING   37.09 seconds
CheckSmatch                   WARNING   100.53 seconds
BuildKernel32                 PASS      27.32 seconds
TestRunnerSetup               PASS      438.11 seconds
TestRunner_l2cap-tester       PASS      23.43 seconds
TestRunner_iso-tester         PASS      43.58 seconds
TestRunner_bnep-tester        PASS      6.95 seconds
TestRunner_mgmt-tester        PASS      155.85 seconds
TestRunner_rfcomm-tester      PASS      13.03 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      12.02 seconds
TestRunner_mesh-tester        PASS      8.92 seconds
TestRunner_smp-tester         PASS      9.80 seconds
TestRunner_userchan-tester    PASS      7.31 seconds
IncrementalBuild              PASS      26.92 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3425687986174423797==--
