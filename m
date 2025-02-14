Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9062661A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546917; cv=none; b=Biepdp2PO+egBOJFluddSGHBJ3Uf8V7rKPY+XpzsDCLbNJU+2EMhuG5s+8kuH5tjy87CWdsFS9q4ZkjBYYQY9IGDMQ9NWrbtO1J8DtvlIww8lnvamDaHrQPgkPUmqR0HVAGHwqpBGiorGuTDRMuz3VNTbz1M716wp/6XkjakNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546917; c=relaxed/simple;
	bh=9J+kZGcInEaTJ86pf5fOztDgY0lG9omNW+csGzNmksI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZxOSzjRj8k5kE3pprgFCI9+v1+S6w/mqorvqb6swfhw/74YCvjpx5wzaLlqW2vfNOkMZj3Q+UpOFNkT5xMpPn2pIhMaah5yvkea4FbO44UeSGTNkV/9WVJFIG2yU/rk7Cu8l17T5zEouAyucUYmPVht6rMgxs42G41qiQevmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq2dG21M; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq2dG21M"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30920855d5bso7600381fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739546913; x=1740151713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN44kne2tOzrc/PsM8eEkDjGlLhqXXZ977xNofZ5eHw=;
        b=Uq2dG21MKzDbc3AIFbs2tnGVwcHvqpqQzV51D5+krI6UdUBAa8feOtKJtMR5JCs0yA
         ipvxL0UuCgdvBIqYMw41kov8gilUFfaxuC8Pux5eIFEZ76nu//5rRbT4aFyOgiz3qeDi
         xQhNKkFE/rdi4RjizJVad/VrtkXkCNA0c9IzhLICIcpWRA4E01RKnbiBXdwJ82rCoxP8
         MKUj7P6CyEc2bmGQC/tNuy/NcM+c2MRFSDs5A5112i9HAfvanG9TieZjCQhRAmz2Dx1D
         ZTMC4k1XTkP3PvqnFnaXOCknzQS3MxObP8FCFH/xrs1BR9Kpd/DU3M2mVHf5ulxQ1zgS
         WMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546913; x=1740151713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN44kne2tOzrc/PsM8eEkDjGlLhqXXZ977xNofZ5eHw=;
        b=VflJfgp7snYfYZyeozxsQAahF/wiDPUnCuAK1upuRfl4EULjKvLB3s/SuE1PETkyei
         FkLTaCWwgZ4d6LdcHsi6MI91dmTsng7SVqFKYj0Q4cZtpaI1XUK28sJlewxg+c66IV4f
         ST8VAsOvoc/i7/ZSSNsxNu7eabnxpQ9pNC+6SpwJxS7AHwqcIpVDySrN1NFO6/Ry7vWb
         7z4OU2OUi658Dph5c7CPbzYUyjQ5q3avdqKaNSgp60cBiHR8aVRGbMEy76/UsSzUuHws
         fExRw+TSEU6QN4DI/tC70XNNYQAjedHmW3xuhzpmXIFruGc+l4+Rv692n+/ePHxBVQ2+
         WXWg==
X-Gm-Message-State: AOJu0YyxjmqCwQ8qP/yG1U5HltpOzd+7st5np5ppVWOzN5f/5gt2k5vd
	sAngSzSVzzu2SHupLThFpGahmAS2O5fcF2oHUPnDe1Bobub10/3R4Oxf0TwhD+OTpG33pqdDl40
	+aMlNKQDKKcalo7tqGbYxE8Nlf71SbXwI
X-Gm-Gg: ASbGncuWrYc+nXqsYNcp2P4FYeddVPAZ1jpgLwOThd5xFr/RAYDhL3teIIaX88jRcgj
	5gayfuRYBcK3WiARZ9ioOhlbysI/M8bmZ6SiwCWBMoPpWRqyhVgvvMchm0+WhO/c+FGsKRp8eEA
	==
X-Google-Smtp-Source: AGHT+IH1GhLgyxvRMX6Je7NgTpWl0ZSC+Jpv3Mweo7yM4X+OTgbRxD7H9xL3gqVhxKetEvuGlaF60tE0ulxLgEafhIs=
X-Received: by 2002:a2e:9648:0:b0:308:eb31:df9c with SMTP id
 38308e7fff4ca-3090f11c8e5mr21957101fa.1.1739546912308; Fri, 14 Feb 2025
 07:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128115659.23655-1-ludovico.denittis@collabora.com> <fdb8f9d6-077b-4fa1-871f-6057e5be5c45@collabora.com>
In-Reply-To: <fdb8f9d6-077b-4fa1-871f-6057e5be5c45@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 14 Feb 2025 10:28:20 -0500
X-Gm-Features: AWEUYZkN2WZvB1ylx3OAw5vll-aSBWgNbjzk2ebqQuRRXbEjMMfPzo5pkdSfLpw
Message-ID: <CABBYNZJYZ2DmYuFrT_-M8-LLva4rXGca8TEA1DoybR+q+D5t6g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] device: Clear pending_flags on error
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Fri, Feb 14, 2025 at 6:26=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> What do you think about this patch? I saw that this was still pending
> while my other related ones have been merged. I'm not sure if you'd like
> some changes or if it simply fell through the cracks.

Let me check if it is not on patchwork, anyway you can always resend
when this happens.

> Regards,
> Ludovico de Nittis
>
> On 1/28/25 12:56 PM, Ludovico de Nittis wrote:
> > If setting WakeAllowed, or the device privacy, fails, we may end up in =
a
> > situation where `pending_flags` is still set to some `DEVICE_FLAG_*`
> > values, for example from `device_set_wake_allowed()` or
> > `adapter_set_device_flags()`.
> >
> > This can confuse further requests because they'll assume that there is
> > still a pending request in progress.
> > ---
> >   src/adapter.c | 1 +
> >   src/device.c  | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 5d4117a49..3eb343cbc 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -5580,6 +5580,7 @@ static void set_device_privacy_complete(uint8_t s=
tatus, uint16_t length,
> >       if (status !=3D MGMT_STATUS_SUCCESS) {
> >               error("Set device flags return status: %s",
> >                                       mgmt_errstr(status));
> > +             btd_device_set_pending_flags(dev, 0);
> >               return;
> >       }
> >
> > diff --git a/src/device.c b/src/device.c
> > index e8bff718c..3c2337198 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -1575,6 +1575,7 @@ static void set_wake_allowed_complete(uint8_t sta=
tus, uint16_t length,
> >                       dev->wake_id =3D -1U;
> >               }
> >               dev->pending_wake_allowed =3D FALSE;
> > +             dev->pending_flags =3D 0;
> >               return;
> >       }
> >
>
>


--=20
Luiz Augusto von Dentz
