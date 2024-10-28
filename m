Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B91DC734
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124803; cv=none; b=BGXohkGQRfjT6FYdxyivSE0j9QZj8sBCAPcxT4DKwjUMnBAZHrtEnDrUASQWaxQViRD0tVVKLFnDXgmvdGWPKMWPLQGtoDdCznvv5ST61kgJTwx3UhkODXLuFExKfCWDGuSUugewm1BRLs1bBQH3COpjtSKEFpzBcllC5VVt3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124803; c=relaxed/simple;
	bh=nUMRW2H7/R7YxOVdHAcOy8nvm2KFo9qCcWH6ryPpCB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQJDEX46lv9gn2vtZ3/FobePIZyhrM75nRVz09dDFVUfk61kTNoB23Uk9RQHgZ+PzbBUmtUFfLA98PK8TBMc71Vq1KPfl7WjChwSqnmRNvgnLTbY5f3dEbe2xHyIoGMTikVyMLLotwxy7vM8mqn476N8V80s+PoA/IrXx2DkNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMTPYzaj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMTPYzaj"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso40602751fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730124799; x=1730729599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp6RNlxk7XpxIVj56j5NLRoFDh24LFdOQSV24nEM5Vg=;
        b=gMTPYzajqjtOTUheUhvFriz7hDWvwgtn/4OYdkT/FRG8NrilImtDWiMUG1ap0+pFBP
         6WhB4MKK1k48WLDSVcSHvM9Bb4hNu8jhgPGJs5nayPvWFo0M/AXL549IOGXA8rxWsisV
         UJXPm877SyMatgzuL3xX+3+scO5USHkmM3R/4d948oj4TQZmlQRG4TMZ12u7L2pLGnrO
         0cZx8j9MlEelp8P5MmqS8Md4Uf/t1oOSl/a9/rXn38S4rCSZML9/3JRt9WFYR2Fy31lZ
         DI9MH9xqhAFJMDU3E/of9tnenzFsfQoa+kWlHZbBanJSVAXpu2wYr4x8pvw97sFX08nD
         63jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124799; x=1730729599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp6RNlxk7XpxIVj56j5NLRoFDh24LFdOQSV24nEM5Vg=;
        b=V2RvxZZmpPPRPMofYWf5/JbNRaiV82+xFpX4P7GrBTY0BzoH6cOO/SetROJ+nkwx8R
         bH5Y9T6CwoPDkW3AwqaPG26ahJltV8eq4C4D9zazUAjlUOojPGG8QSOIy6l9z9gs0ghm
         Fb7MeySAnqATDglLqeERudwP5yT5JAZyvwGLcFJG6Ex1yiSC2sMpfhFhhdzSDJ19rKfx
         52WFaucL6fwOadFhYd4mDa96gMOVnLK229Px56vzwizlQsL1q1WdwNQ8X3lD8Qme5vvJ
         /iadHTfEyxUa+7amwbYkCxQ7JK2gH4CBQWyxobqlXdF1P6UvPC3k/gOFFDleHYUohB0Q
         854A==
X-Gm-Message-State: AOJu0YzwfMn25JDMSpvxhXhu5oORWqCN+NYMiVM0ubck0BdDiv658dRt
	4mVGX0bAtY2OAKZdQIlhkAiSBeZkwvjuGThziOuI/V8MidQzy/WvP1vSP2voKM+VZm8vAA/Pwko
	5BNFTybD/ZCHarF9ooE6Wx//Ifa8JPg==
X-Google-Smtp-Source: AGHT+IGlQ9WRZUjRJNRDEgaAbOiha8PRWo7vY458qJCVjK3mkZgvyP13wyLZuKkF2ZO5kYHDXYJZ94SABG6r3lbS3cg=
X-Received: by 2002:a2e:be84:0:b0:2fb:4f2e:5be7 with SMTP id
 38308e7fff4ca-2fcbdfe4a77mr33334571fa.24.1730124798548; Mon, 28 Oct 2024
 07:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028113643.1012491-1-quic_chejiang@quicinc.com>
In-Reply-To: <20241028113643.1012491-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 10:13:05 -0400
Message-ID: <CABBYNZJC1WO1K_1USRFjh3CHP=3hzChwoKpQMkXN8v2i6i9CGA@mail.gmail.com>
Subject: Re: [PATCH v1] device: only use the address type selection algorithm
 when remote device is a dual-mode device when pair device
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Oct 28, 2024 at 7:37=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> ---
>  src/device.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 7585184de..71fdbb145 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3077,12 +3077,21 @@ static DBusMessage *pair_device(DBusConnection *c=
onn, DBusMessage *msg,
>         if (device->bonding)
>                 return btd_error_in_progress(msg);
>
> -       if (device->bredr_state.bonded)
> +       /* Only use this selection algorithms when device is combo
> +        * chip. Ohterwise, it will use the wrong bearer to establish
> +        * a connection if the device is already paired. which will
> +        * stall the pairing procedure.
> +        */
> +       if (device->bredr && device->le) {
> +               if (device->bredr_state.bonded)
> +                       bdaddr_type =3D device->bdaddr_type;
> +               else if (device->le_state.bonded)
> +                       bdaddr_type =3D BDADDR_BREDR;
> +               else
> +                       bdaddr_type =3D select_conn_bearer(device);
> +       } else {
>                 bdaddr_type =3D device->bdaddr_type;
> -       else if (device->le_state.bonded)
> -               bdaddr_type =3D BDADDR_BREDR;
> -       else
> -               bdaddr_type =3D select_conn_bearer(device);
> +       }

This seems weird without there being a bug with the state itself, for
instance how would it select the wrong bearer if it is not supported?
Also the lack of proper explanation in the commit message doesn't help
to grasp what is going on here, so please have backtrace or something
attached since we need to understand why it would be selecting the
wrong bearer, or perhaps the bearer is being advertised as supported
when in fact it isn't?

>         state =3D get_state(device, bdaddr_type);
>
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
