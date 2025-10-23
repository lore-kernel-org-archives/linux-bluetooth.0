Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E132D422
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247991; cv=none; b=b1ZQpY3DdOd1O2rjbr76x+CKkwragucTTOT66oNWdiO/Py74zKYu+UtY/u4aCZDVOBaIuDjWgZcg4ezJh/YpZTOyLmcc0ipwxPdOiy91y0YZ8b4iUVK9fJMSl2Fuwr9xEiEmCaHySFDY5eREO84woYsleDQXqu4euf/yLcL9rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247991; c=relaxed/simple;
	bh=hleBOQ7uGIJwEprV1pU4PsD3nKhhqYxzBDH9Y/ywWnA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zvjo+PP4VRbluPntMiL/jQnGzEv4JiTlj3EcTt1mqMAXlG99IwqR08QRk7aMs6HwYS/Km+b18aabW+KpVrnTb9kPHUZGP12MpoYsWmBXZnhwegueJ+OnbfQBoNQdLQTxyyYL7XC4fS/WvuO+OeQ4k7BaFIR2/gFZdM6Pg8wA/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0IZd9iK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0IZd9iK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so1637900b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761247988; x=1761852788; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=36/gqVdG/iQTRqH42RhVAVxwyVP3NKXFQcbwfERJLzY=;
        b=X0IZd9iKU1cGF3yMwlk9xTIxYn7DBVakA9YrU0Fbfx5nYfjrE9agKrub2gVvvIcsIW
         FjnCpgQwxLGkRL0Movo7gdZV6Z+cWRfmEOGtZOdJadLcCbXbovXRZvj4zD8pe5b6PW9X
         rL4oEWG17S1lV+TSWaSGQF2D421QTKfdhQZXZwmWnonguegGHjJ18b1r+Cjzsz02tcCC
         +RhVabA4n2rX6LM0OxTMW8YP45cuuK+kSdW8e9HbOZGMaXb+/RTt6OjbJBBC8cKHxgoy
         7FTZ+lAUdES2Uug+/W4Zv897VI4+bqHbfx70bVoVuFdQoHCbD+9wrBvmkBxBPmPvmC4g
         vbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247988; x=1761852788;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36/gqVdG/iQTRqH42RhVAVxwyVP3NKXFQcbwfERJLzY=;
        b=EnjJroiqrcubQZiphwrjSvW8qohBCJa0UxorQNQIYg1NuxAo9/z0+VDfPGk6sg/ro+
         EXSajZfltWG/ZnC1VhIIiRSfeERh1FZamtimjVo71IxUESKd9BWuTKM9x8RMT5jdZuLk
         l2Cl8fswtvE3LcHXZG7N39wcP+di0Bvu8Sk/9Ohv/diudWrbyKGw2A30PGf//YMObnev
         5mxULkO09TUVdDRG4XdvrKEkWec34mqtpCpPoROkXIaCQ2gzABIPZCc8WDtahU5UGSIh
         Gor4fgEBgGlgX3AG1A+HyrL9iVjBmB8Bw15rYipvHLDcpUxMc3BV/hXzEhuRg2/UvND8
         K1Ng==
X-Gm-Message-State: AOJu0YxVleaTX6kGlITYAfMCUkb51GJn/ZBJpsskWRqWPm1/KJ/T9IJ8
	Th65WRxWazIbuAaGVamiEs+nlPoPSQFtrar7dgGLBtSt03yG//llz8KDgguiBA==
X-Gm-Gg: ASbGncuw8SxeZTtXZ3MP012v6pYgrHrkRU8NDmORFBk/GJCVR25WqEC/FeC+a/5z5uT
	WnY3/mBYkhJAK+/xdt1bXwtOhjIwZE1jrWFYxooD4lfivOmUV8MjgJHYXsyV/8DKj+q6fgldO9M
	PGpICNYH0F2k5esxDHu/t9QfZjc3CO6R2tFMdPo+F2O4b3TlrD6+1RCec5eJdIy5SG/bqGYYwAW
	4OtAXy50BSjfeuiEts4qisEoyc7YVqnbYStLMqZCJXc7g5yy3McPp0V7YSEgt/qONTfxz6q49l4
	gf+BZfZ+vAHlHbrfO7kQQ2E+wppxenyJeHQdIjucWdfYV7VmAV2Sg6UPbSuG6xlmJPgJIjlN6rC
	1QBqkty9HfZCytG0AmDjm22fTrAcS3z2I9e2v2otG2i7No6yX4wSQqGpBZha7S+sSNI4iJrbU1W
	CLA2S8QsQuSf51bZTwpQ==
X-Google-Smtp-Source: AGHT+IHv8lMQFrlIhNw7wcNJ/FjSu2koJonKjJC5Jz+PtLeip8eOvvQZW0Nasqw+VlTlQ4MZiDjGew==
X-Received: by 2002:a05:6a21:3086:b0:2df:8271:f095 with SMTP id adf61e73a8af0-334a850aa65mr35347165637.24.1761247988117;
        Thu, 23 Oct 2025 12:33:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.125.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f865sm3248235a91.11.2025.10.23.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:33:07 -0700 (PDT)
Message-ID: <68fa82f3.170a0220.17162e.f572@mx.google.com>
Date: Thu, 23 Oct 2025 12:33:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2908534732929278410=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, calvin@wbinvd.org
Subject: RE: Bluetooth: fix corruption in h4_recv_buf() after cleanup
In-Reply-To: <ab6fa50055fa0c39e5501c123c36e662eb48ae61.1761245114.git.calvin@wbinvd.org>
References: <ab6fa50055fa0c39e5501c123c36e662eb48ae61.1761245114.git.calvin@wbinvd.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2908534732929278410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1015163

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.79 seconds
CheckAllWarning               PASS      27.52 seconds
CheckSparse                   WARNING   30.86 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      493.08 seconds
TestRunner_l2cap-tester       PASS      24.29 seconds
TestRunner_iso-tester         FAIL      33.72 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      125.12 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.37 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      11.60 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.42 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_ag6xx.c:257:24: warning: restricted __le32 degrades to integerdrivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_nokia.c:279:23: warning: incorrect type in assignment (different base types)drivers/bluetooth/hci_nokia.c:279:23:    expected unsigned short [usertype] bauddrivers/bluetooth/hci_nokia.c:279:23:    got restricted __le16 [usertype]drivers/bluetooth/hci_nokia.c:282:26: warning: incorrect type in assignment (different base types)drivers/bluetooth/hci_nokia.c:282:26:    expected unsigned short [usertype] sys_clkdrivers/bluetooth/hci_nokia.c:282:26:    got restricted __le16 [usertype]
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.179 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.817 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2908534732929278410==--
