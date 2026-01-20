Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311B3AE703
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902735; cv=none; b=JAP8elrjzE/IR8riRCXzSovadC6piCN3Rvpj7PGCrTZt8geQDUkqX+fC2sRa8n+Mix/FxYCiocB9nsa1PpGR/5yWL2UczlNkVHhi2Cfu9ag8bsi3+aCxM3VbXB4PsH2ajImTxS+GXRffywuZLt6ZMyqAvDCxmCrruIEcZfQ5O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902735; c=relaxed/simple;
	bh=REvJGJROoP8hFuniuJ5BPxkne6x3emzp9Q9ilu2Xc7U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tCh4gLWF9apPGE+S5/cc+qkFQ/5OmkqyF03Ptu+WlyQOTKKWMocErMhvaLam13Fo7JtbUXM4WJG1SgkKDw3J6W3QVt2NWluEXVJvJLy8Ks18xb0EuaXkyCxekALk03ZmpBR5igXMdTtBEdJA1qjwsDrbyqcCjq1RbPwhGr7xpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imhgB00u; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imhgB00u"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c6aaf3cd62so416913585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768902730; x=1769507530; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pMNylKLSrRqbySs2fhg9D+/P7mCLNVd4luuubMughvw=;
        b=imhgB00umunSXSLMWDM3G4v5xtSdP6HnCXiy6zel8Lgr4N+t5vbsFt5PZ3ke+CWX1Y
         8tWH8+yLK4b0+sEJy/EEFt3I89jpKy6tdVN1dPDOxGMzcBD5IKj+O4n7gTY1n/AJEMpN
         gylDq1iz+60nPUweBqrKPbQKcaOYGUoWPqfj70cKjVkBMSsV5RPw6WGSEaikA+tj9yjF
         QTpnwfjkUxeIo6vz5IoCNWKvOfJiZZzKr/bmrKSWTCOPM66hosrkNZ7HA1Dp9GaoTzpz
         pmTaX+3mHDjx6H3WUWwwttIYE4PrbF4DybcRGzWS7RnwmZltuQA/+1LSznBYThpX9LSl
         lQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902730; x=1769507530;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMNylKLSrRqbySs2fhg9D+/P7mCLNVd4luuubMughvw=;
        b=sWc+1luRTpDI1tYwZ9wksUA6VMoZ/i6OpOzXwMvwC2Jz1g9y8ejr4RpKHWQnersTmz
         gfSRr75dFtM7L8pDB+JieQJaM19clLkXAmrx4ll3nH7NidwtluvdoUGhF5wqjoTqbnEj
         ooce3CMFN6Pps8hgJ77Y72HY/j+EMi94thbqgz0Ys+22xoX96Vb60XR4w9x+U9VTv2p5
         dHWLMLtUyLAPSoKoePKIP9TYt0JTUjjBeAHbSgYind6EOSZdDlp+YVeb1YUJTSgZBGcV
         aidkYBV9bB2xfXw58xgI6akBZJnumM9DePJIjhhk/2mmwAarr1eNCdlZJNfQPIAks3VD
         l4YQ==
X-Gm-Message-State: AOJu0YwWsueUSKHYrYCVhinJJnSPXgVnQTZDbJVUjOLzAWghN4YNw+b2
	GqZjtW7IMlJF8A4XjQM4psKXj+oBKUxclFmUNnlZZp9jet9vx3LPFMca3orktqcB
X-Gm-Gg: AZuq6aJuux+1GmwiBV9t/z+4ddWpA1RjxZzntZOGmaNype1kj2wveq5Svj9p8tizfU9
	5qvY5xhHrzALpobnbIIvhoQiPjDgYFqrvUcuMIYRy27qLaPdntxoWD0o8JEyhqQpOnG1aMONh//
	NQVT7JZanV6VHWPVpj5YfIxLaFiXyUugJ0ja6daqzmbMhNfD5Yj1dpBhWqQZA8mg8lwTxIU6UQI
	vOti8dHVlubR/XBW6U4VaD+w4z0JLP50qDW2fcB66KXsUH/yh6VUpkqPReBQyaFhuFHVwz3sQwt
	LdTvrwElU1bFZuMb0o9eQWlRNrq2xLNctLCl7KM7/3Tdf/jSdG1ab+gzflkr6rsDwaK2efJtSan
	DGT4XMYHZ2ee5kniwQz3t+HK4X2NtWiSJoW9tWyBd9FnkAW157819joi7yNJOJqDJMsRs31M0nP
	v8hzrqpZ4hGXxxklVk
X-Received: by 2002:a05:6214:3019:b0:888:6fa6:781d with SMTP id 6a1803df08f44-894638bea1emr13571376d6.9.1768902730159;
        Tue, 20 Jan 2026 01:52:10 -0800 (PST)
Received: from [172.17.0.2] ([48.214.53.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894625281ebsm11532426d6.29.2026.01.20.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:52:09 -0800 (PST)
Message-ID: <696f5049.050a0220.3c70af.de33@mx.google.com>
Date: Tue, 20 Jan 2026 01:52:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8721645057205521032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, code@charlie.cat
Subject: RE: Bluetooth: btusb: Add device ID for Realtek RTL8761BU
In-Reply-To: <20260120091304.6226-1-code@charlie.cat>
References: <20260120091304.6226-1-code@charlie.cat>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8721645057205521032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044510

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.19 seconds
CheckAllWarning               PASS      28.85 seconds
CheckSparse                   PASS      33.18 seconds
BuildKernel32                 PASS      26.14 seconds
TestRunnerSetup               PASS      556.81 seconds
TestRunner_l2cap-tester       PASS      28.17 seconds
TestRunner_iso-tester         PASS      72.69 seconds
TestRunner_bnep-tester        PASS      6.41 seconds
TestRunner_mgmt-tester        FAIL      127.90 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.81 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.159 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.201 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.739 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8721645057205521032==--
