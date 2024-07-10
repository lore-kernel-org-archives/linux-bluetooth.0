Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC568120F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600806; cv=none; b=KVKLXdy1LsFHFRhnFgztD/EudqajO9HPdH7NGFLCTv3RnN0Q/w0YLUSFmHPVV5agYrkzl0ZDsa/ifWLs3/c2SzOdutnxF4gQ358XgQ1+sBH/8k2p/ki70TEyYRrlsmNlAfr3/V3Lu94LWudDAZBwO863+SjzaOb7s8RIYJnu/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600806; c=relaxed/simple;
	bh=GbA/NQ6mU+TiWgCbNgvTId2lvbq/ggDP5wczGZCfR6s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nV/rX2RHaIj87GJ3vVUlyme/8Sv6byENpzEwNkC0tmRogI2Fi73cO58jQCYlDiob6N2dNSE/CSo/i9bJCXYWTBsnsxT8otE6e2k6zApyTgvHo6DO+Cs036wQNs6tQWj8dvEGh8sxxxQY+zjvphrdjXoqADJI+oF15zluSHrK5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUeEjhl3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUeEjhl3"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f02fe11aeso274591285a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720600804; x=1721205604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b502ogP0o109KT3eseWsnbLyhs60hLRvDbZz+XQXSHE=;
        b=CUeEjhl3Hk+3M4B+bWjvlyLX/rdE7NMO2bFchU/Da+ZrXttPje931Cw7QcIptLCp+g
         2+Smz5AnID0K5HOZEYDse5TBtkZ3xJLCoABW0YLeqtzUZIqn7/f0NFXCw1pmQGwFOhAD
         kwi+p39PExC72dzkBPn6fRTHLeLRwMNg1MYxeIzb1zHSkJKBGl0Z9CbZBNzFpAq34W8s
         Yc4hlREBy/NVtg5E5EbP9spI3Rl3Ie5UhL3P/o1XRTeGgWA1/41RsakslSMH+fSJkDUV
         IWLeAQkfl6Ggbvl4AUFNr3EOOL1QR0M+kbfsI7V9Yb2/iA0CyAvysUT+b58wQT+N4n1F
         aCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720600804; x=1721205604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b502ogP0o109KT3eseWsnbLyhs60hLRvDbZz+XQXSHE=;
        b=supiVVX/HgwGTRGWDqocaFSEMWUrn8bGUjV5257rjjwIie20YAsoNtUNTs6+tZdQq5
         EIrej98VJwwWYTqNB4fA+ICVxm1ac9F6ZLS2TGfVHCCpYjoUNn/VFRNJsCfQQ/4lwHQE
         6VGBxzrtO0yZhJ4dhPnN6huQq+h8hCuNz9riOAoVm5Tn80WmwzYd9wMcWHlreavbWUpv
         0JQAtVpUr22/4QxNbM4gcvWwunB8RjubBUn2Ktftq4Span6upJWK9CfHiez2imUVOjs4
         pLo+ES3lQNOcdRV3/VCpdPpcS1eiPUfvwRSfNR4NX2A3NJU4bla+G3kvbo+UxrmWZB94
         omzw==
X-Gm-Message-State: AOJu0YwrTflA7HkdbvDr6Hwxc6GQyFpjYkAu+JI+gwFNOHHFWMH7kBiA
	2Q12Zj1A9qX2hVYYIwGdmX2QAZ/qk0QEZ2cNLzEPdCVYiUMd/5HyqJd3MA==
X-Google-Smtp-Source: AGHT+IFbEUpt9nvYU7pfYnXW+gdcn3y9xPcezhtT1eWz7Y6VOC803yOTHZcy3gi+JMuZO9DEbX/KbA==
X-Received: by 2002:a05:620a:ccd:b0:79f:af5:ce84 with SMTP id af79cd13be357-79f19c09f17mr497920385a.74.1720600803798;
        Wed, 10 Jul 2024 01:40:03 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.175.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1901208esm176245885a.36.2024.07.10.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:40:03 -0700 (PDT)
Message-ID: <668e48e3.050a0220.f4922.70e5@mx.google.com>
Date: Wed, 10 Jul 2024 01:40:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2540370622781946146=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Fix btmtk.c undefined reference build error
In-Reply-To: <20240710073832.4381-1-chris.lu@mediatek.com>
References: <20240710073832.4381-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2540370622781946146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869995

---Test result---

Test Summary:
CheckPatch                    FAIL      1.10 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      31.30 seconds
CheckAllWarning               PASS      33.27 seconds
CheckSparse                   PASS      39.22 seconds
CheckSmatch                   PASS      104.07 seconds
BuildKernel32                 PASS      29.68 seconds
TestRunnerSetup               PASS      546.78 seconds
TestRunner_l2cap-tester       PASS      20.70 seconds
TestRunner_iso-tester         FAIL      40.34 seconds
TestRunner_bnep-tester        PASS      4.99 seconds
TestRunner_mgmt-tester        FAIL      115.77 seconds
TestRunner_rfcomm-tester      PASS      7.76 seconds
TestRunner_sco-tester         PASS      15.32 seconds
TestRunner_ioctl-tester       PASS      8.40 seconds
TestRunner_mesh-tester        PASS      6.24 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      5.18 seconds
IncrementalBuild              PASS      29.32 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btmtk: Fix btmtk.c undefined reference build error
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 7055cf63bb80 ("Merge 2dcf37264c29230ea17bdbc70e3cea288dac5adc into 13c5da2f1c16f5e1e953f524a562286eda01f5e6")'
#101: 
Fixes: 39a9e1c69e74 Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c

total: 0 errors, 1 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13728967.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btmtk: Fix btmtk.c undefined reference build error

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@intel.com/"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.225 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.166 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.119 seconds


---
Regards,
Linux Bluetooth


--===============2540370622781946146==--
