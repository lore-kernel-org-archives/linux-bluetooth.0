Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCA17E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292518; cv=none; b=Dt0ByWILkr86x4Ry+kNCnCmJ34DOqWPFP2a0zRxc0QtyzUVbTzWb//KUPRpDPtBM4FJuDpzqu+mp/LpBI99iatz6uw2bWj1Y+JiUEDg3ozHAnS6diC6uIwj7hPSE543WbJTld6YcZJdgupC2OAAjqmHzMIuSC5tTHLoFkbwyPbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292518; c=relaxed/simple;
	bh=A4d97PbUla5nGpZ1hHnr/E7EOcGMU3k8uV8dv+qWgNw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qgjpMyjlZ6uTc4NJAlRVYfGEpdBUAUd5uO+D9bHzFZRmWYataJfgDh8hxmsN9TStPwwuRN4+P+5ldy6UFc8nEa+/QRcK/52cUGkMEpZYrMLrLwXuWAlMTGp4ixA6F00FTCCSgAbeznNwqcshdHeqnGWqLEEgbRYBc8ct96cJ67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiBbocgj; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiBbocgj"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-886ecaf455aso195194739f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756292515; x=1756897315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/olwvnl3sz4BCcwXVWsWEvCmuUMATaDatsKQTmaqFD4=;
        b=UiBbocgjbzgveFwskHov5M9xQqHUjeGA+N5eTILEZeAP9vHAOdJ0n0A+P0yEBBANoL
         hFDK1FgtBNwVNv8JAl4rS/oWYx8QhAr9lDV3y9IG/rRyjBFipc5W53pDKgwz50Va1uGA
         tcT9WdvF3N9jpc+zCb4LS/CDXfWVy86uIzcqIwKqPAeQy9gA1kHNqb5CrZclKKCi37IZ
         46wXqsyFOik+P4qtmJAEqNUi1bkDpX+FStDS2urKz0oZjkpyxjlL0izvFJR1DWufLtuB
         d9wVxSJmGLyXUudysRs4Ev9zm19Ubxfgv95MWE3vwvcbEHsiS+xTGKbXGG4Z75XnBd3T
         lZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292515; x=1756897315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/olwvnl3sz4BCcwXVWsWEvCmuUMATaDatsKQTmaqFD4=;
        b=ThAky5y2bOpyK5vOhQYbnH2chgQEFE7/aiA3jmETzMCMq0bKYH6c3niz0vQr3U2sfF
         HYb/fRpXCgOB6PLLe6tyVi7Y8DZLZ1QMIWnmCs7HYB/BujWtVOEL70Cl1m8f/DLb+H8y
         O14gbMbovaf4enm0X/K+huVkZaYIprUJhtXhyvJxeS6OFz3eh61YP8b7VFEFeXIMTvq9
         E23j+mMCXkyGgpzSOrKwJ85Z5QXkGATE91zEqDmM7usZJFpuv+E9eXTmrBXSgJAl8kNJ
         c4/5QrDfQy/zi4LSwR++ZiVdz2UK8J+xta90vOR5PT9cOwsXhFBLUzQ12havBNuQMvqU
         xgxg==
X-Gm-Message-State: AOJu0YwuhC7zNLUToV+IUpB0pbRRHjd5dRFZIvlj1gm+Ayewrm6ySf4D
	/deaf6AD9tVJ0xbTxKppo2V5I+M5sbU357gAebw8AyI8B3QbJAokNujxf3QZQg==
X-Gm-Gg: ASbGncuwJKLZWvYSZc7Fb9/eJOZ2MKqALVj7ANrTIMP4yvxTRUVwOGRrX0bHgYUDR4w
	VlxWstf65lvs3cBB5Tspm+ylubR9kvu6kxFm6eebwHfw/7EtLFdDx80rekfIG7U+bvFuk7QWYk1
	0/SxoAVK2BDGBZKSbrwh0dF8xohNd7uqDzd/FQf7W2gyS+3VbVqbXfCPXxQlvaOIjv65Mj0uXK5
	kcQ6XTaAPJZNCA2mc6c75qHskXN4dQHTKTK+YGYoO7oZBv8YFA9j/C0YqyoKhJ9zwEDtoDy/Ot0
	zKhqnewzjUCj9ZlEAFKXkaXIqHCWjiBxJ24Gk0SfIYLq20xpKge940a4C9ISOp2RGgrAq8rPZHu
	7v1n+ow5AGqcguX6gpZ8VE1a9N+s68A==
X-Google-Smtp-Source: AGHT+IEbv37U6Ho/lGOBwjLjSW21QUCOwc8vUuDUgkzq3hQtJSochWlEQpJIo7eQolqZe2xIDXO6lA==
X-Received: by 2002:a05:6e02:1646:b0:3ec:983c:20f0 with SMTP id e9e14a558f8ab-3ec983c2237mr132026035ab.4.1756292514669;
        Wed, 27 Aug 2025 04:01:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.213.184])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c191f23sm86292685ab.16.2025.08.27.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:01:53 -0700 (PDT)
Message-ID: <68aee5a1.050a0220.8400c.1721@mx.google.com>
Date: Wed, 27 Aug 2025 04:01:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6640047885122396139=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v11] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
In-Reply-To: <20250827102519.195439-1-quic_shuaz@quicinc.com>
References: <20250827102519.195439-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6640047885122396139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995987

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      27.37 seconds
CheckSparse                   PASS      30.82 seconds
BuildKernel32                 PASS      24.93 seconds
TestRunnerSetup               PASS      488.73 seconds
TestRunner_l2cap-tester       PASS      25.32 seconds
TestRunner_iso-tester         PASS      43.66 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      127.60 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.093 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6640047885122396139==--
