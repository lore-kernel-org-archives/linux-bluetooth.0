Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C29158A1F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508468; cv=none; b=Xpwy87e80+9wnamBOGclHP4Sp+nOcGXDifakPNJHRLlG5VOym801pCjltoQsZZPSKPpqtZfkTYxzAknDAxf5JWMhOv87QicOc75KM6doC+vltk9lJdg/Wl2sR5an9Ax52srD5nt8Bz043laE2ZyLOm71hxFnUEXKPwlPG99X8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508468; c=relaxed/simple;
	bh=NQFy6/yOdTM+CoO9h2Qr8Gb0pbyA4v9iI5wuMgksEVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeNmdQKhB/4mLDBQZ8kotmFrI/bW3mYjmAbpwe5ob9aA0UdqD4Rd0KwjXSTA3r2akkwfDV9nf1wl8rd90sBqljZ/NLl2XPkQTvpHkIzlO4dpLLxUl3hZ0i9iPdn3mYy0/Mh4rVYcBfd3AgriyuY0oDJmPrTNHYthKh35j9y2Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVMVaLwM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVMVaLwM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75f116d11so37285871fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726508465; x=1727113265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjqZUiAekftcNhNeZloPx9DFbuZatysyBrpAGQm9uYY=;
        b=gVMVaLwMCaVdiisdm/fGcxcTcqkDB4y4ZsaLgC70GV2Hp+YVBux4L9t4pmtIwCjZ0x
         Q4KbhQCepPdXIL+mYwwYS22mPFajQsaTt+iqmrkeVjo+AK/0x9nLa5FQWjiv47oYt9CV
         h0CfIBwFfX9EQQ6Spj+scV3wcCcijHa57cZD/VHyW8cfGH29nJsUbkBnbnID5+8F1Efr
         z2yyemccHart3bXWjVZo3CVp4XVHfrvK990J4g3GqbIT3ZHs0dhRkZaaugFSEIGFm76N
         UUn82mNxSPIK9dmlnid6UFxQqInSWO1fgIfqWwbN3T20cChoG7AASmy5Q7i8M3AVeu1U
         dSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726508465; x=1727113265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjqZUiAekftcNhNeZloPx9DFbuZatysyBrpAGQm9uYY=;
        b=qyc0wuDEy3esOm6p2orCYTs96t/n7W37MgBpbagA4rgUc4VOYFAzJaLi//2vaOEqg9
         3+ojMw6D07dbLzWfSvlH1EVrABy/MJc1Mjr6ynEmJb7i3AHJykDaJq8Hp8eQMWU8VXo2
         HcA8Nd/6g8SA3o0Sliu+GhdIWAot8G6UYx+cFdQzOee26215hk+rWI6XkwbeDTIcoxZl
         A0AFHF9BPzgTaP7j4uYParJRJeNyDtF/vNQd8U0VvdLHJPhKuSE3lUw+CJtk9/0S2hvw
         cWrtsi0BD4w7n3XgpJbwqbl21wioVXUkUtNYpFPz1erMIXu7008TBsNjjwSlcz6KDkvj
         HUZg==
X-Gm-Message-State: AOJu0YyM/P459h0ROHFjultOBqKVPT25i8JOD7JZ8UsqhmBR0QvOBr8C
	5hQZ+t36vxi+LwTrOV6VHuZI3/fZDGHvVqBCIPClh5O5mc4Ndj3JXhZ1hNwfdFH0W5y/hUiqv5f
	bNQHF8t2awOyQAUkLoHxNZb6Gy3vOIoOa
X-Google-Smtp-Source: AGHT+IGlSo0mfarda8oz8fAHWoY6x6S244+9gSuoX6ma3KTS1Fcsd6/qf/nwdkSty9KuobA8ALOWte5MVGPgwIZ3Pkk=
X-Received: by 2002:a05:651c:543:b0:2f7:4c9d:7a8a with SMTP id
 38308e7fff4ca-2f791b4d503mr61037821fa.32.1726508464571; Mon, 16 Sep 2024
 10:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916132813.165731-1-frederic.danis@collabora.com> <20240916132813.165731-10-frederic.danis@collabora.com>
In-Reply-To: <20240916132813.165731-10-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Sep 2024 13:40:52 -0400
Message-ID: <CABBYNZJh1G4X7ye7RKDJzXj+JA+5+Nv2z-XTDmmi2bG6q6QreQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 9/9] doc: Add description of org.bluez.obex.BipAvrcp
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Sep 16, 2024 at 9:28=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This new interface allows to get the image referenced in the audio
> metadata ImgHandle available in org.bluez.MediaPlayer track properties.
> The image handle is only available in track info if an OBEX session is
> connected to the ObexPort port provided in  org.bluez.MediaPlayer
> properties.
> ---
>  Makefile.am                     |  9 +++--
>  doc/org.bluez.obex.BipAvrcp.rst | 72 +++++++++++++++++++++++++++++++++
>  doc/org.bluez.obex.Client.rst   |  1 +
>  3 files changed, 79 insertions(+), 3 deletions(-)
>  create mode 100644 doc/org.bluez.obex.BipAvrcp.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index 88044aa05..3a9728782 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -382,7 +382,8 @@ man_MANS +=3D doc/org.bluez.obex.Client.5 doc/org.blu=
ez.obex.Session.5 \
>                 doc/org.bluez.obex.PhonebookAccess.5 \
>                 doc/org.bluez.obex.MessageAccess.5 \
>                 doc/org.bluez.obex.Message.5 \
> -               doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5
> +               doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5 \
> +               doc/org.bluez.obex.BipAvrcp.5
>  endif
>  manual_pages +=3D src/bluetoothd.8
>  manual_pages +=3D doc/l2cap.7 doc/rfcomm.7
> @@ -415,7 +416,8 @@ manual_pages +=3D doc/org.bluez.obex.Client.5 doc/org=
.bluez.obex.Session.5 \
>                 doc/org.bluez.obex.PhonebookAccess.5 \
>                 doc/org.bluez.obex.MessageAccess.5 \
>                 doc/org.bluez.obex.Message.5 \
> -               doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5
> +               doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5 \
> +               doc/org.bluez.obex.BipAvrcp.5
>
>  EXTRA_DIST +=3D src/genbuiltin src/bluetooth.conf \
>                         src/main.conf profiles/network/network.conf \
> @@ -497,7 +499,8 @@ EXTRA_DIST +=3D doc/org.bluez.obex.Client.rst doc/org=
.bluez.obex.Session.rst \
>                 doc/org.bluez.obex.PhonebookAccess.rst \
>                 doc/org.bluez.obex.MessageAccess.rst \
>                 doc/org.bluez.obex.Message.rst \
> -               doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Ag=
ent.rst
> +               doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Ag=
ent.rst \
> +               doc/org.bluez.obex.BipAvrcp.rst
>
>  EXTRA_DIST +=3D doc/pics-opp.txt doc/pixit-opp.txt \
>                 doc/pts-opp.txt
> diff --git a/doc/org.bluez.obex.BipAvrcp.rst b/doc/org.bluez.obex.BipAvrc=
p.rst
> new file mode 100644
> index 000000000..46b12f645
> --- /dev/null
> +++ b/doc/org.bluez.obex.BipAvrcp.rst
> @@ -0,0 +1,72 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +org.bluez.obex.BipAvrcp
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +--------------------------------------------------
> +BlueZ D-Bus OBEX BipAvrcp API documentation
> +--------------------------------------------------
> +
> +:Version: BlueZ
> +:Date: August 2024
> +:Manual section: 5
> +:Manual group: Linux System Administration
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Service:      org.bluez.obex
> +:Interface:    org.bluez.obex.BipAvrcp1 [experimental]

org.bluez.obex.Image

> +:Object path:  [Session object path]
> +
> +Methods
> +-------
> +
> +object, dict GetImage(string targetfile, string handle, dict description=
)
> +````````````````````````````````````````````````````````````````````````=
`
> +
> +    Retrieves the image corresponding to the handle and the description,=
 as
> +    one of the descriptions retrieved by GetImageProperties, and store i=
t in
> +    a local file.

We can probably just use Get instead of GetImage.

> +
> +    If the "transform" property description exists it should be set to o=
ne
> +    of the value listed by GetImageProperties for this description.

Id probably got with properties as the name so it is more obvious that
it is referring to GetProperty, or perhaps options and rename the
method to GetOptions.

> +    If description is an empty dict, the native image will be retrieved;
> +
> +       Possible errors:
> +
> +       :org.bluez.obex.Error.InvalidArguments:
> +       :org.bluez.obex.Error.Failed:
> +
> +array{dict} GetImageproperties(string handle)
> +`````````````````````````````````````````````
> +
> +    Retrieves the image properties corresponding to the handle.
> +
> +    The first dict entry is mandatory and correspond to 'handle' and 'na=
me'
> +    of the image.
> +
> +    The second dict entry is mandatory and correspond to the native desc=
ription
> +    ('type':'native') of the image.
> +
> +    The following dict entries are optional and correspond to variant
> +    descriptions of the image. If the 'transform' entry exists in the
> +    description, it lists the available possible image transformations a=
nd
> +    should be set to one of them before using the description as paramet=
er
> +    to GetImage.

I'd recommend we include the list of possible table of key-value pairs
we could return here, otherwise the client would have to look at the
spec which sort of defeats the purpose of having this documented here.

> +
> +       Possible errors:
> +
> +       :org.bluez.obex.Error.InvalidArguments:
> +       :org.bluez.obex.Error.Failed:
> +
> +object, dict GetImageThumbnail(string targetfile, string handle)
> +````````````````````````````````````````````````````````````````
> +
> +    Retrieves the image thumbnail corresponding to the handle and store =
it in
> +    a local file.

GetThumbnail, also I assume the options don't apply here? So I assume
we cannot ask the server to convert to a different format?

> +       Possible errors:
> +
> +       :org.bluez.obex.Error.InvalidArguments:
> +       :org.bluez.obex.Error.Failed:
> diff --git a/doc/org.bluez.obex.Client.rst b/doc/org.bluez.obex.Client.rs=
t
> index 5ae7cc5e8..f20dd5baa 100644
> --- a/doc/org.bluez.obex.Client.rst
> +++ b/doc/org.bluez.obex.Client.rst
> @@ -43,6 +43,7 @@ object CreateSession(string destination, dict args)
>                 :"opp":
>                 :"pbap":
>                 :"sync":
> +               :"bip-avrcp":

This change should probably go alongside the patch that introduces
support for creating the session of this type.

>         :string Source:
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
