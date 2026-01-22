Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486B47AF5A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068228; cv=none; b=Iu+gsFSzrNul/MPV29Xplha40LSsEV87FTOcrWzMiX7ipqEum8v+3xQhI0rQpKt5C8qL6LEK6L/jL6kvUwYXrmcoUZyYcPkw2UKwPO2S4TjGIvzZnOz6SJp/Uz+PwP7XPNtVFvAcEy30MAuQ8MCkK91Ycg8jp14W39jaxZ/VZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068228; c=relaxed/simple;
	bh=IlsqQb4V/CBlMFv6qwp2agXjlymWcwDhlS/39S1n7JU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IlwPC7LcuoV+TAMLjHBDmqm2PVGCJaFElTRm29vSVIFlIFxp/3GhTZfTl05NIDf28bm1j7QnNCBsyNROTNJ/hw+uvVRN4lQaF1o0Pr/mSVBfp7DSo/j2I+shbzEDj20VD4sgE9RavcUbGEQ6hnqj4AiXavW7q4rL9ZCySIS5l8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ5pSN6M; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ5pSN6M"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d148f6833aso219859a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 23:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769068217; x=1769673017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aHnQJ/PfOodnHS9SKJUAzUW45ogffJITOILDHgE/Z/w=;
        b=WJ5pSN6Mb2aA0v4pJ6+dM6prMGbRJMohHI8dknC7GOqW0Qvt7foDgA5pl2THZFzmqT
         lYTbAOJ/N0IvO0D0wvwG2pq4StR5n/NzBpwg/5SndfkQV1fsjftrGG/R4bmZyQOd7NAI
         4rKv/Q83+RWeO7sXKqNb+nBIA9ZBSuXily58Np0688e3S5tplL9BO21P9kd0PyV2t3lt
         rHbt3hoKghFBWlBVwrZfwCUaKNrfhsGHNoqsXRr+qhs1qPkxEVQgZwRGOpPudCJ7NFx5
         rN6PDAIx+NmceX0gykUQ8QlHMkbpWgh9al9+8hF/qk4QvznXiwNB8lDbY8pw1iMqb7Ws
         MtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769068217; x=1769673017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHnQJ/PfOodnHS9SKJUAzUW45ogffJITOILDHgE/Z/w=;
        b=VYfuYeIb8ekiw1UDnfSkUGFVL3E5hGRO9Vsy5aCPW82G+Aw1nf2hNl49fBgat7odH+
         uPiw6gAC/oJFCKa7Yc3DE1rhGBCSilcaWHkfS/dk1HtwPKW8JrQwkfQSpSm34++bR8e1
         pSqfVLhqpfx9xeuC+fivL1//MTNtW1o6ghRVnkcUkCn7NArmuFRsugvsStihQyjcd6Q9
         hicSD+o/v2NC3djGGTabLdHSZQjRAeHERZkzES7yF7AxgEdoj/ge3ynseOm57O0IqWxy
         S8rBEta+fuyxMgU8UidEnjzdPBGSH8nIIxeB6Ae8wAv286IOgaOm4qG/CyOYoMFzrrtH
         648Q==
X-Gm-Message-State: AOJu0Yxr70zMOj7oygocCtoJIo+SkqDywVH/8IMkLr42DLosbAwzGQfE
	d9Vb6yeJn4yGQhQmePBDiKKj6EXy1w19THh+eySvSOGiWjqobCOqQ/28RyTo0vVduxY=
X-Gm-Gg: AZuq6aJjIu1curcVrPXoevWwkxUspb6qJuY49oo94JXEeAHI7hQvK3LWvD1JFLTc+yz
	cbC6iaWOHTIIMnUbEQLKjrl/5k3Im3sDGH29bhYSej1fJQeKo8UEW1Xk7Ywr7bFpjcCPiIBjDM2
	O7Lp6aKduGbHA1cRq/pJF+z4vsEgRrv1dlzadrXQKvUwArfLaaMNsbeStE7Bca6i6q/5+OsxhqV
	BEaDKQS4deHWoWO3TVMt1xkTvl2TcMDFHAdzO4qwU4dnO2QNaa2zkf55/cfACBtBGXieEaosMq0
	J8Ku81hnUSU3UY9ko6ZPAP8K4Mt/MJfo3CS/Pb3DIxvDiOBsAIWtgIy8Ss41V++6+LZd6mgc3Sw
	+hZtoU7IFOom7IfEYTFr/9DcMEiDyRZmT/VA3py87XVHKTy4zsFTk79692XyB+fxmkbbGSCiT1m
	rYn3Y1ZEqsGv967tOFrQ==
X-Received: by 2002:a05:6830:81f6:b0:7ca:c803:f539 with SMTP id 46e09a7af769-7cfded3f30emr10943998a34.5.1769068217392;
        Wed, 21 Jan 2026 23:50:17 -0800 (PST)
Received: from [172.17.0.2] ([52.173.182.168])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0e956esm12055969a34.10.2026.01.21.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:50:16 -0800 (PST)
Message-ID: <6971d6b8.050a0220.d30d3.ce1c@mx.google.com>
Date: Wed, 21 Jan 2026 23:50:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1372977322021451215=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] device: Initialize device volume with a valid value
In-Reply-To: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
References: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1372977322021451215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1045489

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      650.70 seconds
MakeCheck                     PASS      18.79 seconds
MakeDistcheck                 PASS      244.71 seconds
CheckValgrind                 PASS      296.47 seconds
CheckSmatch                   PASS      355.04 seconds
bluezmakeextell               PASS      184.47 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1040.61 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1372977322021451215==--
