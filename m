Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52301E505
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607705; cv=none; b=i4ZDqKKfgg1Ck4n521NeHqCtosgcdkhS8lxwKO+siWjsb1OsOwk4I37qYb81tqGHoTyv83o9OXzCQFYBZSYuGCqHFVJwv/oRURf+C4C21fJnRapqheVZFGCwF/T3yz3UekN+PNeCvgMU3pNwR3krm4eMkiJ/azbOXkxvzLOEd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607705; c=relaxed/simple;
	bh=F/6+sqLkeOvQ8PwnMCzjk0HHVhwmmULwDfeNCtPnNBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPMbk+Cw62XW0XDjcIATdg/7KDxOtk/cBR+ZnhP6Ji3/TBpscXXHiI360zuH0B8DHeWLyMkBiHia6YyL+fPWP2pLrmXWcgOggCClvm1AAVicmpws7wqSYiNc9fPl2l4UVdPUllIKIZufCV703W2BGUcDGU43W1gxGkYKLlC4AWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgoM06ir; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgoM06ir"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so63145291fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729607702; x=1730212502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4m4V64NhQ1AzTSFGsrSfmvGZarL0jC1GFUzXhEinfQ=;
        b=hgoM06irQqs0fIBhVKiQtpPX3o7Rqxxr4fbMtTtIhPdwycD/xwf6irpslipMU0qXtK
         GwvHeBsGPE2P5WYQ2U+sGiLm9Gqe6/7gpPvX+d+hztwTUl9Jhx1F3Wivko4hUYdZVhLt
         TauE5TAYJ7SbFLm6Ninp0xtYoMfTuam6+MnYcmqAlfxQ2P0SV8VnfjNuR7bD9rY3hkGn
         FN30quISHG0k7OGzwgKZSEqhZW/5o7o4NeokTHVRh/rcK69IF9Ss3NN6BhYhZUE88J0p
         oeRs0sjpaU75FX5b15QTZbZXgkvKTJk6HDfoqYcI3Fte7aYY9PT9kx5tDave1EUzov6r
         +gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607702; x=1730212502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4m4V64NhQ1AzTSFGsrSfmvGZarL0jC1GFUzXhEinfQ=;
        b=n4m5z/3tICy5BiaZ0Cmkb49Q4fPj1QDkFyHJsaVUBvKPs0H0xGI8TMCfquFkuTHEuE
         S/GnK1R4WYYeXx/XpC+z1QjYj1SHyCnvNoYSk7hqKL7YKe/Gf5sI3S/exagGOoW7t5j1
         OLvLtIjuWUg5QPY/H6qiijnmHmacvSV1CjUY0eAHQGsj48oKeLPrQDFK39UWe9/f8Unj
         trVNrSfY3jt5o71MCqpkEzINT5FxeNHcHZdIoNEcmcHvDroXwQTgjrqr5b+J+hrePSQY
         38T5U7n72LL+2YW4llgjFiHT8FEUm5icEa21ohEj5WNnQvE3cH0++ZQedDqw7JTb6b+H
         HTOg==
X-Gm-Message-State: AOJu0YxlT5yuHGDZYlhPD8z80e355Uwfa7pe/gBaVsfeVT93iMdagKQG
	4rbW0TrGL7Hb89B/F2kecD77Rs+CTMsz24Dj0piKQypMK1UqzzUo7RvSkL/wX8vU/bmcdbk/C/V
	48j6H+Sp+NrSZP81q7kpwbtu50ZaWhg==
X-Google-Smtp-Source: AGHT+IHZkPTjx9NzAwvpX8YsnEXaBRPJ0jVMy49+YL6sbRzDlaCBRhvGOSBC3Y0Bmrz06erRRusIZbkzj2W6j15gsNU=
X-Received: by 2002:a2e:9e02:0:b0:2fa:dadf:aad5 with SMTP id
 38308e7fff4ca-2fb832009b3mr61589611fa.28.1729607701661; Tue, 22 Oct 2024
 07:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022072423.4080043-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241022072423.4080043-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Oct 2024 10:34:46 -0400
Message-ID: <CABBYNZKBKZXLQP52P73oLeUd7VESvSGDcJxKaVCZYu3eq0neqQ@mail.gmail.com>
Subject: Re: [PATCH v1] obex: Resolve SRM issue for PTS testcases
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Tue, Oct 22, 2024 at 3:24=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> Add check for unknown/undefined srm value.
>
> This fix is required to pass the below the PTS testcases :
> 1. OPP/SR/GOEP/SRM/BI-02-C
> 2. FTP/SR/GOEP/SRM/BI-02-C
> 3. PBAP/PSE/GOEP/SRM/BI-05-C
>
> Description - Verify that the Server ignores a SRM header with an invalid
> value in the PUT/GET request and carries on with the PUT/GET operation wi=
th SRM disabled.
>
> Current Behaviour - Server is sending SRM enable in the response even
> though recieving the unknown SRM value.
>
> To fix this, I have added the check to verify the valid SRM values
> before continuing with SRM enable.
>
> Change-Id: I399b1daacdcfa118137dc9798529514d36fd78ed
> ---
>  gobex/gobex.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 40d6b8129..4dc3d8b23 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -317,6 +317,9 @@ static void set_srm(GObex *obex, guint8 op, guint8 sr=
m)
>         struct srm_config *config =3D obex->srm;
>         gboolean enable;
>
> +       if(srm !=3D G_OBEX_SRM_DISABLE && srm !=3D G_OBEX_SRM_ENABLE && s=
rm !=3D G_OBEX_SRM_INDICATE)
> +             return; //unknown srm value
> +

Perhaps use a switch case to handle to enumerate the
supported/unsupported opcodes.

>         if (config =3D=3D NULL) {
>                 if (srm =3D=3D G_OBEX_SRM_DISABLE)
>                         return;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
