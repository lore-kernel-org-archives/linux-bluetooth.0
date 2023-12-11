Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIl6xdY7"
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D451D188
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 07:34:55 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77db736aae5so235341985a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308894; x=1702913694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w+kpz5J809iqizHA8zK8/NjDkrZGA4gKvYixNbf8A8Q=;
        b=hIl6xdY7TROsMVg9eNsVBdjjzvmJe56mPutIFlSI5cOCJSaDMOZByFTYbLUC0s+aTn
         YfoGj++qzMNR5Yr4yKtt72tZWbrbKoRaxZCrFte/WRBv6WeEIVpbW2Jh48UQviTaLpa7
         YFnVNR/5ywL2oj+THF8ZWWc2TSVTEiayKCxmSWdOk792trDjPAIUW0+ZgnfZJpxLg+bI
         ZefDMQuE/W0aTsVw89p5ayNPnPq7b6N9s0mlXmmmQ/ql71qgnEUtkJaKiHLxmfS4y359
         uIAma4dPIKdF77jQ+Rp1lpCiwx6HqXq5tRma1UcC9nNQsxCK2C0CBRxX7qiQrwqjZtRL
         83gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308894; x=1702913694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+kpz5J809iqizHA8zK8/NjDkrZGA4gKvYixNbf8A8Q=;
        b=rAaV9CG4Bcs1VjpLBoc4IZYr1fNc/AIsy2aMIiyyEORyq3GDyvY1MOi89QU2HZ6MQs
         mxqDe7tYlOX/TgHsD5VDBTFLmWn/GI2jaKs6ixy/+O3zKzrOZHkhVqNaHdXPEbtKE8m8
         s0T6L7PGw4OTbGD69tMDX1EQZiFVhMzzAmIb9N0hLaJMcp5NxgONhA2F4mPHOl3bgDN9
         e3/rxvk8WWXdahgtBVXmBileh2u6nJR9l78HRhWO5FUIhDIKK87vZxBYAh5l9HCyc8KY
         SpZyPFx0RxY/x6jNKlzm8Tlq8bUaOHGzO1BtUgCcNx/nvETOPS0H+jwYSfJ0shBRMczW
         XFUg==
X-Gm-Message-State: AOJu0YzmCjLyjQByQjn6EsECB6LQnKA3Wx4TFirx5lyqATfGWzarylkL
	ra++GKMLuA594XIln33+RpXQ40TiakI=
X-Google-Smtp-Source: AGHT+IFA31ODy4WKPmiEu17AsouiP3FYkBYROcMuCSVP8c+vsu2j2vYOvMpu2vtJmbcH9o/YP4+C/A==
X-Received: by 2002:a05:620a:f95:b0:77f:2a50:aae8 with SMTP id b21-20020a05620a0f9500b0077f2a50aae8mr4343509qkn.135.1702308894396;
        Mon, 11 Dec 2023 07:34:54 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.194])
        by smtp.gmail.com with ESMTPSA id tq6-20020a05620a3d0600b0077d93c7c785sm2999243qkn.119.2023.12.11.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:34:54 -0800 (PST)
Message-ID: <65772c1e.050a0220.54fcd.c72c@mx.google.com>
Date: Mon, 11 Dec 2023 07:34:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2174981280835482231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hedonistsmith@gmail.com
Subject: RE: [1/1] Bluetooth: Fix UAF in __sco_sock_close
In-Reply-To: <20231211144037.2039209-1-hedonistsmith@gmail.com>
References: <20231211144037.2039209-1-hedonistsmith@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2174981280835482231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808810

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.33 seconds
CheckAllWarning               PASS      31.08 seconds
CheckSparse                   WARNING   36.40 seconds
CheckSmatch                   WARNING   99.66 seconds
BuildKernel32                 PASS      27.47 seconds
TestRunnerSetup               PASS      426.62 seconds
TestRunner_l2cap-tester       PASS      23.28 seconds
TestRunner_iso-tester         PASS      91.06 seconds
TestRunner_bnep-tester        PASS      7.16 seconds
TestRunner_mgmt-tester        PASS      162.53 seconds
TestRunner_rfcomm-tester      PASS      11.12 seconds
TestRunner_sco-tester         PASS      12.67 seconds
TestRunner_ioctl-tester       PASS      12.28 seconds
TestRunner_mesh-tester        PASS      9.07 seconds
TestRunner_smp-tester         PASS      9.91 seconds
TestRunner_userchan-tester    PASS      7.46 seconds
IncrementalBuild              PASS      26.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: Fix UAF in __sco_sock_close
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#92: 
 atomic_dec_and_test ./include/linux/atomic/atomic-instrumented.h:1375 [inline]

total: 0 errors, 1 warnings, 0 checks, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13487356.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/1] Bluetooth: Fix UAF in __sco_sock_close

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (87>80): "BUG: KASAN: slab-use-after-free in __sco_sock_close+0x2d7/0x6b0 net/bluetooth/sco.c:444"
39: B1 Line exceeds max length (199>80): "Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 d3 eb 02 00 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 21 ec 02 00 8b 44"
102: B1 Line exceeds max length (90>80): "page:ffffea0000711e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c478"
110: B1 Line exceeds max length (199>80): "page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 6803836749, free_ts 0"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============2174981280835482231==--
