Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6714457D3
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892509; cv=none; b=tGbUpZwL41V7PQ0H0oOzQrdyxzR5ynGyZlH0gIpUeXkaXKr19hG6xcTLLMXg7aRSDV9Lv8CSOVuRlNxg4yDK7RrFpvV5pK7CjtI2oF2hrqKrlFyiKpGLamZwOAPTq2/i+fKN6+jtfvPrhPh19bzu1EmWRxPZ5QylOHVRmOBoMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892509; c=relaxed/simple;
	bh=DcdmneQNLFIuQLIfcKTXh51QQmeiiclSs2wyzLMnwoY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jAeLh1PLa9p9gsihiAAOKjc/1jGQVpxyJYQzd49SWci0eRQeyF/iWau6To5QGmt4R3TOerQQe8foFtHHvx4ya/x2f+d3UDTqrUZFG1fONOq0hy52winJ5+gxqAW4C7bFJP3u7dXIW9kSrL2mW+A5we4EP4QrBbNfhVAx7zjhXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvEk+C45; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvEk+C45"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso297018eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892507; x=1792497307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D5+4r8LT2lOlFQ6T9Fg1AsXbRLoF3wlp8mq1nU1G9lE=;
        b=YvEk+C45UKm8LFsC6bRxxmGrFR29UmejX0T20+jBJlcYmdhIJfixElnsjjMoGnllTK
         3FlgNjlp4Df1jnu8r0BkTZySTatPhWIFtVTq/2NPth6RvaTqCZgAaVIjMnRm4L1UhRje
         FpzSqD5RKdXWPQwBsRYXIakJaGglkhgCDWyVNSi1XiBnB6t0jK/0nEgIzO2YDqhmnJok
         BZc98p+Poo/UXg7v0Xyq6SxTcLBqqmQ0A8wwl2b+RFOUWRD80lCUnETN4tzirtD5NI1d
         CqL6SijBPN0HYmpMWYK8YeKPpoyk88B57ssAIrb8/3VUqWj1b1CMhKQ2HsLyDR4/lXZr
         HUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892507; x=1792497307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D5+4r8LT2lOlFQ6T9Fg1AsXbRLoF3wlp8mq1nU1G9lE=;
        b=xaizYIcromYggp2HGsyS3d9Q2NvhErOFPsBd0xx/pZRN9kbcVqgPz0DA2dxXGi5Rvc
         EhAjRe1HXnsnHYS3t9QWrOLmee1m/XPR7b3CrPRLYh2lShvhyAlCGgOAApXJoANCdlAk
         tgxEw70HV31sjHlUWP3UhuutyIaVV+Ne4e/Au+YL7gCy5GzirTzsQxw42eF61Pq19kwn
         VotEZALXH4SA+/U4ye61JvwNTBZnarrwWzB9nZ6oZpxTVL54p2l2P+wupi3px4VdMp8w
         dCiqAZSBs1ZKz39q0oLU8qmdwR5KTI5aGzflXl4F8/Pe+fsMYSdMEi44Rk8uE6fSgT8q
         UtFA==
X-Gm-Message-State: AFq9FYIqnlNRYqUnSC+0DOikwg1SvFXN/y2EP2VCk0neDPfro0jac3Nq
	Ixg4eqAjw/luOMSuEFjhIQoA+no25i6/9KPhColrErN3hANOUbYvf/PK12VqQg==
X-Gm-Gg: AYBFou01Q7lGvhmr1klSTJlclMF33EKHNFKlZeVS00L4B5Zcemi3E9YtBf9I2piGVgL
	p5dj+PiX7/B3879TXrfHVYxT0hj5WNT4qCf0t36hNJBtOvraBRyo6aTxcQ+1bvjR0VnHWxK/gNv
	J+6z0UjgyxEWCHu/WTe/eQXa+Y/XeAFp/JObv33EbHfuQJFvRa18d2ZAaYkvI5PqGjGOqjJKnMD
	kFApLsvgFi1nuKiFGoWgFqSZjQ36BsSY9pNR9VlcRDi1lp58LzS3qKrPL7BGnyVWVKli1MbghpA
	NeCpI/unihQ7OpVy9wlubPyLfSq2eYlYt74C5W6dgYwq0vttoBvGME6vbYro1c711umzpwP1V8D
	KGACNSK1tATHe6O2DkZLJ0p/oDrDNQJdZKnr8D5LXiFgrhuSDcvHb2mTx1OWzFdZDITUrrMscPh
	i9R79YHwMQEItUotkb3chegEBOWXYDgqeUKmYakZ9lJxJWTg7z7InvZmB/jhtFRFDw1l3q40JqU
	q7cZNLz
X-Received: by 2002:a05:693c:88dc:20b0:35a:6fb0:a35f with SMTP id 5a478bee46e88-35a6fb0b364mr8731090eec.16.1791892507034;
        Tue, 13 Oct 2026 04:55:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm43472808eec.2.2026.10.13.04.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:55:06 -0700 (PDT)
Message-ID: <6ace1c1a.99020481.232b09.a9df@mx.google.com>
Date: Tue, 13 Oct 2026 04:55:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3208918480247359966=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [RESEND,v1] Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
In-Reply-To: <20261013093650.423572-1-catherine.l@intel.com>
References: <20261013093650.423572-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3208918480247359966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184572/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.87 seconds
CheckAllWarning               PASS      33.81 seconds
CheckSparse                   PASS      36.50 seconds
BuildKernel32                 PASS      29.41 seconds
CheckKernelLLVM               PASS      37.77 seconds
TestRunnerSetup               PASS      715.60 seconds
IncrementalBuild              PASS      27.97 seconds



https://github.com/bluez/bluetooth-next/pull/915

---
Regards,
Linux Bluetooth


--===============3208918480247359966==--
