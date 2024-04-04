Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B41EB56
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237534; cv=none; b=WBXaGqPcyj1fxL7UJGAKxmaghe12JtVILNNf0H/Ph7CdIA52toOmluqS36vCPEYaVKGFVulDwGlFS8nIIfMdUOSo/qmuZDzvs1ESBcvZLoRhlr6gUMhmL5XGwGpEfB7E618yN3JEvcgqI7W1RGqalgNCkTAgNB805Yeu6YU5FPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237534; c=relaxed/simple;
	bh=PQmDE9lUZzIWzni5Q2fOpjJAMi9/zAqCC3lfM88lJk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=itw/FMlX+FgFyPIfkVtZjzJj+ouASNcV39njb2voodBPRJ8GvqYZS1HDrIk1wVfDngt7FQfGrwXjGBCNShicBDj64h3+fjEknvC9QGgtX8AJ32af1GY3x6tDFooq8LohFRrqXCPCIAoN+mEq7vwF9+34PTukGXSE0XY0bGICMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWl5wRyD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWl5wRyD"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789e6e1d96eso55404685a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712237531; x=1712842331; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7TkB8LwYw/1EY67pUcpCSrsLluWHRBycv1sTMLycj2k=;
        b=cWl5wRyDwKXWLigvm4GppLcDr1s2AftQ1G5kLhfW3Uaog5VNaPGEwMmrfGoWQTsOng
         NMebra/6IPUcIikXc+kdb7pNc0oDbLYRNjBCC2WyP7weAmzamJZgWbhHFeLr55/F8vBk
         6WLXQVXFzp1iKtkwlwkXcnLCcHseaLXK7p/mpXaefakUPUyN2OXGYW73awppMFkKLvem
         Lwh+gZf79VWcywKJUUTa4XI3/kFHuYJ562ob2OZVBlV26QRTi8QP0yH9KRIGbTMXyrxY
         SjMXLzSyKhDTHMDDpbwshHhPgZ01x0a+Ch5hM9VJiQcPZhrdxYgiUCwOlSIV4Iebi21h
         cSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237531; x=1712842331;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TkB8LwYw/1EY67pUcpCSrsLluWHRBycv1sTMLycj2k=;
        b=gO7E1hsOY9x26EmIDuZS51x5DUivqSrT43VWh7flJ5C43wUIGgg/Ia9EXvXffjtbN8
         CGug4nqBSS8QsAtCZ8s2p6PV04Nx11ibwv+g2e5wM0XMI8rMHM0095aGSNOlcqZhPOxr
         YHP3TnMrwWSQq9XwgkiytFsJESgsfiRYEZBH+GFtBLfuFgI1BBrXu9vuFp0V45cFhrKP
         nmzwPeD024kSmF2PIwoZeJgERLBIoRjPfyuXccZJ5tLlY2I67UF/WJpEppyU4uh0scaj
         ojRwoc2+2BoHBM7jhM3la6NeEIFl9muHhFYotohpUL8+bN0ODkMORgrbgjjOFlg2EOpx
         Cmpg==
X-Gm-Message-State: AOJu0Ywz8aQpJqpwKJYJ9glE21r4L+9RfS15kLxDPPnMWdNdkty63JxY
	QfR7SItL2txZHVKDmxdZGcfJlUXWWD6IXUNx+kdCraRwY49R+Xyed5Wf1ZPZ
X-Google-Smtp-Source: AGHT+IF32WvLx/40gSuWfMdCG3rzKz/IizeNFYlDFMcEouGu0sVfjoPc9Uqe+raw5JSkGbUyCBej1w==
X-Received: by 2002:a05:620a:4006:b0:78b:de95:a037 with SMTP id h6-20020a05620a400600b0078bde95a037mr2980390qko.45.1712237529575;
        Thu, 04 Apr 2024 06:32:09 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.106.53])
        by smtp.gmail.com with ESMTPSA id s25-20020a05620a031900b0078a593b54e6sm5861231qkm.96.2024.04.04.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:32:09 -0700 (PDT)
Message-ID: <660eabd9.050a0220.d210d.0b51@mx.google.com>
Date: Thu, 04 Apr 2024 06:32:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7776786652585913975=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, edumazet@google.com
Subject: RE: [net] Bluetooth: validate setsockopt(RFCOMM_LM) user input
In-Reply-To: <20240404124723.2429464-1-edumazet@google.com>
References: <20240404124723.2429464-1-edumazet@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7776786652585913975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841427

---Test result---

Test Summary:
CheckPatch                    FAIL      1.03 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.16 seconds
CheckAllWarning               PASS      33.60 seconds
CheckSparse                   PASS      39.51 seconds
CheckSmatch                   FAIL      35.71 seconds
BuildKernel32                 PASS      29.72 seconds
TestRunnerSetup               PASS      536.32 seconds
TestRunner_l2cap-tester       PASS      20.05 seconds
TestRunner_iso-tester         PASS      30.80 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      111.92 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      17.66 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PASS      29.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[net] Bluetooth: validate setsockopt(RFCOMM_LM) user input
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#104: 
CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0

WARNING: Possible repeated word: 'Google'
#105: 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#204: 
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>

total: 0 errors, 3 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13617810.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[net] Bluetooth: validate setsockopt(RFCOMM_LM) user input

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (95>80): " BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]"
7: B1 Line exceeds max length (88>80): " BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]"
8: B1 Line exceeds max length (102>80): " BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]"
9: B1 Line exceeds max length (101>80): " BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673"
12: B1 Line exceeds max length (89>80): "CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0"
13: B1 Line exceeds max length (89>80): "Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024"
33: B1 Line exceeds max length (199>80): "Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48"
66: B1 Line exceeds max length (90>80): "page:ffffea0000826a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x209a8"
73: B1 Line exceeds max length (164>80): "page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 9917548498, free_ts 0"
115: B1 Line exceeds max length (81>80): "Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com> (supporter:BLUETOOTH SUBSYSTEM)"
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.163 seconds


---
Regards,
Linux Bluetooth


--===============7776786652585913975==--
