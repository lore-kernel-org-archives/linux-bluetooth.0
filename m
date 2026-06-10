Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174A3ACEF6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080389; cv=none; b=WFkPccbN6Xn4niN/6QjYwdDF2bGNWi5tV5i16M33azaAu+m8OkgViTH0MO9QUGELNqLRC4K+FQn6b5xePq4kLVqeQ0T8RbQwHQ5jl6AJUQwrPRGTzYmXJeC7PxvegA87AbaFS4/2il7xx2OxJ8Elshd6QCzCBl/PVFzrjzyv5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080389; c=relaxed/simple;
	bh=3nEqNCErtvXy7T0qizunp+gtP607fT+nTo2RDsYhUfM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QFOl/E1r1sjvPRa0hw8NvsVQtm7Vg3hwntYvRYnFCdpFEEItQwOYbVd3HHdR2876VglMdCNjygpB2bQAWnvsph44qhsYqV03nRHVe6dpiJUgF4sS26o2gR2o3L4NgRM9hmUAS/IjorFtU9zmbxMR019acfKrwGg4KUYmQdD51xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuGbMbXs; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuGbMbXs"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so72545136d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781080388; x=1781685188; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3nEqNCErtvXy7T0qizunp+gtP607fT+nTo2RDsYhUfM=;
        b=EuGbMbXsQoBh9eGs8dDqm+4t7zgQE/rfued5/eV2KOMHNjrjZpgZTs12qVVlU8Aq4H
         6DCLVPMrdRHKo37reCzXUuifSLFuYopU0Gjhr3v1T5EfZQ6cAooLeQJnbOcG88qci7cF
         Wbl41jmlzxJHi0zaYuOIXYqLLpX2mKaOfpXYCMrG7OKUeIjYraEwfPYZsBeMN1FY9Jgv
         1ShkFiOxvFQowTVZ+gurg+dxHkrKPQt0KOwKtP5z1INYRHsv6ysf2hwQPKxxe3LDOwvc
         q6p+Og6qPbOsTv1+LpRh4gHuvB3APg0gIUH4VHAgTzYi9rAQfQSXtKLUB008prj4l3et
         TX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080388; x=1781685188;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nEqNCErtvXy7T0qizunp+gtP607fT+nTo2RDsYhUfM=;
        b=DWO2roKdolN424uUARHzE6CZlegv2XOekYTBlaRESCU0CnbJpjcLHM/hyb9tDkh9pz
         j3oNjPHAsJqmWPXmC0guVyxB8ny2O/rAXVT9QGeBtQmDrOV2zSa4r0QVhptuJJ8qDu6Y
         wOTtTZEvWqOmq7q2hdeiap+XnqowZ1RnJoa0GCLlXlBza27kqC4OPiPILGc/LuTMqDeq
         s1e3oIgao8Trp7X2KHZh31v2dJNpikEaCDmhnQ2XiEwyx9txeXv3M6VNFxp5iJdH04Y9
         oAPfF3ZO8A83piMd/D7kF9fuqmAQnF6leRMNjwZXrv6BgLhMNGAIU0T9EOaxpbuTugHk
         /tkg==
X-Gm-Message-State: AOJu0YwC8is1p6LwRnnOmlWnTcwPFNIS2Bn1gX+cHhP8Nw4RGfT87xDF
	wliVLk6gEwzizaNbWBxdrH4NPkJktmM6L/jF/MURnsrHaRgLPWUHb0Rlh1a8cA==
X-Gm-Gg: Acq92OH1oK0CBGdCIZxV2wFlaNgbkNli9vZKQIujY0peIW6u213P6LKhaaQOpQorcl/
	teYk1TvGH2dNd3g1paJUeGBExK4X7tmtvXcarK2ORzktbEKtzEQmZSmtHWeIeVDGfExIDYis6Yo
	L9ZN0SoodPyIx1oQAR0tm7Kj7MnC3ts5kBMWjE23X5KfB+uT0COHAfsw32uupQXxtpjHeV/vt69
	0Le7z0T3oou+OEGH8UokU+FTzdbOwxG/KoDZFOo/Bh2j9Hta3mt2BE/slmT/Qc/7ZhL0AxZ0C78
	Ekrw96+DkxFRjRbkTXE4006K0Kk/0mpZ9rH6avE3Q6QSwAE7iNrOl4vzmTi/z8+q9ThDcyLUsYn
	q+fVucKDf7PeXP6uV7+6EOfTyehASST6xQqjkwJY4KAT1XfOvRYiRPLzL1jjtfwjprGslIOEq3O
	hscHHKMIWDA1zriOFwM4Ylca8BEWPzYr2HEnk1WCg2gQ==
X-Received: by 2002:a05:6214:4e09:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-8cee6252853mr357633816d6.30.1781080387604;
        Wed, 10 Jun 2026 01:33:07 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.177.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm229734886d6.39.2026.06.10.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:33:07 -0700 (PDT)
Message-ID: <6a292143.3b2754cf.39ff73.704c@mx.google.com>
Date: Wed, 10 Jun 2026 01:33:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5889069329091937117=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sanghyun.park.cnu@gmail.com
Subject: RE: [v2] Bluetooth: SCO: Fix use-after-free on listening socket in sco_conn_ready()
In-Reply-To: <20260610060824.552957-2-sanghyun.park.cnu@gmail.com>
References: <20260610060824.552957-2-sanghyun.park.cnu@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5889069329091937117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/sco.c:410
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5889069329091937117==--
