Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB51953AA
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769031; cv=none; b=iPjRpdI2O6IDA00sKjoVhoTDhzkrjkmyR6jmg4YoxhBoCdUzrOKqxHEYPN+nnhZaMbzx+yien2tWpeQwiqq94xBNi/Y/d2j5RPGWlFDw9L1efhM3IExgnBvQC2+MmzR/AWu1LLgWtysZkfCO2sXTd8SDdKH3yL7aDsIYLUYiacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769031; c=relaxed/simple;
	bh=HZV+tFeNh6iLe61XF+Co6euktdWBohji+f+XAl/74as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B48iLr5ne+w6mDU8MX4fG8WlnBO3/RJXossvpIwacIZFCSuMupGXcFdRYgC9pCxNoXE7RZcE6VUIuiyUw+Id51UtkHI9iKBsqigEV7SVV6M0/KG9eGRdma4CYMjNAzjfjrT0qfYs3T/6BwYYPLJStAv5VmRpL3r7pqqz24f5VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rif1s7DV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rif1s7DV"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaa80cb4d3so32602011fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2024 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717769028; x=1718373828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLbFCAJwIjrDdp8X2GQ49yFb5DqCrpc1/XDv+EEAIeU=;
        b=Rif1s7DVMN2l78SqJlCneqdu/4kJMxXKz0RQeTxOiVrkox1RNgGmELPBLEmzgrdRga
         J/PfGk4t9b3xzbwv3pgrnjwNZRaMO3g0GR/IcONAdPcSSGrgC+4TafZTHUM1D0u1i54n
         kqa1DeWDRU/rZB3j1RakR95mVCvM9vlJqK6Prqd3kNaw9t409xBjg+yHb7f/IrYXL474
         YgqIp6MXzgrR1Oo4Awgz/wA0H7mV74j4kBAVpIrSin5KPsiKp/+SKqP3YTTm/8/J1ajR
         c8HDyXMKpKuXdsAFT4KTmVHrofArsMRx03CXdSGsVWU1+6O0mPyO/mQT1bXbiniwJu87
         e1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769028; x=1718373828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLbFCAJwIjrDdp8X2GQ49yFb5DqCrpc1/XDv+EEAIeU=;
        b=EeNLzP0NGl+sigC1I6LHsY4llzsrg7DqgzmQ7seZeM+nRyn5ELtyQi8cv9LJWxxjDF
         SLKuMtKqSc0FQkEXRENLdbbBASn5W+FVLnHTVg6mtbvrh5bz0JBuDuwe7GazMhtwgbZo
         ODa7A9Zk6ZLVF3V9MLRq85TN81FqRFbaAbsqiOOa4yNJu/nINxqBvC3j7fcKh8GqHA4Q
         ofaCKV8oFs5YDqZ7xm93SRXuwDkY7BYI4im/P7trL/gNyXT5nFtZg/ECouz+FJuywBhZ
         YtUSieUh4dThDlnXuevxKMJi2HqDwvY+AAtyKIT3cSmrulV/nquzsMW1uP2+s3r9k+pb
         Dybg==
X-Gm-Message-State: AOJu0Yw7ECOGbJD0w4izaF06q/C67OeJZNuqp0FFbSHgAsIyO00vkEHe
	Ib4m2gpqrs6nUIAKCbEU2OAjtYivAFcFtjzKEOTKIU33Kjn5435KuV5DYH8z5UhC4PVnYbGGAYE
	MPyQvJCNlsqxvV609fT+wq+FJNjSAvA==
X-Google-Smtp-Source: AGHT+IFK6+EHZTz1q6QA2lJ5ixxWZzUyG803h1L0SiVaCudUa/67KSdswteIXKM1NGFaT/tk0lQNyPl1RV41asGsXL4=
X-Received: by 2002:a05:651c:221f:b0:2de:8697:e08b with SMTP id
 38308e7fff4ca-2eadce4d93cmr27062531fa.26.1717769027780; Fri, 07 Jun 2024
 07:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607121522.1255175-1-yauhen.kharuzhy@softeq.com>
In-Reply-To: <20240607121522.1255175-1-yauhen.kharuzhy@softeq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Jun 2024 10:03:35 -0400
Message-ID: <CABBYNZ+czz7S9Dk0mRC4D+uU+Y8V6BZXnZWpvS9eN_GPbDhsmg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mcp: Implement Next Track and Previous Track commands
To: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yauhen,

On Fri, Jun 7, 2024 at 8:15=E2=80=AFAM Yauhen Kharuzhy
<yauhen.kharuzhy@softeq.com> wrote:
>
> Add implementation of Next/Previous Track commands to audio/mcp profile
> and shared/mcp.{c,h} code.
> ---
>  profiles/audio/mcp.c | 18 ++++++++++++++++--
>  src/shared/mcp.c     | 20 ++++++++++++++++++++
>  src/shared/mcp.h     |  2 ++

Please have the changes to src/shared split from other changes, they
have different licenses and shared may actually be subject to unit
testing.

>  3 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> index b410b3d2a..8d1b7588e 100644
> --- a/profiles/audio/mcp.c
> +++ b/profiles/audio/mcp.c
> @@ -224,13 +224,27 @@ static int ct_stop(struct media_player *mp, void *u=
ser_data)
>         return bt_mcp_stop(mcp);
>  }
>
> +static int ct_next(struct media_player *mp, void *user_data)
> +{
> +       struct bt_mcp *mcp =3D user_data;
> +
> +       return bt_mcp_next_track(mcp);
> +}
> +
> +static int ct_previous(struct media_player *mp, void *user_data)
> +{
> +       struct bt_mcp *mcp =3D user_data;
> +
> +       return bt_mcp_previous_track(mcp);
> +}
> +
>  static const struct media_player_callback ct_cbs =3D {
>         .set_setting    =3D NULL,
>         .play           =3D &ct_play,
>         .pause          =3D &ct_pause,
>         .stop           =3D &ct_stop,
> -       .next           =3D NULL,
> -       .previous       =3D NULL,
> +       .next           =3D &ct_next,
> +       .previous       =3D &ct_previous,
>         .fast_forward   =3D NULL,
>         .rewind         =3D NULL,
>         .press          =3D NULL,
> diff --git a/src/shared/mcp.c b/src/shared/mcp.c
> index b3726ebae..71fc2d151 100644
> --- a/src/shared/mcp.c
> +++ b/src/shared/mcp.c
> @@ -628,6 +628,26 @@ unsigned int bt_mcp_stop(struct bt_mcp *mcp)
>         return mcp_send(mcp, BT_MCS_CMD_STOP);
>  }
>
> +unsigned int bt_mcp_next_track(struct bt_mcp *mcp)
> +{
> +       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_NEXT_TRACK_SUPPOR=
TED))
> +               return -ENOTSUP;
> +
> +       DBG(mcp, "mcp %p", mcp);
> +
> +       return mcp_send(mcp, BT_MCS_CMD_NEXT_TRACK);
> +}
> +
> +unsigned int bt_mcp_previous_track(struct bt_mcp *mcp)
> +{
> +       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PREV_TRACK_SUPPOR=
TED))
> +               return -ENOTSUP;
> +
> +       DBG(mcp, "mcp %p", mcp);
> +
> +       return mcp_send(mcp, BT_MCS_CMD_PREV_TRACK);
> +}
> +
>  static void mcp_mp_set_player_name(struct bt_mcp *mcp, const uint8_t *va=
lue,
>                                         uint16_t length)
>  {
> diff --git a/src/shared/mcp.h b/src/shared/mcp.h
> index a2cd6fc45..ee57ed4bf 100644
> --- a/src/shared/mcp.h
> +++ b/src/shared/mcp.h
> @@ -59,3 +59,5 @@ void *bt_mcp_get_user_data(struct bt_mcp *mcp);
>  unsigned int bt_mcp_play(struct bt_mcp *mcp);
>  unsigned int bt_mcp_pause(struct bt_mcp *mcp);
>  unsigned int bt_mcp_stop(struct bt_mcp *mcp);
> +unsigned int bt_mcp_next_track(struct bt_mcp *mcp);
> +unsigned int bt_mcp_previous_track(struct bt_mcp *mcp);
> --
> 2.45.1
>
>


--=20
Luiz Augusto von Dentz
