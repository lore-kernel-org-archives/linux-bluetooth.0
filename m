Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13435C1A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629572; cv=none; b=J+g61nCx197DP0gXEulq4Z+wmSk9n9vJfgansFUrAXv3cJiUFhJrqHuNsgtiKR1LpU06caUf7g9cSbKBM9S5mQKoNwCilooMVq32GM4gurIDm/jTK4WoF43BDQEu9zzBNchqxG4xISIIvD8IztBAdc8dtkaAD6CBYPSW1W9ZyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629572; c=relaxed/simple;
	bh=/pQLc2cUcAM3D7KMkgg2EwE9zTZCykYjSAcsmWD35GM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oEb2Tg90O4c1LXPgpY4/d1/UwMQ4WbLVib8AxqPsLH+t/khtjmIpOhKvZx18Lwraw0XZ1D/an2TpwFDN9hOyBtrhfU7d5OqX559J3EE/MdXZglbEt9o6k+TT9cBK3q+/hshTRyDLnp1OcZT47+NKYws7m6k6jJ5K2u60WitWywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt+zGt9U; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt+zGt9U"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c2c08ff3f8so1715396b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629569; x=1791234369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/pQLc2cUcAM3D7KMkgg2EwE9zTZCykYjSAcsmWD35GM=;
        b=lt+zGt9U3z3y5q/UhAUYdIfoGytC2RxdNgTh/70SBjLfxS9j36PYI4IypAd9EIxCb1
         pJ72BeWGAdBC4n1KXq+OmxEDNT7fBKkSapC+Lusm4WAolA1TQpv6IUmTfKW+vtDtBniD
         +s78fxq04asgfU7AF43+bkt+cGwiELUoIqiKKBEvrZvD7sWyaXNz2V0Lsqkt9xDyAvae
         guFLzFQsEYYpL03wuQFIoAyMf52tDpmFShzV6OOCLi+2BMi2P6fF0ezTg42dStlp1EbF
         EYiUEC0nczVQHP/+c7Eqb5W6IjMqtWQc7+au9Ejjkce6O+mB4Z86E9bK+uc/r0r/vCUg
         ro2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629569; x=1791234369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/pQLc2cUcAM3D7KMkgg2EwE9zTZCykYjSAcsmWD35GM=;
        b=i0QFZf2O7SC/h/6WO/IHW6J0T486PIpt1BnzTypqdpBqJbT1yXSt63Tv0rY8J0fqU1
         CehCagcE92vzTnKCRNK08KuKJZeEFVK2N2pajRrRH/hmgYes3cUYasbdsdOKAm4/EKpK
         GnmPxG0VmwinUSavJDvTy6/rLgpWVDDG0QOhpYyQInMRTCvjK/O8KWWZAZaK8xybmU7H
         76BYlPyBuVibfJnDfIa93i5CCK6wMgt9Yb2H+gsfqWdv+lAPYDiMswiPVwIc9hIXjrS5
         VRGid5AZGxMjkmJXFZEq1GzaByXGjGE4mlT7kTI6yqUsUsVPRRZdmGG6Qt6pnibc2vTj
         NC8Q==
X-Gm-Message-State: AFuF++l06zjokgyuhJERGzEI0e2kNR+9ohWCSlmUxw+vzkOSq6Ke2K62
	I7UemyTI3lm7I8diQTBNN+x538rqsCGN6RMvycbSK1gqaRxDBHxcI3KUwdsB4mnn
X-Gm-Gg: AYBFou2WOBgNljnU/faSVYRt12Os+D/GtrqnX5Y0rDIld2lFQN0DL+nhT6SDUbo7U3D
	nW8q8r+uxGcq/V2e7kT+ST8pCxwlt8VM8jXj9WI1dI+0qISBWPWZwrw0p+jzmkmR4fvdOYHu4g/
	Yk9kYN9KLC2w/60DYRzCFWV1x2VSJGdhGtqF0615v/6GGsDkSRtMauqcfLRZR0pBPzw4BZjMUHE
	2hNuVBygz6vtUrbTUWf6M2BoyvC7fLEFEB/H5vgmlpvMMq+ggxSWE7u9CDv4iMlwiklmry01lNK
	AKLxmIGVfq3yBo5FYNAjJKPsxHlRlQnetU68S5HRlz7A/rJhqe3RfsYauLUbV/iwxjpO1pd7wGy
	x3yfAUhsgIMOY9sfz5PClvvWGKu3lD1XDzryc92WXKOWSk/HYGZ0THnPHqQMHi4fdDXS/vOi/aT
	8uuVVcm4x4UWK1dPX07LqKZit2JWB4gfqkUuYrkt6PQnqE1xjSZZABM2Fbv5ZKUHRwao8EsOP+L
	ObOwJ8CQfBo0UyOTSo=
X-Received: by 2002:a05:6808:f92:b0:4ec:7639:2ad with SMTP id 5614622812f47-4ec76390c6dmr1972486b6e.13.1790629569528;
        Mon, 28 Sep 2026 14:06:09 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.71])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbd25cf71sm2618824b6e.16.2026.09.28.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:06:08 -0700 (PDT)
Message-ID: <6abad6c0.71dd44c1.3a890c.e399@mx.google.com>
Date: Mon, 28 Sep 2026 14:06:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6782926090447101838=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Reject signalling responses in invalid states
In-Reply-To: <20260928173324.1837653-1-oss@fourdim.xyz>
References: <20260928173324.1837653-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6782926090447101838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:4284
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6782926090447101838==--
