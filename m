Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93311F150B
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329964; cv=none; b=Afo7Lqmk0pUz5AGE+/qrHzGqekPVs0yCQcrUTm6pU0RGSrHqamTpt6dLwEUGNlcJlOa6hMOBPCNUnN9woKu65vlfUcLBqqUnxGZcDqL874Aniz+z5UKnBbN6W9UBQ+cIOpqcez9e4K/W28f1+PKJSwZsQm6WgquuxXac7Wbnc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329964; c=relaxed/simple;
	bh=2W3iuYk/0Zj37UP/dhxX64Q1dh6NmQXuJD+CRnYOjss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8CxRTrV0BSv1vw/kDWgg4Ok4kkGBfQN8dDUOEvy2sO8fo/sYV1kFrqwgV7SB9WZsLVzB+qKh2mzukTYW4O6ae7kuPdrYkLVOIYSz8zNU/r8MN78GaeljsQiUawmlyXqOFiu1cRuHryYFGyGplL558RHvBCKcn5GsPOqoW+4DWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W34ANjNm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W34ANjNm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so5948358e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329961; x=1745934761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQtYbnnzXEgdH3FWdbBn9Y9ve5/iDrVPN4scq8U+eNU=;
        b=W34ANjNmdtZQnuZ9IiowtHCDkaDC8UARt4s5Ql66ME+PJUe2daWw/Givg5lCJ4BDc5
         tJapISAj71wbdD3rRzCsJXj7pO6edNfqDOGaKhXW/yq7QmgrYdQT4aHDI8rodeKsIry3
         z65S01+NjNJR9oGsj/tICp1V5JhvBDNsLcZX+GBehz/RbVf3B60gMa9whTT4t8AKM6Qr
         wpO2V/AmJVl7ivMwvMwRB1gTZs+ooxBjQQnphRmbKGFFuvnaS5w7xCNMRUQSeG3HMuyn
         dVF0Bntkpnt4Bb34cOWA8ni76WVL8zTAyYc3XJU4U7RUxd7J/6CBGFXtoNRVce/D10OT
         MKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329961; x=1745934761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQtYbnnzXEgdH3FWdbBn9Y9ve5/iDrVPN4scq8U+eNU=;
        b=QvbTkqYot4yu7UT5AqyAT+zZAEG9nO+ebq+KUZQ1hEJvKMaVLSj9CAIIbupVIYAslB
         6FfoWI3IsI9EXClAII4jtka66CcVfRnPEn+41+Is0DvMmfCPzTCt8llS0sN36lyCGyg1
         MkjnXARh1zgGJpLbxcNCxj6JMXMmRl61K1GmxEQg/sUZhDhlWGbioQW/u480ZpzOO96w
         QEe/ojpBuk686nTe2ZedGVCe1+PDsvt8iUf7Xrdna3Ssw8regtZf9rOH6ffTwCiJUer5
         CuiptRUH3p6YmEq7gDl2Q0s8lI+uXGDYXBxibHuMBXcJIhgJO/fFqk2qt39o/oOKqeru
         DMmg==
X-Gm-Message-State: AOJu0YzimLZhcLHXoxHddPkk0uHUhHdEFCMYjYP4Cwkn88ZrTiH4NhFZ
	LaMKc479HmhbpuvC19eFALCPGMvK5p/0ZgtmgfpI9nt9zWfBhZzMv15ScUIzdd4b8f97HAjzDar
	jbSDeYbVFAUcMaahWMgxYO2hhVTv2LTPX
X-Gm-Gg: ASbGncsYRDRoE2Q+5xx/JD3ae/I9XeIWaI32hIbJJv/4a0pz80qPSshHwdq6jzug4IZ
	U6fk8mab1S0ew5ricPBjbkQude87o4mQjZpO6ktrwIJNwUrzcHoLPR3dKKah/CdBXvBsaJ+FGJh
	ScheSChWF+fzvih8+9XEoF
X-Google-Smtp-Source: AGHT+IFCA2+Nh4S3p1mrnsHgrGwN8rNRR+qK81GpsLCA6QfUwnO7lMJsvRrNq25d93SKCwtCXypYJlR1vuscJoVcnBU=
X-Received: by 2002:a05:6512:3b95:b0:54b:117b:b54c with SMTP id
 2adb3069b0e04-54d6e66d881mr4212732e87.55.1745329960522; Tue, 22 Apr 2025
 06:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422054547.132400-1-sanchayan@asymptotic.io> <20250422054547.132400-2-sanchayan@asymptotic.io>
In-Reply-To: <20250422054547.132400-2-sanchayan@asymptotic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Apr 2025 09:52:27 -0400
X-Gm-Features: ATxdqUEYrr2lQV7fHsz6YaTjpeo-mF6ayHw9iwaYdzvCavMDloLrcJ55JEiZ9d0
Message-ID: <CABBYNZ+-ETFabKbANa2mdUOd1-z8ihp-1V3D+0pLyOTuztcEuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] profiles/audio: asha: Reset state on disconnect
To: Sanchayan Maity <sanchayan@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org, Arun Raghavan <arun@asymptotic.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sanchayan,

On Tue, Apr 22, 2025 at 1:46=E2=80=AFAM Sanchayan Maity <sanchayan@asymptot=
ic.io> wrote:
>
> This fixes the issue of an ASHA device failing to re-connect after
> getting disconnected since `asha->state` was not set to STOPPED on
> a disconnect.
> ---
>  profiles/audio/asha.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 10115b92d..df283dd22 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -478,20 +478,21 @@ static int asha_source_disconnect(struct btd_servic=
e *service)
>         DBG("Disconnecting ASHA on %s", addr);
>
>         if (!asha_dev) {
>                 /* Can this actually happen? */
>                 DBG("Not handlihng ASHA profile");
>                 return -1;
>         }
>
>         asha_source_endpoint_unregister(asha_dev);
>         bt_asha_reset(asha_dev->asha);
> +       bt_asha_state_reset(asha_dev->asha);

Any reason why the state reset is not handled inside bt_asha_reset?
Also perhaps it would make it more clear if we use the term detach,
since the general idea for src/shared is to handle the sessions not
the driver logic like probe, so whenever there is a connection you
attach function and on disconnect detach function.

>         btd_service_disconnecting_complete(service, 0);
>
>         return 0;
>  }
>
>  static struct btd_profile asha_source_profile =3D {
>         .name           =3D "asha-source",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
>         .remote_uuid    =3D ASHA_PROFILE_UUID,
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
