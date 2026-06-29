Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA73D76
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765147; cv=none; b=eY5HhMh3rJJ8QpeBeCQpTaQwzSk+WAmZJXfhJeSGDZTC3pMMFiSR+xm7pD+Z5tYj9PsBPobJPnweTdHcDL3PQTLgvvBUGBGTo+nOXL83Uuo8xxt4rdSsL2ciR9ua+tIEmwbIREwwO1gzAEkLpyn+ZxybVS0T3KtYj8uom3RZGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765147; c=relaxed/simple;
	bh=laARY7Kl4iRKiDjYPo3v/sK9bS74em1zzpQUVeBqPfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WXLBc/rG6iKfGO43zfq6HyWt5Yh9YgMnSpw0B5kQ0nkgTmrLLnJUE4GDAnBnYGg4hylEUGTqSv2BjVSvaaDO2pgTgm8HWW+qNd54pZxbOPKb3ZkxI9xfN9AOIrNS7Sv+UzGoXQv8HamAtI5j/TwaqodDq4BGw7cgCFY82z/r8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWZvG08j; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWZvG08j"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13986d61b4fso5252186c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782765145; x=1783369945; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=djRMelU3+f6rI9/UKC7eaKFY2/7lmN2Orbf6QSBfbKo=;
        b=ZWZvG08jliSikKIyctg6U/VsPHS926Y3EyPZny6W4ZPPXUVBGFNeFEVhO+bu2u0Hoy
         z8bC8Rc9RtlkLYcQvNClMhY45vQtogzKHVdkdAIBmimXUWWw17tePYtoJICGLDDeacBp
         zqdvf3tKQ+xhZsL4EijeJMTCGu2pufT9rX+4SqEqxxzDAGNGdb3uQuVo9kJ+lsAYnpLj
         C2FdPEbXcB5f5vkddOC+Vb7dC5y09b2UqGxTest9GPS71uFh3vwCxpgr0t4ds1vfyY5j
         6sK1y5R3Vc8Ky7Woq0oLebZLCfjNjsUvOfq2xKCdi8GUXifChGzSRqxHVhHQUuAFtQ52
         iWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765145; x=1783369945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djRMelU3+f6rI9/UKC7eaKFY2/7lmN2Orbf6QSBfbKo=;
        b=X8rpROKiv9vvgSn/gthpfFK2bkdYdsm3FIxf4nCbiY/C4YyfD7RpmB5CzQ7Xbyk8ER
         1oFefiEKEWowJohVZdDKXRlxasPGsOyVzK0W2m8DP3V3e5tpyZf3doNTGUHAuvpmqDNV
         LeBatLB/W4RrpgEksK6lgHw2c4fexiFpECdB1XhQ1F3tNokysAqu4qEAgD8n1j5aIZZP
         Bt1iAHTgI7OPxM2ITPE0tn7Y1qLUL/IisiQ2WgeonuUduvpTukj5FpSRuDMgnM2pPb+4
         A5mFY8cWbpPaDRuficohDVhbSn3NDXJA3Ak0eNUiBOilr+KbIKPhhDzANdg3durn5h0K
         bfTA==
X-Gm-Message-State: AOJu0YxiPqqautyPJfk0+rMA3pAX76tCm/3dUN5JtE2S3mE4TvnlJCqn
	uw6dwvcHALiVndmtzyT+Wr/LUcG7BQI0G+4pKYmm3DGL2HrTEm5dqqX3HBFdKA==
X-Gm-Gg: AfdE7cmjfX/mn2JU/n7hFC3hwfBjt11mxW1IiFdoITcKF/23vwnKjXYNcVPkulV6HKN
	7Ar/2+/vchFKinpUeRegRfH0SVew9poiK0kCoj2CGCucPdWvcZ5vxW1NDhPeckVY94CWiScC6N4
	KJyvMAkiVjw3+xuBlYOoTaz58lIwTT0EvlF45vnPPHxbR0rXW6kdHmsJAg6+KdZsPyQiBFY0FOV
	hM0ois9/kfKoJZYHE1YAH2gORYLkDvDHVYs3JhjIv+3UXjsGOB3nb5v5uVVVuzmGnIjIeo8rWzY
	W17PfMD9d+zyMXpP8/ReuZEFuxAPg7/WsZ7MP+0vWdK5DHt6ltROO1DeUnpWjM+5VG98fA3R+Cy
	9k+pYisB4EJlg3mhJR3Vm3XhyHO62dhrFvGggfSQqMdy3dfgKAAPcrPysggSErW3Fthjs7r7kb/
	KktG3Ad6ls2pFzvGADM1+S
X-Received: by 2002:a05:7301:7c0b:b0:30e:c24e:2f11 with SMTP id 5a478bee46e88-30ee1472625mr531467eec.30.1782765144710;
        Mon, 29 Jun 2026 13:32:24 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm673042eec.27.2026.06.29.13.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:32:24 -0700 (PDT)
Message-ID: <6a42d658.f732ad81.1d6a4d.ae76@mx.google.com>
Date: Mon, 29 Jun 2026 13:32:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2644779932760921628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silurust@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
In-Reply-To: <20260629195334.11944-1-silurust@gmail.com>
References: <20260629195334.11944-1-silurust@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2644779932760921628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118472

---Test result---

Test Summary:
CheckPatch                    FAIL      1.14 seconds
VerifyFixes                   PASS      0.31 seconds
VerifySignedoff               PASS      0.24 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      26.78 seconds
CheckAllWarning               PASS      28.63 seconds
CheckSparse                   PASS      27.54 seconds
BuildKernel32                 PASS      25.77 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      486.04 seconds
IncrementalBuild              PASS      25.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
WARNING: Non-standard signature: Co-authored-by:
#135: 
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14652253.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/373

---
Regards,
Linux Bluetooth


--===============2644779932760921628==--
