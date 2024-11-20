Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53011B7F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090934; cv=none; b=Yahh5uXFw/vvldEucbARBqKHGMeY+ZrShdLbp+I9k/hNUfVJmFlGnH7dzJmK4GEeCDOyPu7ERlhTpU/A313lOvitNdJT6v4WncPfbnerEles+AdsN69dUUcFRnTcqqUOSISlOKscP51Bq0EKdMfCeB575cAYsNa5F8xb8tEsM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090934; c=relaxed/simple;
	bh=SQDFxHYt15TUMARvkobkAzpCJ2SDE6zv05d/jYENCM4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QfSMzBCHNL87jCUkvSuliO5AWlrtyBiuvXTCXLDxedE20+rwFbJWUnfJh1giFDUpjIyKCuLkBM87rXTo3EEeclxhZ8duDGTWc4kQjQHhcus1u3+yG3cmYiOt170m6F4XyN3wMUsF/mY6qevD4vFSjCeixTJsp7L4UUAR3P3MHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD74LnI8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD74LnI8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b175e059bdso256842585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 00:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732090931; x=1732695731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SQDFxHYt15TUMARvkobkAzpCJ2SDE6zv05d/jYENCM4=;
        b=TD74LnI8AwVBtUkYdcImqgiOD89dP8qigjCoDSNUaIX6IyxvOwR8AQ0NABh4El40fk
         E0qoX09qIKCdvrSZB405xYw3/Cc6C6uKS6Op0zIMhKkuMkIyTPXO8QNvCAP8z4WjzoAt
         uu7mSXQYUJQhpb+ic/vq2D7BO0GWA+VF6/rVKtMvtaieqt89K0wDSFpjLMT6DP5mNgab
         mXoft+uh9Ki4sWP3fL2ocdLF3nFg7dBOYdL4f8IPGRbL+kCVRk0ktsg3Wm8adqT0vOgK
         7Ee9WKIzax9ApqERicXT2MrKApTzlyVCvHGC3xreiEC0VxAkUE0ZbvOveHGl3xYObPTc
         os1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732090931; x=1732695731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQDFxHYt15TUMARvkobkAzpCJ2SDE6zv05d/jYENCM4=;
        b=Lb0Wp4dJ9uBdbD8EpF8Greo9bmm7eA9gLHw1KjQbxc3WcL97tLUR7goHjYErSapQ2W
         lga6LVmNs5xzsM4I2tWLWRBcI7J+69SI2yR143RxhYONuWT6iGs0zCHXF7HKAvif5jcE
         a2KOBPwGZEIDLZ5EjuZZhhdQgoHJskbagsrjmoFxzGXdNgIhLjy1zr3Otr5xALTP9oaF
         qkx4yzWdBkK4VwrjNGee4RUWGlZ6MKWp2Hvb0goMh6pf8xzkLfFFukkRz9TExamEI2G+
         MRwtaQMPxE+1Rv6u5hrJtiarT6VLqOD/vmhCfmgAkh3IpxUIGUB+mZTtjb1HSdHQzGD6
         lxlg==
X-Gm-Message-State: AOJu0Yy5erEsbdpbhAxR9aTOiIeg+a/QImA9wvImUV0Ghnri038O0RUV
	gOO1TpWZ/SdPXz+yvELRyy2zrxQZde4VzGnXUElNvE6pEUi03o0nMOM4RQ==
X-Google-Smtp-Source: AGHT+IHKEH5qLyO71SwjiQFNN4DM2habHptH5EgYCnay+nTlt4wE5EDI1SmdZTv44TAt5yr/UOdOrw==
X-Received: by 2002:a05:620a:440a:b0:7b1:4536:8dc1 with SMTP id af79cd13be357-7b42ee7cb93mr214386485a.62.1732090931538;
        Wed, 20 Nov 2024 00:22:11 -0800 (PST)
Received: from [172.17.0.2] ([172.183.130.203])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b485242f06sm67250985a.99.2024.11.20.00.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 00:22:10 -0800 (PST)
Message-ID: <673d9c32.050a0220.1eba9b.1322@mx.google.com>
Date: Wed, 20 Nov 2024 00:22:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8670967993711629698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Subject: RE: [v1] att: Check security level before setting
In-Reply-To: <20241120080447.233393-1-quic_jiaymao@quicinc.com>
References: <20241120080447.233393-1-quic_jiaymao@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8670967993711629698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/att.c:727
error: src/shared/att.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8670967993711629698==--
