Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33B2D47FF
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811115; cv=none; b=fi2JOhMiDPxvSBFPCvYHoQfQ6dNDxyH/R/8ld6S+dEPcwRrsjDBz/hN/XpE/Z3DvIkAz1BykPi63hPg72Ke14fx/4sqs43W68nYeBHoBGjpxROGa+BpGsGi7oZZhmM1UDGphxUqXcEcCwWAae66a3zMx3xSZ4h/K0Rhe26AmRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811115; c=relaxed/simple;
	bh=iP424lbWdQEg6YzncIab6MBi6/AYywbFGkKAAtZOIB4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UpqfL1mqpfrcHIM9nBdKD4YZvLnIDBYZ8XoGiGTXkxIaDaLpYraZBu93S+jQUnx4+yuW2/B/eutInwjVSJzheDeC5i6n2cNQLlmdJtCy1xYdl5nE0BSxbbhT41gauw9XJic4abe2OqzCc8Cd6c4Ahfeq71j/PN6HG+uj2cEhFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coJPLFbG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coJPLFbG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so8326116eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782811113; x=1783415913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6zCxxWwI2UFFaJf9HNDBGsaN1+sLXR/WNURtannSQn0=;
        b=coJPLFbGEEJ3KFp7OlS0KaGvnQI7r+yrdM1Asu0PyHG72du2zdK5EaVWnwYcYiM2D3
         3qukWxQuPJcj8GkfZpEKo26oY5tDZMkfFBjNJCWNvTB5EzmrFg/YiME5FS+aw1Yv+aw8
         kRTBMA22FwhF3PeMcFXP/AVGPuEUL6d+ra3KzLn3BSUzqTF9BPbxw9/VmyfquLI3Ko5T
         fiCAA9oS77BFQ0SoPwNux4qzbQR5lGxQn1NVQFOjh751b7vskrPAjAK4wVneRULXNchx
         wRQ1YDzj//l2hbZnELgJxVR8gzBuU24sllN0fSGKsCac/whDE8vIgICo1TQotmb6tMuN
         b56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811113; x=1783415913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zCxxWwI2UFFaJf9HNDBGsaN1+sLXR/WNURtannSQn0=;
        b=S9NF6Xxf86kA4u+M1E6E7AK6KlVJnf/vvvYIMvZJgpRwcRmMR0ediDNNjZXYzZRtYk
         7Hda5weIlZYISRsf9l785424Iibpc+uAW9QRkjikXR3DvtYVOQkF+tZQdK0JQ+Vuejip
         yyhQbn+xCTbF3sHIP5Rq0HMZx1X4tREWYU9xQnV+o0KnM2dBSpXmbHr7OGidkAatcbSB
         WAK+dWzj0pvG7v99vtA6kimo9Ysncz3zhy5oJwqd5M58byquj72CLgK3bUeFUcBi5h6Y
         KaJrscjHEYWYrKm5X4znnJAfMspjm9kE2DoKEHRhCp2kuWBGwcmkDJs5iqRpktYTUd7d
         T7Yw==
X-Gm-Message-State: AOJu0YzBkK9dA5zx4ixyg7N6hQ7foz9Zwe6YZFCbhRA9UL2cuA12Li5s
	dLtaAy3I4HHDxbjkBQ5W6zsaZxrSl0KL3vuz2dd4eK9XUFksjCkHGewidyDYIA==
X-Gm-Gg: AfdE7cka9DToEiU243QSTRZGN9SSEbf49oretH/gFlLW4FjygAIHq+mG/38beMuudcN
	OjMjAuZog98jq0uJn8JVwF6NA+Mx4l2/LnKA79ULFA+3meZaWlusrA3YdKxN2TE+AP0EwdmVYTv
	rsIOAinEYrh3/q2/Pa89Jx3EEPx5BJaH1zhRV88Anq262P+rr7Xn0YAGCmXJHsqoCjP7gDOKMBO
	+BjXfY/nevHdYVA8xWTMJDka+PtZnFv1yE6CsroHXROEmp1/q/mpvrURpNVbNKzBgXalKZtNmK5
	tx+kAVMjikxdcLmLDjjXpwH4jsrtpJHsjHqR4q0auEAMfgHhqKUx3w9WiUxxcqtfJEK2lPcfvKl
	UvBH1ufG1a+Ti/3HTItxsqJ47tpQ8ziJE+MNj2udyCGNtFgeCMSUU+TgGDByELysp3Ob4/L8KtB
	iRiIy8PdNu2gHszLY1chQ=
X-Received: by 2002:a05:7301:6192:20b0:305:56a:c38f with SMTP id 5a478bee46e88-30ee134ff47mr1484285eec.26.1782811112795;
        Tue, 30 Jun 2026 02:18:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.233.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2ffdbfesm6242062eec.11.2026.06.30.02.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:18:32 -0700 (PDT)
Message-ID: <6a4389e8.9b510543.2bbb51.303e@mx.google.com>
Date: Tue, 30 Jun 2026 02:18:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0085483777656217849=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bestswngs@gmail.com
Subject: RE: Bluetooth: bpa10x: check response length in bpa10x_setup()
In-Reply-To: <20260630062759.2769059-3-bestswngs@gmail.com>
References: <20260630062759.2769059-3-bestswngs@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0085483777656217849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118670

---Test result---

Test Summary:
CheckPatch                    FAIL      1.51 seconds
VerifyFixes                   PASS      0.23 seconds
VerifySignedoff               PASS      0.24 seconds
GitLint                       FAIL      0.69 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      28.49 seconds
BuildKernel32                 PASS      25.75 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      490.41 seconds
IncrementalBuild              PASS      25.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: bpa10x: check response length in bpa10x_setup()
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#117: 
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14652779.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: bpa10x: check response length in bpa10x_setup()

7: B3 Line contains hard tab characters (\t): "	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));"
8: B3 Line contains hard tab characters (\t): "	hci_set_fw_info(hdev, "%s", skb->data + 1);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/375

---
Regards,
Linux Bluetooth


--===============0085483777656217849==--
