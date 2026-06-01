Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CF3537D2
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339805; cv=none; b=eV1vzMiDI3ixK9zVfqekhlIZtm+vihcQVsQCycZHGoYOhDJWmsJTuBbegRpFMXBocq+WdbxgSsTrpDSIxY2406QP+gaAXocdV6girEKC9ZU5qAWgWyfT3Ey2J2wp+3+CoKx318u56hJ7yzs7TN5LVeE5xG5IdFOtJRgiRMC208k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339805; c=relaxed/simple;
	bh=ISD5mpvbDEGAPfBy8WcQdUWGyOomaMpqPwfFlDHzft4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C2sere2uI2npll71RI2IL/XdFUGwGSDX7nJLb8C+zG0vSj7q0UB7H+wl7GcylwdsnGX/EuuuDCmFgxBr460ZDxpBibcE1L9c0J5vaOdhDhGBuTeIS2TOsHNRGO6q3hsoe1JW1otnKRbCoCSPRiaIITQZQYhgC2OcgfzbDG1VoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuz0/rBm; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuz0/rBm"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b5c374e5so1543821a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339804; x=1780944604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pscsKP7/eYRwaL6LxFw1g1fi61u38UbHNAbyFxYOrho=;
        b=Wuz0/rBmE39tbUjTO5Mgd3F1ProMbyA2cTYLbohPuCawgRddRmaD+cG3czW7GIJnWn
         cKt2XBJl+YMRgm1coBxzTFIWFdNWtVb+wEegcr/4WlGEHjEnsuTvx9RpJeSEetxLXORW
         RgoaoNJKpOoT7RhDCk3cP2/Coo9wOhktvLYKExQc2ZOV1Wq+6i48N3qri+3AZv/m0Woi
         UhIvcURWfde/qVge1SEAbriSwD2QCbaNCp0iftPzJIxtE3qV+417xei+0dgKLbCKZadg
         J/rtMBTPSq58p97hH+1V4wphzpd5rw8nC6svGgUXPNGF1ucqT37kTEw89v2dn3NacmQV
         Whgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339804; x=1780944604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pscsKP7/eYRwaL6LxFw1g1fi61u38UbHNAbyFxYOrho=;
        b=qwf41XmvvBhNJTErIVGUDDh0mwFa+LSWrGDShc+TEiKwgP0QvwIcnW6zNqqOZIzDBb
         KmQ0sb5gjKMIo/FEI4qocwGyWmnH5a6UziIOmXoHvIKDNDhRlGWaF/oBVYQj82tPexjd
         7xHkQZJXcXTwXX08E2vuSoZYzVezyuYV3UQ72V0anuumNabgXqbxk7oeT+tcTC5mBfFx
         cSObEfkVKKmVT47w+yUGWtBEPeuPzpB3ugroo7jUUPuFbXXSEi6x0rcDB2HqMfTIRoPp
         jyYthiiie7HZ53+Gn3Jvo3v6XTtxVCdxH4bsu7R/V1lPljM3/uPbIG1+7hu8ncEw1vNJ
         trSg==
X-Gm-Message-State: AOJu0YzYTNJppvggFnPviyOxQzoJE/BHe9oAj3SNZXfhZvMKJ1pgsE/d
	uskIvtcRUC04eoeWkymMx99KWA/NL1DvBQY4Z7jAmePHM9GbGwntruCXKDBjqQ==
X-Gm-Gg: Acq92OFKmCrGWdFDZkQJBnJIJa5vVk/kI2eBoyYETxZDSMWvP12iVcvZY2VNPl2/4LW
	0dqJtInwR9gt5rzK9YaYkAUgfREXXZFz0M8fLvoE5C23p2wr6oiaXh8QySHju9xsjPr3L0CmJIk
	H2tBF3uDVKP7C8rN22jQ9NYV9yAg13nEzhoat+avAlerNxkTlEw/9a+bmZ+4VP2x/3w/8fccCw3
	CIiTEHsbT01yMbFcTS7CZwDkY63mWecHheMpW8lERXI0HYSvnHXdwOGY3/JmyOHWALg4I9ueKU5
	SN/bc1GBo0hqH81K3nLk4WY1tTrmUIAIUMTFrTnsLRW465wW3aOAqSS0Q1LxgQUnk6svZk/0vdX
	Ou876HKUbfuBpoxgDtlVT/VhaGc0o0L1rHJQs/2u2G0ffz0Wl0YRZ2piO7k3wAuoE1cH94EGJve
	Ox41lJXAgtSN9o7roaRiPmu0p1b6KtwFfOwBhRNJCf
X-Received: by 2002:a05:6830:6a8a:b0:7e6:ca29:961a with SMTP id 46e09a7af769-7e6d22a882bmr434690a34.10.1780339803598;
        Mon, 01 Jun 2026 11:50:03 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.32.68])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d176dasm8333211a34.16.2026.06.01.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:50:03 -0700 (PDT)
Message-ID: <6a1dd45b.d84a4299.29f753.e027@mx.google.com>
Date: Mon, 01 Jun 2026 11:50:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4429287867698961296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260601140444.1676239-2-oss@fourdim.xyz>
References: <20260601140444.1676239-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4429287867698961296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104048

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.36 seconds
CheckAllWarning               PASS      28.79 seconds
CheckSparse                   PASS      26.78 seconds
BuildKernel32                 PASS      24.76 seconds
TestRunnerSetup               PASS      529.97 seconds
TestRunner_l2cap-tester       PASS      59.39 seconds
TestRunner_smp-tester         PASS      23.58 seconds
TestRunner_6lowpan-tester     PASS      22.70 seconds
IncrementalBuild              PASS      24.41 seconds



https://github.com/bluez/bluetooth-next/pull/268

---
Regards,
Linux Bluetooth


--===============4429287867698961296==--
