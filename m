Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095644C51C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509521; cv=none; b=qnGghIwktdqEL5ZxM1Yl4h97LTOXq8UlW52e2PFaPrnaDen8gsCtnmOnqF5fni17L4iOKdQp8+EPKAZQa35XhdAXYKueJlMaKvG0ID4AGkWwNQyxNYA9plhaa5n9iizf7UAxlCrnlmlbVfNNplSitOu4JmR/0xa2G7/C3GpmwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509521; c=relaxed/simple;
	bh=J0yp82B6q5fj5Bk1g5H5fXWjGYTnFbHcbxQ0kyjf8Q8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hlDgrhZISGRJkPKCGs8Qy+VL8hx9ew3wxwEJ7z9ljdkmzcV1TeP8boJMufMid5Udbj4snYanAa0KOxFCOqMavaJk2+R1f7s4tVIbDVg2SBeso59QQGW2chDV7CwKK/mscUCcDrsZ9AxsUJkoBLd9YH/v2BKvpaq3xPme87eB9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwqnk/gg; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwqnk/gg"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86b90133ae8so166348b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789509519; x=1790114319; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J0yp82B6q5fj5Bk1g5H5fXWjGYTnFbHcbxQ0kyjf8Q8=;
        b=Fwqnk/ggm/uFUBhtvKmMXjcqzf/G3+asGFcWcUTgfg9oufXJPesqUzdWp9rtOG/h5D
         yHDDSHkmGFt432ByeDQ0Wul6Z+ueyXtwJa9VvfQUuSkM2XOSXVYF3EmNczHRQCsoecAO
         sQEJ29bRqBjmCBwvvMITSRzTYciPBm817fjwvBOadg+WqhO6zsrbh8/MdDMJhtWC4K6b
         9CmUR6LxN4jDhS+V/+uEd49lma55zaPsQsAkumepcEfNqXMJGfX8ApbM118ncXZ4+9/P
         zmdt5iwXzrRp54kp95kxF9pGxcI+rvSdeDFIB3c0YU7KMn3T8TyuRFdRJw8IhaQDk7wF
         C/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509519; x=1790114319;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J0yp82B6q5fj5Bk1g5H5fXWjGYTnFbHcbxQ0kyjf8Q8=;
        b=QY3jIRIvLdogDGfeGJlRpNN86jTyk3VncSzzbTgITchjwr/ZBQxJAMWxVzq8iBhwxl
         LrpIIGJkY9l4YBKQmX/7WDvqte+o62uxPKFRnxqq9LlJ21TiQhoL1W819HU7sP3u5zQ1
         z3tZqHC3JdPotJsyuPLrZAnNbo1UaJD/N2klNrZQ/jipJ3IKJ/pFDdiAtKU3RJvEnK+I
         /UdryCuqPeaNQSLtBs1PFc3dSYf/lhFCWEIUsJYDNJR1NJtCyuAne/6ZPfuOu9Gvsfx6
         rpvLQB8GoL5eww/Z178fH7ycEimOYkb0z7G9Ko05wBBjmQ98/6x4BnAz3vh0tWyuHB4D
         YZLA==
X-Gm-Message-State: AFuF++lZ4dnlKS4AAAnLEZilujRUVDULJgaaBU9/R8wzk1VJMLtA7BR3
	DyQK1n2ZEOMj81eyW+efbvBhg2N/A3QDjgTT9AORudx/t9ZhcaRdJOkvx/0p3Q==
X-Gm-Gg: AYBFou2N3Toc/4pDwWVfarPqKvdcInAppFvvJD1+tVUvt6TevRzaV0JTp3dDm5zgiJH
	ii9cceZdsEAYN0uxmdCMrfXvSbvfR8OI+tNMKJm0CSQZiQ1lqq3ENel+yRDXhzitcsrdWhLnkAE
	JCvwnxjK2a7LAW5LSYFbaOfB/qzJkNOR35CAuZeWH91+C2h5SUEpEGDfnHI9EZVD+/JwRodya4O
	1njN237ykT7CPbDv36Nh/AkkHFQDy7oywxI3pxAoBpW00XiFA8bvxCk+PW5w/o4uqH2JoGwnlUR
	ydVlCtPUrf4kvt2Z3do8v/h+yXQ59eW4RrVNfdjC5ojHXaAkGhONE9nd+Y8gQaGwcAPa1b0O/S1
	fd52sjFfsNFFqBkYTd5lh0X/mekLbdhFBypt2wfoS1bOknAY9ei8wrCKRiw6nVHlWb08MhLyl6I
	Qob7TeJ/XYYtNZWgB/YzjGSFRNW6nBHUMtMQVfiq6zddBrf11OMP1D3OHBrrV7GPgrhKkhpUaN5
	RGF59BKu74Y1A==
X-Received: by 2002:a05:6a20:7f8a:b0:3da:e7db:5afe with SMTP id adf61e73a8af0-3dd5f5d85aamr538698637.14.1789509519219;
        Tue, 15 Sep 2026 14:58:39 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b030aesm1747701eec.26.2026.09.15.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:58:38 -0700 (PDT)
Message-ID: <6aa9bf8e.ec46f90a.1acc6.8f24@mx.google.com>
Date: Tue, 15 Sep 2026 14:58:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1146207113008522480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Cover a BAP stream to a coordinated set
In-Reply-To: <20260915211528.1223784-2-luiz.dentz@gmail.com>
References: <20260915211528.1223784-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1146207113008522480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: test/functional/conftest.py:2
error: test/functional/conftest.py: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1146207113008522480==--
