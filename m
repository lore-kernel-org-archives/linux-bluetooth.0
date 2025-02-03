Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2720CCC2
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605574; cv=none; b=ZCTOVAIJgSwoHkgnNbOp1wMRZkRhvr0qybNyRv5jac6zB9xjyy8yQ8V0nxFDixusoAw0x8w4nAOhJiJnHGnN5nxvAnJsLeHgq7WIe2N9ioW0GcXaBUXmA7IJySx5dWPVvUkukgQRVtWHY9jermJIRPemsrAt4d5JU8VYEsVZyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605574; c=relaxed/simple;
	bh=FH6BdqxQDWhVZCuB9/NIGX5/OCFtl+gDbIVZmmVH2Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhBQMUwz/MZ0fyhqG1ukqQHSmCmrfmFWjjmxyw66Rao4NMNFnrxYWX3+gw08ffPzYP0BYM3aqqqjN+lmkMdUM76urFV2MzwN+Vk7tK9TLtiD7difNDaH4jwvcNdj3WqbZ4t+CQC+YFOI/WlwMtWpmP3c2yK94xX/iugAHqIZUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVAJee6y; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVAJee6y"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307b8e4fc25so18370321fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605569; x=1739210369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEGcmq2a2QCuzn6fEuqTX0NBOrUBbKxS9ElzHHISg1w=;
        b=TVAJee6yaMq2JbUBlScVcu0Szf8TYUpUl5Cc20jxvuoY98NB0+p+EIWrqVfHBM9BkT
         6FbE5mSpCi46h4mTjGkeq3Z8/A07IM1z1wOGFR1XTnuhg65t9c6Zr8axr5bHAP4ri2VP
         aAbhXnPIiglJR2KbXypJ+w/T3SV7kCEPTsSBL+U8fY1fJ2QFaApo26Prf+mxW2k7kZ6X
         BAvl2OHPk0NLHTMq552Unmq9Ym2P++ZAgNKFG64isi3yozQiUgugHT1B4O78+XAtUSvK
         QbuaVA02tnKpBqBkw7KRLgP+/N0xjJFX0zq8W31MO1UPW8svrzuU+jHjqC+sc2/+C7UO
         2qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605569; x=1739210369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEGcmq2a2QCuzn6fEuqTX0NBOrUBbKxS9ElzHHISg1w=;
        b=PRN6tUF0vhPSWirGnvWxZoq4DvYgt8sN15sXM/pBtOx8JHEZ0vldUxWZBrJ7fs4XN8
         Z9XbXuQCZ7Wjl9/iIfEBt7Hhw9NUSeMVr7R+5pJs0B/1bCG8YSTWdOix8jfDA04Ao4DG
         TM03Hlnpbd8BWmyeWC2WCVVHstsd0n7hCGYuEmOU3HE3RRWsNjuwt4q3BYpvAshOB9NP
         N9iIcrZfQnvySA9508tE8YwiZNrH5XXdDl1095g6XGhQtVJ6zeArw52jiYzUmcekIX/k
         Vm7oVZz8AWLhfuS+Phk+pVMootl9vgry5k3gENNF8uK1zi4049xhdApeS/ujpkQXeNPG
         YnVw==
X-Forwarded-Encrypted: i=1; AJvYcCUQGgOO7ohJUeTjtEGie7wxpX7U+LKtwnIxZa5eYlbyE+/6mJk+Qym6re9tGwF/8AavEizEGsHK8xL7W6Q7czI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ4QPNYo1+VEIfNOlFtwBjw4T0tx2RwyxGm5UeSkXjHeDHuhE
	l/CDsRVqsuD4GOI76hrs3IwbY3akERLzZZcoCIQHGErifW+47lrF9acMmZJmyfM3hnWaqVuleqm
	3TTK9XWkRpnZ84sfXvBPd4upDbK8aRPFguLk=
X-Gm-Gg: ASbGncuE8Cz3KPyoTg39ArGmKnCXhZSVXnMRsRIGf9rLJ1nyHummGyoWXdVJ5/UdzAX
	dUYMmnHWeJqERxEfXB3r8CBezMchdu57t/bVpQP0dnHzJkgO9d9fZymN+3YQdhhoNsPJwr/o=
X-Google-Smtp-Source: AGHT+IGRCNP5ji9xlpPNr85mR/o0+FSKs74WtGjCLM5L3R1m5yOA7kLfyBQEIuKfgVMsnLHlg4ENvVGYucqbhKXZwig=
X-Received: by 2002:a2e:a909:0:b0:300:3bcd:8d05 with SMTP id
 38308e7fff4ca-307968da703mr85950731fa.15.1738605568947; Mon, 03 Feb 2025
 09:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130090158.266044-1-sanchayan@asymptotic.io> <CAN03qa8Xe+o5L5G35gXJbD1XvEc_hdsp80ZW-2UN6opP5DMLMQ@mail.gmail.com>
In-Reply-To: <CAN03qa8Xe+o5L5G35gXJbD1XvEc_hdsp80ZW-2UN6opP5DMLMQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Feb 2025 12:59:15 -0500
X-Gm-Features: AWEUYZliLKuPyNVxt_6XXYVo1lNBre803yVSMmcf1fpq_8XfvQERirogfqsn8wI
Message-ID: <CABBYNZ+=VmFjRNd79GNygCEvxJ3LYeSkXV-fPGBtMetUWoSxwg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/asha: Add support for other side update
To: Arun Raghavan <arun@asymptotic.io>
Cc: Sanchayan Maity <sanchayan@asymptotic.io>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 3, 2025 at 10:41=E2=80=AFAM Arun Raghavan <arun@asymptotic.io> =
wrote:
>
> On Thu, 30 Jan 2025 at 04:02, Sanchayan Maity <sanchayan@asymptotic.io> w=
rote:
> >
> > ASHA specification requires that the status of the other side be
> > communicated with the start command. The status is also updated
> > if one of the device in the pair is connected/disconnected after
> > the other.
> >
> > https://source.android.com/docs/core/connect/bluetooth/asha#audiocontro=
lpoint
> > ---
> >  src/shared/asha.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
> >  src/shared/asha.h |   8 +++
> >  2 files changed, 168 insertions(+), 3 deletions(-)
>
> Reviewed-by: Arun Raghavan <arun@asymptotic.io>

Well we still need to fix the following error:

./src/shared/asha.h:56:22: error: =E2=80=98asha_devices=E2=80=99 defined bu=
t not used
[-Werror=3Dunused-variable]
   56 | static struct queue *asha_devices;
      |                      ^~~~~~~~~~~~
cc1: all warnings being treated as errors


> Cheers,
> Arun
>


--=20
Luiz Augusto von Dentz
