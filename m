Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23842BE7BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203833; cv=none; b=h5uJPESKBhuClkUfKPmFVusu/e4lZhsow8D7XTr9WmlpBkT39SvbMaZaie1aqi/i8WRcysIMeDh1LjTKBSVNiKb0iDYDnIWtZptYsFnKX5H34pLVhP8v1z3epfhBiLwQ7JQbVtWYQwmmMZrqV2IZ8ONkQ1/WKPGaOn0Rw7Zeqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203833; c=relaxed/simple;
	bh=UcfRIL0H4QJ3ztPBeclZ6vT5z+TUNJpuI9J0HMuZOAM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YmnTzj+s/r9JN13T/7O0eJ1RoJQOF0FzuPsUXNYj805SdCSTSGsZux1pdTQIvwWpR6iZv5faDT+RxZ0x/NUyd61iEQpCwSFKBgtR/yzaXDbr2IvHCG5YuvU7L5h9EAVY0WqX/JwRILzComHZdv38cUAqacpPbe6lPXI2Ymr0f1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYntroZU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYntroZU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso423907a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761203831; x=1761808631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UcfRIL0H4QJ3ztPBeclZ6vT5z+TUNJpuI9J0HMuZOAM=;
        b=RYntroZUprF9FFvus6+bq/cRQVveuUDlq3VVS5tZ30YoyBSqiLU9ABKcJSvBM3gEV1
         BSFaEClA4YW5PwlP7p9iGxxgOKrJoSGFvuY+/jgOpF3Dd3TMYcaIqcs/41k4thGXqh0D
         bS3O/OPjfrJRk6MsCM306MEykJlIsHAiYdvW/oey6WbaHldbE6Kyejg5jd+Y/1vlYezy
         v0qn+NHfKToOiSJnT9CA5XzBChGaDAnZZdbpJMMiAgQekphmTcn0Cy79HvuyDO7TpYiT
         iiOKtOECn308FyLr63AC4mIDwdhDuqgKaxAn03Cf2C+/oD3d6RxHzdlWau9VNAYG3vmv
         8Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203831; x=1761808631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcfRIL0H4QJ3ztPBeclZ6vT5z+TUNJpuI9J0HMuZOAM=;
        b=Az6OAJuS2mAp8jlCiGbinBXTozPaRWA+KbcBwANuy1z3JsexFZ3epfzuxbXJHua0rQ
         siZg2sXo0r9+0hv/HFaVTsJ5xPjlt6Kp3iMsJ32RRh5AO3w15uNHuEg0VhWdkpMhqpku
         6Tty6Em4WygfgJXMddxou99BP8Rx7RU9grjcsknS54uyJTDd7K94zWQYqdSSQbe1Cke0
         Xb0v3DR+ln77bhy7JbtYIQZN6ebq8MVpmpdPNHO348yNhqCoHxd/Uzz+V/e6Of8CI7K9
         X4PcBgaAw+grJzoTQoJaCKwYrdf1ZsS5/l/0X4nYsBbXIDiiq8NDSZBcrM/RTYB+mAHY
         nYZw==
X-Gm-Message-State: AOJu0YzLUPmd2IzjUhDzSxIiy01QJs5IPYvzxbq8Ur03aql+iCuaKu7x
	aGEv9hHSvy2LgVxsBRSXZtGj42aWVj8/3zQU6cKoFDuHdlTM/RnlD6WqzY99cw==
X-Gm-Gg: ASbGnctMzzM3hxoFe2ZwZV/yUN/uqurMPz2198ARZh+FjorxGayGFrj1KpWOh3wgSz2
	uybpiXocdtuv7ngOfCqgPZYwOf6Jv0zKf8u2OoEifM91uTc1fPDzeFj8R+locOK7zJEtAU5N/2K
	A8S9qgxsUo3F+SzZMQ9eR+EL9NLBeHwqSObns6nQrOa82zwzJ7OSrD4S6IqfN4SiGd3kHjqh3Cm
	y7dSqrIdX8rvOsYfZq5jvSh13FRbyHoPJ7Ea0pwfNKRQueCzw0vVgyLeQ4r67csKUU9fPL87zgN
	Pla5WFDsMNnGGksbhZU6vi95we+H+lY1MFsdCFTdHKmxpkcMmQKIuWaVU52dLaclQPf1d46yWVm
	eMIXKwPXRxEyX9JPCUjWZNtqKwIT7V05J3BjV2ej0homcgOJmdOSt1nFygJc7Gmm5U701AW0791
	rS0Z8hjNBtpn5lcF3HXA==
X-Google-Smtp-Source: AGHT+IHxUunfQC96BFI2yDiBw0/BMfJPJEgOu6f2Q0hhFVKQ8z0KXeYYcVpEN4zaTpXnKQJK+ELZeg==
X-Received: by 2002:a17:902:fc4f:b0:25c:982e:2b1d with SMTP id d9443c01a7336-290cbb474f7mr310853335ad.59.1761203830394;
        Thu, 23 Oct 2025 00:17:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224c9bd0sm4705670a91.21.2025.10.23.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:17:09 -0700 (PDT)
Message-ID: <68f9d675.170a0220.16fc.5ef0@mx.google.com>
Date: Thu, 23 Oct 2025 00:17:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8814294737800206639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add the support for RTL8761CUV
In-Reply-To: <4c38283c501d47a89a5c5d3f731de031@realtek.com>
References: <4c38283c501d47a89a5c5d3f731de031@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8814294737800206639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btrtl.c:1301
error: drivers/bluetooth/btrtl.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8814294737800206639==--
