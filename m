Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141F3E9584
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413886; cv=none; b=oWpZ5XWO5whFy4fvl6/3w+ug+2BC9zoWkhL4CGZMHX/ovteFnlUf0Sq64A07m90tUjvo3rcv5HqtA28+yt/E4JgCk8qJ1hZGarvr28F/KXMOsUHma50nYRMQOJCeF7B/qL3b00XeGc20Z+MIFot8DEfBq9dZtk9EBe52kb8/Oak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413886; c=relaxed/simple;
	bh=an0jTbIlSc8Q8Ji9GWRuA/H78P7tU2vYyPLACOYzsiU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I5mb69jcpen5x16E6Wq4UnuIa/BuNv1ec2IzP9OT1WmvrmRThvzzeFynv23ltgUVhDKkANdHDt7vB1BJ4+gluCwsSlY22EMwOPbNYjnNY4ik6XfLHMddTPSj78P0TH0e5Ewvwq27l4KQcTpahFxtfmL4S5toOoOFSJoWyIw78Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzHITRWw; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzHITRWw"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6c3154fa47fso2969671137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413884; x=1781018684; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hMNRCKA86A8Hv7+Hg7ykyhMO/Yo3e2twKYc55gRa/6Q=;
        b=QzHITRWwadw5ejQV3LfZbSpmD8f7JxsGoaKs5uyJO5yL3EykvirclD23BbTkvGDb6+
         hYsFsJZVdt1mBEgvK4SqVLQBi5LX64Le2pjIP4yu59vnBqmE43rS9El1+pvfVEU2wGm2
         uKuS0l695M3gurHbZ+H6uXaebIzbDxnBp8k4D+ZVBryvIqN6/z0Di1RVvqU3Fs/dgFIh
         gd5v+bdVh2Pso6nxAQbC6ynlSzdp6Jzfkqzga03PU6moia2mgCqB2JUl5A0CHz2fm11Y
         /hCN2ne53MekDxcf23IIFPS9YMaYk/QojfONIvb6AeN72DKDbXmnrQSKDHYfQmplcZRb
         PMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413884; x=1781018684;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMNRCKA86A8Hv7+Hg7ykyhMO/Yo3e2twKYc55gRa/6Q=;
        b=pXYwzQV7PH4JZ1Cr2vmRHo3QIqLK2mOl47VjgnPYaFrkenjLoBy3hHT3VQwoIo/RwY
         ss+lmMtodfM0+1JK1xTZQcnZ8IPpZ5y87gwV2PGELJKDN03rVbsaGmYwvt9lNrYuHBSx
         RMQ5uiNKro9kYt0B23k4HNvhk7mD+5nTCvGELtL/v02f+ZTysgj50xFgSwo+aAXt4/qe
         JryfJAU0v+1hOfJP6C2laJMU1H6U3weBrfU4stbZCpn7Kl6RNd6LU9v6nhXsQaeD29B7
         dGtmMog22qk+C8R+vfvxfl/pAJhWws7kFQy81AkxqpnTqV6EG5VsOh8XXXmQZ643kfqI
         tlPA==
X-Gm-Message-State: AOJu0Ywe4e6kQn5HAGq7NblPxMURhxnZswDzlTUUywX5ID7XUcl7o36w
	+fF0V6yXaY2zjNbAbI/hbvKleSWBksEDnKkxnEsnBlpMAXXaXJch1NqBi+5kcA==
X-Gm-Gg: Acq92OHsRlwckxN6NlZJblcLJDEDRG+4l06ppwQ/cEQFhorSSAqEEsc50pj8+L7fwCe
	4KzfpkNLmJ9H4ym8/A2DsMNxTbBBdrw2j+jH7QdcVaXz1qq3AIw0zU1SoOYrPuKXSTcW1QR08+x
	98nSJMF6M54SRP4NdftVzMiadvmtQP6hOI/fV7S3L8P8I/sX/z6sVAtuFui1T1jdePW4NNEwgFw
	rXVJ74B9aQPzndtAipIOVpTbLScJ+Hl1QuWPgpT/m/RAyz5DVIO15XWOufQz3PHQ7UGtInu/f9N
	jLol4CwtQ08auaJfmwMbMpheLL2GNiJYGl6jwwuo4s2ndXgkf9omyEL4CzwbHuUBK6v1Q4FaFyb
	smPKgdQV7mYQpjZkcZd0rmNrDHm0fTRHBgncnb47JfjNMOoSU/amhXyYO229tHH6gbwRI6FEw3/
	LmqQfjBnTO2M6/9ZcJPPYs4AKAE4nEegnNpKCZXnfU51G9G0boQSWlfQ==
X-Received: by 2002:a05:6102:580a:b0:6ce:7e04:ddae with SMTP id ada2fe7eead31-6ea2acdd709mr237587137.18.1780413883527;
        Tue, 02 Jun 2026 08:24:43 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0663fesm119807436d6.14.2026.06.02.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:24:43 -0700 (PDT)
Message-ID: <6a1ef5bb.4c95d0d1.2fc0e9.f59b@mx.google.com>
Date: Tue, 02 Jun 2026 08:24:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7884258646167957114=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cxs1494089474@gmail.com
Subject: RE: Bluetooth: btusb: Add support for TP-Link TL-UB250
In-Reply-To: <20260602135419.3092500-1-cxs1494089474@gmail.com>
References: <20260602135419.3092500-1-cxs1494089474@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7884258646167957114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104655

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.93 seconds
CheckAllWarning               PASS      28.33 seconds
CheckSparse                   PASS      26.99 seconds
BuildKernel32                 PASS      24.85 seconds
TestRunnerSetup               PASS      527.95 seconds
IncrementalBuild              PASS      24.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add support for TP-Link TL-UB250
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14607133.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/274

---
Regards,
Linux Bluetooth


--===============7884258646167957114==--
