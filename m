Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1654165FA9
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450710; cv=none; b=gtG08G6UGU5mcKtEwSFpTeTdBw7ZF+O5RIgAl0j5NQDlahWo0FEVCsHkJCdabKfdGfybToAVSguudBiNeNJaH5/CFPm7mWCJibGHo9A86LFwjD6u513RcQjnZHkZLYN2HrgCYE+jWek5djPBzo25bP1H0jxC75TOthRG5ZOFWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450710; c=relaxed/simple;
	bh=b0rQa9iRT2XS6SaPkmyaXWZc/GSDe9+BTxyly17kDRQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LZ40tSLQxyrGCvjie2ji5EvzofiHGwLwZ+2qZROcQqZwQRMwacSS0gBWC2DHqMc4qFMjfstgOXK//7wWXiIXkSuSJLGuKsL9AmwLej9zrmOJYplelMo+A++kQ6uq+dgwZ/NnZB+cAXqFqqNXGDufzF1vz/Q/f8GXZfsTijZVEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkXa7Mdj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkXa7Mdj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a04c581ee3so3424806d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450704; x=1714055504; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P56NdToD5SF7lpNObJiDQpDjY1pupQJgJhT4RIAUh3k=;
        b=GkXa7MdjKNiTFwcOkfAxmm3d6n2bxz8xzzJpVAxhcYScLvMDdoS5s6GaBfPP8+A4g1
         dS3EUtQ33whfBAcESC5kv/yZO7+1fPYiUItHv4CzgosxVFoi73JwCTlFPdKWJl7InL9g
         L7hwKdFIPw1lW5N1qJf5iuhhBgnNTjehTPZkVjuNmmPQCjDqbes09q8LfdHHxddlGOal
         rrg3zycleikXrs1V7ScItU5hYyfdjJ0dhR1Cl4jbbSXQrhszfslza6RFT9IC0unSzUab
         0q4ITCgkzKWrzDJqufoC+c4lk/S9J/rh6CFEKtDRwNoW3ih/fjZqn//uek+/OmRC3vbt
         XLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450704; x=1714055504;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P56NdToD5SF7lpNObJiDQpDjY1pupQJgJhT4RIAUh3k=;
        b=q0+p26rKMTgVKb35grO6ZDrFHN5x/EJf0AEVPlUzY+K4wnBpryEx6pZv30w2/mwPY0
         zke19SzPNitPRs+y0PnlSKQ8a+hNSUgTdY1B4obBcoYb3daz3fS7+6IU1dgxXYEeLbKO
         9+lFCN1mU9XEG6hhcOHvU2LDIvXDHYzSOJBjypnFbPruaOD7QquHuEv03J8GSSPJzqCE
         UtO3fHZqEw9DD5kSwGCvf/p7jdj2Ok276J6T4WwQRGQcTFe5z6RaGiHW92z+O1Od9dhO
         +pAIR3LRhJpeo9Gm7uxaEZc7JsuWUpivRgFYAKeK4xHodKErSrU36YeyrstjlbCBqgzw
         YktQ==
X-Gm-Message-State: AOJu0YyuaGPQ77vx8LqUYIFXxZkLc/Dx4PxMepIpMKvDZ/CE18TaAwTt
	FZaUXhDMfnUHm1jorMJTzCI/qwGTnPDo2C6UarVWMrGK5zn7SZcK9nP9EA==
X-Google-Smtp-Source: AGHT+IH9wcf9mqloToAYnCt7U6jwDlkTw/oZerjDi/CaZgS8LR1n1laGgR3kSlNXWj4xDrHWcMbDMQ==
X-Received: by 2002:a05:6214:14a9:b0:6a0:556e:4c3d with SMTP id bo9-20020a05621414a900b006a0556e4c3dmr2105217qvb.44.1713450704532;
        Thu, 18 Apr 2024 07:31:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.32])
        by smtp.gmail.com with ESMTPSA id j11-20020a0c9ccb000000b006a040633bfcsm700137qvf.7.2024.04.18.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:31:44 -0700 (PDT)
Message-ID: <66212ed0.0c0a0220.c9212.2b1f@mx.google.com>
Date: Thu, 18 Apr 2024 07:31:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2701147948999855518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix two regression issues for QCA controllers
In-Reply-To: <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2701147948999855518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845820

---Test result---

Test Summary:
CheckPatch                    FAIL      1.62 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      32.12 seconds
CheckAllWarning               PASS      34.76 seconds
CheckSparse                   PASS      40.27 seconds
CheckSmatch                   FAIL      36.68 seconds
BuildKernel32                 PASS      30.14 seconds
TestRunnerSetup               PASS      524.15 seconds
TestRunner_l2cap-tester       PASS      18.69 seconds
TestRunner_iso-tester         PASS      33.55 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      110.36 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      5.76 seconds
TestRunner_smp-tester         PASS      7.22 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      33.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/2] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()"
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#116: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726

total: 0 errors, 1 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13634834.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()"

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (90>80): "[v1,1/2] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()""
21: B1 Line exceeds max length (139>80): "Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f"
[v1,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (93>80): "[v1,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot"
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
LL Privacy - Add Device 7 (AL is full)               Failed       0.189 seconds


---
Regards,
Linux Bluetooth


--===============2701147948999855518==--
