Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592D126BFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858270; cv=none; b=CqqJgvOb205QVnu5lxKRChQG7se4bXSuQ+nkniMlcy8ZTpgu0jYU9AkvsHF3tfDp+ULB3MAPvu5JYaE5IAhKuhOBE8EPpwvrzwsjGhA32FJQktJ//5G2lCOo6YtPeT8r1knh4R6N7hT40C40kJaOY3MODW5glCMjX7a0heyLlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858270; c=relaxed/simple;
	bh=7xdU/Tuketz32UV3MMNHGf7SJCX1DCWsBLnOnJyAUsg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DuzJNRmHIVCLzUgMHIn9gtQ5HG2RepqT7Eiy0ZvajoW2nn/tg9vdi2ZcBFaSeqLzpMMLDwuVAZEwCGZdWzKMNB3dOX/v5kA+fO1zZgjxWg0KTiy+sZFjP3M7p7CvQ6mSH21qb/KfZjV60vc46NCcNOgU+LYM2blMi5/rvUekRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWgk8psV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWgk8psV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23508d30142so91793175ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750858267; x=1751463067; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gQOSXwfwWcZXMx4o2eMIfKKjZW0xCp6OhwLszLte2DQ=;
        b=HWgk8psVdFK03O2GMxAX6eKutN3McWvjrI7ug1EHfc3KRQy/SMig6iiI157f4nkpAu
         hOvsGf7sqKN7d7ePoTH3WJ1zebuu2PZC/aOzs/c5VlUnt16PK5LShwQJROSJAUqQHlBS
         GCAb/R/9xIDccC4VgArN5HuAKRDfAICjF6VB+KB8qd/v0C9xBYkQlAw9km3p6npQHT4W
         yCSJri/LwNzZZbcMw8/E4YmDgLGWswT+ksZzUcG4AqLZ3FFilTt1z5aK2/2dHZQ6esYV
         K/5tvS+PulhpdqnYR2nPOrFj6keeWO8ypUIpBGI54h/J2QetkOY0VyiTJnHAjtowMsiq
         Q0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858267; x=1751463067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQOSXwfwWcZXMx4o2eMIfKKjZW0xCp6OhwLszLte2DQ=;
        b=n4f04i9g/aq5phTh8CUuh95bBlh0JDGW2TuAnD0+vCHoJgnNBXhTgKd47FwFwrG4fw
         DQAJ0yhjZEc0pNjZQigKtCAEXNvYSA4IAUzuYKvFGj8XHDhvWN4VjKDlcmjdqLGT2hZ7
         eDGvCuyhsyLQiXJR/i09sNfUw0hlo1rexPNJ3Qy+LiElQCFpemlND1vThG15Lm35ajtv
         8hhWG/uyPpT7e9YkVSqcttKwTNO2nm3XS41djA4BK7GmSYp8SV7klssswIpea6lyodqV
         OL/rspzvvBlFBTuB9OkX+UL24D9kKgftEifKJUNOzY3769vvu9lf1fOrEInFC6Mu+3v8
         c2mQ==
X-Gm-Message-State: AOJu0YyRK0/4gYEw4Zx2RLm1/eQp+myfUWng+giHXLPRnHp4BNKg3Mdy
	DDiJMB5J/0VPWO4T/4DLwdUo2Yp7uu/YsKolci/VwAmUJrZIMtTDgeMp/gUsJg==
X-Gm-Gg: ASbGncssl1ZfbBNqjK9OjWw71J7uuGjGJYhoZDzgZ2va/bP8VErOC24oUwh3wHQFAE4
	2/zoJSjJ44xAapxSkXalySSo/7x0F9TkbMFKYs643DbuSLQldSJyQIQZJazpWmpK/vle2bCFOCH
	3Pm6O7GNCTQ//h8gDXHNaSmYDAYLHPHEtFuZAuZASITam0EpVUnohKzPm7s8ExPD6uMkuhZ/12f
	nDFKHoG7bhVyjsiudbxqWYywZppzmFV3Yc0/3fa7qJBlWPzHcvi+eH8wq6Lmuy4szVV4r+fUPrl
	4/aphUtaov3nIQkZOiC6b+lyFZua9Jp7+j5ywxc5/6/Nz9qxXkQd8C7a/12yklbBW3mTGqcWlut
	DVA==
X-Google-Smtp-Source: AGHT+IFmYqTUHblw5IuEK1fxDc8Hz9y4l8BE5ZPQ1h75+ZIQm4H/0oyaokg3AjnW/V2wCJrzNMj5+w==
X-Received: by 2002:a17:902:f544:b0:235:f4f7:a654 with SMTP id d9443c01a7336-23823fdeef0mr61822975ad.22.1750858267419;
        Wed, 25 Jun 2025 06:31:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8398dcbsm132463845ad.48.2025.06.25.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:31:07 -0700 (PDT)
Message-ID: <685bfa1b.170a0220.381f2e.cd49@mx.google.com>
Date: Wed, 25 Jun 2025 06:31:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0678456767363027097=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [1/3] Bluetooth: hci_sync: revert some mesh modifications
In-Reply-To: <20250625130931.19064-1-ceggers@arri.de>
References: <20250625130931.19064-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0678456767363027097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975791

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   PASS      30.61 seconds
BuildKernel32                 PASS      24.00 seconds
TestRunnerSetup               PASS      469.78 seconds
TestRunner_l2cap-tester       PASS      25.07 seconds
TestRunner_iso-tester         PASS      36.43 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        PASS      134.01 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         PASS      14.75 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.098 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0678456767363027097==--
