Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351841D135
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959761; cv=none; b=N96w6XwLWU3PgJx9ZAqzEvh3BG1YnBctKY18mdVwu5v9Q8WfrycNY6hgpKoVtrCE3Ku2YGnW7XUVYyH5Mgf79r4yEVePhpKH46c3DFPvKX/Dpuz/27isZyiAg3Ndzt+cP0ZavPDG7vMZ1yV8jH0goRfGLkYyN3c/3xmEHCsOa5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959761; c=relaxed/simple;
	bh=8zByagSuV3YDmSZqbHw0hmeTS6tiag+anEceTDDTBnM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZgIkuNtpZEX7CpORHUI6O7GnwNBqZuz4A1vmbCib4Eb69pBsEP5hornJwF7H4d00nNFF5YIudMMnIVyppJmtzBGySiDw5WEMl8zAEBTJ0u8cMsHD3tuPEH4E+QUJH4DsTtfOXkP2Y/BIyp3oBnlZD5oI3OoBYDww6s0dcefZnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKFNKLOj; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKFNKLOj"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6dde81a6820so494748eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959757; x=1792564557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8zByagSuV3YDmSZqbHw0hmeTS6tiag+anEceTDDTBnM=;
        b=sKFNKLOjWOZDUCegRZWoLBAHFH7WtZpx/BIuTbsRPU6yfdWD2PMy/GeEdj6aMigD2Q
         6GM+2/yPHPYptCRyZxEcf7dUtLEZDW08aFTszd2OsSBB7P4KqSKuSD4LP4ls8n+u2l0h
         eCRz4UDJkfle/23H9gsQi0IwmlqbyoYgF01/ih4P9Foxm8tTKMlEGGLzrvjA6KZzbhGb
         X67yD5/QB5LSDtnLLGRlb8gpk7uput5/E187/dAT/rLyVk3dcPgX60Oc+v4lHjZtjow9
         vQxzV33Y9DO4LsM+SGVTy8/AkUSyzUuKILAnR48rkzvVg5f9T2fEzLstkYwvTfvK4P2x
         FJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959757; x=1792564557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8zByagSuV3YDmSZqbHw0hmeTS6tiag+anEceTDDTBnM=;
        b=dkkcmmusQ8z2er3UBtqEULrR8Wy5wFJ0Wcaxfl1fFMLeTWTlqyGv0Jnlviyfhwbbf9
         deCi17wp4asx45BxPY3ebT4Jl5HjKmCPdsagw6jP2eBnqzeEREAauYXTwQ+NzZBDuC3w
         /jS6c47HR9kMJ/G5vQ6BfSebHybIPSwf1YOrvtIeX9staof7/hvVRBXow7dDkTrz0AFD
         asxtaZlBTFi2Oql+r84HmnJX3ud+9We7PlAcmz06z+BMojlPk2ig2uH1xwAJFeweQlR0
         +LEKCGohJA/Z2P+PAs5+x+MQTmusV/VVnOZ4cSURXl/9cQI342AJeNZrNKE2Wmka2npW
         nSbA==
X-Gm-Message-State: AFq9FYIrU0Z69QNYvSn3wUohBNWe5Bl2lVoQK3pdyoxO9pKpg+CDZIqA
	ntzlUAJOUcG7E+WRQ/N5OPp9zWHaQ2/WC64qRqjHtrNkjrhLi+ovWzc41Ha+Lg==
X-Gm-Gg: AYBFou2dPmkZyul8AxX34FO1okbgl1VEyqLZD9mH3CF2CTje3yCflEPw1sH7P0OeP3G
	PkoZh5Zts6YiXxLNJVuTJ+h1QUA/GUyTKIvXTDalUNyFt9zHKSacDTaX2pn9CkHS51BErQYTYJj
	UumIgVd48EXqOAo6GUhUWUNnivgPPdoSdX9iypJtOwvmJwhlGM5EGrxrpvTfuolpe5NNNmB5vrc
	AM0Dew4Yk6hDxJCCtHbreZiM3JWWLosFm59LjgdXS5BCOxW6rO87n7NXM1t1MuS51oddn4glkQ9
	pqhAC9P1vvSuwU/dq4y/CNif+PcdNWpNtOZ+HjLdOMUZEZqqiLtzhNn0OhVAqUp4PYHGvjv5H3L
	ZXGAsSG3NyaMCbi2S+ESp7IxdeyCqbKDMNoV9fq/AkCcG9aMUbAeRV0TcJbFXZ0ltbwFLVnSh80
	SeUBki+SmEWhUFYeP7wHmhPe06oFuMYA67XWSIZh1oVVssasooP+xy1W6wyWd7lgdUnZOjRwgdQ
	/uES7t2
X-Received: by 2002:a05:6820:1623:b0:6f7:fc58:b78a with SMTP id 006d021491bc7-6f7fc58bd9cmr5124034eaf.32.1791959757495;
        Tue, 13 Oct 2026 23:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.167.166])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83038f822dcsm13995042a34.10.2026.10.13.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:35:56 -0700 (PDT)
Message-ID: <6acf22cc.33fd30c6.2fdb4.9f2b@mx.google.com>
Date: Tue, 13 Oct 2026 23:35:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7293036512496083145=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: RE: HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
In-Reply-To: <20261014051326.3784498-2-dmitry.torokhov@gmail.com>
References: <20261014051326.3784498-2-dmitry.torokhov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7293036512496083145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/linux/hid.h:1019
error: include/linux/hid.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7293036512496083145==--
