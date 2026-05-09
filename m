Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE2366567
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321839; cv=none; b=GSNhL/KLt8JefSl/HLRjVtWu/+v/jG1lnSXydEsnFyMhaRSxrnbiDIs8dnyuJUbjhAcWjxBj9xQTM2E2Z4qJbwbPFkQXynYkOUlz5n6YRcsu31Thv3jkaZj42ZCI79wL6Mbg7+yIYwwJEMm1NzLKfyWAyEbZdCo77HxrilkUUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321839; c=relaxed/simple;
	bh=ZcpalQUfpekJzLKjOfCP+gK4irRNmmKdXqUOudnVxSI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pjWeybQ1ELyla11RJ3SzyQOckEqPIv2AcLq2K8J1hV6Zn1PR0oPdTkkOXvK/ynyP7vSm6p7AezT//2GMxMajIhe5X2iIdO4YQyIPhdrYh2L/sZe9/6z9DWF1bNkr/VdgWIyXzSO18V9tHlMsxzUdd4b5jVIkbVC3vD3BepwUpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmqOW0P2; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmqOW0P2"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c45281a06so4816445c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321837; x=1778926637; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YgPsTO+cjy2QyADvAXjcX42Inlm2XvwHOaqh3le3hc4=;
        b=VmqOW0P2aT81xHaN5hR6IP8TKHQUvVqMFvszbqlFbssrFB7FIRNXsLi2hg8vDDGQNe
         F1Zb32+Tkj8z6uvWLojhzL4Ishwer8QHGOVQNTgOzN6zfmZn45/LyBNmVA54gywZKOlU
         MQiFfb6VP0xYb0qIU2v1mQu5SGknUBp/qrHVcNzuO7cMFhNzUl/spBDJDvg0Zwddg45x
         Zv0ShQnWge5yUuH86k2C/eiCT8qwSMKsWNQSDA09YPiwf+uEtaHjWRWc7k5A88ek2Fkq
         DYUoxfOf2ND5ZXWUgv9dj4i1TtTyk1PIbT8M8KCxrqT6881NwzHbVo6G4VkGoJjatthX
         45PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321837; x=1778926637;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgPsTO+cjy2QyADvAXjcX42Inlm2XvwHOaqh3le3hc4=;
        b=A/XnFwR8RlAvcfF6hPybAZ5W7P0Hb0zd0oTkemQEeXk0rFcMr2RktsJnZAnUOczfg4
         eKaRq4yrvL16RJQk7dxDp4vwNaHXyUqYBvtE0a32ObrPjSoTtQBF/PSuuNb5h0Qnewne
         PhdhAcEbdqQPFVDVYcIsoj+A2Dw1/Vapbqayo4up5Tynuv6xPh0iBZKED2sxsnn0dkNW
         Rp/MI5k9kjv5jWQsmotYVpPL1H2DN1w4K7j0fbj+F+3ZGed3Z1xILblh00Wko8Xq2MRR
         pVY6BRKBE/yTGJUZq2nhTyKslvgcAK3J8HztqA+KpGQ2GfDINOrzlZrWnPuyxLQY5kF7
         Gdog==
X-Gm-Message-State: AOJu0YxzMkt08yZLZWLGcy0j/dOm9mXJ/a613aTOIJyFg8a+mi1rd/Bv
	/J9sSUk/M2n2gWjximKj/ui0/Q5z1JyFrl6gyAwEC2HUQ8Qbk6fGBEIjNYahxQ==
X-Gm-Gg: Acq92OFfl1rYptwLQWLxiUtoVIeucNEG7dQpfoBAqwDm35VLFy7UbiS/h0eWcOj6mwU
	IjBiwhPYh88uq5aTje7Vy0kAq/rmo4Q+8RuCiACibOmbYuB/dwEe59oHhLnSsVoEp2WIYXsaSxA
	yKmDCaqQslFBcWv1tc9se9ToxOiR4p2ETLKi+embuyXPAt6kBLBeuHQSOKPqa6yEGRV2jrKDpx8
	G64fgv5/15Ag9sauGv/TRuwV1lg8WnMW8qXCSg6XVrX9osEyXDQa9Tziq3fjewhcOi7UaTeY4r8
	MRkv3bFDtLiDA3a5BbPe4he8+5r2H/m3z8ZQ0iKOFyRYDbYFBEgKFokWkuFW5rD/zpk+JpqwRL6
	lZpsuHwbfJKMKbeW0n4aP8bdO1C+hmWQR8ybMSDKIOB6SXxqAMH9AkViG6VO3jWaCOR+t4Bo9UR
	iw+EmZWYAAYHUYQwgta2iVig1B2SiIW4eITp1uBQ040D0=
X-Received: by 2002:a05:7022:e1c:b0:128:d5bd:3572 with SMTP id a92af1059eb24-1318ea2ef7cmr8404147c88.31.1778321836659;
        Sat, 09 May 2026 03:17:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.193.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm6621124c88.7.2026.05.09.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:17:16 -0700 (PDT)
Message-ID: <69ff09ac.050a0220.157bbd.cb88@mx.google.com>
Date: Sat, 09 May 2026 03:17:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0220794442940612740=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wuyankun@uniontech.com
Subject: RE: Bluetooth: hci_uart: serialize close flush with write_work
In-Reply-To: <20260509083124.291207-1-wuyankun@uniontech.com>
References: <20260509083124.291207-1-wuyankun@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0220794442940612740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091961

---Test result---

Test Summary:
CheckPatch                    FAIL      0.92 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.57 seconds
CheckAllWarning               PASS      29.35 seconds
CheckSparse                   PASS      27.96 seconds
BuildKernel32                 PASS      25.93 seconds
TestRunnerSetup               PASS      570.70 seconds
IncrementalBuild              PASS      25.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_uart: serialize close flush with write_work
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#97: 
Reported-by: syzbot+da2717d5c64bf7975268@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=da2717d5c64bf7975268

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 2 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14562736.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/158

---
Regards,
Linux Bluetooth


--===============0220794442940612740==--
