Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B41863E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016921; cv=none; b=e3JnmkkrEMmvUJ93fPlm1tVEzCxU/6mOdQJ3RqS60wPoW3iy/Y0Y4DlSvm+BBttPiZZpIscWt1GbEJcMbJat2znnLzERJSVZ7xSw4ZcTb7Ag85q6SOFjgE4SYiRU5se4Ao50DCvM6XK4r42lyqs0/ZqHzUpGoC/nJQtT6lpHcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016921; c=relaxed/simple;
	bh=g+ghn/rVKrpoCpUCze1652+Jz7Cqh4h9BCBFiCn8M/w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QX9E2iu3lOccRROtwEx5UWoCZJhkPGDu6jgUTaDo324/6mZpdY7GsLgTRvEpeyCZCdt3QCrDGN4uxSWCncmIyabhIijLVEbkCu6a8gEd6qFloQF9OAwhHqxOdvYNDe0LIF++W4tCOa18o7/e+2oC728FIhtQhHkIVCR2vv0qc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPl7weLO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPl7weLO"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso35636186d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726016919; x=1726621719; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g+ghn/rVKrpoCpUCze1652+Jz7Cqh4h9BCBFiCn8M/w=;
        b=hPl7weLOqQA3DRWs8x4EGSIZEhxmd580ZDTnqZxjhvu/lQOXZekV7LL0ZQTRwmDIvS
         qFtoAQ7mI7bF8rYhzN4GyBBG/gbIVXALDHUNemHl2E3VcxT93reNJJvERU7h902GEfsq
         lumiX6srne4GbkTAFhReqmuyFadYNJMoI8XIPsGH55W4ph7lgLrLgHEB+z0pQtye9wTy
         SJ5996+Vpi/jXVQW2sNUxXo/W/gYwbJ4ZsWRIHvMm2Nz0peYv7EOTl2P3hgtT/PCnJuo
         aCiHB675sDjtgH8u7zT9waueJV6HcpWY/Y8vI8yWFEBI4tfdRxED2HYqe2qbPrI0fQow
         zBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726016919; x=1726621719;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+ghn/rVKrpoCpUCze1652+Jz7Cqh4h9BCBFiCn8M/w=;
        b=GQ0LNNJk3NtQiQuCvtIb6tEP/mSGAh8rujIu44Q8+sQ5qJ1DRIR52HklXSIgeM3LmF
         2DQo7Bzqyn5pm4/ujmcsN4lDi/ZMi3SwcvWHvVygV62zkPXNINBur1bsWvhjgJY1Kj/+
         0omBf4Jmlxkv8XtZPBAIil4JKTkYVjciKoBTOjg7ICis1+DwePSDQcrYAdw2SklR1L+D
         DuTJGlpByjz+7tSZOSvOeNenV1coKRC1oxOabDL5BtP3s5mq/N8yfewSWLoCtQ39uzek
         vQzNPoCY0GiOwh0wGwtvrRmx9kipvLaw6nQ5v5ob933QT9Ie+YcVJQdht+mnDWd4OqLC
         g31A==
X-Gm-Message-State: AOJu0Yz7ecVNrWYQPsUUIKNJ3Cr00mqTkXwZ6vjRRXP8xAjCN7YAF6P/
	vkKSITAGkbLkUHNrq83Xi+45Up1+HsEIsfmZL41J47eYL2F16fvBFI+3lQ==
X-Google-Smtp-Source: AGHT+IHeNAtlqnmez3yWUV9CBeNdlOXqnaUzc8zjbzvDLK73A/V5fH/3mEk+lx7HNY52hipu01bQvg==
X-Received: by 2002:ad4:498d:0:b0:6c5:30c9:c055 with SMTP id 6a1803df08f44-6c530c9c2c9mr184508896d6.14.1726016918614;
        Tue, 10 Sep 2024 18:08:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.37.95])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343296afsm35508226d6.2.2024.09.10.18.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 18:08:38 -0700 (PDT)
Message-ID: <66e0ed96.050a0220.3552d4.da4b@mx.google.com>
Date: Tue, 10 Sep 2024 18:08:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1142825054874421240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: [BlueZ] mesh: Remove duplicated init for mesh config
In-Reply-To: <66e0e4f9.050a0220.385dec.8d26@mx.google.com>
References: <66e0e4f9.050a0220.385dec.8d26@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1142825054874421240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: mesh/mesh.c:266
error: mesh/mesh.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1142825054874421240==--
