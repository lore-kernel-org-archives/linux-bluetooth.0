Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AA2AD14
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633609; cv=none; b=RrnBX18GayN6HiHWheaT1rc3UlH1JvP1Q0JuX5Si5VFTBomTB01taE/W+A8HAK2ZPbbHUtsTdLgFXBk5mUkrPtUDklKkzw3RpyYLtx2XXv+mfI0IRfJ3sjLmtqOgvHLE4C4bJCymTs29wWfdHmnhQbIPSZe4PqptcjT/VZee0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633609; c=relaxed/simple;
	bh=HfuledhJYcsnHO9A6VG1QNibeZzT2Wnage+2B+6wScQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qB+qE5VqtmC1iEZjJRRbTthFYlfUVhqT0aigTVSvKv0gL8z88VB9zyrPcDi18AyQ/Isw3GgySFORqRq94I7+IEa0GQNZV1Tpoylzh/eXu+FT/IhttcqFS9vTKgCSCR5ro9Gp+4SgR6Egz1++Hjrse4nRNYVxrQ2jwcEwWXglEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2TCOvQJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2TCOvQJ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46090640f0cso8515041cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 17:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731633606; x=1732238406; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2YtAory/2LKzg/w2ssBggFTUe/tEofrwbXOuNhcLvrI=;
        b=N2TCOvQJcuRUatf9Zz+5/QZriD9uEoqo0pDPryj+6N16l9mQmDAiB0PCjZQ8P0JhxZ
         DD3cVQqehragGh3g9Obc18R3W3kK7RsAt2056SPr39tW5IZjuIonGEOjplvFjvYuHED3
         XnDqDgd+r4exHdLQXyclbGT2i5jh9/39KG8CeIwVVtiSFPeEiu63PQJdglhhjrPMHt1I
         dPP30fUExmQlp4EOXAZ66BxR+x6hSG3PjkcRAWoh1ZkCd32QMysQhcxyoE0C+Yu/f7hI
         wHZ0WnqX+ULw7I3j1Pr7gY1/UZsnB6O8EqmCyFSD+InK/rbqKJG9WF4wVAHHhcTyuV0P
         GvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731633606; x=1732238406;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YtAory/2LKzg/w2ssBggFTUe/tEofrwbXOuNhcLvrI=;
        b=rG9ljNlHS37gpnCbE+3pjv2WBtG/6LS/yGWd/SjT2jwd55DddDAsIgdajr1yLPNkD0
         /0F0Z0VP4JXs94U/bwr5mPfxtuAp8s5EpNl9/97Pi30TNJMJ7ihQFxS9s7ulEumSqdI+
         RYVW70NbFIMKiuDWMaY6FKN9J247OxzlOiFxskpQdc25XPoqdanEgvM1Or3Y2viNtgPc
         DAlQmukUoAwMtYaE+aRR5pobCQDcHvSQiKMy4DEOdxz85WLrEq4DefDTFtaXxPJUwib5
         SbBIU6bzC7v5JC4kvFzOW+eSXmweY2PQvcsLxC103lHp0VmJ6ne1OlcDNd88SEOkOGpP
         CuIA==
X-Gm-Message-State: AOJu0YyyK3hcziG7f/hCot7zBS6Gg92+lf7XiDYOg200BmjReUB0fsWL
	TyDSTRJIk2yfXNUSQPL5rj/2pNSBiChTZ6q0vBb1vY0W795Z+ah0xK3T9Q==
X-Google-Smtp-Source: AGHT+IGdgKEz/XMK0rL/gWUKTa9Uzh4AwTSdzsfOztBhU4b/sSxzTYAVGC/74tAqAJRo1p0FlBuXJw==
X-Received: by 2002:ac8:7d4c:0:b0:463:990:4250 with SMTP id d75a77b69052e-46363e93fbcmr11740791cf.38.1731633606065;
        Thu, 14 Nov 2024 17:20:06 -0800 (PST)
Received: from [172.17.0.2] ([172.200.199.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa1a0b0sm12756651cf.45.2024.11.14.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 17:20:05 -0800 (PST)
Message-ID: <6736a1c5.050a0220.236997.4c97@mx.google.com>
Date: Thu, 14 Nov 2024 17:20:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1752167291548416594=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhal@rbox.co
Subject: RE: net: Fix some callers of copy_from_sockptr()
In-Reply-To: <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
References: <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1752167291548416594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909786

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      1.33 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   WARNING   30.92 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      435.43 seconds
TestRunner_l2cap-tester       PASS      23.36 seconds
TestRunner_iso-tester         FAIL      34.58 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      120.44 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      11.39 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        PASS      6.01 seconds
TestRunner_smp-tester         PASS      7.97 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 119 (96.0%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.238 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1752167291548416594==--
