Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DB360
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193241; cv=none; b=Sp5wCMw+yjtgstCor4qBjYDYt29+0w0vU3FT+/br+y7TTBFDbWkUdwp1l5wgQCR9IdeYmeT0Ep5cCLJcG20g8zkMlH4nkU5eoSCJvSt9S9nPOSb3OcKTjGNws7lVEiT+T9ZijTE7jrRIR2W60J6kshuAheVTk9S7P+mpGFOsZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193241; c=relaxed/simple;
	bh=Rbvo+AKcAXG7jD+TBxWqLnlwBRjUsQKNjp7YlfpjEmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJamHnFeeyhsUHURGC9eHUSxfSG4zgzWmiJnkd4kS1NEbXm9vhcxFnnKyFuAE8yb5eZ42b3HK6V009pTX3GRAsFE1CFClI3VwFVrNg6N55XrIzwK2WpdauirFa1sqvgqAxRlFKN359s4ZVhXMD8otEeBf8+VoXCGkK7vzBbeVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV9ohgua; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV9ohgua"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30039432861so164208181fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2025 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736193237; x=1736798037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvAnnOg0nuM6rtjPF2OxBPtFvW+niLqA3/INAh04wuY=;
        b=FV9ohguayCiWVKqBlo7VVpB5Etsxo8Sl50LlpfCq2h3wLk4iGDoNv/W+2o5AFXfhVw
         iCHdsPUXDkSprGsRW5ysA1EuQyQFm/5eB0KXwcFD3lpBTzC3JKGrmbZHyuaRAYEEPrzl
         ertLn1vOj/j8gF5z6BYm9fQ2tCEN7t7h6qooU26EWEzumQwcMRT32FclEWiubYe5p42D
         9GIVCVYCWqMijEl6dEz/a85/nhkJ/UPwHiua1NjPQXik/cSYzx2fHnB73+U8eHywr5Z2
         grR+fi5uoupR5gWLjR8xNZNZkTJiPw1Lgd6g7uZP0k6jWJRb21yxWH3gbVULYWExrPJ3
         ZBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736193237; x=1736798037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvAnnOg0nuM6rtjPF2OxBPtFvW+niLqA3/INAh04wuY=;
        b=xUoTVE8foStErjCpAC7b11sOqB7jxlhme2fcSsMMDOZ4B+e6NyUEICea/wQXieT3cb
         UI2AJZKT4eXN9ASz4HUeEBRLq1oXYM1hid6HJKPvTxZruaGq3RjNfjzaAG2DuRhBK11R
         McVUSHOTSO1U7PmJC62kW4kuVtZ2H4iUzJn5LAO67xam+U/1xtnomUwopJ12HfvgeKFd
         vibP2GRaWOZQfhxBnJXkSn81ErdEiD4n3o6wGl0O78rlx79swzMcSquheKQqh9oPi/zm
         iarN7+IRYpFVbT3N01AM8u0CP4RyDELurQTsU8lU4/KvQN2ge4ogFJ4VHwO6L0K1Z8Xp
         JXHg==
X-Gm-Message-State: AOJu0YyJ3pPybvZDmkSzAipRVBZBn5kM+lpUrgRqEWJ140JLpFEHBo0m
	googiIONXM1078E1Aq+kmjbx88XqDowbNtbAHve4ZhVJ1z8jTK29LV04FrkOH/J0E+3UWpOdU+V
	aSKt/QH+fITdCzLeS02tNV+IXDD0=
X-Gm-Gg: ASbGncsr2dpD5Ehc5kTZGGIHURNo4sqpryg2vt0VWqx3XRCj54o2sBfKONrKyyi0olv
	DYVeFKlVbl989aiIu00M9T6N6wVkdVD/KYQVyTi4=
X-Google-Smtp-Source: AGHT+IGXyDFmM3FXmjESAkAqjQNme4ObVo/4x1ng2c//6Ix/KghlsRmZFUS+TyLj9Exxly36jm208P9CylSMpBepDoM=
X-Received: by 2002:a2e:a7ca:0:b0:300:1d91:c2bf with SMTP id
 38308e7fff4ca-304686076bfmr132097221fa.41.1736193237140; Mon, 06 Jan 2025
 11:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224142424.10572-1-mahesh.talewad@nxp.com> <20241224142424.10572-2-mahesh.talewad@nxp.com>
In-Reply-To: <20241224142424.10572-2-mahesh.talewad@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jan 2025 14:53:44 -0500
Message-ID: <CABBYNZJ8To9fm4j3bcGsmPc6ChJO376yAN-Wr3Se9hs_3GpJoQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/1] HID device not connecting issue fixed.
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com, 
	sarveshwar.bajaj@nxp.com, vinit.mehta@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Tue, Dec 24, 2024 at 9:24=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> While connecting BT-HID device showing br-profile unavailable
> and connection did not happen.
> Steps followed:
>         1. Pair Ref device
>         2. Connect Ref device
> With this patch HID device is able to connect and HID traffic
> can be observed in btmon.
> ---
>  profiles/input/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 8cf8e5ea7..a6047998a 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -89,7 +89,7 @@ struct input_device {
>  };
>
>  static int idle_timeout =3D 0;
> -static uhid_state_t uhid_state =3D UHID_ENABLED;
> +static uhid_state_t uhid_state =3D UHID_DISABLED;

Well this would contradict input.conf:

https://github.com/bluez/bluez/blob/master/profiles/input/input.conf#L18

Perhaps what is missing is the detection that if uhid is not enabled
in the kernel it would switch it off automatically, that said it was
intended by the distro to know whether to enable it or not, so we
don't have to play a guess game runtime.

>  static bool classic_bonded_only =3D true;
>
>  void input_set_idle_timeout(int timeout)
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
