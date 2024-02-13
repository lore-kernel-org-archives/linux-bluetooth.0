Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EE63503
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861575; cv=none; b=UZA9vh8WqAo7IVCbiX26B41ZItlQOv9CHcv04RykeeUqIKxn+oWRO/B8qRA0q5Xt0XS82G8g4iOrXTVwWZMeBa0tQII5PB3W5mIosnPShLbhb+gZ1iptxXMx3MkGkyLQ8Jz1bj0Bh/sogBOhBR5gnlYomMWBZtw9g7XqAtcMw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861575; c=relaxed/simple;
	bh=kcH6CN6cn3Id6VtU0duuj8POtqQWsdOdNtlk/vBziUA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B5HWAW2Bw+uUROtIJSwtkTT1OAF05Y9G39hbMmSRp+LAFLK7IN/U+ubo7bLDbAaePagePAYLpSdFYDqN3IQhAVh8VJc3Rt27LWYI5A0big3SNAaD6qzaxyjAQ48c6EOUkuoQjdG7P/LfYLgM9yoKRKrYF3NkBw+OhfoHi/uqw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SanfbwKr; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SanfbwKr"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4c01076b9faso1978622e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861572; x=1708466372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vKEAm25Yr3DgUPzBiqGR+qO+0xvONEwb+RmhPG08kEk=;
        b=SanfbwKrsfD1AVht5aVy1Hvci4D2QCTkPiIyiDxaiZbuBU6XNQVPKY/O2Ze5aBzyua
         eIfH3GTL5U4mixGK0zvWp4mvqaxT5rzA+Ri19XiUB6XDMApgbZm+qWFuFYOrCsKqIl2z
         ZQtfnNSyKaeEiTNLA/SRV1jh73TWFa3B7ZB0FMjZdvtcGA78VFn7yncsgdh7tqZOzDbE
         B9taxXjRbQ4HclFQHUHvafYmOYzM6IAuUdp91gz+y00FBvkASXRxxNpDSPr2X9AcraUc
         SFR30HqakV6620FNxFCxMx6s7PmCa3/xY1Rw+9xFOd7SOnK+RI1dt3GKMGIgLH6Qe/ko
         88/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861572; x=1708466372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKEAm25Yr3DgUPzBiqGR+qO+0xvONEwb+RmhPG08kEk=;
        b=tkdK8HKXtWnmvYX12ueMnhsYOEE0vIwZnAsfAJBLGbSiml7itZztfVotVOzIhMLIHr
         iEgEVdVPblCQJb43uDtt/mKkj7oHpGHoMgiipCEWzL8Ka8+9PyHbKuV/Uu81Ez+GAXrN
         4V0saiLTXf8p/nxZsXGiZlO6xRlK2AUvBkCeKEImhhG78IYyxuBJQSZHlEZ/xDsHarvb
         AWk1BYzzYJxHA96hpcr/MAktl1Yvf57AXzK14suLa8keYI42XA7SXVw17lTq/Zkg7YQX
         RVzOu/WnMJ/D2akRDVGXYfTOHEx5mebs4vt1T873eHt+tSMM/ecF6n/NXVknuuiHN59t
         QT9Q==
X-Gm-Message-State: AOJu0Yyl3toYsQ30hXKV76KKrrZHUgKur/WNd2txAQqLqaBdcOgtwc7L
	LXQj9Paq748amOCPW41psji2TTAuAgxKYkaUvmPVtWBBNmTflSGt1vSh2DkU
X-Google-Smtp-Source: AGHT+IHxnk3M8Hf9wPZ0tBPRWk+BRmrvI201sk0mwvkILs5ZHdnXTIQF9/Glv+rE6r99XfRPTtwEOg==
X-Received: by 2002:a05:6122:45a7:b0:4c0:9ee8:212d with SMTP id de39-20020a05612245a700b004c09ee8212dmr784719vkb.16.1707861571792;
        Tue, 13 Feb 2024 13:59:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjgWuW/Bpx5GLGz594q/cKe4y6XGhLRwUOOv7BYL+jfA4LtlW9Q7Lj4NcAMlqNmeGJdQzhLs3nOV/FFvMhYMgjr2Sfjg==
Received: from [172.17.0.2] ([20.81.159.99])
        by smtp.gmail.com with ESMTPSA id i18-20020ac871d2000000b0042c790df685sm1462106qtp.84.2024.02.13.13.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:59:31 -0800 (PST)
Message-ID: <65cbe643.c80a0220.74759.9cac@mx.google.com>
Date: Tue, 13 Feb 2024 13:59:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0194707949703140229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
In-Reply-To: <20240213213123.403654-1-luiz.dentz@gmail.com>
References: <20240213213123.403654-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0194707949703140229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825785

---Test result---

Test Summary:
CheckPatch                    FAIL      3.38 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      27.69 seconds
CheckAllWarning               PASS      30.21 seconds
CheckSparse                   PASS      35.97 seconds
CheckSmatch                   PASS      98.24 seconds
BuildKernel32                 PASS      26.93 seconds
TestRunnerSetup               PASS      501.35 seconds
TestRunner_l2cap-tester       FAIL      12.30 seconds
TestRunner_iso-tester         PASS      31.44 seconds
TestRunner_bnep-tester        PASS      4.92 seconds
TestRunner_mgmt-tester        FAIL      171.41 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      7.92 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      74.76 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/3] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#97: 
Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequentially")

total: 0 errors, 1 warnings, 0 checks, 53 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13555669.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 5, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.119 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.143 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    2.199 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    1.999 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.839 seconds


---
Regards,
Linux Bluetooth


--===============0194707949703140229==--
