Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2614F119
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603158; cv=none; b=ntf8hVV8YQ+Kgrqoju02kBHfDesg7JgQPu1EPAhYKKALVSxupkZ8veAnwutWPHduqSE/X9bIg9R3/8n4l30WBnUwaw5V53ix7A3H775TNuEZg/LdIlJw9fdpGuyBt5b/D4AdolzlS2LohGowCOliKhVyfaFHT5uws++H/LAYbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603158; c=relaxed/simple;
	bh=gDREeqDhR0Bt8M1vSSFA7LJbmHguRhEWkjOns73zGCg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r72WloAk7wWmoRY0RTjbiW2cGGJzUVePj2gQwFmLEweuJZ9DuO+oFuuYgeD2fOQ/HhnAKuB/LSb6eOGjkH8d3+bSyTdxD7oXHIAnnl+Ak7lpkZ88UmpdZrOL4DKzd8hDEk5bzU0fNa0dewIVMBCI40FG/OivE4NIIJJzhufkcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1BS/efq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1BS/efq"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ed3587b93bso2378112a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715603155; x=1716207955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gDREeqDhR0Bt8M1vSSFA7LJbmHguRhEWkjOns73zGCg=;
        b=V1BS/efqKBzGcr8zYL0eyz6Qxp0P3AWYqo7tYtkP+qnBJzU2obl21yYT4Vd4WbSQbT
         Ux5dISXo6L0uMWZr/KZoE9aAcFAmussIoUyBQPfzNv7ZwYRXotKQFPC1VhiHXon21ppE
         ggi6BnXM98ZT98bK+ATO/g0L4eysudR+Jr6mv0AncRXxoFYIzr6xfGSUOP9rvYBTbOqZ
         BDRxSGSr1JfitDCjrEZHH13WDHEZ9mpl45uxbqjev7/zNU2HtKH3RTPE7WLNheW8yO82
         lX/h3wdH+5X/bZTxU8PIIUysDU1usnaeDUw01xltlucyFQMC/uMHBuIJhlc4WozsAdvZ
         Szvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715603155; x=1716207955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDREeqDhR0Bt8M1vSSFA7LJbmHguRhEWkjOns73zGCg=;
        b=kldVFS/iBkJ3uARif4yre3SW0+w8rc009vGQJbgT1DPIBgZvHWf8haslqdpFxJbruI
         CZel239aaeRyGnO5VWv0S5A8bz7slcU9DtRxWvuWzOQtVD9WaOjFOi9bM+/FMolYKZrf
         /xpjXyqttfx+JU9elkg1bPfiLWsudRMoVRaqZ5FhOdmdhuawsqb7O18C1x3DWS0qXd+P
         r8bJLphL8RAAsufu8G2QRo++HZ4NryZk9XZObKgJbJCo8d2Ja2L26sqHOXpjmr+IVs4q
         pfnaQj5F5xVT3Vo9xm/RM4+txtaZMz6XKrNEtNxCAzZww0gMdRYyqHI+G5MiamC8hzFv
         VvlQ==
X-Gm-Message-State: AOJu0YyVc1sWv+zP1EbMCPDZ8Q1aS6gIpWVcYZWex4ocXCZKDf/Ej80X
	6J8L5kn05QxtfLBWIWaJmq0jcgoWq6CjY78+hd11C9Eb84xkNwiucojeDQ==
X-Google-Smtp-Source: AGHT+IHfZ3V1uFPIrRCJnV3aeOLu5viR6PKI7z++z5En15HmRoNJOi6CNCbub3g9FNg+i0K2yF3X0w==
X-Received: by 2002:a05:6808:23c5:b0:3c9:92f3:d519 with SMTP id 5614622812f47-3c99702c90amr12325517b6e.4.1715603155382;
        Mon, 13 May 2024 05:25:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.88.15.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fca1dsm449948885a.92.2024.05.13.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:25:55 -0700 (PDT)
Message-ID: <664206d3.050a0220.db919.cff3@mx.google.com>
Date: Mon, 13 May 2024 05:25:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2435950741624620286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Create transports for matching BISes
In-Reply-To: <20240513115014.36484-2-andrei.istodorescu@nxp.com>
References: <20240513115014.36484-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2435950741624620286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/bap.c:1092
error: profiles/audio/bap.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2435950741624620286==--
