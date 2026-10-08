Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F83AF66D
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478501; cv=none; b=fG2xd5SG1h8BDiQdQvfSOjQdI/JvBkLcCrHJu+3xnyY0VIhD8/Aubxh1z5b+9zrhpwe3J0j1Ip3pVnhj6U5W7cVMll3C+w/q7zpv9Le7qsVXQlq1Vn4t7w6sHWmGxT3iwahgyPbHp2teiO5afhnwn+wksNBH1889dyDy2dsjlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478501; c=relaxed/simple;
	bh=6sqq0B9YNKYopc6Qq40tmHWKqvSoKQi8RoY/pTmGEcY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vnm7Dv9gPC7FFxR4zAetUF9HsoSBLfKYuXLeIma3uXlUKtuRNJ711GI4rL+Mi9M7v3Jr0spH/fNGjI4B7ZLza1eYPpXoYOQOGMAJRIf9UfVRtuYUWo5B0JPT6MkTCLkUTq5lxzPwLHqw0p8JS0At9JRgy8xoaMZmdjZQ+3m9QeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9W48F5U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9W48F5U"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e82462a3f1so4185945ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791478500; x=1792083300; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qbTOqWPQ1bbjJg46ShBlRHqEEJIXIOFkpW05qcUOMn8=;
        b=J9W48F5U8fVDj3/k9jV9qcNvAhnD6EFOYBJLRXl9Y5w3+qY5IKrcmK1Tzz/+US/jTK
         NZ+ZHGqJWEYwxFaA8O5VCF4YuKe1TBBDJBf4kXwEw1+EpvPjQlx+FbHrwsyYBufo8+Oa
         qbE8T/CFxd20eiod4pT7ocbZIFhT4+3jpmV9goRAM0LqFScN21Eq7NXpbviODWzUTJmK
         00EPtOh5sW0UCDsYlxS6obtpSr/oCN+AUdT08qkxPKFSBsHIsklYMSBSGiazYIqMIWYP
         Mmfcw9WTp7VpnE1qMeGtzLF1IZs2aTyMK1AmR1laJ1gLP1avqTzabPBEyR50BeudTv8b
         zFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478500; x=1792083300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qbTOqWPQ1bbjJg46ShBlRHqEEJIXIOFkpW05qcUOMn8=;
        b=WoxKvxczMUEnrAiBkHfm+yRTVpmKrr9teX28QABJ8nD+5Ws3RvJGnj1u/LBVBI5FgR
         VIO+LXtP9Sofy3Rvbyc5iXDqXbXCaSlyX/aLeQrvP9RakV6Fo6YN1yWqPeqEOmeGXvfy
         WffRtam8K8D+lzj1US9iUo4oD+yiegl9LX+t1hjvlpFzGz+66A6Ja5jpeZIe+hhvI/ik
         cTQywQ64/ozKGNM8vgda3wZ1TdGj1mNPZDxvArE2Um6PcrQje3MFE42uHCKmunXZLZMI
         ni7skLr4EONlPPTNfQ/2y3f4+fvNDp3dY1Qs80Un4Zxf7wd0mynMGXsCe0HJTcAPDSyJ
         4BOQ==
X-Gm-Message-State: AFq9FYJxiXcf/AWCOVGRTypnfUzJiVo0vqtyJ3OrecRMtvqDGS8U7IJI
	+59OfA77Wpey0JGjsspeI0n2sLVSHM615TQUAQAmSI6SVpGV3yzj6JRxAd2zdmRB
X-Gm-Gg: AYBFou18nEEgqifGUdMG5Za6k4Orb04CO9l6slMZdDW2uyzzRU3BBR3rLxSV5H4czKb
	qWmwPWram7nzHrIfd1csNG6KJk3UT5BrHCVoJz/hngblRJ/asl9kA11NjvTJcILtIewusRQjpvW
	stLIlPK7FekVMtgD7sqg8Y7rzG2jwWuCg5q8TQwshgdBl2DNQLW3HeM69681CCRRzv+t7uA6KeR
	I9pymgYtlca1RCfjcBaXImGM1z7GpY9DbHCILP4nWP0xSUSSaRAFdkfwrhDPuPikEc8jDVfaCsY
	cB2Zf3mc6tHOmZ8rDX9fY5flolmAFivfDw7D6IE93wz2UNIxSPCDadebi3ifsHcXGfkv3HJpGRX
	bk/pmihqcjdrWSoub3yogC4ca7y7cfKH4uM4+QrJguDZBHbCantPy7zJ6iXwwbyNAkmhLpXT3in
	p8AJ1FMfun7VAIiSktOBPvQMvLnyL+DrZJZDLW5KTI7SOAgMSnylmmpv10Jwo14Rao+m6TVf59M
	5nC2g==
X-Received: by 2002:a17:902:ef09:b0:2e5:9923:5582 with SMTP id d9443c01a7336-2e6004e36b0mr52447965ad.29.1791478499738;
        Thu, 08 Oct 2026 09:54:59 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.236.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fe3a7sm28946585ad.23.2026.10.08.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:54:59 -0700 (PDT)
Message-ID: <6ac7cae3.db5799c8.16508.bfc1@mx.google.com>
Date: Thu, 08 Oct 2026 09:54:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8671755831239423274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: audio/avrcp: Add AvrcpVersion config option
In-Reply-To: <20260923091827.4496-2-pvbozhko@salutedevices.com>
References: <20260923091827.4496-2-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8671755831239423274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       audio/avrcp: Add AvrcpVersion config option
   Pull Request: https://github.com/bluez/bluez/pull/2571
   Created:      2026-09-23 10:01:20+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8671755831239423274==--
