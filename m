Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF9219A91
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274793; cv=none; b=J59U+FrYU1H/XPwSpHRpfag8OZb1z7XYnZUXD/wYjGBFUBoZFIHUhcR0zR25lZ7daYxlt/Tqnt/Pz8VPL86HkFeyZjE9WbPO1VLhmnfQlEy0bfZUc6fNuVFLBuryUf74SgiQDu7RcRvYZir8BDjLilsvykvCzM7CnfeGvs/qekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274793; c=relaxed/simple;
	bh=mnJyGZLSvUv/zSSMrEw+jhV94cKijNpWvE+rgmTB2Yw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NQ7fcQmRCk8sm96rHsAwwakONh8/AGyGIso7B4aMBkQaLVuku5NvinEPnPc7Lt/smDqmUok6UroNC9fSaFpb0X2FKdi+SJUvBAZRt7tCkX4qN1XNVXNcAT2/d6RdDHpJv4LToTMRi9kWbPiJaPZT7hiaHQnlE8KIpDUG8Eaq6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/VEAkLb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/VEAkLb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5b8d13f73so462904885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745274791; x=1745879591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ih68fNuFNMdGBN3Th5kQlby4W5iGmBCztvaVxouNZMc=;
        b=N/VEAkLb0onMfYmRWyOkH9tRj0uSdqvavFGijHKJ0yz5Fl57wSNimOdEr/6mPxwJ7s
         15jhzxyhGB1e40hDZmN8LDNTDKPofIO1Bj/PEF+nBEA2XxdOYKb6dJm4tGkZ96B1LKIp
         GeyfRU85sFz71OcgaRzoPpK4u38SCX5bpCWtI9N1hHXskr+6Pp4FbdeQ4QYUm+QxETwd
         5tS+pxVyc+7BlZ9muRTA+rKt0LJAl7ceXFmCpRyIdX2h+zj+2L9cE7Waevruy6tmkAHb
         iiJ/yDhr3HwGVYtHt23yk2BQodTwrFmtoweTkDzwzJFK/z6T6xcphpoAZ3LiilreXI/E
         t81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745274791; x=1745879591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ih68fNuFNMdGBN3Th5kQlby4W5iGmBCztvaVxouNZMc=;
        b=nQKKqwBIdWIJL1SzcRb1b2/gwXHfRBchAd7kp+8C3ZT770Kk/ebqr5lsN1HIH5yP4h
         HSXEBp4P/EFKeliY3SHOYQGuQWf+bSDgyGJ6DH9bOVJY88r0b2EmBGSixUINGOiRVWZ1
         So4gQcMNYIY7F29VMOQdZpSEiqOvvLX6mW4IQCtUPtXaT0WCsM2u0xcNrVhgpon90wVq
         EdSsTxfgmtRArhZ6R6ueT0g/8XH0Es6D+U7rpLjsvs4MlZFMGJJKB4+LcKfaqvKZ58zy
         H6M2kE2891smVVWca1zFcxQN1IRXZij34kcrBnwNRO/z7XY29tZq+9XRxN0mpdJENJ97
         c3qg==
X-Gm-Message-State: AOJu0YwK0SZDQBHeQGrAPAXvoA+zx+Ax2QMpDuhLBNn319oY7NR7B5Oy
	y1Pf8mdyCjaC8g3hF+m3Bs6f8jrfWzYUvhRYsU57eNoIrdEWF0ZiNJSfLA==
X-Gm-Gg: ASbGncun8VoK3lRn8FtNg1/1HZnylSR0J9RZwUyJKLad8mBWHCBfEw15xwsaWMobwlB
	z4Bi48h8Nz8bfQ/UrtF/HHAKbFXL4uwEpkAt/iwc03LjjYnKzh+D8/l69aYSTcezmRE99EBcwkF
	WXk7qXnNaagrWftZ3UqcOwp8VnS54f4tjTDsxVN7NDCc28giqbumX8ND3n+wLl9xMcRZv8wtAtd
	cI3T7yyz+7xHhXVFoROHi0pw3iUpAeMMORXf+lRMR7ZiP8wYwEEXDzHjq2QkzvulJtZLOH5nXL8
	ipJltIJBx6C8c1tR42oMcZMWH9YM0TxIa3SP0ny7HQ9lx8axqQ==
X-Google-Smtp-Source: AGHT+IH6Tm1McJ31gJiNtsQPxsywrJ9DByegyGB6a3ng00y96tAhzwi8maHspetNjIzFV5dN8VuDEQ==
X-Received: by 2002:a05:620a:240c:b0:7c5:a513:1fd2 with SMTP id af79cd13be357-7c927f59459mr1954365185a.6.1745274790742;
        Mon, 21 Apr 2025 15:33:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.199.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e51fsm472882785a.6.2025.04.21.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:33:10 -0700 (PDT)
Message-ID: <6806c7a6.050a0220.11f3ce.f7ba@mx.google.com>
Date: Mon, 21 Apr 2025 15:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7860612697888469191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
In-Reply-To: <0ff3e783e36ac2a18f04cf3bc6c0d639873dd39d.1745272179.git.pav@iki.fi>
References: <0ff3e783e36ac2a18f04cf3bc6c0d639873dd39d.1745272179.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7860612697888469191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955479

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.63 seconds
CheckAllWarning               PASS      27.22 seconds
CheckSparse                   WARNING   30.66 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      464.21 seconds
TestRunner_l2cap-tester       PASS      21.21 seconds
TestRunner_iso-tester         PASS      35.37 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      120.93 seconds
TestRunner_rfcomm-tester      PASS      7.95 seconds
TestRunner_sco-tester         PASS      12.49 seconds
TestRunner_ioctl-tester       PASS      8.32 seconds
TestRunner_mesh-tester        PASS      6.01 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.44 seconds

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
net/bluetooth/af_bluetooth.c:248:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.153 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.186 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7860612697888469191==--
