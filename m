Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D572FA0E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016813; cv=none; b=GPfP/mvaEqb+hb60H+9OhfRgWBv9/UDKWg2bjMd5WjEogJv8lBzgSX7/ebkWZLE2ER7/yUh+ZqG6K9HbdGFOgLVy2GjtnA8ekqoACFRCnkEfd0+dUPwCTbWG7G5i6ApnzeRq8drdl4FR1fsRZPdjGMuEQRsnmlU15V1l5JpaasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016813; c=relaxed/simple;
	bh=02j46ZwOXEXTH9NjhRs9KwHdQwlzXZbiL3yZV4g4og8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g+stRiCo4na2cojJXmn3+dDn1iN0EAVjyIl1BMaHY0ZqMKtGE4jSrauN6W6Tfpl+Au6prRWGQWQYJBFMdI4FTCIHs7/ZAr4FIP0Rbeb9zgenbLgMvyyDPEIM7K31Xk6m0izoavdo7Y7xq67VtGE3gyj2lktVr+zncJ3xXyOcYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh6+UM/2; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh6+UM/2"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e3f0f29d09so26360585ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016811; x=1755621611; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I2ZpNIvZh1l5OfhFQtIIIILo45NCRPPfZO5dX5uHquE=;
        b=mh6+UM/2G3MDz+ehH6LzYyVUMUMXqTi4ODz7BZEmob1r7Kuqsen07kunxmXeoI4CCW
         /51kVTyRWXLF665V6vTROh3UKD+kNC/JNwqA3BCc5HuDBVkRss020fsJ6FPmU+0oeXbn
         XqrEmbsb7sDVN4UZMwZ0yzqQeO6kBbFE/gQryce5tSibwOyUAV5/c1L0i08D9/EFMpAP
         HRoEy5B1Lm5bFX5mBLzY2PY+gxL/tALtuZkXgnLyq4dka8DX2fBKiPUx+jmcxDxT7LnV
         KtT6PwPEBG9ckOEliWhuj/ZU4FllG4qyw//V8jnpjlQYFom0KB/bAPGyh6OmVUI/txW7
         /nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016811; x=1755621611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2ZpNIvZh1l5OfhFQtIIIILo45NCRPPfZO5dX5uHquE=;
        b=kmuH3a46gHl4fqnzFSqUjxt6dbU9CpN901tYbnEf63C6I6lkgF1nKa+x04rGjo5Lqt
         cj/wBCNqS8kFdJ7RJirghD3x9TDH46evlyLhTTUBcvrKdi3sQytbz3CNkmtaH7u8OMY5
         3zdh61o/bMGGjD00RdfSdAlRzPLemY4F8Z7u6lnuuXgt+qEhlIIVnXXsaFaMLSffEQ6b
         g4sKg8U+A3aYJuMO0UwqNBm+CscNZecuaqlqwHTHZnUK+3UHbcyha6/MWhMJsQFhyeQD
         b7Q4oqb3vyR51O+Ngpu4ImPZO9EY6mNDA8MghXm419is9C102qObUlleI5XthjZ38lpQ
         AQGg==
X-Gm-Message-State: AOJu0YwPAMv07hdMTsNBdqbg1l+oldFYH6bpWNlRy43nwsKE9nVp6Tug
	4HuARkKTHU6ce7FGTEey1ar9YIi7cye97pNihTpvdHOB664yYiMyqHbSqxh+Qg==
X-Gm-Gg: ASbGnctuVNCdn+15ZCbBTzQwxpqD5+Vj4eHPVHzjcEF9xRyktDt8CNJ58hmMLx0st6o
	KUETN+gmNWgIhFBp3mgq/tS8ZRIxtgOIpa56/9VM5XxHTpImla47k3Q8GtDAEfrR/06EP01gQMf
	mljl+dbPaCuEkTL+pWkTVNinGcWqh6Hoo6uOmyb7tItMYtSn2kKK5+nNzivrHaQyhE6cYQ62J94
	t1eM1mNflz1Malx9+lmoZBdCCP7QhPD2Rm7Tx+JzOXK559dwYeUoMoETvwSj1jQ/qbybYgMY0UW
	kYGWozn6sFDKTP4YCZ75twu6oqmvl/tvvfEB/P3FMUIJqhfdDlKhsoyI/98hISf9nE2rBJzOOqq
	zoQ5+dxi2V/6sx7/0i5QXm80ZE7eJJk8=
X-Google-Smtp-Source: AGHT+IEAAMfVvQoKqIJ97zGXVn9yhUPToQ3ojIpbqtUrQm2/4PPD9tau6FeKxamE0P2jSPcB1XULvA==
X-Received: by 2002:a92:ca4d:0:b0:3e3:f81b:7a1e with SMTP id e9e14a558f8ab-3e5657533ebmr9476215ab.6.1755016810689;
        Tue, 12 Aug 2025 09:40:10 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.176.182])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cd7fedsm47501515ab.46.2025.08.12.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:40:10 -0700 (PDT)
Message-ID: <689b6e6a.050a0220.39aa6d.77fa@mx.google.com>
Date: Tue, 12 Aug 2025 09:40:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8552938874113262369=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: Bluetooth: hci_event: Fix connection state issues during suspend/resume
In-Reply-To: <20250812155527.995119-2-ludovico.denittis@collabora.com>
References: <20250812155527.995119-2-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8552938874113262369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990639

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      25.83 seconds
CheckAllWarning               PASS      28.90 seconds
CheckSparse                   WARNING   32.02 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      499.81 seconds
TestRunner_l2cap-tester       PASS      25.60 seconds
TestRunner_iso-tester         PASS      42.26 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      131.91 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   1.10 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.136 seconds
Set Device ID - Power off and Power on               Failed       0.132 seconds
Set Device ID - SSP off and Power on                 Failed       0.124 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.871 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8552938874113262369==--
