Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4946D0AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245107; cv=none; b=dySSW5i1VrTwJrbPBNiS0AofzCLdwkvqdarYQkkrHP1YzGe/IVeVIHCf0WuYHC7Jo5PZxbxRQSlGflHLuwmj+4fMrQa0njYLUVmWuOkU6jNG8/7SChNmOwvRErn61GtDD1tpgLS0E8Gxk6B/8RJsGICaWdmJtvDIWE31tbYW8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245107; c=relaxed/simple;
	bh=/ljYElLiaFgzleyw+8UeG+MpsjkeJTPBnUdJ30g4Gd0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mldnlt6US/1ZmIbiqgQULIWKtydrS38aSOihWWyPaTy/SJGhmImteBbNmqg5RnUCPxXTs57I2kHzrc+VX1F1M6Dlp8SBTPPdQPVjuUvEhb9Ft9Uf9mZvoO4jrAFpDxAElqWY1Gwp+8bAJXGAp/LDP8nwFcrzFYnoFEOf2wSM2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI8VaHML; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI8VaHML"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76543e1so7884671cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245102; x=1790849902; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ljYElLiaFgzleyw+8UeG+MpsjkeJTPBnUdJ30g4Gd0=;
        b=UI8VaHML4BauUfmkRwfi36XuSCmeVLRdGjIRzgtQA7n3B9Kz4wP+GGiqYp8PaHeWmL
         VOU8RLhzjAkOoG78J3QVU5O8Bd/dz3yeVmWm5YrNofJV274g/WRGk5Zz+tJmBnuNEc4r
         UbSKKmpf+iKUyX36QPswvEy2XqapQLDiIrMYJ0Oi5acjklYLes/a75uuLa1kKUf6th8I
         /IZbV1qNU7U2P8la4BQ5uhthGlv1SsiMo7SPi0au48jAbtcOcVJBupmdeRpbYSvLiAHf
         0NS4OL+mrR2YSY4x4PxSUxJXciXuQit9NIkp3hK0URj2KFfPFn4rT9Id6nWtuRwYeEFx
         puDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245102; x=1790849902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ljYElLiaFgzleyw+8UeG+MpsjkeJTPBnUdJ30g4Gd0=;
        b=C5moAeQJRMXwqS9CvaFkKiBQ72ArV9PasI3kd3UrL4/XDIDvmH38Uw+qqZ2Y4daFYW
         /rXuUcFLKGfnbiIQ+DfH7IqBFg6zMkOc89FGt8jdDY2bQmzuyz5vbHd7Hq9u1FO8nohV
         Mk4ZJqtfzf3Dwui3N+7XvOqUi340nBxXcOtKM6AetRXAX1t6DDylt6P2jG+lJ/Obcei+
         BclAgjp82kD4RYVkxt6uHVNO8sIZqNCRf5yzflsl0Pw2+MdJErSD8PP+LwR/JvoEEJ1i
         OoGam7tGUYLNuVLNCSmkTPqo8vZkLgew8kPg8AkKwy2h8ejF1bT0AO2e6CgKbPqgSe+A
         RsJQ==
X-Gm-Message-State: AFuF++mFjvBkSJU2eRzL0QJMmJkxc8Rtw10joDlAh9OBS9rIJI8pdo3a
	4+keoFUBhzLSWPf7Wx8jy5iTQ9YAgPu7TOYHmo2hqP/1tOwlGAe4x4VfZ7jmFg==
X-Gm-Gg: AYBFou3XAWk5SV4ALcjHyXvU4F1+M+GFwhaH/I/oYFgm6wvi8WsGZFbeyyaluy+mVWd
	XOypAMWkSY89CgglVGQIT0eFlpm86pBX47EBURM+miCx7nSmonCLNmN3FeKBI+JTONlDemDopMx
	gkvkvrt0MfeFWfmYY9md+rLsb+mS1KYj7MPdLtr2xcJsJjoGw6NfxBmwU1sEJBex3ULBGa3e7N1
	KeEV2uCU8+VYM75yFpl5XZYX2Xs06GfKvGfDZImVmDgDqVOK/EjZA0vniW2qpIbk8EgjKt/6aKQ
	T07CTKxk8xU4p3bOgxHSMV2a4BQOxGz5/wEUVvO6xE1UveX1fro1VJN7BdC0Y2wznkAzEV/HyUs
	6huW+djs0b0bsJC6l7xpZUWm0+An7TA5rBzJ9SPqxf0NYZbl8Cjg9GW1NtzcOgGkbHch1KTzGwO
	ePYygzz25QYljSw70LMzQiff6CqIUn0IUiU9Qq1diQ9gCuxXTJa4UHk9VAujdN/180cRLto9ta5
	TYjL5uCnMbotryg7oc=
X-Received: by 2002:a05:620a:1a0e:b0:93b:d7a4:9d4d with SMTP id af79cd13be357-93c3679681fmr182666685a.32.1790245102330;
        Thu, 24 Sep 2026 03:18:22 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c29e070dbsm334711785a.14.2026.09.24.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:18:21 -0700 (PDT)
Message-ID: <6ab4f8ed.d869e029.37c53b.9dd7@mx.google.com>
Date: Thu, 24 Sep 2026 03:18:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2673369006387895773=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanli.yang@bedmex.com
Subject: RE: Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
In-Reply-To: <a9adff17461c1e66d645d2d0edb35a05a536e1a7.1790235697.git.yanli.yang@bedmex.com>
References: <a9adff17461c1e66d645d2d0edb35a05a536e1a7.1790235697.git.yanli.yang@bedmex.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2673369006387895773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: MAINTAINERS:738
error: MAINTAINERS: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2673369006387895773==--
