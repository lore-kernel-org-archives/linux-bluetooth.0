Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452C3A7F54
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807445; cv=none; b=lCldfHdgp8zBoPArROTbqb3F5BmmYg5+HXYKr9Ox0cniMMcKIDuMlDem/bNXo0muDmeYR/kT4CiILtrU1NnD7hSEPKG2d6vpbXIxb8wNC7uCVHTjzxZwLtz2F2hPBHpZI5VKux2+yzXUbKLUwSlPtM76klb9lKor0B1+YPwVieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807445; c=relaxed/simple;
	bh=amRYf8gEydXnO6PV4BSQzAiPWhS+zAdCysmV2muCz5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCSX4GbqLtUAK6Q8jMdkWN+0cPs7b8q+fZz+9+Qpzv8lQ8QG0yfvCwm0z9+d4WQVsfHAD91gm9ngF6DlchnjPLHhQJMBzeeM6adsG8wTrB+EkuHB4/jWUrLsuPlnaC51pZO3xAwU9xpQLQYmgBCMxYU9eWV4bDFNYHB0Yjo2cTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVeKEqXa; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVeKEqXa"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6455a60c12bso2224032d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767807440; x=1768412240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amRYf8gEydXnO6PV4BSQzAiPWhS+zAdCysmV2muCz5Y=;
        b=hVeKEqXatWvIOheO9X5Mp7dKRWzSY9zEfg+205jixR7YeKnDRJM+DqhnaVqM04jQ5G
         LOF3ODTkU59EITqLWxWuxyLFu7oZqykLyE0lX389tAzjF3rdCdfOBl8w79+UGTm33ma0
         F1DOulZYo3M8k+LDE/D/cDk1RUfhFH6saze1vUqUprJsYHci+syH9fBaPqJrpXiu7St/
         L2jlYck6JkkoqE77p/3aitEDa/YZe2y7XoLvtZnGlT/ws1v5laTczUt1BHEqGVsehj+W
         CTyUhUH4cET1V+U4snr2UJNR6RkN/urArvRVrdRnxDcqFd2+3CSeij2I8RhWdGLnw1Do
         aAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807440; x=1768412240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amRYf8gEydXnO6PV4BSQzAiPWhS+zAdCysmV2muCz5Y=;
        b=jjIHNuA49IjgjNipcKk7KR952TAK8bPqkpxNFhMHuf7EyrapU0c3uAMEnapCXtEPiG
         fcG8XCJ7+JnkbMr98DVSqkgpgYFMVFYACuFGFSGB0xdvn72I59xEZLVYYrmjx7v6x/WO
         ov0/ofbukc1YNvGiH62kQFSEqaswA/H0e/Ql1ETYIFMBNaMh86uL8NeRMN5EyhkAF4ir
         xTfjbB3STcvZG2lIPps+RVttHTc1drIy7pfzcF3Pv6EN5DWutCG7R2VH4LRCYOCBXLgE
         jOTUqtaG23uJjmGCL+3wYVLi2wOogFUSpcqx12uPI7NNN0lnAsjtzMmEnq6keWGXWZyD
         q1JQ==
X-Gm-Message-State: AOJu0Yxj/1lM75pEVa11ufqBQ0e0HD3QvUZDG2lFBY+pkQsbB8EYeCMb
	qIMLkzBOwEqFvN1k6QrQNEKvxrHU6om8zUdRMnWEfNtIXBAI0x+k5cG6y+ALmdjqKtxIGaTlLz1
	34EjHY8QNNqMV0rLqkB9wTLcDAahcXerUWA==
X-Gm-Gg: AY/fxX7iTigmUwCHSnW0phXnuXonPeCcqDnv+SOfpQkzzGC0z867n6cptusMA0EJVqU
	yMIzLbG5Z3Xs8iLHnpKNKvq+YVqkp3sCa41xMRdx8m1bDWuYewRuhF4H6siDgYbyDI6WV0l4OQH
	xzlh1DXQN0yxKKUVOBbZ0eQM5A7i5gogSyizif7a8uP6AnP4aFrQTGSgmpf75s5fIV+mIvI9Djp
	IoLhgONuJlFW98IUHVIfn8Wr7cJWDD9dSsNlgFOKtXIkh2foM5jJLuobozPe4a6GP+RXv2dofTC
	ZrBSd6LEaVXT9TdDpmzUpySRYx03SWZQVg9ZF6mDHyiNoq3NEF+WOHQBig==
X-Google-Smtp-Source: AGHT+IH0GnRsHA9gRSlNYc6R9FaHK6so5r/dtNJRBoTPW4ls0oqqrY5dNcKSN8lwyB8bgnEUbZ6Np5XEn7ET5rs8Xa8=
X-Received: by 2002:a05:690e:24c1:b0:641:f5bc:6995 with SMTP id
 956f58d0204a3-64716c79edamr2297984d50.81.1767807440281; Wed, 07 Jan 2026
 09:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3679882.dWV9SEqChM@n9w6sw14>
In-Reply-To: <3679882.dWV9SEqChM@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Jan 2026 12:37:09 -0500
X-Gm-Features: AQt7F2pUegSgktgB-VxzzkOSZOjskpBf84g1M49al2cr35tCp30fqyR2-YS9mBA
Message-ID: <CABBYNZLYn1=3WgVujb9nLdXNrfmDxo=uQvPLfZHgmABM_MiRtw@mail.gmail.com>
Subject: Re: How to perform Bluetooth SIG qualification of a Linux / BlueZ
 based product?
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Jan 7, 2026 at 12:17=E2=80=AFPM Christian Eggers <ceggers@arri.de> =
wrote:
>
> I feel that I can't see the forest for the trees...
>
> I am in the process of performing Bluetooth SIG qualification of our
> first Bluetooth product. According to what I understand, an end user prod=
uct
> (Core-Complete configuration) consists of a hardware (controller) part an=
d a
> software (host) part. I already have a QDID from the controller vendor,
> but I feel unable to provide the QDID for Linux/BlueZ.
>
> Of course I understand that Linux/BlueZ is open source, so there is no
> company behind for performing qualification (But I found one qualificatio=
n
> for Zephyr OS made by Linux corporation).
>
> So do I need to qualify the concrete version of Linux/BlueZ myself? How
> much effort would this cause? Google KI mentions a tool named
> "Bluetooth Launch Studio" for this, but visiting launchstudio.bluetooth.c=
om
> redirects to the qualification workspace.
>
> So how to obtain a proper QDID/DN for the host part of my product?

In the past each vendor used to qualify BlueZ by themselves as it
normally involves a specific kernel and userspace version, we are
discussing the possibility to have a generic host qualification for
BlueZ under the BlueZ's steering group, the group is closed to only
BT-SIG members though but Id be happy to add you if Arri is a BT-SIG
member and is interested to join.

--=20
Luiz Augusto von Dentz
