Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C352F7F07
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660187; cv=none; b=JwLW6CQdpVKlRt+U2aEuOflxWJCsaXczpRyrcyg9Wq/G+34cZOCSMHbkQDXn4Gs8x97XFamCeBNSK1EJb3bchVgJFSIt+0YF71kd27xStmnC/kGXl/32lF1Pp+dwoxVwLkjXqmEqUzz1a4mGoZkqdwFc2Z6v/RggqjWWHm6qZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660187; c=relaxed/simple;
	bh=wpRDLg8HV9EB+NTqpbTZg1uPlCy1IaeeRaQYYqiLkgk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R4OUE6UnlN3n4HhAOc5AvAd3Kk3fPyTxvmGWHglYwc4NHB/iY++EWW/et0hPwHFaH8iSlmclRI0QMiogxkAHSIxeI/ST4hIz0WUuSgl49lnwHtX2SZu8w6QsmxaTuivLb7oS+ve7CvhcCnhD6uwOmuLSkhsWx8HcwcHUp7UuPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv6Jy9r1; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv6Jy9r1"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3550c917fd3so1099598eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791660186; x=1792264986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wp9bQj/07bVzsrUwmIXkn8UYep/WWTGzd3ynTv2OHII=;
        b=hv6Jy9r1VJviCwJxJNwDwLURg5SvdHTMRUIrVH+pYI/5IR+qoE8oSli8mw58zn2bj2
         hX1JPH2eYY4FFL1mj+AJj3dJotBFZP3ihWRe2k9aJzG7BtGtjzopWPpvCji6u33iSppa
         uhmJCLAXUPJ5qWLivoSXPIGRznlJtV6uW9gdlZ6NVz2+mbOR3sLiw2ptHh8mcvxekbV9
         Ux4JOIG4+m7dB133YFYOO5GST+zkdtQDVG5+9TPrsyMXQC3BIKseCYrvrm1FYd/HhJqB
         FKbfj4B1IWuBMZPz+HAjO9Zn86EfuIW17D8/9rW7KWkjvqMImIOZ7Oe9L1Oh0xXy/all
         G28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660186; x=1792264986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wp9bQj/07bVzsrUwmIXkn8UYep/WWTGzd3ynTv2OHII=;
        b=Vx5RBc2M3Ggv+JthxkjCl6g5RtXT8FxOY+lpDDmyFAIxa0rECSWJzH/kg5a+EVYKsd
         6WRpUZNU7d11omH4MNe3k6gWDsZUxiBsQO+EAliY3NijL8u0H3aF/EGtMw4nJLqz8Rct
         yjFQvWrfnd+zgmk7tkkyinUyaE1b25en5wiDVvJbXGhL45/oMVYj3A7+jWnrdqG8WGuo
         mz5Mig+iwLyyDRygDoqFc8AoE8sS3DPBtGfy9WPsN3dm2GeM4I/cpbkxiLLbgF0ZHHgG
         oIa9tgzkWYDveLWPnXBj6xJTXSuc6KY0YqcKBcHGhNqSM94cvgB2/4wJ8Q/O9b6TVsqC
         bcQg==
X-Gm-Message-State: AFq9FYLRRZ7vzojM+fpifYrDE4NpMELyQkuI7KZivbxPG0eiPOngSB+2
	jxnWdSVVKHwZyeeA3+obyXdOFA29phLrtZ7VunrhsBr7AW7HkmBXxfo4wMijiQ==
X-Gm-Gg: AYBFou1bjnHDe5iv2rqTDDYS2hCgPb88nSiRWWc9k9S+swBN+Yt30+r89b2BR/4/icd
	lUBnsAVInnD/pYk8jXFStKwRxLSzq0LPuBr/4q6VwrRo/Oe55HF7gCRv4ixCGVgs/JHP0QRSNDG
	99W8nOVk1dVpJUY2vldsnsx9avUk5SmxgJP4U8cpPN+j0I0Xz5DSK/MIU1ywX2jlrNulzm2o6TW
	KQltNdlf3lHBEuYOwC2ycHJpvk+duN5QEW/WBkzCgERnX2cnz6ymrVnOzxEyJ49YUTxMxKVkRtE
	CJQKA2dy/3G68XIX9HZVXNoSP/yMwS8XNQKA/6pvg6kX67WX87JkEqjl7+4ztq3R1isB7kDjbbJ
	EIRGVW5ndY96l2JCP5mv/jmB7xmtDPJoVrKYrm/bSgl5rXtK9xOTcc0/OkEuAoPwkWmb/9nk3BC
	pme2fYgKyenUIG7ye8sIvEldX+kLESh+jE9rHQ4Yo7mTkRlZtatijY3Jlqh6ZpeNj6FCbQRMkQX
	d8+hg==
X-Received: by 2002:a05:7300:ce94:b0:328:7033:9b8c with SMTP id 5a478bee46e88-3537e03331bmr7583774eec.6.1791660185485;
        Sat, 10 Oct 2026 12:23:05 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm20607302eec.0.2026.10.10.12.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:23:04 -0700 (PDT)
Message-ID: <6aca9098.82a2a138.123ae1.9614@mx.google.com>
Date: Sat, 10 Oct 2026 12:23:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3039579771538064069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ooonea@gmail.com
Subject: RE: [BlueZ,1/2] input: Reset report map state on detach
In-Reply-To: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3039579771538064069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,1/2] input: Reset report map state on detach
   Pull Request: https://github.com/bluez/bluez/pull/2590
   Created:      2026-09-25 18:59:32+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============3039579771538064069==--
