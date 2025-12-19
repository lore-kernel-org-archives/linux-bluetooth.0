Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23207405A
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766115010; cv=none; b=IJ2tAJovZPdVVZt+qZGNaSJl4ejoIv9btb8/ydZRnBTHjS8BzQ8aBvdtD8cFndZK57sBV3fHJUGnSAu3q7+yWnyK9bSjYpFrERZ+qnGPQYgfKkjJhyDsgBo/94Z4gQS8pmUhXQIIaX3ejPcTQ99464V7YBti6uXgxdifF//mQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766115010; c=relaxed/simple;
	bh=y4LVuhooPen3SBiWK+c4m1z9t+r3ndtuGm7LQHi7SdE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SVFztYQ49JnIobHkrq++H0J5HfdOQoSLf+NkZRdT46k01A88BA2xNWqFtHgqKA6qGzgs//2lynAihHehJ5EwnklKvNpdy+q23HfQhOXYqS1QGd2zfOSamJjY7XHdACy76Jf7G2+rMhwOh+QQadbX3cZmbeD+wLCIgUBLl0oXViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbNa7qdz; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbNa7qdz"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso1340228a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 19:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766115008; x=1766719808; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa2k+lE3Y/KknS5whlirFkv4bX+BH9NIjKKL7KI1ZWc=;
        b=mbNa7qdz2fLKfaeD2KRqUVsRWoHEwVMtIb1p9PLo+29Xdbn3lCWMlIUO7z7tclRdke
         gbBfD3DxCJ7TYism9VcIrJnXiC+5C+S6V9MquYnPFwAThxOdNFkqA2WKFT/6BMLhRtpY
         xfNf6esOeGiwV7sjoGjOCCb6nOIgHbwI0iJb6o92XENMZiNOINoLkqwDEG9HAAvElJFY
         wiq41hntKh6S0RZ4wfDycs0PAiTPwET4LEg1d7G64HO9HmguwWiojqCYjsp6QUh9is8i
         XVZj+nbXXlwgFBCrF91FgRHDdLezlmyXsRcEySPs2fWRHyYlwP5RGFZK54m9UTUbNsV7
         BzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766115008; x=1766719808;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa2k+lE3Y/KknS5whlirFkv4bX+BH9NIjKKL7KI1ZWc=;
        b=P7mX+FDjotPNnOWZ7jpmAwGzhfjhOAi/tzSyPMeMZGJw7MWYw7ONaT2IlFy9CY89zj
         q5v1auzcqLwjLqaS52G5ckTOodnpIzx1+cjjk9Tc/SPT0Zo++PEzUCVhykiu/PXRTI3u
         Gj99Skl/be4b6RlN8eyaMjZrb+Pe9+wCtmy/j3zC/CJnG8liVOHzaXuEWm3X6Ux10wfH
         JCEQ+PcTg22kcCuEHkQdLgM54kjJNj07WeuzmyiLOEXLrxbC1JKdtft6pxI5uT6lGa5Y
         hCsitMlQenXiJc4MsyznxQ2McT5a/G4Zc1TncUUVJ38gxBD6vF14zpGjwSpjKZRfk0+b
         iItw==
X-Gm-Message-State: AOJu0YwaiswIKpS+JATYsTEx2liTis9tapuM6kccs3Y9mta3r+Uvz+Tu
	26trED+qeccibbJPnq0IxglkHBDao9NNlQ12WSqZrb0SW9XU8QwOVY99Pb5oe3Zc
X-Gm-Gg: AY/fxX4/YMNnHN2NUghSmFwgk5cUT3jCgK1UA6jFLaD7Nst7ELvv8QLecUGh+MWrmHX
	moKL+Tzn9694KXBOgl3hW/dwN4QR2UeNqrQNXekOvabxRONELhT4nniLNMZnEmhayifd0N0Z1pV
	fLQ2s8y37MAFpNxKUUEKEA76AZuDXOw8/mViZbIm+FznJIC0St4pAK6q0DnhzFlfaGg8hiW8Cys
	UwCtwoGo2Y/oK6YA4qwFQoQZProR8AQBPzXaDUUazHs6+lNhrhg9yOBnQta4+33BnzsDxz9ys7R
	igydm7y4bIw3Y92IDSmaj3L8qgwCvYahEoJ86ZxdAvTl0qrcXRpFkBW/+ZpW7WMUxgjTdPe5mNy
	SPPFILMDMz1+oXlbrv7B/EkuNORXf83lanKo5aPR3NZPnHaa8XgceLkbDeQM9FmEs74xOmaEOmB
	4PVPk1Y7xO+RogmyjT9Q==
X-Google-Smtp-Source: AGHT+IE4eHPRP8CsuX77bDQda6Vm0I5KlKgJFtk0REYXPCFV+A9DZ4IK8y265hUNJ024GR3pWwr9xw==
X-Received: by 2002:a05:7022:62a9:b0:11b:78e6:8323 with SMTP id a92af1059eb24-121722fd212mr1559369c88.37.1766115007328;
        Thu, 18 Dec 2025 19:30:07 -0800 (PST)
Received: from [172.17.0.2] ([52.159.229.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm4096258c88.5.2025.12.18.19.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:30:06 -0800 (PST)
Message-ID: <6944c6be.050a0220.2f9d1d.07b1@mx.google.com>
Date: Thu, 18 Dec 2025 19:30:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2882482206137820612=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_sync: enable PA Sync Lost event
In-Reply-To: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
References: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2882482206137820612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034831

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.55 seconds
CheckAllWarning               PASS      27.66 seconds
CheckSparse                   PASS      31.07 seconds
BuildKernel32                 PASS      24.77 seconds
TestRunnerSetup               PASS      555.85 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         PASS      80.14 seconds
TestRunner_bnep-tester        PASS      6.14 seconds
TestRunner_mgmt-tester        FAIL      114.58 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         FAIL      14.22 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.163 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.172 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.952 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2882482206137820612==--
