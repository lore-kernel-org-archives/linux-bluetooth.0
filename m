Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325451D63DA
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033637; cv=none; b=tr8NCDuWk/R5jkpcaLmiE2/YGhdDtYMtJ7PZ97A4CqmxjcwQlMFOayTP0pr+R1sS5lfByymu9uOqYZaxHlB0kz/FOLcqa//OsJ5N5K1EBdTc5lJcwEDzDw1DfP2u23S+qyF25chozNu1xXxcDAodRw3cZLETUauwXoEo0ZsvWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033637; c=relaxed/simple;
	bh=E7PBTrZAH3ZbKpRiXLjyMPUiIBR1IZxIbTUglZYSC9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4rWTv07ztG9HISH5DcMu/fMnI2VYiIgIwSw2YpUPzvSWi+oFLpW8tKMg9JuQtB+uhWgiYz/IinMB1KuM7uB+GJlOm7lkhHYgU7l7Ekr7d4X04I/v1tvf1O8dgWlOby1pJmvNQq2ybk08zWh9NoaN6tI4lQOTB/5zm88+ix0Pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=FYG+k10B; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="FYG+k10B"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so559910a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729033633; x=1729638433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guqvnX2MDH3oX4FJs8ET2tIkQNvvg150UDLzRoMm4po=;
        b=FYG+k10B1ZgqXlFvGmHXjK0t88WDqp6JeeLsCJhGAZDS9mm3qxPg6XA9Wv2qfnd6q/
         D9C9Ha+WAz0XKNI2GX2QntAo2FQ0wOcMd2FWsrBpx++crju6t5f+fXxqblN6D8COxm8P
         Eq/qToKBjf/iRWWdv14dYv2Pp+/zMtDnUGNM66eIso8u0pjf0wQTrDPG5cDywyWjjzjE
         VJajhcm+bTZ53bFOkcKMPk/gkzHkMQMP3dTL/m/KDURPZGaby9VRzeytb8U0SQOJ5yc9
         ozDmHhVc/7PaXvJLkEr9qS+KQEjajseOHoqhImVW/VgC+JFdiENe+Eipt+M8/BjVfDdm
         ZmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033633; x=1729638433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guqvnX2MDH3oX4FJs8ET2tIkQNvvg150UDLzRoMm4po=;
        b=UEVBGhH6NXxmeOIpsLd1WzE3hACXqHyBW/E+tt3dmeEq0VqmmlrW5lVM/dvOmDXRTz
         sHLPbkuaVs+52WZV9gASVw3ckkUPlZjz4TCpPPE/ggKs+Rd5qA2mumRGhOpV7NQtwpcu
         OyLF2T1tYlIjtqwRiyLqumI27ef/UBrjOBrBPJTFIaEs7U+RQ2lZLX26l/K9H0InXp6f
         RfSgBY2lLFQNQiBw+pKR0CdvCJsiR+aocRsKNQg++Iag/JZaGd/ZABarmQn6lQKPQbG/
         AE+fpomncrgUlPZNksT8LFlZz+opd2LjfK3rxzhpSA5qxj7H/qMY/t96uNs1a6bnawXV
         Ah1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHb7TbVxMNsxZAzblXVwlKGg8RnSBw30+FT6o8A68hDhmY00QHM9eOpWXdfuiJADSggWD8lF+FiyWHrer3A4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgL9Ht6pG3PVhiJQvaWwu+jelpz8TTIL3cXXBJInwt/6Qi4yR
	Lpp97feLmhr8oig2EGJKj7d3Sc+ZeT1ZwWCtPWLP+8K77AiI5Xa8qBZd7WqBtLv1vNSkEAAdPLF
	kgloGm+mR0DbMGe7yOJpzEFaEsQMeFuVIcVVWTA==
X-Google-Smtp-Source: AGHT+IE4m6oEn9p0XHD7GyilqGR60jHljiPnpCXyjhWOO/7AzQTrqk2mNfequr5OyVlWNiBMSSjKd0ta2+tSJF+WD2s=
X-Received: by 2002:a05:6402:3907:b0:5c9:19ee:97f1 with SMTP id
 4fb4d7f45d1cf-5c947596650mr14995821a12.19.1729033632671; Tue, 15 Oct 2024
 16:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015193013.16790-1-everestkc@everestkc.com.np> <f7c92929-dcda-43f5-a163-9a167abf0de6@linuxfoundation.org>
In-Reply-To: <f7c92929-dcda-43f5-a163-9a167abf0de6@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Tue, 15 Oct 2024 17:07:01 -0600
Message-ID: <CAEO-vhFOv_CWUF=E5CjFB-6HVTXe52UOHtPcwPj7a2tkjUXK8Q@mail.gmail.com>
Subject: Re: [PATCH V3][next] Bluetooth: btintel_pcie: Remove structually deadcode
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:27=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/15/24 13:30, Everest K.C. wrote:
> > The switch case statement has a default branch. Thus, the return
> > statement at the end of the function can never be reached.
> > Fix it by removing the return statement at the end of the
> > function.
> >
> > This issue was reported by Coverity Scan.
>
> You forgot to fix the typo Dan pointed out in the short log.
> Don't forget to include reviewers when you send new version
> based on their comments.
I missed that feedback from Dan. Will include it in V4.
Also, will include Dan in V4.
> + Adding Dan
> >
> > Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between dr=
iver and firmware")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> > V2 -> V3: - Removed that the change was successfully built
> >         - Removed the link to Coverity Scan report
> > V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
> >            - Added that the change was successfully built
> >            - Added kernel-janitors mailing list to CC
> >
> >   drivers/bluetooth/btintel_pcie.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index e4ae8c898dfd..660496e55276 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
> >       default:
> >               return "unknown";
> >       }
> > -     return "null";
> >   }
> >
> >   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>
> With the typo fixed:
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> thanks,
> -- Shuah
Thanks,
Everest K.C.
