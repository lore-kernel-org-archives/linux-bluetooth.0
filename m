Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF07264A9D
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065810; cv=none; b=OcfC4bOYYnrSL9bt0MrPHqYmbSQY4a9j1CTtOc+53rb3xvXoTZoTjml0R+ZVYLVi5+SUr9pp6XL1tacOjpRx94gy+IkQBHpBZY1Gfk7S3dTRaAYFzTHClB9zriakZ//TkHJJ52GJhvstigrSrCjtA/c9Xb6sKG4txTi5gIOIOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065810; c=relaxed/simple;
	bh=a27XAxkPeQveee+vinBdjqYIztjof9JPGhZZp5dTJBs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uRFuKf0ifW2cTMqjEOS5aGhFuFdLCWBbOVe8zBzNHd7PvzipRK0oI1b1RFkORXXHYbuxkE8wXMGQ4KZJi9heXL9McloJntyTfbwwLLSpqckBK/pDdXh+JmeYl5hXZFH+tELJXUzMe8NoCAyjcVOem0vZUH5AKCu4b6Il+fHN7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PglA2Dnd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PglA2Dnd"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b2b289925so64300041cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775065808; x=1775670608; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg95bakkrzAAPdKLOMhZh3yudYB5TSn5x+CShdBb8iM=;
        b=PglA2DndEcuA0N8bRnO7ZnPMnizerkcAY1yOWoNotr11PATCSGLzsqEiIKLZWgxWqc
         z9Ue5vN9sPEzbaEEEnDhuQq7XWQg5z7HD0CrpOKdPcRS9LWE9E84TRwjliua2LFilosV
         Zq8q3fTC6ii5KtO12lOOsEBFbNuiJZbDnznxbX4Xpsn6HjsiZTVhEu29CJ6K5nsW5Fv5
         BTb3909Y3kiuMFc0/DV/73QG1M1ELS8meMp3Xz6G/P27ZaNjb9qTY6y7k70Xiv3De22Y
         igBstDfwV9HJ30Y/f+NwjKeupLdZX7pPmRKgzyuKrDCXwOKkf8yG1lU9UZSYo29cIdob
         fH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065808; x=1775670608;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg95bakkrzAAPdKLOMhZh3yudYB5TSn5x+CShdBb8iM=;
        b=NRgTNGAvoF/0KoOXeVDR9aplTrhpt9dGb+Mf8e9AiSG/SvmtCNInAQA2MidwZaCbOu
         qxDRnaekFtmN73QMkK4yavTxrVTNLws7/8VzAV187FDMM+1y5+/QiFXIqpYv3zz3DkdM
         DrDpIzHUSTBHaWBLcjalXzpRyxhtJbwaAL2hR6Yqw4jZyLFbE1w5hE8UZqOlA/nnIU+Z
         40mwHNdD29Rg2A5Jnn47Eaq1BzB71VhTwArR4FdnOEU81vXUpoWwKQc+c+nQKlwH9WRQ
         RI+b6rW9nrm1nepimU0/1DOMW+2Vy70LgJopqIDNIXh4TW4xt/aN+UkD5lpJFiDO0MgK
         IGqA==
X-Gm-Message-State: AOJu0YxCs33ypAqiKgALpULZXsTeudO3YEVJFmbUKAGsXvykY+NYpVcw
	0HbiNvrEjsfyiHD00WXlkMl0j34IKxj+m2p8ppqyrj75OX4BAvNcBlsxvfuECA==
X-Gm-Gg: ATEYQzzf2CJSHuqxkk7Rn4RWecrQIwmw3EMLuyP+l8a+W06q7+FZDiHufcX1aou7JcO
	kOrCG74AvfHoMt36LQyWdOd4af+d0BNThOjCGPzsGRRiOKQJ8ZVog55oO5O8HHJvMdbGMEwcIT5
	ctBXxa/c4psPnx0duBQrThSGc4tbgalmOFojep7HWblhHOuvyoyq8LSi/xYKa3hlahxvRlPs2Ee
	eBN3lsZhB6PTAKmu6qsiq3gmDu8Tm71H800bIafqFuz4Q18u0LLSISYSt7U6YA7rLDD1r2CGEou
	MwQ47nwq310LyObLsPwB44DPkoyEC6vQxEyFzS9g86vVqFf2CBXxmN7nJKqfmSWzec9I7JJNx5k
	XIcNjLBZzmHHk/Zlw5+LUdP2sG7fBS2yd8R+dSjCiBcdL9V+E5IR9MREbsnwNNivcadB//xQ6bk
	ua5UTpPi+OJZPwuTSVN0gVrxPrTpE9
X-Received: by 2002:a05:622a:199d:b0:509:4845:8ab7 with SMTP id d75a77b69052e-50d4baf3eb9mr7184291cf.8.1775065807852;
        Wed, 01 Apr 2026 10:50:07 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.123.0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b86ceedsm2928831cf.20.2026.04.01.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:50:07 -0700 (PDT)
Message-ID: <69cd5acf.050a0220.2e526c.18b2@mx.google.com>
Date: Wed, 01 Apr 2026 10:50:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3108401065399758900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thorsten.blum@linux.dev
Subject: RE: Bluetooth: btintel_pcie: use strscpy to copy plain strings
In-Reply-To: <20260401164622.752376-3-thorsten.blum@linux.dev>
References: <20260401164622.752376-3-thorsten.blum@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3108401065399758900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075961

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.44 seconds
CheckAllWarning               PASS      28.51 seconds
CheckSparse                   PASS      27.67 seconds
BuildKernel32                 PASS      25.57 seconds
TestRunnerSetup               PASS      572.18 seconds
TestRunner_l2cap-tester       FAIL      28.14 seconds
TestRunner_iso-tester         PASS      52.09 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      114.09 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.30 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
IncrementalBuild              PENDING   0.54 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Client - Set PHY 2M                Failed       0.148 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    1.821 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3108401065399758900==--
