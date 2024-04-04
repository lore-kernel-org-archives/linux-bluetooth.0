Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3976023
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236056; cv=none; b=Zj7mA6wd8SFeDHjMsnbjr++r4MIi9O/HyxrYlNQe6FEGwinMa21AXlyCU9c/OOeu6Gsmo1IqwQXYCQsy8xuZXh5X2YD749LI/K90X2njkOyPVAIl+tNvQjiIM1YcbME6M/Mkc8asGJToXDm5sZWjGS1IKRnKFlY5Vw/0pVFeGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236056; c=relaxed/simple;
	bh=MfO6tMTPnJi1j7RtkuARIwuEC9vC18kFn9Kufy8R2LE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A9/BRs1YAzWxkzlJxM8I62z3OWHidosbHmv/L2vjM0YVbQND9enQhLDfocAMpKWcWWjqCDpv9tBqCjqLHUmqiZFEAQuYoWSAvirASRC+9Fquvf1rTdhaiPKj+AE+6CZk0HraYOu4+XRWWsyf4HTWfJhskuqOqgYm/ExOoRggN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyrLmBxD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyrLmBxD"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43442ed933dso4724741cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712236053; x=1712840853; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MxmWTvyAN0rHMqCOMMVcktKepOVJLy8iR5Td9eXv+5Q=;
        b=QyrLmBxDvnVJtausJHmn3bn1CEjTPBkf31rDxGoB63YxwLsb4WHXY33HlMsokZLHKd
         bNTW+yd6P2Gxqd0InYhR6tWjOL7J1n2poppetkLrMTfvippgH9+cmIdkeGciN1gfLIim
         A5M26Nk/9e6ZIiu8+r1RBL6TFVorPQcikVMRYIl2IDJlxfX6xXkoihhGbLSSShTXCVwI
         rcBqCz7mjPRsJpOAdFsXwZPZVqjbTVQTVEAUkJWU8cw1R9gZVz+/KN+tmCecycReNuC2
         66NMm3X4sYHx54UrWf3c6qNrpE1eduBigaaQ3MQBDNAD95FHskDa4POZZgnKFtDY7+Y0
         mnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236053; x=1712840853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxmWTvyAN0rHMqCOMMVcktKepOVJLy8iR5Td9eXv+5Q=;
        b=AiOGQ251V/BNyio2lBbGE09WYRMYsgNfVFyiOQ+4XRNdNNOqQDXwSpS7bCDJMQYl5f
         PAyHfOG3+B8uuETAvwMTKbDJzlERSUQ/t7PFDLgtkzA8lv4+WSetTjIabnXKLKrkHyoM
         9cKnPqlFUYs63w3DPYusT9DbOQh4yuXkCf/lQSkdRT0QC7ywyA42cO5YoyGiKmZLDpGt
         zzCHG6OATv42/qRfi1/AvvV6JLeHUaUcTfHlsiMLX8E5c7NZ/mm4VV0+x+HTxVbEB6WW
         p/stzYAOtAzyP2CFbErDlwlk8cixJcVMUrq87ihKC1ns51H/lQtIIpQ6acogi8WvkwGy
         p2Jg==
X-Gm-Message-State: AOJu0YxuXHMSsB6MqJQzbRDdTXHxPxhTCbHVC1EP3OHfVdDIOpZ36KWg
	UGxBz6RChgEut9sHIa0PuKj9xGT0DLSMaNGsoziKg8g1mMC30/zxf+sSIch1
X-Google-Smtp-Source: AGHT+IH0Wz3wsIAmuUunsvaWygL1iqHXnalZkmYe4rp4EDhJ4tDmpFcdK7C5r/grzhrKxYOECQGJ9w==
X-Received: by 2002:ac8:57c5:0:b0:434:3c23:d2ab with SMTP id w5-20020ac857c5000000b004343c23d2abmr2239132qta.33.1712236052635;
        Thu, 04 Apr 2024 06:07:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.53.187])
        by smtp.gmail.com with ESMTPSA id ew10-20020a05622a514a00b004312813a743sm7635859qtb.43.2024.04.04.06.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:07:32 -0700 (PDT)
Message-ID: <660ea614.050a0220.580dd.6e4c@mx.google.com>
Date: Thu, 04 Apr 2024 06:07:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1843058330740666651=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, edumazet@google.com
Subject: RE: [net] Bluetooth: validate setsockopt( BT_PKT_STATUS / BT_DEFER_SETUP) user input
In-Reply-To: <20240404123602.2369488-1-edumazet@google.com>
References: <20240404123602.2369488-1-edumazet@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1843058330740666651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841415

---Test result---

Test Summary:
CheckPatch                    FAIL      0.99 seconds
GitLint                       FAIL      0.99 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.51 seconds
CheckAllWarning               PASS      33.21 seconds
CheckSparse                   WARNING   38.89 seconds
CheckSmatch                   FAIL      35.46 seconds
BuildKernel32                 PASS      29.60 seconds
TestRunnerSetup               PASS      523.49 seconds
TestRunner_l2cap-tester       PASS      18.03 seconds
TestRunner_iso-tester         PASS      32.44 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        PASS      111.42 seconds
TestRunner_rfcomm-tester      PASS      7.25 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.78 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      27.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[net] Bluetooth: validate setsockopt( BT_PKT_STATUS / BT_DEFER_SETUP) user input
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#104: 
CPU: 1 PID: 12578 Comm: syz-executor.5 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0

WARNING: Possible repeated word: 'Google'
#105: 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#225: 
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>

total: 0 errors, 3 warnings, 0 checks, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13617776.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[net] Bluetooth: validate setsockopt( BT_PKT_STATUS / BT_DEFER_SETUP) user input

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (95>80): " BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]"
7: B1 Line exceeds max length (88>80): " BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]"
8: B1 Line exceeds max length (90>80): " BUG: KASAN: slab-out-of-bounds in sco_sock_setsockopt+0xc0b/0xf90 net/bluetooth/sco.c:893"
11: B1 Line exceeds max length (89>80): "CPU: 1 PID: 12578 Comm: syz-executor.5 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0"
12: B1 Line exceeds max length (89>80): "Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024"
31: B1 Line exceeds max length (199>80): "Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48"
64: B1 Line exceeds max length (90>80): "page:ffffea00017dec40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5f7b1"
71: B1 Line exceeds max length (186>80): "page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5091, tgid 5091 (syz-executor.3), ts 75758857522, free_ts 75730585588"
134: B1 Line exceeds max length (81>80): "Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com> (supporter:BLUETOOTH SUBSYSTEM)"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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


---
Regards,
Linux Bluetooth


--===============1843058330740666651==--
