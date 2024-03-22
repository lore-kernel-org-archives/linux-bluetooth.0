Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39550A8F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121350; cv=none; b=hKJTku7RWZzht/138kwy+9Y/qeDwL6826Z3Jc+6jqvRTmLaABIKWQCmnFSirjwe1X/Ho912jmaYxhXm5+tIUymMhZWhmY1RBnTL//rTpcYzRDtddwML1SYQYxwF41Ee/6Uk0pAgyNdTOOXfteo8cWkrzmkc/dAwCbJdHjBHNMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121350; c=relaxed/simple;
	bh=U/i8Uiv2lq5UNIQNm9O5uuQ9Qg6ydz7MAZxr1uxj5J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6JUtvRfGXMCapX/74eT3HAynm//Chsh9/uH6nbOR4+ZrVN6zCyVuZ2RqX0CHZ2u2zzBTBifS5KxMf3ACOFMjnc1rbZGLOqqv9+EVh74C3QNO3ARxTuQ+bwLOiKtEN/vIXU/hixvw4EpjjS28siaGua522671/9+u/uUFBMNOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV0X2FJt; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV0X2FJt"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so30822921fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711121347; x=1711726147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv2/SGZeFbOhxu2ZlN8feKEfti1ci2i1lBP+7TY2F4k=;
        b=NV0X2FJtQgSthMcAETMLTpQCwupgeAd/6QDKpCvyuigpyPKE/p/m9kA2JoxFpFSYbm
         m5m9ofSlSEONLIWaqrP2suHqZEjHFQ8tEr7w9I8/PloqZAKRDKW5dueXyo0jAg8+Apk+
         mP30bNu9xEg6FEd8oSpw52XBiMcUhil2420u1BXeaOrEyORWYi2Im/EzDqAF7TRIkDDU
         mog5PfBbvwHYOj9/t8po1SpMcZYfpCZcMiXIHfzDOTrXSAYG7MflzRhqzFCdXmc0iXqZ
         Khk2pg9VeMIt0z3FfnSvdXmsk/izFm+ni4xxlbVr5a7ru5L5fU1W5Q71flSBQ+etLm/X
         AQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711121347; x=1711726147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv2/SGZeFbOhxu2ZlN8feKEfti1ci2i1lBP+7TY2F4k=;
        b=vmymn9fnxAhfJ2fuvBWEMedoyqPxzXb6Q+a8U2XJcf2y+OH1NubTYRhzAp6wCaQhCz
         e8usMGKiJduXfxApquVbnM5sqlwU09srWZuW71rXGXrz/rRytLeWBpCX6fNUpIEL0EnL
         I0Iog/C3H3rCZJpufx3Kw2DxOdtkBFSLJXdrNy+a2GVLn9DkFwkV7I/NKMlGy7SYyuO6
         5KLzqgDWCDDKBvzYaNBPWtoomAphXcSPqFlxFWhK3grkWnpRHsSUxhgrMxwdj96nYpox
         bzx9zeJCM8GUXIHAyZmn2fd95lXQL7SWtVkbaSiL2JMk0HhLURRU3XD/WuQFZH1IDxvj
         d4Xg==
X-Gm-Message-State: AOJu0Yx+572fPWngjGPKqKIfUdvpx3EJCehNvp23H6M6xYATFw3dxieU
	RH16A6B7qSBNaeeQF3y9cO7J45PmDd1SR2L9hczeSTlWNRRh7D9BmipaAGu7FPVbChMSIyIbsNB
	vRWqweN1gEmhFCVEn3Xzhg2e0z99F2z+FJ+6uYA==
X-Google-Smtp-Source: AGHT+IGUjqExWjApmvjR8ngTIloTQJp8xzF9vRsUpoJru2jYVWBgSRKMvZg1d6uMWxbZWSvrkDp2tXzKkXqPMabf0IU=
X-Received: by 2002:a2e:730e:0:b0:2d6:85ea:efa5 with SMTP id
 o14-20020a2e730e000000b002d685eaefa5mr1859207ljc.15.1711121346329; Fri, 22
 Mar 2024 08:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322143830.1476938-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240322143830.1476938-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 22 Mar 2024 15:28:53 +0000
Message-ID: <CABBYNZK64cAFTm7221QxN2T4Eip0=LbpmWUX_bJ3w+O4wAG2UQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avctp: Remove redundant UUID checks and additions
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 22, 2024 at 2:39=E2=80=AFPM Xiao Yao <xiaokeqinhealth@126.com> =
wrote:
>
> From: Xiao Yao <xiaoyao@rock-chips.com>
>
> ---
>  profiles/audio/avctp.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 8ad146df1..6199ee951 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1597,12 +1597,6 @@ static void avctp_confirm_cb(GIOChannel *chan, gpo=
inter data)
>         if (session =3D=3D NULL)
>                 return;
>
> -       if (btd_device_get_service(device, AVRCP_REMOTE_UUID) =3D=3D NULL=
)
> -               btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
> -
> -       if (btd_device_get_service(device, AVRCP_TARGET_UUID) =3D=3D NULL=
)
> -               btd_device_add_uuid(device, AVRCP_TARGET_UUID);

Patch description makes no sense to me, this code is adding the UUIDs
of AVCTP if the device over its PSM because at this point perhaps SDP
discovery is not complete.

>         switch (psm) {
>         case AVCTP_CONTROL_PSM:
>                 avctp_control_confirm(session, chan, device);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
