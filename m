Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006A1E865
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119090; cv=none; b=lzNZKBNuwwQ5vettuUp11BBAFFv4tjqbudKmiJ99MdE3o/zLN37W/roKWWY8IWPrxMf2LFKRaWRV67wC7vQ6y7iLaDPeJaTUdDts38lJE0+lrDq2c7fWOMG3+v3vGF8eyF1C2UmxEjeMydLnXdF2lyhnXdrOl/3+ziL/oSmUFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119090; c=relaxed/simple;
	bh=gkiBM/PmJvPFhA1Si/NOH6I5lPX+fePnTv9TYGPQtAE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ItF/1Dp8+j+04kRttwv0NncemQM6BhQiAmfxIIm9pO/OaermuqFJXXiJ+X5GOtPWKB3E2WJagopQ5Du5bf9bBTQse2NLBhZS+j6fejxwv4IeAILA0kIy29g5czLK6wRNV298H05gsPcsxr8j+uIy/nA8r3f9v1VYIi0JvbAvHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0NR0lev; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0NR0lev"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21e45ed41d7so1008600fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708119088; x=1708723888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d4HZ1ucRijO3eLCYj9jh6/Ppo4M3z3w8JZlgpCt539g=;
        b=P0NR0levKOwTMpNUI9CPL1uE7tEZJ96dsm8eLQAIqZ9tWyJbqh+mjKiPrQWDizL9aM
         DEILNo6fwWq9tmOGA5Sfnub5NNJTP8VOUB3KOF1ojm4Q0q20y8sh8ccz2klDNZXuE5Kb
         aB4ZEeQ8EyA2iyZYKsjBrmFk244uEun9JgwvweKqO2u7Bpdz6rVC7rgsDdohT8WnkZl2
         7bSo4vPJyGR4CcG8vDDpxEVVFqiSEPKBfc+o4CJw4ckXZtzH/EpLiVLdCdZo4M6LWNaH
         8KsWqqrmmrvl6cNRqk9zcSh4Nu77F3wxJ2oOtfYBNsUkQl/PwlZa00v0/ZzuTdaHdriy
         Q4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119088; x=1708723888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4HZ1ucRijO3eLCYj9jh6/Ppo4M3z3w8JZlgpCt539g=;
        b=LJM4+uLHuIcluvYp2kqnc5SL4Q8v6VCuYPTTeRg7A3TAACvs2Joxjli/x/Xdk0HD+J
         zA+5qM/2C7joky15l3oQVYc3scMHU74wjRYUTMgt4evUxJaffca7y/E0Yah4DYKJIK9V
         jsTezjG8Aq8D0dia2ugfSDi4aPhBI/EXI3ZXsk/z3OizKyVGZ0tKI7bTXNXYHluv5PhP
         kDMM/g4TiYRu2cz1Ql4EFjeLyOJKpYMuGks3W4JiSyN7gmnXGRJDAraUQjF+ui9ZOSmu
         2d/i341QYxKVzCQ6faaDnzg1RX4fGzRSPyFAEbAjHKIWmceaL0BuO3YIEupSPRYSggqb
         E+ZA==
X-Gm-Message-State: AOJu0YzETzEI7zFCf0GLsRCv+Q5wQaV/zujCMYOguZH/m+WcCMJRFb12
	ftCAc7z6/Zk22XcU4bbAZRuQLzNWPplJQPLrngHBZeKCp/UxN4uRuUdJI9KH
X-Google-Smtp-Source: AGHT+IFdMJdpoREZnRSw1e10XYjy9JUHLAG306UIv214MxfH1pSfXcFhyiPYS3zBSDWKsNG5Y5SbMg==
X-Received: by 2002:a05:6870:506:b0:21e:3dcb:347 with SMTP id j6-20020a056870050600b0021e3dcb0347mr5828008oao.3.1708119087854;
        Fri, 16 Feb 2024 13:31:27 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.32])
        by smtp.gmail.com with ESMTPSA id b14-20020a05620a0cce00b00783b6da58a9sm304815qkj.39.2024.02.16.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:31:27 -0800 (PST)
Message-ID: <65cfd42f.050a0220.92498.2f46@mx.google.com>
Date: Fri, 16 Feb 2024 13:31:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5919066387752399443=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
In-Reply-To: <20240216205005.111967-1-luiz.dentz@gmail.com>
References: <20240216205005.111967-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5919066387752399443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826930

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      30.40 seconds
CheckSparse                   PASS      36.02 seconds
CheckSmatch                   PASS      98.38 seconds
BuildKernel32                 PASS      27.01 seconds
TestRunnerSetup               PASS      498.84 seconds
TestRunner_l2cap-tester       FAIL      11.12 seconds
TestRunner_iso-tester         PASS      26.93 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      170.16 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      25.84 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.186 seconds


---
Regards,
Linux Bluetooth


--===============5919066387752399443==--
