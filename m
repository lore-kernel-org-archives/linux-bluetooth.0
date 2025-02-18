Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5791C1F12
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917897; cv=none; b=D+o9h0hJyHlwguLjc5XfN/3BSwYv2jL9jhHO0Oznjo4tZCBnye4sumRahlZvuOEQ6QMw4mPGEdgDf+WVecYNQpQ57G8gQbvrBc1q59mL9fz851go4YAYUGA0q0Lk1HsCYgEwjkjJWd/i/6yqqqJfjHfgriPxLqDNJhPjTPZuPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917897; c=relaxed/simple;
	bh=reqPLeN12mETirC9p17wKX/+OG9FUwVDs+AjIwmdboo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gW8y1b5aXDZ5Z1Qi7cn3qZqBWr/dyCsKkEgl9gXo69oKqHLB8RnIagIZeJLVZ20VS/3azZrAhxy83sLv41kmGPunPkStlvKgeDn28QHnYA55sIATAsenYn2yVhF/ObNbsO6Fm4uva7XdZtBRRDEBHgFoWep1XB+5i3v0lSSOVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdN5NIcY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdN5NIcY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e68943a295so14904026d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739917895; x=1740522695; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vB6IT6K9FavJUzpLjCARVhG49yI8AieAMO3uM8qAHzg=;
        b=IdN5NIcY0fO4otCcghq995Ydh4TKDB+YdbQcZlPn7FulDkv0FNHE3m7DdNBiFZi3Ox
         I4XDhStj4tYbj2F6f96KDmFVHwnmY2ZB+7c5lmsHc1Dn/JKVUeFBmZ6ItHIRAZWkko9m
         SNGmu+iC0zqw6f40BVcl9PTVawM+bmCIA8FSKBcoQ5/k3DnImMM1ENLm0+FvcNTWlDe0
         MRIpPjY9GYijTHq+5IaTi7OxlPJKAc9hwQsmgdQzrQStd6ND0xttV4CtGm+2ViSVJkT0
         Hhtrx2BKz5+lGfqaHXZqgAEEgfX7SGyhrX+MenpjTT5pagzptcLu34yTCh8Q+wKOl3Sp
         K57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917895; x=1740522695;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vB6IT6K9FavJUzpLjCARVhG49yI8AieAMO3uM8qAHzg=;
        b=EE8WVzHBO+E5mme86BsweE9OhFALOwJ9Lxye62gmEqynz3E66FvMBO9DFifactuqU1
         FDa3nLMTrpekfzwnty19/kzhaoWhhNveQ+pO4Iklpevug+P7g6iMcmMZqufS+2QJXKgo
         3/hAUrCujM5cpK2bmxcoIfJB0ROg1gq0Us9nLgbzuItSfGy0cq3e2LLaTXPmC88ZiZqN
         L7Z+pqxeVz8UDKsBMv1W7TkidhZTw3RSmQUJQ3m3fKFSJwz/CO3wyQuW4TDh/eIS8Xl8
         AjhciJlJrva0Urq8jyyycpNRpzMpKxBu1RzCUWih0W7PiB9bSQGVaXukblfGP5IcuWqk
         tOOQ==
X-Gm-Message-State: AOJu0Yw8+LJLIoRFYatqFupEaVUulh/nYrPX94pad/yV7UrYpO3RQOSg
	/2+gtRCVSP+ZC+7Az/gIrA58bMDuZmAwVSPDqkWO73fKRNsVoi6xRK9FBQ==
X-Gm-Gg: ASbGnctFo3C0bmtSFWaLHZWYHkpJJo9mj3k/OcMLwgq4ATdfPu9c2imGNOHICrE3tqX
	xHBtNO1DJTvfKVq2/tSGe5h9zv37EY/g3nQAhEeQSXNbSo91HE5cutv/PEYxf0ofgRrsCnsGx73
	Vk5H34d6mDyT1jJPMNGhONVwq7Cr9EhpSrlCjM7556bHReFwXDtVGiwAKo2hEvA3FumOsnPiSI6
	GQRZfolxKkd20BaV3wKcYK/djANqu2U6hknFOIFUOdAcZkAACvdrNv18k6zpSmUGV7GL/JJbcsW
	agJJzw/gEFDZtZDRHRtWIcd/
X-Google-Smtp-Source: AGHT+IEJzFreNizcOASUn5wJFlqU3ziPDLoyAVnGZ2lsOU1iQqYt0zPClydIRsP0Zd9h+n5oBiIGSw==
X-Received: by 2002:a05:6214:2422:b0:6e6:698f:cafd with SMTP id 6a1803df08f44-6e66cd0554fmr264912836d6.37.1739917894819;
        Tue, 18 Feb 2025 14:31:34 -0800 (PST)
Received: from [172.17.0.2] ([172.183.111.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785c09sm68193566d6.36.2025.02.18.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:31:34 -0800 (PST)
Message-ID: <67b50a46.d40a0220.1fa8da.b2c1@mx.google.com>
Date: Tue, 18 Feb 2025 14:31:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1402970391617451159=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250218214344.1519862-1-luiz.dentz@gmail.com>
References: <20250218214344.1519862-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1402970391617451159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935304

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.09 seconds
CheckAllWarning               PASS      28.51 seconds
CheckSparse                   PASS      30.92 seconds
BuildKernel32                 PASS      24.34 seconds
TestRunnerSetup               PASS      438.23 seconds
TestRunner_l2cap-tester       PASS      21.00 seconds
TestRunner_iso-tester         PASS      35.53 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      122.70 seconds
TestRunner_rfcomm-tester      PASS      8.32 seconds
TestRunner_sco-tester         PASS      10.33 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      7.26 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.193 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.130 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.170 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1402970391617451159==--
