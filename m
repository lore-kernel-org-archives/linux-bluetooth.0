Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29921DFE22
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325626; cv=none; b=o9pVUknFrjnpx7Fbx5079XRysWAiwJ5X7MOtP6IzyUp/kA/M8vWaKlgGE9D4nx+v5n46FjOdn/wmyuPfvPomzabRc8tw+0dP4GStshrehIgJK/YM8ze3U/6sFEoZmNnyFKQ4jRYco9DESRnJ+r+FEG6BpE0dv65UTxX0Av8Gijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325626; c=relaxed/simple;
	bh=vRK0g8RY4RB4B2UyvARSUQDa7G/ZiQqUz+6+Ilte9Uc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dhCClqaRW8EbsUp5R9sTQnRX5lQz8kecbxmkNOTlcXh6Bvy99v8+oA+SYHpuKQfWcRPIqmSYu/BPsScW8BUIRxg61uG2Uwl91bmiNh6h8iVwD6mlnjnL+c+R54M/1CL5f/7Lfj/AegDIu9ABeXSF9NUptpHejkUljHyqhKq1xv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyGskJ4W; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyGskJ4W"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5d980e08e06so1467619137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761325623; x=1761930423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C28/YgqZbvDG4zpIJhtkaSA+aDlgHKDZ6KOT2trmSYA=;
        b=FyGskJ4Wo4PTQBoQNRafurvDySg5QRVJ7kfDEvt3UiTnl4vAwNML8v2KGmw7n28+zs
         gDYc0cgRahRIEao5ujuBVN4Wlc7d85it8otoOwaf2u7Bx454NZqoC7Y6edicvr+uN1G4
         Rl6f0nW+sWZBdF+rbVGuA21K7841eDdr0QiUr+ZR0EQIQrdazYPOBqnRLkrhmnZGBZ+J
         MXXVw1sWsq6LoHlrQ+hWvsSqslSsRUc79rK9sk5a/1PFNZ3PX9brsosnUy07B8jsuuWK
         ikY+x9bYXvRvnvKdN4qERn5TVkFAwrSOld0Vtb/stZBt2yVUr2NkNWsROhod62bT2Fs1
         MmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325623; x=1761930423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C28/YgqZbvDG4zpIJhtkaSA+aDlgHKDZ6KOT2trmSYA=;
        b=DtbYgOL4Ok/Jm3PWdhbhHBb2B3k+BbpzBAojoBcUjlg+Lxk7hvEwtq80RqCRBUK7EU
         HYlvIop5XObFewl2YG0xnYGwx9leEJ/qujLhDNpcx7h7YtW3Wesww17G48wmcUa5GZ79
         wTeX4o8H031EgJ/jOTQ6xJoxrlyjcPBmBGStuR6Osj2PKxSQwzj7tjt+Pk5E6/Mmtn8f
         RR/ZMh7PJA7zJclOeVo0W+1ehvcqfLxvve18vrEhz9s1FEGXiAcFL294f6U2LM3N1+vs
         6obRfRwYU5eAvSnsubcNUcBgdtVOIJzpX1BO0U6SCMDgqTgSW55jemLJBfuSv4RNilFq
         H6PA==
X-Gm-Message-State: AOJu0YzeFEBhJJxdCSVOOVxdh8VSGs6jNMkncRcnjoBlfcPiSXOCEIJR
	yIyZBklNTLrV3NdxsucW7wt43VuVf0/6mfhLGpxmqk4Yaa9nEN1g+axYsFQUvA==
X-Gm-Gg: ASbGncsf2I3t7nCahWrhkybpZwyKgk7Nz4YOCuFTBbNLNvd9VQ/X9VGu0qNkuPxzYy/
	tYGFiYd+hszeMq9QpCdj88VIcl9y+UbTTZ2eKtIMbeZz6C9nPu2M6Xwz4abIKUuXQyzcJvi1fks
	7YYqS0HutfMUR2XKXkqhw3OZPVn5I7D2QqlYi5MEkXIcRUxnt7mlPHgX6NofZuq7eyuKEyoaH0L
	GJO7NP0J8wCLdEA9WTJ366aMzy/NwEAXhnPsC4JSVXOI/Pc3i2SLKSAO7ClMx/qK99n6QENSRHI
	vpc3ijLuZKH963V0nd5rR2/kz62J0jB5xt+qMYPbjrp48VZYmfm9q9/8/pgg7iMXlmF/x7NpbPi
	GAvXkwoiKEGCDDFjLPiS7zLuQZdfiD3ErQ+U9fL2va/z5feeqrd6ezrntzaxEXOan3iK/g1vpBL
	MZgZnvSg4xZZj0ApjbeGhJYdwA0k6zCA==
X-Google-Smtp-Source: AGHT+IGK7JhffFzTGbJRjVSL49CGP79gqRs7Xocf44EP9twGiQ3KMV49OhWYo/YzlV1zt71iq4KiJQ==
X-Received: by 2002:a05:6102:3255:10b0:5d7:dddb:3e5d with SMTP id ada2fe7eead31-5d7dddb3e88mr6962343137.0.1761325623290;
        Fri, 24 Oct 2025 10:07:03 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9de7df29sm39816486d6.18.2025.10.24.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:07:02 -0700 (PDT)
Message-ID: <68fbb236.050a0220.13e81a.cb1d@mx.google.com>
Date: Fri, 24 Oct 2025 10:07:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5622321296851388560=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rpthibeault@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: validate skb length for unknown CC opcode
In-Reply-To: <20251024162912.221224-2-rpthibeault@gmail.com>
References: <20251024162912.221224-2-rpthibeault@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5622321296851388560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1015551

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.09 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   WARNING   30.91 seconds
BuildKernel32                 PASS      24.74 seconds
TestRunnerSetup               PASS      494.84 seconds
TestRunner_l2cap-tester       PASS      23.99 seconds
TestRunner_iso-tester         PASS      84.28 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      115.41 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PENDING   0.83 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.158 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.025 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5622321296851388560==--
