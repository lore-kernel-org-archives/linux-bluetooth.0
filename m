Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5E1AE872
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646864; cv=none; b=ECfMj7i1Mmv+LJgfUybixxJqcekJQoAYH6WjBZuqkWSAlTNtpad07bdz7x9CbI9+TlyfvwUOThTNIQOBj+vvyVh0HxbAnKht9MYEfCyzv7zVpAlyVyAEW8uNxLG2JGvNpaBRjfUXyHjh449zjNDqT6RTU41uRlNpzKE03B2odAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646864; c=relaxed/simple;
	bh=aCwZkIMnmJPyhTDi4HCVc/7yavqEsiuj2fWbjC+gry8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nn9zFuz8ZQdkgFLpd19ChIsJBTYmEW3F7UcDVihOGHmPHoRd4votdiuFYLow1fHyTPm09a5s7j/eWp431wE5bIcUZQRzGocOark2ECaQZRG1ke1hcQbCNyLdUVN07hD/IBhydp6Y0GfNxnswmB2L6FXGXuxI9BmLAVlAPpU3VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asl8J2GK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asl8J2GK"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so87540201fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723646861; x=1724251661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrLuUkNcD1e+oLPWsNWK6e2mB9DmjlBJOmvVndzBTfE=;
        b=asl8J2GK79+NkiLfDq1q3PpiePZMIX3PFBTxNn6rNuuMOk9UAk77k9xCwPA4nta0ge
         ckVWh5dF6UD+dEFSQDry+rBUBpRRV6Tbfhh7lxW9MMy/ME+ykKdAoldZkbxqhjZay8oE
         mdQr0w+z2xVYYhUZrom26mitn7mVJ91wpRuqUHim3sfm5olBfpXJD3QpQhZPeU+h9dTa
         YBbMtHekt0IDsOv9/lrU+tQc5rTtO+C7ZQ7zrCJP3RFl3Q/iovwQDq3lYC5Kyjb0nbRA
         FLsY/7HQJkP4qRclcCCFrNshdXaR2gCeP/H0xVxoPfUa3YYh75dX+arzvs9X1xH0qtio
         ++nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646861; x=1724251661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrLuUkNcD1e+oLPWsNWK6e2mB9DmjlBJOmvVndzBTfE=;
        b=mpFvJnf0i99QMAfq5a9WqD169g32isP8aLPq0FenUy74pYrdt8oPHIb2Mzj6gcYEvp
         peyyRULFSWOa90Y/XmVbqT7A1JTYVPt4fQOR8kIwQQrd4q0hkNX/ae/pcO3fZ+po5828
         HJGoU45BD2G48kZvBwIDG9koAiMvcGDEZc1NPokyc94P4RBm7rm0NgEXIC5FoaT3r6IJ
         FX7dKxnhttThN1hzNnyv5SuashQFR7U1nLf/pEpKb62Evst1ekMmcmb0bKb0CncRnDi5
         ZCl61t5JHOQjlUFSi4hJ0e3bOsh66jOPve12ScpQyJYSTv0RonGx41O/ejzvXr0ghuzk
         0xAw==
X-Gm-Message-State: AOJu0YyKu9DwjK60IdRUJWrfpVAuqB5z/URqrc8nCkHi6MpiczDFb5Sd
	wJQnwL2b5ccblhha/JLAX5pcyyhvIFNmCH44YvWqTqdAjAbSDmb3m3I7QJf/wBO47vzgzaqP2ee
	WMAZzEFXg9v4YideznIDg1rUamwkNXp0S
X-Google-Smtp-Source: AGHT+IFzZ0qlTvrRTW898Yu5b0aSI2tHdzc5HgszqRtjg6uWSS1e2DiPMv9/SaIoqWWdCp7Acm5yRWNqKcTwEPLJ+Ao=
X-Received: by 2002:a2e:a99b:0:b0:2ef:243b:6dca with SMTP id
 38308e7fff4ca-2f3aa1a3ca3mr24331291fa.10.1723646860229; Wed, 14 Aug 2024
 07:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172362641171.1463.1558884635182654862@lain.khirnov.net>
In-Reply-To: <172362641171.1463.1558884635182654862@lain.khirnov.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Aug 2024 10:47:27 -0400
Message-ID: <CABBYNZJ0OK=yfrzFneNXBD+ye8UF7w_5pLJah+Fyfr+XHefLsQ@mail.gmail.com>
Subject: Re: monitoring advertisements from specific device(s)
To: Anton Khirnov <anton@khirnov.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, Aug 14, 2024 at 5:14=E2=80=AFAM Anton Khirnov <anton@khirnov.net> w=
rote:
>
> Hi,
> I'm developing a program that needs to monitor advertisements from
> a known LE device (or several) and take action based on their contents.
> From looking at the kernel code, there seem to be two relevant ways to
> initiate passive scanning:
> 1) performing MGMT_OP_ADD_DEVICE with HCI_AUTO_CONN_REPORT;
> 2) using an advertisement monitor.
>
> However, it seems that 1) always enables the duplicates filter, so only
> one advertisement for a given device is ever reported; meanwhile 2) can
> (after my recent patch) report all the advertisements, but disables
> device filtering - so userspace receives reports from all devices, not
> just those I care about, which seems inefficient.
>
> My question then is this - should my use case be implemented by
> a) extending HCI_AUTO_CONN_REPORT processing code to allow disabling the
>    duplicates filter on request;
> b) extending the advertisement monitor interface to allow monitoring
>    only specific devices;
> c) something else?

Have a look at scan.pattern, it sets a filter which can be either the
name or address using active scanning, passive scanning is only meant
for auto-connect and depending on things like LL privacy being enable
the host may not even see the advertisement reports since it would be
done using acceptlist/whitelist filtering which is done directly in
the controller.

--=20
Luiz Augusto von Dentz
