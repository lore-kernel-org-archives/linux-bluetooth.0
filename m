Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60B37CD4E
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646235; cv=none; b=TmHiXPyGdJc23kOfHRxrEP+V3rGfXwdi2mFpnNxDv3kaQu9oCTNLz4uhwfsFjOqQO/eIs2Zn3gZAV9UntVSiJZ6bLn8BnoxH8y0sgOLEk60VlVm6BMR0vERnrqhgiEp1XqVpbFxgjO8/8wOUllg7zHXpeDJpIGJJsCu4zkYtZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646235; c=relaxed/simple;
	bh=shbpFXHKzU0caoCMiLkJ372rzjy8roo3CURrP466R8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VTwjXKpFvw2Wd19D8i/6VJWHpzhR9SWvlB3BYZQyVCvaFVAX/CzDgm/KqzKjb1XFHyJJGNrpYjYwtcxve7wLc4X1Cj9x7g7GRNXA8MC1rVLO2ULHvGXTBz3McZ4/w629ei1+1K4k0cATYHrC38DM+mTbAP7OfW533EGYbtWU1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyy5XQWL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyy5XQWL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso217840a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791646233; x=1792251033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W4NRz8Uv4hDsquHYThm2uhhdtRGgQRPuLxGW2WO3dxI=;
        b=eyy5XQWLDwqVs6abJDPXZWrIIksGqfIwAFlFTiBa6mTj3PygjRDvnbsMX2NWXg4G4l
         P4eYeWAAPVh8qovRRwaq/UqTA66sZ7IiGbzyi+rxRSAbBzDpVqxwli7TOrMtv+WpmxSj
         W5uLqz0kXKFPhuRpKyq5EhqeapPbJn/MR/0Pa9uWy/A2iNCyDC914c+QK0gnU3ulAHKi
         sa0W526DD+Rg71eOiS/P5f0K/OzUGM4ECl7oFnXZKKjUZ/QNEGr5QUr6kHtHA+xdBbys
         tz7WHHljoCQSvj4JBPvc0A+6/k6KvF+ZUlWT0kTw+NjNPj0sVmPddkJL5O2LMycji3ED
         wxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791646233; x=1792251033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W4NRz8Uv4hDsquHYThm2uhhdtRGgQRPuLxGW2WO3dxI=;
        b=pvxw4ASpYZE0w87rxRg9/ULlTbJyWBl1VNdbqfRaQe3et8Qtho2hEZqOtnANKTR3yV
         nkt1asqv0cQY3KQCaWVH3P5X8gFXx1UNR7jYuNqAw4evI4JbxHAtwrpe4HvxKKOPp6IT
         /SUCsY+KqeXuF+gSY16S7tUI0UgiHIpuRhbsW3YtiA2LZfwefHSmsHnFKv1WXA0tAnoJ
         iNgU3LjPXaXlxVCJvGVO1F3aUJ0c65A/RJD5x9K30Wp5sE2bwXhqBHv6c87mq8oJuOcB
         jlR7eMh2pcJJrh9/I+C3+KS+LmJ5bWr+/h3npTrBsRUeBRfitsS5ar1GZlQaF8qlspIq
         x4GQ==
X-Gm-Message-State: AFq9FYIMnpw+8D98+yPK3wzjK4+fTHZ1udKe5i2RdW2Z5fcoCeVVc7ta
	8Fx3Dld/F4rdh3OOZf9jJWSQmii8PqIc/PDOO9slc8XklM5SP920NGUI3+fOAA==
X-Gm-Gg: AYBFou3xBD5jOOWGp4a+udawMchQef9bKzKEozu7TqMn5h2k0jP5BrVH+lyAyhRJRns
	A2ErA7sNq7AVDW7mTkfz6ggsxUNHLJOJxUfFHiFVDsUJowZzi/6664xmucr2Q3xkqrVKiP/OYzZ
	MoME7srg6ZLv1x9pH+f/FcfQt73Jats+hODYvPY24sqMVFIiy9gOSFVJ0dsLxE7FL/gcyjlgiHl
	e7AR7kEsbCZnfMxntlqgSYt0rkdKFop+AbtAIUFphdeJxqk5t4Gnvw0Wgyi8F/IjgC0YlOs1+g/
	A8y043TsYxcKRUlRUQzLj+Cf/oimdkDEz4gIRKvH4IgTEe92hRm62fXEb10v1C8CFRrWCKShARK
	stq7JzlXVHYWHaxMJRTutPbbp3HfVBilwLOq9IyIdnEZZT9IZzJyq5n/4j8jHTwmplkVRmhamLj
	3x6Y9hc7IMoaIYOFe7l6tIsuIzQ8E2iknSXfozTpMzvLMHUaScwVsZsER7S7Zg/lbCriZuLWNh9
	+c=
X-Received: by 2002:a17:90b:2886:b0:3ab:3606:f281 with SMTP id 98e67ed59e1d1-3ab3a92f6c3mr4184749a91.47.1791646233158;
        Sat, 10 Oct 2026 08:30:33 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.69.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38fc9e52sm8453723a91.13.2026.10.10.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 08:30:32 -0700 (PDT)
Message-ID: <6aca5a18.6e2bf4e6.39a807.9579@mx.google.com>
Date: Sat, 10 Oct 2026 08:30:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8714072840274995263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thenguyen1024@gmail.com
Subject: RE: Bluetooth: msft: Ignore vendor events shorter than the event prefix
In-Reply-To: <20261010140806.65929-1-nguyen.ndt@qualgo.net>
References: <20261010140806.65929-1-nguyen.ndt@qualgo.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8714072840274995263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183002/

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      29.37 seconds
CheckAllWarning               PASS      34.42 seconds
CheckSparse                   PASS      36.65 seconds
BuildKernel32                 PASS      29.67 seconds
CheckKernelLLVM               PASS      35.30 seconds
TestRunnerSetup               PASS      782.21 seconds
TestRunner_l2cap-tester       PASS      12.64 seconds
TestRunner_iso-tester         PASS      10.78 seconds
TestRunner_bnep-tester        PASS      3.07 seconds
TestRunner_mgmt-tester        PASS      61.46 seconds
TestRunner_rfcomm-tester      PASS      4.41 seconds
TestRunner_sco-tester         PASS      5.52 seconds
TestRunner_ioctl-tester       PASS      4.57 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      4.26 seconds
TestRunner_userchan-tester    PASS      3.12 seconds
TestRunner_6lowpan-tester     PASS      4.33 seconds
IncrementalBuild              PASS      27.96 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: msft: Ignore vendor events shorter than the event prefix

27: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/894

---
Regards,
Linux Bluetooth


--===============8714072840274995263==--
