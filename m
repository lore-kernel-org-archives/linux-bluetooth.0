Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870164;
	b=VJ2MjH2XXWim/8JB9pMj8YtGrnurUbBwc2OYSvf7vl+BYP+GvGGhG8Q0Ei4kQfZC8ikV
	 FR8RQ5J6zcheOQmbwr1/EqSUJDMzsTl1GIc8d2FSFHrVBuTwGY5t9HzCFFRjewo4cZNAi
	 sVY/BdqFtHyhgNtBGO/+n628r3Ba4I9YlUImyFSPyhqBHg+aFplAimENZIb5+xBttUuog
	 ZJI3ljd+u5LxA/rxrgrCYnYUlXTiZ/NuklEuji1mBxtHlEvsQMVonl+JgZ6cKuJr7wBUK
	 07S3vv9beiNfG+L34QASYCxkJF3PBBIaFY/ueHtyc78XVfM/vGA2dOiFvalfdPgZ7OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=G69kYeU+Df02my1NDGMrntDSbBuBH+hFhEbwjOsqnlw=;
	b=kABmLZ2ZqekRYM5goWgEVTGToWUXwb01asnMilVMSzvxN66PpRx7X5ujpdOY+EqliT9B
	 +eJDKU4WPzywr+J3538g1KmD4AiVG69wf0zKYBOMAPpI6oqC5K4klF7gADBuQekvDYJKe
	 JLPr86VmfZ9AT3hnwFHPNzF1G0CwWLPvzhI223MHkpLhT9RZwwSHqPwLXelXeEC5z/qpY
	 IqNICKCgYJIHSJDrdrzIm/Zar8bUO8uWOFEvdSImQnC2MZDhvrgzG/ZfG2q3tgvQuzYg4
	 UQWBaiPu8LWoT2i8pcVdSzJoHmZr8uzw7UgTZ6knsRM0paASQMHhE9gqj9/AQKKrnCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyCDF5YT;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C98606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 09:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C98606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyCDF5YT
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a6f2825dd6so457592fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793870163; x=1794474963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G69kYeU+Df02my1NDGMrntDSbBuBH+hFhEbwjOsqnlw=;
        b=xyCDF5YTMYKpim0Z2dWox2vRlYmXetCZg97u1BH2u9MspVISPMcKQVMaEMTu6mPbPI
         0ZIDJET8e2U7Rz/Ng/csfmxouIFYWl8glRwcvGaHGeCCDvMaA3IGdLtPBzkGjZrAvLCi
         alrkSI7qpE1lmZCJPVPfIZgYTNDoZfpO4LulOAxeDT7x3MhkbRd7TEcjMT1AO7f0UZ2W
         ExDWHkkv4AuAds6fDsjTyI/gupIoTQh0+6/Vxd/XPvxzlxhVew0iWjOaXZC/L6nYb3EU
         apcRcsJchrkJJqJIvkAU2Xd3giNgpYjis+aFvGRRNBgi3Q9dQ+iquD4OWXJ3Dh7FfgJ+
         FY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870163; x=1794474963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G69kYeU+Df02my1NDGMrntDSbBuBH+hFhEbwjOsqnlw=;
        b=2PVQIRZ6h9B/++EneOtunFVmSseFTwSFF6oE+hnbVuKyHNvIRmPrsXd6+f6I4MHhAB
         ONopFKuIItg/7gVTvjmn5Oz3FtCIWeDM62yyPrtJQH+4+r2zawzL8OdMxK7bjvbVqgVz
         b7jzGZwXOp8oyHetIF4VgqiVw2t1V4gJIPwh9FELbDQcI9znppdHHO0Qwn+MjRw/+ycc
         00bEillOIWYvieZcJO01mPNplSKgx/G3z51VJqmDpfo9vQhyX+QmU7FbiW29EiJ8wZsk
         EkDE+ZkyZeF74GD3l+NAYj7c59gnti0uLfLZg6LT5FboARSuMv5dm92kiQVO+okx1SU1
         3fyw==
X-Gm-Message-State: APuU4Z8JLGUi3ObPAFm+La1Q3bFC1Szau31oY07a9mE7yvWD0prCdQ7g
	CF3QTESkU3cl6staRQ22QOVu5Z5Q8nTnnOKnQJVIETO0eyWJfQQXainqFEJfPw==
X-Gm-Gg: AYBFou0jYK7KoUvbzDGmnS9cn7YoJ8SaAfLb4viyfbaB+g+7scVKEek3XcO19NOwU67
	rnCH0euDiLZZBRmWGA/EPTJNm2c++IXqwcwF4yHxdxMSlo5eH/uTvWomN402c81aGpUVFFuaMkZ
	kErczyeTU0Yyl1AS2qKIc7jKnZeNTY6cN77dOM3so8RonSCOPLbu+X7BChb5UeiH5nLphmPjc49
	Pbm0Re52n+Up99DA+VQ1vws9CXoIWNiISoQ5tyTlsTUEUxWAf4/3RO+FQapHApAWkTdsk+6JXn8
	tPDTDdHS+V/GYiEDJIy9A7/+3stm5bwTf884r55Z30PPuQY0VrAVPPeUrfvwPdt13xqk1ONXjjo
	hFF6h9Ito4XJJEgiN0i3rQRalxLgPLZC61MVM2kKZq2fjBwnaSGNS0mHp+gNfwQyLVIPgZm7+i/
	4OQeVpAWd8JTYLtQ9dzGzanLZTxKIXz+r+yAMMppTVM23NpQ8yLhSRGzI4j6Q8vd1jWGYcikntG
	xdCxwhsYdMbwWA2tZFEVRAR1gyRmur504idtwdUXJx/TTFtkAMp/b1JD02NTWXlF7j0tOOWGN0T
	at4aKyc=
X-Received: by 2002:a05:6808:244e:b0:4f4:73a9:f838 with SMTP id 5614622812f47-5640dcea0camr13842292b6e.22.1793870162617;
        Thu, 05 Nov 2026 01:16:02 -0800 (PST)
Received: from [172.17.0.2] ([20.80.111.50])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f400fasm3784582b6e.8.2026.11.05.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:16:00 -0800 (PST)
Message-ID: <6aec4950.a96d76c3.73922.59ce@mx.google.com>
Date: Thu, 05 Nov 2026 01:16:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4698156939012741048=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 25031212351@stu.xidian.edu.cn
Subject: RE: Bluetooth: hci_qca: fix use-after-free in ibs debugfs files
In-Reply-To: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>
References: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4698156939012741048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202755/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      5.49 seconds
GitLint                       PASS      9.75 seconds
SubjectPrefix                 PASS      0.50 seconds
BuildKernel                   PASS      23.24 seconds
CheckAllWarning               PASS      22.03 seconds
CheckSparse                   PASS      24.64 seconds
BuildKernel32                 PASS      20.28 seconds
CheckKernelLLVM               PASS      21.23 seconds
TestRunnerSetup               PASS      454.56 seconds
IncrementalBuild              PASS      44.95 seconds



https://github.com/bluez/bluetooth-next/pull/1070

---
Regards,
Linux Bluetooth


--===============4698156939012741048==--
