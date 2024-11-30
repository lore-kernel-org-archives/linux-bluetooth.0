Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF84087C
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Nov 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732971584; cv=none; b=QtaRATJdd5rKkNMDyv/hmQ/iR5dbVks9SWqayYuzPuigxuwPYik4YwpSKIib+9tYJjiQREWJTfoN4fYQ5LME9SGmrkN035vSVVgjuiA3nUnu1BsrEHX/UKxlrG2rYfTB5S7g60j6DYFxxsZx5UTFFmMTAihhoV5lH8xqY64xH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732971584; c=relaxed/simple;
	bh=Z6x7sVF4VKn6nOD/5VEABC1yN4T/hfHkSFud9xFkb1o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tc2iNhxgJ0c5pw44qE7OBCusCmJO4Jj+0o7UDhKsDKRcyLhzebNboXIPooKvlgaMcNmcfPu7UUhzXLDLNM+YXfPsIMh+hIg6TAG3SjCx+T4tTW6v2CGc44wcYskdNr5psEdLY3wvPHP16XsO/QqhkWm+CQTFb90Sc36k1isdJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/AWwbnE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/AWwbnE"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46677ef6910so17874991cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Nov 2024 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732971582; x=1733576382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6x7sVF4VKn6nOD/5VEABC1yN4T/hfHkSFud9xFkb1o=;
        b=E/AWwbnEreI403KlpsdiAImxAMftxr1A1y+24CcbYrd0/X8cTNScvvMi7QZuqXO9Pz
         t+dUmKgssK9ZErtfQoG4wkCdE1sZjDvBwjcPuZXCv9wLGuRvcUP2iMTD4lyhgVbGEear
         vHVbz3pDEb+Aoch6bvnPs1waJJQFKV5Jmb0uAupNMubaEIs6dRIEahHR+/4+CHXBtFHZ
         CenyFVRpmx83MAgGmtkCVgEhAJmreUGdFDbD9Yrw4tckFaTuGAZ1fw0NfT3YXK8cEHWq
         PkaSQ3Hudw1JsVh06a7204gCmt9OpfGpUbkpoTYXFGqMYry3ajjDVIJTFfNARjB9ysat
         1mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732971582; x=1733576382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6x7sVF4VKn6nOD/5VEABC1yN4T/hfHkSFud9xFkb1o=;
        b=coyHqNBgIAWSp2ppwtLgu61C5LUlVj5DE0xRM2kWT+jMAFIv4C8lsMjlL64+rf2vzw
         3ua7VpVKmD7KLhm1c8EvouGZGws/2727SAwve2OvPMyX82qPreDexI3INXy054ppuy7/
         fbsBURdnlJthn+SlAwgMCn+LDLKyKtirH5muPiV8zhc7vMUmaY5xNrKNIURo2Ds/cqm6
         wrQV72nE75X9XXEx1g5djNY/YTJSU0klSDAqrs1zWz9sPRyPgwTEwbLYDBDMFFbtF/hv
         zyKtyF9bFSp8j24detDCKOQbcoepdXKumIYoYZ9sJvA8X6O+0g038uFTZ2hAQGyhu1eb
         UVvg==
X-Gm-Message-State: AOJu0Yw4YS3y27G9sKLzmwLQSM4G5i04rtQ7bhFLDah3pP3kKlINmfVB
	f5loh2QSEXOuLda+xCGwbJU33qB8ASOd02pteQ1o/VtLbB8s/o2cAUud/Q==
X-Gm-Gg: ASbGncs316Po/OVYxTp0DWInZ8FJgqW74HQZt5zgmf6SQJvuHP2pHI3Pmd7dVY+RUhT
	MU7BNePkNTASMISMi8jpshQZqDOyA2AKnBI5WqUMvg/xU4OVHz0vSbApSroibpZvNMQigscxCwi
	zXVa+kqXNNSBzzSBqQYfpVIKO2evF2Dy4v5YHML1NMKHXYNeBixiMPC/WklI/fgsenyzt+5vKvf
	PU4LVXwfRfAWg4t9gSAFABo+T3vpBhiczhRwHAHzHhq5GoJ4Fz64wHZKQ==
X-Google-Smtp-Source: AGHT+IFs0TH7f4njmgWhtAD85uo7tw011GfMMnQ3M4GLxT8Dyk50cslowoamzm0bNjMFclKUmpxodw==
X-Received: by 2002:a05:6214:48d:b0:6d3:fa98:cf4a with SMTP id 6a1803df08f44-6d864d8e7a3mr186664156d6.34.1732971581652;
        Sat, 30 Nov 2024 04:59:41 -0800 (PST)
Received: from [172.17.0.2] ([172.183.53.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d897d4c5f4sm2803296d6.16.2024.11.30.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 04:59:40 -0800 (PST)
Message-ID: <674b0c3c.050a0220.263fed.0851@mx.google.com>
Date: Sat, 30 Nov 2024 04:59:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2940778285973238686=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n.zhandarovich@fintech.ru
Subject: RE: [5.10/5.15] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
In-Reply-To: <20241130125457.29343-1-n.zhandarovich@fintech.ru>
References: <20241130125457.29343-1-n.zhandarovich@fintech.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2940778285973238686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:4751
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2940778285973238686==--
