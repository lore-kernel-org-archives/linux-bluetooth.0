Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1516ABCA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314595; cv=none; b=InM7jLrY1pYyZ9ulNijw2MK+txGbeCxUhDQnnqo3tPMGL0ElrUWA+avEoQ1tgC5g4zvS9jYDY7s1lFeMSyKwmiTs4kfqkXx+8uaF5TtgQz9ugcNupE1TUd2DcmsZesdvIcSU96kUqwnGKX5/dtQUSrB3hY7q0ayFhshH5+TG7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314595; c=relaxed/simple;
	bh=Ztw4mKL8iYE8FpqOkCX69uPviF7mk0X6hbbsB1ru+A4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZTsfr9H7eRhVIJjMTpsnZ+S4BmgftcEhFTTXhjbdDdh4k3rC26Qzvgtr71+YssLv1HzWiyTxvNdFKNX/Ew5lfj1bQwuMmy/UcO9aXvslE5FT9/Jx2FG+cKIrHXDn3JSFhhkSAj7aBf6LrMudVquTRCA7lNCaofS2kT+hdO/WyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQum9Xz3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQum9Xz3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6993bc144a4so4702796d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712314593; x=1712919393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ltC9yoMHqBlRVRUqlwUsdNQhhtUahtRw/+VCdfFQ7EQ=;
        b=HQum9Xz30LUH6POv1YfTtQdXDrXdYQg7xm1ew58C8FhvnNl+VwwyjuH3LuupyFqluq
         bD5etrLjdgD6sVpnKPkC/S2APA7f28hE0FpIBJVj6rgQUGOHuuK9d4OPPK83aYFPAXYM
         FWTrScI3GBAPg2vQpaAIqGB6tTOEUpL5pHIs0NcY8zLvSg8t0DGY/8eOijuSB/PenFpp
         mIuUiS9ZfbX66ASDDyQVml03hkI34gAxxDEPdidQb+JI2CZFHCd1B2wTiIno+eAsIkkA
         OJAvjtFpBMZXTAThEeo8iJUj3Lr2fPyn06pA/wqhyrfsXynEIFAzq/I1gNlyxItHL0tC
         T4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712314593; x=1712919393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltC9yoMHqBlRVRUqlwUsdNQhhtUahtRw/+VCdfFQ7EQ=;
        b=Bg2h7uRbRvQwmKLSaSZhqPEIuPVikeZ9DVDMWcPcjfPvYMeCFN8derjwACaZarvrp1
         Td6MAbY9nTuDTH0Sfqu8qxYvP67eEK0iyc7yVve2rBwQ1s3NiWuP6i84avPhfwZSLQ1N
         LDbX0njHA011yS7yofs2t2GfRr3rNqrmqIDmGS/mCcp/nAYF8EVtAUKPdXa88wrkzGfc
         xRDQst+OwcJSFDGmsRDY39+iyV+4fmgjWUfw9dfE8M9yEIMX0h+u0EI3WG0RXKgIliIJ
         0k8uOsKAdQldx2n2FeqQ45pq69J1XW9++s83R+4n9rl82FP5rPXrlWq50nt6H0yZIUEO
         Yh0Q==
X-Gm-Message-State: AOJu0YwpW1CYlJJxYaGJpflo5YqVgEwVKzM7/l3+G3QEXyd1IQWjn9Qa
	u4NocMejd5pOhL82pMdZHAMr2pOflhG66Y0bIKgA0GTcD96n38crTmuGi+ub
X-Google-Smtp-Source: AGHT+IFfG0FtmmOKuMk4Jpz+fvym0pdikpvZJBujou+mqREOm6hNWBUbtvYRzkGy5wXg37nUMrE8zQ==
X-Received: by 2002:a05:6214:d6e:b0:696:b0f0:393c with SMTP id 14-20020a0562140d6e00b00696b0f0393cmr952474qvs.20.1712314592943;
        Fri, 05 Apr 2024 03:56:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.137.221])
        by smtp.gmail.com with ESMTPSA id f28-20020ad4559c000000b006993ddfcfc0sm518850qvx.38.2024.04.05.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:56:32 -0700 (PDT)
Message-ID: <660fd8e0.d40a0220.2f47a.2531@mx.google.com>
Date: Fri, 05 Apr 2024 03:56:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5501012540276078055=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: net/socket: the length value of the input socket option parameter is too small
In-Reply-To: <tencent_7A77E9664E3C953694964A37444AF474AF09@qq.com>
References: <tencent_7A77E9664E3C953694964A37444AF474AF09@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5501012540276078055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841753

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      31.06 seconds
CheckAllWarning               PASS      33.45 seconds
CheckSparse                   PASS      38.95 seconds
CheckSmatch                   FAIL      35.51 seconds
BuildKernel32                 PASS      29.83 seconds
TestRunnerSetup               PASS      535.04 seconds
TestRunner_l2cap-tester       FAIL      16.87 seconds
TestRunner_iso-tester         PASS      33.25 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      110.11 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         FAIL      15.43 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      28.99 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
net/socket: the length value of the input socket option parameter is too small
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#90: 
CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0

WARNING: Possible repeated word: 'Google'
#91: 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#149: 
Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>

total: 0 errors, 3 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13618859.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
net/socket: the length value of the input socket option parameter is too small

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (94>80): "BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]"
5: B1 Line exceeds max length (87>80): "BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]"
6: B1 Line exceeds max length (101>80): "BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]"
7: B1 Line exceeds max length (100>80): "BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673"
10: B1 Line exceeds max length (89>80): "CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0"
11: B1 Line exceeds max length (89>80): "Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024"
31: B1 Line exceeds max length (199>80): "Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48"
66: B2 Line has trailing whitespace: "Here, optlen is determined uniformly in the entry function __sys_setsockopt(). "
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 55, Passed: 40 (72.7%), Failed: 15, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client SSP - Success 2                  Failed       0.063 seconds
L2CAP BR/EDR Client PIN Code - Success               Failed       0.058 seconds
L2CAP LE Client SMP - Success                        Failed       0.065 seconds
L2CAP Ext-Flowctl Client - Success                   Failed       0.057 seconds
L2CAP Ext-Flowctl Client - Close                     Failed       0.063 seconds
L2CAP Ext-Flowctl Client - Timeout                   Failed       0.054 seconds
L2CAP Ext-Flowctl Client, Direct Advertising - Success Failed       0.067 seconds
L2CAP Ext-Flowctl Client SMP - Success               Failed       0.065 seconds
L2CAP Ext-Flowctl Client - Command Reject            Failed       0.055 seconds
L2CAP Ext-Flowctl Client - Open two sockets          Failed       0.058 seconds
L2CAP Ext-Flowctl Client - Open two sockets close one Failed       0.060 seconds
L2CAP LE ATT Client - Success                        Failed       0.063 seconds
L2CAP LE EATT Client - Success                       Failed       0.061 seconds
L2CAP LE EATT Server - Success                       Failed       0.055 seconds
L2CAP LE EATT Server - Reject                        Failed       0.057 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 15, Passed: 12 (80.0%), Failed: 3, Not Run: 0

Failed Test Cases
Basic SCO Set Socket Option - Success                Failed       0.081 seconds
eSCO mSBC - Success                                  Failed       0.079 seconds
SCO mSBC 1.1 - Failure                               Failed       0.081 seconds


---
Regards,
Linux Bluetooth


--===============5501012540276078055==--
