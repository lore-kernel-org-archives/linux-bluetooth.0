Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0A8472
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714168; cv=none; b=XZRSD3gZYRcCcqq2US+U/8Z6leyP6+qtpLjbnkwqu4JYGcaxVJF6n3hLDfu567R0ezzYW++2LOgqmdybsaVAUPdfoCxGnWDF/0I2SGcA9m7wVFqTV3juntNT7LTl5EILTWXx/x3Dm8H7IcEGwOB338BBl9QrBNNUpLbgqJ/cRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714168; c=relaxed/simple;
	bh=ByHnwneSIJPZDY8XmVjWhDcSXgK0JzBkMW3TFABcIQE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jvgRdqeuzw3DrRsJ+QcY3pK1xJQjoI/DyzYPz1EnW1jkxIp2Dbn4Yt7hH6lBQjwTzdYjKEG1aO2qb+Xm13Nb4zXmro0civKjTuABtBn3PTFQc1Y7ZD5P2HEVtzmYa1UhDXcgSfLAY6IEYc/D7OMBTS8zU0M7WiD1lfp86JTJ190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ3yR4+z; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ3yR4+z"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66dbce0b639so1697077d50.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714166; x=1789318966; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S43pA8GtcR4XDj/eKycYXWBqMWFJScqyRjxBzFXjBhk=;
        b=eQ3yR4+zykDoUhKPwMsGygxN0TS0Ds5OtA8YNoU6JDu76xlHM30b89g+QiGU0EqvJJ
         wiIUMh+G4/S6Xkk1iH/oJYedqyaFY454YcK895kHF6f/wO0BYjtzF60a7ekjaJjGczpT
         pvmXZlZ0kya8/ND05pjadSkNwPTLVQods3bMD+ZGFfmA4PlCvWUhLFXTGl5zM/UTbo9Y
         n2TNJXcPZM/D/HV2UEDu2K/rj8PSUEBsgFnww8lBgS3IxxEnswqbksD/BhhxgZ0lh7++
         bz6eubPOK+qNrwD1gttP302d7+aAC4/ZqqnRC7Inpjy+nmjjxklqYgNWZm2ksF85xDGk
         OC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714166; x=1789318966;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S43pA8GtcR4XDj/eKycYXWBqMWFJScqyRjxBzFXjBhk=;
        b=ge+7OzjY3l0Vkfis0JTJK5zrNtzg5QcJ+SEaNTZxhdcbB8CtxR/0l906eBcu0FQ9ER
         buX1XjlimOSUdKZ7txN8PVkRSHcj0HRi0vRnZkmgIO9lhefYo3FpFNDUsM6vWuZKZFBy
         lq6Jj77JmJs4x0miXF5pTql9xpCjsjdm+1MHwImUZN9MIMzzYHH6yVR/dm2E0B+NvGEz
         a8f7tYeGNghlN/6ulx+V1pHU89GPEW059MlyhmTDWjrVbF5NAk6ba7jTB9kqgQLkyHYF
         yr3/g48fVjyNraE+64un3bRwlQZHCGRv4AkTXpnNhihMs/7miOP2D1G3D9Wbbm5dFC+p
         A64A==
X-Gm-Message-State: AFuF++k4XMMxnkABMXdxICmJeg0qpJLybsNF8kMOFWIaVaYQZX90Z6S0
	wHC+jcPBAgn7gibf3cn2PGBiL4s7vQc7uBbcXa+DpGEbwN383ovNqXINb8AMxQ==
X-Gm-Gg: AYBFou0gOOZ0MdjjdkQvj8aIhvbc7BAejYtHOLsTu2zKzDePQ/GuWIl+eWcienuxNBD
	0klBZe32cGmCbvfo0FajiiybXUcoPxvWXFj0z2HGDz+7140uRUEDhZZ03okbHZrOSK4LoOsPhU1
	uX9GNQzCh3tjebndgWTMFdM7uJsXn2oOhhLPOvWNqQDClWxpod6XMT4CTY0BralCzfxKrN51s7w
	0EbkyE19/2lqanBgjruBqIOGHBVzYWxx4aT+UzS6RK9yTIjg4LWeF9s/ZTXIx/1fLFEAnlOVzQ+
	MmBRnpNuvFdpUlu7KWjkJWv81CpW4lCBKPHJlEjik7rLiEzAtrxArNIkXsYuF1327G8wbV7EKrE
	eT8ShDZQym9/mDzl16oXw3Abaq56oPFv/1pyD8/wm8e7wI1PaXI30htRObvkw1Hx2PlMamEWPb0
	DOIcKFPcNrVOPTi6nOMWWjDp0kjMIyr6xXU9wyfQmiilhx5c8wvI+AVEwvMJ26TR6oHNFCj+wRb
	Wk31Z0=
X-Received: by 2002:a05:690e:4c6:b0:66f:c1bc:4087 with SMTP id 956f58d0204a3-66fc1bc476fmr2480159d50.74.1788714166273;
        Sun, 06 Sep 2026 10:02:46 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91058416847sm4597426d6.4.2026.09.06.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:02:45 -0700 (PDT)
Message-ID: <6a9d9cb5.a0644158.3ce550.914b@mx.google.com>
Date: Sun, 06 Sep 2026 10:02:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4859073053921423338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ngocthang2710.1999@gmail.com
Subject: RE: Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained
In-Reply-To: <20260906152127.90734-1-ngocthang2710.1999@gmail.com>
References: <20260906152127.90734-1-ngocthang2710.1999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4859073053921423338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1159088

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.46 seconds
CheckAllWarning               PASS      30.93 seconds
CheckSparse                   PASS      29.82 seconds
BuildKernel32                 PASS      27.39 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      517.56 seconds
TestRunner_l2cap-tester       PASS      66.45 seconds
TestRunner_iso-tester         PASS      113.75 seconds
TestRunner_bnep-tester        PASS      19.69 seconds
TestRunner_mgmt-tester        FAIL      228.20 seconds
TestRunner_rfcomm-tester      PASS      26.65 seconds
TestRunner_sco-tester         PASS      33.12 seconds
TestRunner_ioctl-tester       PASS      27.29 seconds
TestRunner_mesh-tester        FAIL      27.60 seconds
TestRunner_smp-tester         PASS      23.95 seconds
TestRunner_userchan-tester    PASS      20.56 seconds
TestRunner_6lowpan-tester     PASS      23.93 seconds
IncrementalBuild              PASS      26.98 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.253 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.622 seconds
Mesh - Send cancel - 2                               Timed out    1.947 seconds


https://github.com/bluez/bluetooth-next/pull/711

---
Regards,
Linux Bluetooth


--===============4859073053921423338==--
