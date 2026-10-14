Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087A44999F
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961192; cv=none; b=cCVh1t5Z2lX5rE7cpZ3pbj0at7ihboHcRBXJrGHcS2z1RSBS+XVVAzAr7NHzTR+2emlhAybuAoikCocD3tJxKjhQgnKsZOSrr+BLNrUlwFc7+Nn/gRkvsiHGg7242nGjtCNJLqtMu/6/LKBCgadrFaHE6/KLbjNalYKGHKojRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961192; c=relaxed/simple;
	bh=0fTwfFmttH4lueOnz4YYET4mcu+lICkyVVTxSA+iNHM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TL04J4UrbxdMgjVEaEvGLKrUD9vlw2hWMgg9u8nQ6OJmgONx+XwephgJRL2rqHE2qHA9KKq79oxPA3g6ZfNdRRUPB6EWrI9PO03O8GMoEOLQnnari9IROykrP9B5B3pNsJWr0leeELrP/WYgJlDlUs1F6V+A2AoJ3Y6cfcnZQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjo7Ui2O; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjo7Ui2O"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-82395ae2ea8so510711a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961190; x=1792565990; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A+P1SDEZImzBCknSfORqLPMquLjBxc6MzxmSMEDgOKY=;
        b=Mjo7Ui2OFSekawgQqdCqeI7xY/qeUi84kTN0D6b96n/9e/okkdZF6hpwrT6Z2fPak9
         7uQpZnle+alp0Sj9YqD05AVmIhZTEULOVjmfqqQg6pELjEjjQoP8uaLtAZeE6WPnS2dC
         v4OUqlYSZFh+EvS3cm7HdeT+1C2G2NADLd64DR0yo4i+yvcZE68PRCxYlfSMZ2mOcqUi
         7wKD7kHMgiH0uIPoglStKsjQi/GS3iho0uEcYwjBjwMuhu164RnjFNt7BXLcdYkLWy4M
         twG9iKYzjbKYY+CaGM//p0oR81iv5M3IysLlp5fy0Ksp6DdpTEWcH4hjIlvkueSwYFQF
         u4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961190; x=1792565990;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A+P1SDEZImzBCknSfORqLPMquLjBxc6MzxmSMEDgOKY=;
        b=mpHX8BTEVqYjKTIYq1Rvb+ioTCJz8RWxdcBUi92vnVQbjS3OTUwarE4m2PwGX67z4f
         vPJBvryX1aHkkIFUFoxNXezw4DJR8jA/R8s9mtiiXoJ9BlmWRservAkihjY371l6KxOI
         PxNTuzm0xpmui2pL/vitXGoIJu5EhYi3TqvnCWdfmOjZgqcOHcxC5XmBeEfdJy+piNsV
         SfAaldkzEyUDToTVSBBG76TDMSMxhwP/rMok6tmAthlp/Hg7C+Eoy2uobo92ju0cd9Kz
         p6UaKY3MUcNhdcmnqvWPMxlIHNB/zsvWbv5nu1hqd6mzI98C+g4b7oF4qbXVl0tJSr7G
         0ttQ==
X-Gm-Message-State: AFq9FYK0WjyFfdOV32o4XY7UhTzp51A8NHdtPLnGvDp1qgWnoWmuwowt
	UK8lz2eWA3Fce+gxsw95tblhehwvGWbu0fRanuPc41vjXY1OCSl+ZuYQFIgmfA==
X-Gm-Gg: AYBFou2j+UG8MaChhaJc7qj3NCYhbEG9jHZKHuM2y8tfXaGSllefW5Frgw9EcK7zEwc
	zLLJAat8T/2sh5eSaLjg3YiQQMg1LNMEV3h2G2Pe43LVqCevPUSK62bBznP3SmTs2k9UhaNYmze
	Avp6OeB4tAXmi1Le21wyjLUm1kOD5BBmirdvXFC73ha/yaiw6GHiAWTW+k8rxv5gnGSuYyymybM
	ITFloyqr7xhz/T6SaEGXRG53LtL2g83d+f4kmCCLCbrX+Rtdr+wkw9LWqxXt9AvTUHn5/yEeWkq
	4W1nS4ib8IgHd7+8OyWHInneRTRD3oQ6eN8v0RoLJ4ODlYCeVhLLWqSwIwm/KcuCDkAZtZBzJkG
	M2WA0Zu+aJd9hgS8pFiuVUB2Qsu4AzkEz+10nh50vJ/vjNK3HiAIEJSKmT2b/dd24xW9PnVcac3
	K0LaLOvhqP4XF9JogCJYa5B0rlqAZv62+lQ6DpiA9jAwbEsHMC19PW6EzZB7vp8uz4cr7t3NWwz
	MTuB6vX7Z1zkQ==
X-Received: by 2002:a05:6830:67e3:b0:81c:b7d6:e6eb with SMTP id 46e09a7af769-8309479975cmr13472839a34.7.1791961189655;
        Tue, 13 Oct 2026 23:59:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.53.74])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830384c4985sm13551384a34.8.2026.10.13.23.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:59:49 -0700 (PDT)
Message-ID: <6acf2865.04a3e10e.39b245.e0c2@mx.google.com>
Date: Tue, 13 Oct 2026 23:59:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4915004627836310114=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: Bluetooth: hci: Represent advertising report payloads as bytes
In-Reply-To: <20261014052244.416087-1-cochcoder@proton.me>
References: <20261014052244.416087-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4915004627836310114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185255/

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.24 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      18.50 seconds
CheckAllWarning               PASS      21.35 seconds
CheckSparse                   PASS      23.11 seconds
BuildKernel32                 PASS      18.58 seconds
CheckKernelLLVM               PASS      20.17 seconds
TestRunnerSetup               PASS      411.44 seconds
TestRunner_l2cap-tester       PASS      12.70 seconds
TestRunner_iso-tester         PASS      8.44 seconds
TestRunner_bnep-tester        PASS      2.70 seconds
TestRunner_mgmt-tester        PASS      80.07 seconds
TestRunner_rfcomm-tester      PASS      4.25 seconds
TestRunner_sco-tester         PASS      4.81 seconds
TestRunner_ioctl-tester       PASS      3.95 seconds
TestRunner_mesh-tester        PASS      4.94 seconds
TestRunner_smp-tester         PASS      3.85 seconds
TestRunner_userchan-tester    PASS      2.75 seconds
TestRunner_6lowpan-tester     PASS      4.01 seconds
IncrementalBuild              PASS      17.14 seconds



https://github.com/bluez/bluetooth-next/pull/928

---
Regards,
Linux Bluetooth


--===============4915004627836310114==--
