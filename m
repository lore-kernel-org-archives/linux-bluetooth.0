Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085718DF8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755408; cv=none; b=qn8IPOfdPwE5WmAyEWBGT0AwFGprSXwDZ6Bo5P06JwJrFA2B8lLv3xvdLw3g1N5CXbhmvaSJVcd2vaoTB9DaOiaGsTRLRJAnEi02iKCvWN1NrT3BfnLH73i7lkS+BnWXYC0hYqr8R2MXyi6JBgHdRJXDFAlJD+jyy7LCsTXXk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755408; c=relaxed/simple;
	bh=02mQLknI+ENS4WTgpiCIbhmiiUvEMEHHosL35+DvsGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kMd+P3b9veAyjqTKXi61QPSvz0exGu72LI7gGYeFD7HoX1Tqn/ymTl4YGxXnltOnXBKi7/6z6HOAoq7AjfLS/26TJvpS1Z/snLzvrVuqNYqNrlHzF35cSgRMY1KK5xuhtJQkczGp0AqTEWdDjO404Z1mFsSTJPoxsGQ0ioroWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMYw802l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMYw802l"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c560c55bc1so566804085a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755405; x=1748360205; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N11DUQUNta1+jsQ03J05mW8aMSjbQvwonpSvErHP6p8=;
        b=NMYw802ly454WHCXOAMOCL8Mi+r5xRHF4Tk+xnmMYdfQ1MWAgRVLnbbhZqc6cu0lzm
         x8n/unFanPP5K/dqxYv3Z5GmV+IG9n6v1Be1vz6NStwMMUGGQFDr/IB/jgBZeUZ0Vj6U
         AoywFrm8WkpHL8YyeRVy7fY1HRLKp7Q0uN39Le2uTNbLiewlmMZnMbhqdvCVsZhZ27bq
         brcNhXIEoPilNAiZXHR6q+r4TmHhfBeqA22AK/wQMKUidyc7FEvKSg5tqcehrMxdUURH
         EDr+cI2uDVyTEROCsIjS/s3Kr+HknB9UFIrXiTV2SwgowsLoCeKYVXQWQiW8yWoB0OIi
         wmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755405; x=1748360205;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N11DUQUNta1+jsQ03J05mW8aMSjbQvwonpSvErHP6p8=;
        b=GiBbvU/rsYkcWKo6/tKs9q7yhtOFkSlPyl+nsursbUfqWGf7+RsmO4GJbyNooLS3OS
         wE+xoKeJqtqVfKVTub3bUJA9s6scYveWYKR9E84+nf4uxt5Ynn8tRjNRL3AfKNhQmlhW
         pT0+e7KymU/jH/OyXvUNrTBirwCCFozLgwbaoUfUZr9S2YioBV7fQjZWs1LEwBL8dLFv
         JHM74eRitsMLqNGWfTvsdVlBGXK1DCKEWBjrzRPyXah9QJAFNPjHLeqnD3cysHhjUMGD
         /GewUcUa/EmboGnvqMe1UQZCt1imUrem4DwqF70ZxDHFO2/8YjwkXMrKyMCx3uWRLVMy
         gJEQ==
X-Gm-Message-State: AOJu0YyqrnNT+EajuKWIvcBy41wWcqQLt6KuQk8P1FMhF5l7K9yr3pJZ
	U94IUqGA5fLCcS1qrhBWNUzhsEDVVFLD2c4nEMOiKenb2LdFxpkulFC0p1sp1A==
X-Gm-Gg: ASbGncuBY6+K0oLkvRJEwPxTBowDkY53kAgyvXYwI+UiaH1Avjm8HW4bOjZBsDOJWp6
	K2ttT0cWuuXbf8yG3QChwq0//E/iZqwAn/BG+R1IayXyPj7StObGby+kpdNm36aDpRvIp0U73t1
	FVkdgaVSJ2hKwIWduBnosGIxr5uxNH8m2+dAn0ndPlrrDsPR5ketcFnshsrErN/XusGtNWJM2qb
	1YavNwhBfTssKi6jRYARSw4WCC8bZcwd0MLcIkqvJ+dljl3d+eRLyi4zZlS4zeZwtXzPFPju6m6
	d1thOPkjCncyecaLPZvbfui8WTHZeZL68FKeUoDku1S0QMKooDzIuzl2n20=
X-Google-Smtp-Source: AGHT+IF0hS5zswSx33VsS1G4fm1K50/DWPPphup2hz4pEP3ZdMNAPMm3zCvieJ+DKaliP+zr08yJIw==
X-Received: by 2002:a05:620a:400c:b0:7c0:c332:1cdb with SMTP id af79cd13be357-7cd4677d30dmr2487806485a.38.1747755405576;
        Tue, 20 May 2025 08:36:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468e5a77sm747544185a.116.2025.05.20.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:36:45 -0700 (PDT)
Message-ID: <682ca18d.050a0220.33414d.d8c6@mx.google.com>
Date: Tue, 20 May 2025 08:36:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0467493326482442392=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: [RFC] Bluetooth: use RCU-protected list to process mgmt commands
In-Reply-To: <20250520144935.595774-1-dmantipov@yandex.ru>
References: <20250520144935.595774-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0467493326482442392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964617

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   PASS      30.64 seconds
BuildKernel32                 PASS      26.37 seconds
TestRunnerSetup               PASS      458.41 seconds
TestRunner_l2cap-tester       PASS      22.07 seconds
TestRunner_iso-tester         FAIL      148.33 seconds
TestRunner_bnep-tester        PASS      5.08 seconds
TestRunner_mgmt-tester        FAIL      125.41 seconds
TestRunner_rfcomm-tester      PASS      7.83 seconds
TestRunner_sco-tester         PASS      13.00 seconds
TestRunner_ioctl-tester       PASS      8.42 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.35 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.88 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x78/0x1c0
Total: 127, Passed: 126 (99.2%), Failed: 0, Not Run: 1
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.183 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.155 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.187 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0467493326482442392==--
