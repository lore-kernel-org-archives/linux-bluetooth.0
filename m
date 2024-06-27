Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652B13E41F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495476; cv=none; b=EpB8KUWaVyize3xY8FBy5RmAoLDLcVYCojFmEndQcASL7B7vp9ERLn995xVVmKAFOO1lGcICDQvPUrPCxnNl1qCRspiZRuabhS61RsKx+wrBYOTqKQpBO9braLIdt/ry8DJ4Q052uxG9KNokaDFCsZVffP373CK3I6mivBTaHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495476; c=relaxed/simple;
	bh=sl6AaS1XDFw9NmFumr4f1yxXpdgaLtykkCx8Nbt+MEo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ltyWO2u0Cu6gMCn5L26srP8FBTLau2/mN5FV7ngPUq0jJgCKGMwroOSnyr32HIkeNnFmGnpbinniod1LKQJoOzYjT2go9rBeHAsXPPzQMaun8VG4TcU+9b0lBjSSZh2bjl/H0BXEJd/UviLd9pxQwkgXwR93PZVlG1XlT4L+Q0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNrTtWgv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNrTtWgv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b4fdf56903so30638846d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719495474; x=1720100274; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bADqJWKk7U6gunkH9w0Haaxt/5Y5zH9T+7j3JYMk9kU=;
        b=BNrTtWgv1w4FZa2oMvpbrhLDfoDBohp5zXsbI6pLB4tnNWzuXNqYfqz4zetak4ZcuK
         3lIT3jAN2gV8fgfJywGPFPwqbuz3LMOcY3s/3h4JXAu2xCb3PTYCVVbo7nSADDXX/jRN
         Xf2DFCj1qCyi5dHcvB8hI+kdVgFw5mi8NDtPGhbr7SkY9pBdz5qxLp4/j9upbnK/TKrR
         m1gt47Zjnn6Mmgc/PXmr5XB9QfGeChzFWmV6iOB9w5ABjP35kM/xZUAXWQyxpBTNFNdz
         UeZogtQxaXkYBnfNlJ1zaAX+5u6UKmPc0863bJz5oJeQoLbCuCsz86rH5bc8pw2LxgZB
         01PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719495474; x=1720100274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bADqJWKk7U6gunkH9w0Haaxt/5Y5zH9T+7j3JYMk9kU=;
        b=KK46bmqCsaGPdRzy39NfT8IvH0OGTsUELWxFMqyRCbTwjPxCp87FZn/RGG+08XDVPL
         X8w/3M1b5+37hXfQJJzWQF14Z5gJO7Xic/UKD9s9XuLypDiokJqeEDYbxvj/3rxa9dtP
         lJ2cJBmQ+C3+N7x+5piEgEWxcZxTmJwe/2tu43gescKnZdUEVkjZwEKQOotTDGCLpI7P
         pKrBCh9y+eSXNlTm7zjPgo8Ye+0l2sh7NrRTSqexMF3EuKc1hgOSWbi13jHdrtqYDY8z
         P/XpNl4qTuyfR0UQR7OUX9vbK9oa68G4Fw+A+mkZ2WoZCw8f1dvba1UFoUyw/KcnHokf
         8NNw==
X-Gm-Message-State: AOJu0YwTYiYobNDG62miacDRORwHOqQdRvJNIpHZGeJgYSO3mXkKAAcl
	gE0wjjLNXJvigchBg1SPY+TVP3AX3kv6hwLs2dYK4iVqRfYS4jIHh99Yng==
X-Google-Smtp-Source: AGHT+IGmyRhtOUW0WKvD+1KpW8o/BzFwMO3AjIV77eFHCfGSdmE9g6B6prYIgNF/bmZdFs5w3BuNKg==
X-Received: by 2002:ad4:5849:0:b0:6b0:89ac:ad3a with SMTP id 6a1803df08f44-6b540aabc06mr139326896d6.59.1719495474093;
        Thu, 27 Jun 2024 06:37:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59247f95asm5211676d6.38.2024.06.27.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:37:53 -0700 (PDT)
Message-ID: <667d6b31.050a0220.7ed12.1e15@mx.google.com>
Date: Thu, 27 Jun 2024 06:37:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2929530530787121449=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Fix the sfi name for BlazarU
In-Reply-To: <20240627130639.2744811-1-kiran.k@intel.com>
References: <20240627130639.2744811-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2929530530787121449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866149

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.75 seconds
CheckAllWarning               PASS      34.54 seconds
CheckSparse                   PASS      40.47 seconds
CheckSmatch                   PASS      107.02 seconds
BuildKernel32                 PASS      30.03 seconds
TestRunnerSetup               PASS      552.27 seconds
TestRunner_l2cap-tester       PASS      19.00 seconds
TestRunner_iso-tester         PASS      40.20 seconds
TestRunner_bnep-tester        PASS      5.06 seconds
TestRunner_mgmt-tester        PASS      129.26 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      15.20 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.11 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PASS      29.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: btintel: Fix the sfi name for BlazarU
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#93: 
Reported-by: Tsigan, Vladislav <vladislav.tsigan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>

total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13714333.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btintel: Fix the sfi name for BlazarU

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (82>80): "[146.111839] Bluetooth: hci0: Bootloader timestamp 2022.18 buildtype 1 build 16362"
12: B1 Line exceeds max length (97>80): "[146.112204] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-0291-0291-iml.sfi (-2)"


---
Regards,
Linux Bluetooth


--===============2929530530787121449==--
