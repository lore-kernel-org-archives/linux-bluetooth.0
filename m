Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDE1E89A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582965; cv=none; b=bX/phA+7MpZwgvzlGE6JRDACWEQ9+/86Lhop9DbARQIlYllrVtsZFh/KmPtSbIi1s+67O3kuxe/rHS7OBBRpw2+yjf3QYeKOusBp41hC2CyFbXwff5xmLmnZ4H6WHNfFRniOidExMn3OzRnzTgx0TUINKB542tz6a1CxERsi/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582965; c=relaxed/simple;
	bh=2WT6XO0V62MZedmd71IZ+mxpC+L7m74Vxbs1h0u0TrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ3jOEK+GAasHObfZyjpFqIGqjL/eAPKkYQZut7B7X5Eg/6A9TkZb/eXhWs0c7c1bxIefZ5BzCEGIJ8UVkyW7xP+kUWFQuxDcfdetrs4yjoou/T/iRZnyRuiZn1NbAgHU2o3QafFElCOHvy3xVNjl5yMtunzTW7jphNBSg8BYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8A12mWM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8A12mWM"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so7899151fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719582962; x=1720187762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtnFPmGPWjcm6svwIxp2RkM5bbn94pbHMyCJWCEVaYg=;
        b=S8A12mWMIQPb7e7UPdJepveVoE0lP9+srefsVYdwJKUaSa7WqdFDBA1CufcXljci+w
         eUfiJAJAeRRTv6ImOo1F3n70/1Hz1hda7+0PtyvXQdaqwfV8Z2vOIqfbOxmUXu3z6/1Z
         ULnhJIAFZArXMfAjiAiVA/sbgAGSw5ym4O14BCv8nGdLgyseoiu7kKFVRyKq5dAd12mB
         7uZplqEDVRcAI7vmuj7yxA2PcaLoFtVCjCMc9pPANdd4KOm3962P6vAknaPVXWttsnpu
         0K95SzabDEQCpC+RyvOIVIkOOeEEP9y7betbLDylDTTp3I1XlUejiRLZPKvoUbLUwywY
         ypdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719582962; x=1720187762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtnFPmGPWjcm6svwIxp2RkM5bbn94pbHMyCJWCEVaYg=;
        b=rHRro/U6w68bF4gRbdy5P/WzuCizvxfVVbarFSN7ON9SjZx0midzCesIolnN0cc/bL
         eaWR8De3SAdT/5okAAPMb3BPL+qCcA6GGEbUEpfYPVa5GgtKm9H1Tv1uzx8OGGFZD/tp
         pTwwEMtGmd8HI4OAm+yDQ1nuNtp4vIG3gTjfANPcQZhi4zRwCUeVZPyTaPVnzC2eapMg
         1eVCz9TauU1iC+YAHQLh3fkWjdw1TJROLQ6RAl9VFjnf45RczMpiO2LVmBisdFNTQ/sO
         R2ZPCyLOo2PNYAOzbXbLpVG211bwnFNFvLSZEClpseMggR9bz1EbPo/GVWXqexA5n453
         O41Q==
X-Gm-Message-State: AOJu0Yw/D7sj4TOVGt5N+eIaCRsLzce0sYDzUUofwhK9DdBD2fVZkyCf
	XZrnOuBqy5Pc9hqtuenUp4zLz5pc4M4ib/73Rl6PO+zCkLJXJcmA9bJDvd/QjtVsffyBJ44UKnS
	A9s43FRCmADQzobCgoD0qcI1SLGU3XQ==
X-Google-Smtp-Source: AGHT+IGeLqJ7lJsTaWryrjP6jgT26xqCvHoRQGKmbZqmVVOaDKfLCHpmIiA2C4Oc2cMbAW+zciWGX+8ERgyagndJAao=
X-Received: by 2002:a05:651c:211d:b0:2ec:5dfc:a64e with SMTP id
 38308e7fff4ca-2ec5dfca6demr122412301fa.0.1719582962038; Fri, 28 Jun 2024
 06:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628105521.540629-1-r.smirnov@omp.ru>
In-Reply-To: <20240628105521.540629-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Jun 2024 09:55:49 -0400
Message-ID: <CABBYNZLSBmyT9+XBHH_hftfCXSAB8XKvmsSUsobUEu0NM=fL=w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] a2dp: add NULL check to a2dp_reconfig()
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Fri, Jun 28, 2024 at 6:56=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> wr=
ote:
>
> Add chan->session check for NULL before dereferencing.
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> ---
>  profiles/audio/a2dp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index a3c294bc3..3f9deb9f8 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1893,7 +1893,8 @@ static int a2dp_reconfig(struct a2dp_channel *chan,=
 const char *sender,
>                         }
>
>                         /* Check if stream is for the channel */
> -                       if (!avdtp_has_stream(chan->session, tmp->stream)=
)
> +                       if (!chan->session ||
> +                               !avdtp_has_stream(chan->session, tmp->str=
eam))
>                                 continue;

Move the check for !session inside avdtp_has_stream.

>                         err =3D avdtp_close(chan->session, tmp->stream, F=
ALSE);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
