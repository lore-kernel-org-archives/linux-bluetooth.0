Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28740FDA4
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542508; cv=none; b=k5cY/jLBAQ+aAhWuknj26LJKAoTI1H57+cEoEMJFh7HYRRtmYWiSftKqEKDY+h89RrZ0qE/PL/RJV2T2ei0n3ffKv7tmrmU9LXS67N/LETJzkwM+H40GAX3BN1npkokuF4zQN7FfW3N702Nb0cSZe+ZpFRr+wFcQ84jgzU3UdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542508; c=relaxed/simple;
	bh=wgW4qEaZUUGxsFCpdKhUEAwtr2/8IYhzGxDMFOC9ReY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lbOnmweWvzgpy6AuHFLtXy3zrXmD4I7iLtqrLtFFKXDyqLlUscTCZLx7W0UUjK7zyJoGfWyA6FTmuL5SoUsGuwGw6DrBha+Cqa/811qy4o8G1OuIi3rLIqZ1OVGr74f/sRf/q08aZispRFNN5fAR3EyOsALwZcCXWRkluRC2vT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBnTxWQ9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBnTxWQ9"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158c621ebbso454215385a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542506; x=1782147306; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eY1xhIZfBfDFf0YNPsdaLjhr0nINSPsqVpush8//B7k=;
        b=RBnTxWQ9egVV6hw4wFXFJt7dtUnhI6RzAstMWgABhRN/LT2KlDd9DMB/2xMfOnqObG
         N6afIK7FsFLNzF39VQniG9CSvI3kkQsaXL2DMOI0LzbJsj19uZmwthT6toUojZDexfAz
         5uQruCynw2jibTprjbL6sEZcFwSQec2W+p1a91UqigyJe7a5oPuhaZJk3pt/OFaUhAoE
         618F/ieRiJ/u2bZtUMNyRXStDdmilJPUWto0jvp0MTxLwcMuE330vjl8JloqVyuN2KX/
         NwapUrEQ7V70wNI73U4AANqHdKvQH5bU1bHOEAnt4KDgxK7pgzH3VKjTaQ4pHUaAqtK6
         cMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542506; x=1782147306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY1xhIZfBfDFf0YNPsdaLjhr0nINSPsqVpush8//B7k=;
        b=nigVbZJ3diVRtQdPNMYP0P9eXulgii9H5qoBAkXCq96IHo8pLRVQvadf1wZFEsmWEb
         dFMIF2Dp4EyYwae+D8jCEJI43InIN52dwl9AtDa1oPlXUqAizu5nGR0XIhFapHpQLxV3
         F32PZ5PB0Ucw0u20+B7FByhZQqV3L4MreJYD2Q1BB79pJTSGJpzad661p71kpcLmB6Wd
         9iaYDGWCEu4vfjolNRA2fj9DHg22N747c5uEYccMnCk+FJCDZXOetrOHm01WNyqi1vmD
         15z1aYovBccKV+NC4fbX9Pya7UJDs0DMzZq3aB9I5CZTrsQgFQY4R8WEIimZwULZ0PPn
         ltCQ==
X-Gm-Message-State: AOJu0YwJQCsMAYdVGwmQ2UyQDpAb9YL/cP1hB7XVm2Kh/46Aom5av9zX
	TY9Kkzms/YQ/pApj8Jd0+g3ib/kTMPN0VrgiwIbO/bmsE/3T/qxyD/sdwqJcbg==
X-Gm-Gg: Acq92OEWcmqEE7553wqepLVTiUDOmvY08QpusDXo5ez5oA/Dc5oAIVrWrUBAv64poqR
	4iUjNly1qzRlDIqtRE8JWq7WQBAWsBS/Vm7xjBUHDbAte+GXpOVZ9Z1FpB+1AF3xwO0/8bY7xPb
	HjO5l4p3E9b7W8rtzLSo5ruzT7Jno2+P97+8Y9H8sQzUVQQqtH+Xj7i9AR6/qlACAMFmpHs4HUy
	bCcwKvuUdmOj4clYPbSR1qMZAz4GVE7ylOthyGg50n/qFWFmD2K74slPPnkaozpIvAxEZahusY+
	LveHgsJ4vq4nFKJJT+HW/sHu08id8XSS6QAvXVkeRnhC3WqhMkqRoP+k0UUkRi1tV/cegoXziXC
	Ld6u1gUKx0ZwNwWxaKqOTLVa2hRNmKsyzJKRz++C9B4pSDKANxV8J5tFiFg5uWdUtDHoUhfD2eM
	g6ps6FyAGJ05/xr9Ivhf+mE8GvxXx85w==
X-Received: by 2002:a05:620a:31a0:b0:910:87f4:9a26 with SMTP id af79cd13be357-917f1e44e09mr1844735285a.41.1781542506436;
        Mon, 15 Jun 2026 09:55:06 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.73.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f06835sm1184593085a.14.2026.06.15.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:55:06 -0700 (PDT)
Message-ID: <6a302e6a.f0689485.3aa831.034e@mx.google.com>
Date: Mon, 15 Jun 2026 09:55:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4567886158582059904=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
In-Reply-To: <20260615152948.776154-1-luiz.dentz@gmail.com>
References: <20260615152948.776154-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4567886158582059904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111788

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.71 seconds
CheckAllWarning               PASS      29.48 seconds
CheckSparse                   PASS      28.54 seconds
BuildKernel32                 PASS      26.28 seconds
TestRunnerSetup               PASS      588.05 seconds
TestRunner_6lowpan-tester     PASS      22.78 seconds
IncrementalBuild              PASS      40.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")'
#98: 
b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding

total: 1 errors, 0 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14629714.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/317

---
Regards,
Linux Bluetooth


--===============4567886158582059904==--
