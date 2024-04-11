Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96213C806
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816192; cv=none; b=mSVZUYZiAFyMkbkgW97LpDfk1wsVt8grfy7QPXZU6OMaeZxtR07ko1U/BiGyjmZzS5PaCuZXskKDqRqKF5ulMObsqdFRlkZyT/XM9FHktrCWmzs0WXeaz9NWYbJZRN4bo+49+K/zi1SPyk1u9IKnRZPY+gb1Gx3nIaYTJPK82Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816192; c=relaxed/simple;
	bh=TPHWmqJlvUiqAdTD8Y5w3cXlg5ZDfj4qDwnCNcIbD9Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dQs4FRCPG9MjVnrByJU0wgmws//MIZC+zwdCQslf6ZTJj/TmITHiOBHL2KVd4Aw+4/IO/UeCUVQHRhCiZBM+b3dHQzPaD9FUPpmJD7VoU1tIyPSdUBhWAhwNSDp+x+q95m6X/1As40v0iqLrO0wSvxPXiDCvV8hNTk91QBb8ckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdhkCDcL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdhkCDcL"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6164d7a02d2so81538467b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712816189; x=1713420989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TPHWmqJlvUiqAdTD8Y5w3cXlg5ZDfj4qDwnCNcIbD9Q=;
        b=BdhkCDcLw5vX5V6pSagSOXvUdvGs5Sm4VgX1uVCYNwX+vvG47vbcYmFTKi6YLZtxJn
         pYtp8oNY+hoO4xbq9//UO6MAie+/G4pCvfnCQpM6Ly9l13GRUL81VN0eHm+GTfOPhhl1
         dwqMXGabaSuo7YZT8PI3WT6Qd6d50Q2GkmLriJGU6nTFlriqM6P9OPqJ2YymDtYZRRoY
         /3lGWkelMP7Eoiw6DYgEupJ4q0yyoOwGHwxjj8e5ruUk5da9HK3oPzKw3TPmd7Le1dlA
         9UtKzOKyYQUZvVbety4pudsxSAgWXG3UZgWaeQuZiki6frDze9jWqPYPbjdfAuufMfKZ
         khoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816189; x=1713420989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPHWmqJlvUiqAdTD8Y5w3cXlg5ZDfj4qDwnCNcIbD9Q=;
        b=NpMOkClYshHizhuzeX76RAEtcZqlq55MkFphZunSGMKbyPQ7Q1ywaCRU8v8RQ0wFye
         zIFyL2MYCuNLlQobCIlY66LZfCpT7NDuTIhaSQSQ8ZFBnli5eO1g0vJ9G+TIpiO9NwfS
         K4sU28gzWDK0KArzHfKU9Hl5qRKMJn7N3UvBTPhFAk4KxpsVX0tIxCHiflPQ7a3OAQoH
         s8My9nU4Xr9vILir4To/+YbkVHOLxqZ/7w2ojPa9yEbuzPlxSb2v2hkitAtH9v04Lr0s
         7tNmgf2/W5+EpmkZ2ol/NreMifHG8Zanqo2VfBEYqSrbWJ3sb8/6qojfSZIKia2NFJg+
         dmRw==
X-Gm-Message-State: AOJu0YxFPQQbmptYMKn53T5Jyb3tCUFjDagW1nqSt+bnJCJFf1wdsd+k
	R1jgssa48kTsCc4hPTSbTTP4wAoiAUo3I6Rl7oF8IAU3sJXlMhuVcHiiqg==
X-Google-Smtp-Source: AGHT+IGxiJyftm7fMMpNgaxAF2Y3bkgRvctTUo8jsnV/2Pijcd8Mkrzj5O3vqaNLKtkEvt8ixyhCwg==
X-Received: by 2002:a81:d248:0:b0:618:4b9:7811 with SMTP id m8-20020a81d248000000b0061804b97811mr5288724ywl.28.1712816189676;
        Wed, 10 Apr 2024 23:16:29 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.6.27])
        by smtp.gmail.com with ESMTPSA id o19-20020ac84293000000b00430ea220b32sm510913qtl.71.2024.04.10.23.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:16:29 -0700 (PDT)
Message-ID: <6617803d.c80a0220.fde38.10c5@mx.google.com>
Date: Wed, 10 Apr 2024 23:16:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4677002392343661749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925. These HWID are used for Windows NB. Enduser may install Ubuntu OS, so need to update.
In-Reply-To: <20240411060812.16394-1-jiande.lu@mediatek.com>
References: <20240411060812.16394-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4677002392343661749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:616
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4677002392343661749==--
