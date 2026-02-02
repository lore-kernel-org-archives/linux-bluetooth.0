Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596C291C07
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Feb 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050479; cv=pass; b=ZMWnfaIP/zToy2ptZM5gdWmD3di3IUCkAI2nN6i/aB30CVA0FtJJVUWo16+ypj4U3LGW+gaKoq/QQ10bPeEsjHezOQ0+4eDKnZ3Xq9ZmtSKPSSOv38fxcTJDqZMxtUPkieFjtgCucpn4OihoTaY8Wys7ZifLKs57UhQ3+fE/v6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050479; c=relaxed/simple;
	bh=u/4yFFI8XDc1JUXQ2Z1phEr+Dtal/bVt+fM4egIs48s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJJ7pexPeP7w/pN6ThqteIWjZIBir3l+j6JtyTJL1dlHZAZawS4Y9C+BHqwf1CAiDUGzfxyJ6C99vXYCDPR2aChSmz7EYe9GXLspUIJssjQvaJBSfIgHUDZ6YjlzRi7Fs9bxvVfzMNeXSoqjjJ76MgYlYDYGea2upOm4GgPrPSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbIJDj/b; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbIJDj/b"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927b1620ddso66913857b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 08:41:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770050477; cv=none;
        d=google.com; s=arc-20240605;
        b=CmGpNIcfJO8v3ITN0o/6aRWJ58YstotyKa9bzqJoy0oyTZC1jrzQGYngOCyIVHz40H
         N5QcMrHbcnCqMyoAevum+Lmwkc80feFBjI0Oyc+U0ZZ77JMM8o9oy+9UsM2Tk9PCLD2N
         b4ZU7oZH0QEQrXFzTGiIjCQDPARa+31OhHknHcM0W1hrp8PH9iGke6yd8zLe9hW/cfkY
         Uebjux5GY3xuk/y2kwVVcexb8kuqUsS6KVTF3mS0LaxpvMg/CsnJ1Mk/9p0kSBz9UAC6
         kl+SU7oeusSCnDiXHoqi05Q4sIii/DAF+gYqlLh/DNkdU5rZ1s9B5ApK5IQL2I8sjcsy
         uwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0B2s/Kbxxtv1gV/6lfad9fmm0G8/HeOd+257cPZJPDw=;
        fh=AEl3mMWbhnp4lbMu9zC46bTSuSCzZicB/+wSCPMilSA=;
        b=ZIpFrayddYn9lcpayWg6NED1rdR2qdAhBaghsMlyCsQ0yJ6nvFgbJVcYjtSU0upYAS
         Mhl82nKa/wEKmpqpYs5vVGLbnI047vj8YTzRPx0FYRwx6CPhzX39T7S3k5qNXN5I2s04
         4+0dvA4QW0b4JHuXpwucjvYml4ErOIlan9BFu0befIyf1+GIvzx+oxOrOjSF3EduKPTb
         bAkM1bVAtbGS4ooDi4B/LTZQHqcP5fFFsYJLtuzctJAAe3QPtM5k06NoEu/Bh5ihqU7J
         0pP90svHFy+CptLOTAkjff31KWBm3zwJKctImG28QCNJm/+F14ApGXeB9BOg5wGP1+Mu
         Ue3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050477; x=1770655277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B2s/Kbxxtv1gV/6lfad9fmm0G8/HeOd+257cPZJPDw=;
        b=UbIJDj/bmpbYgYdP41iWhBDkXJ0/so2PJA0CgMDbCJ5zaGTmWwZ1HZZbyH9r6OTIM/
         w3pZ06knIFjYfGq5DdURZMMyzbuXWkScj0BIe/YKwRYcWzl4G7MuOOLOWfL+nTOaETOs
         IWCWDYGDhhk1w3vqDU/2J4DSBFxVLFyxKOMHhV74TLqf8u0Auk7+YU2tyiu27bS6hhTY
         b0YdBhCv65t0Xne0nkjlFbSQszy96N0a1ZU6a3+uuL+chBgTY2AL0ipmdoLHxsooN4uG
         jA89St3mOaG4X4UWqD3HDJ7U8bAt/o2FnU1MKarianzwVH6JHnCzVWCppZjawctAnI5k
         vV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050477; x=1770655277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0B2s/Kbxxtv1gV/6lfad9fmm0G8/HeOd+257cPZJPDw=;
        b=RkC4XLVKiBuw/29+4Yq5bOvqA0LVXusup15erJ1r8NyAvIEEdcPEi8uM8ztuyzZAkz
         eFh6JN01lRxPz32eoqgpM5mucRnNhkGfffIDz+HJtb45iGVwmpDSUvkMzPDVuBdHamsK
         yZILUcIkVwAZA5zYE8552nr6jf+UvEiKuW8tk2I9ofJ/3DPUJsX0iL0BYCowc49NombU
         5UsMCyAkeGnwA2iBrDZ9CbiBBF/nX88+mZSxeOt7jKZ54uOi2lBOp8eJYrXrtStPyfI4
         k4icTaF35Vo5xhjl1t7KInch6Xdrf3EOerZXiA1KxgnZnUdY1dKqgqYVItW4rGCrgBuj
         f5FQ==
X-Gm-Message-State: AOJu0YzSvgbUss1C3tr7R0BbMkzU5pHdnuWGP62WhhfOLrOu4rCEB0u0
	TZMONfnwE259P7bQbIWzZnswRYRjiQ//Pyp02ZFcXtDhbWh7nkSd/6Fb/CF23rlEFhj6eeSaJTy
	SmH1u0yP23R0oB/bvzt4ExxOiS4RXn3vfzIDpPvs=
X-Gm-Gg: AZuq6aJ5799u3Q3Kp3kf4OU5EcPuPavaSzUs+ZfSjo4yQL3Svb5mbDdPHIu1P1k/Bgm
	tQhalUb7b1B8lPscnD0IDKme9gAurom5eBAyeNVjuP5MgGhHvmH4BTZVUxCtPUJRuEIJn6W+57x
	ZDjdJosXBx8ltSImaaSoVGQreKZJkbHVUZKeIDSi6EGZahD4WCR/N2xCHJtYyytKQq2ZZdkKnB7
	jDPqwCJ1IChCVPaWU9+OSMmxYBQoQXjEZM7GMQM1gzON6cB9kscTWr3CeXwPrFWZg0NOAmhpN6p
	lrpNSC6y2bl9gUF6EtoopMK+/cXZ1PkoqrxpCPV1gxbFkULuAStn6qO8U/hF2IF6epB+
X-Received: by 2002:a05:690c:f8b:b0:794:d9f0:2375 with SMTP id
 00721157ae682-794ecb86e7fmr855467b3.0.1770050477268; Mon, 02 Feb 2026
 08:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202153215.27593-1-limahaliyana@gmail.com>
In-Reply-To: <20260202153215.27593-1-limahaliyana@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Feb 2026 11:41:06 -0500
X-Gm-Features: AZwV_Qitba9jEmwOLMcRtyDexgxnMlZ0CkbzDu_gV8Psg20YDKqzghRMBoi2qT8
Message-ID: <CABBYNZ+RGPvwJzkOKy5jn72L_Jp+jCVkKJEapOYjyeVoM1VCxQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/att: make att channel respect LE socket
 security level
To: Lasan Mahaliyana <limahaliyana@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lasan,

On Mon, Feb 2, 2026 at 10:37=E2=80=AFAM Lasan Mahaliyana <limahaliyana@gmai=
l.com> wrote:
>
> This prevents unwanted pairing requests instances where gatt-client tries
> to read gatt characteristics that require higher security levels than
> defined for the LE socket.
>
> For example connecting to an LE L2CAP CoC socket with BT_SECURITY_LOW,
> one would expect to not require pairing. But as the gatt-client starts
> automatically for the initiator, if it tries to read characteristics whic=
h
> require higher security levels, it fails and tries to elevate security
> level. Which would prompt pairing.
>
> Which makes it impossible to initiate a LE L2CAP CoC socket with
> BT_SECURITY_LOW with some devices.
> ---
>  src/shared/att.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 77ca4aa24..ac527fccf 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -1193,6 +1193,23 @@ static uint8_t io_get_type(int fd)
>         return BT_ATT_LE;
>  }
>
> +static int io_get_security(int fd)
> +{
> +       struct bt_security sec;
> +       socklen_t len;
> +
> +       if (!is_io_l2cap_based(fd))
> +               return BT_ATT_SECURITY_LOW;
> +
> +       memset(&sec, 0, sizeof(sec));
> +       len =3D sizeof(sec);
> +
> +       if (getsockopt(fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
> +               return BT_ATT_SECURITY_AUTO;
> +
> +       return sec.level;
> +}
> +
>  static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
>  {
>         struct bt_att_chan *chan;
> @@ -1219,6 +1236,10 @@ static struct bt_att_chan *bt_att_chan_new(int fd,=
 uint8_t type)
>                 chan->sec_level =3D BT_ATT_SECURITY_LOW;
>                 /* fall through */
>         case BT_ATT_LE:
> +               /* respect the current L2CAP socket security level */
> +               if (chan->type =3D=3D BT_ATT_LE)
> +                       chan->sec_level =3D io_get_security(fd);

Nack, by respect here it means don't use BT_ATT_SECURITY_AUTO so it
breaks the likes of change_security in the process, what you should
probably do is to identify what attribute is requiring security and
then simply don't read it (by disabling the plugin if that is the code
that originates it).

>                 chan->mtu =3D BT_ATT_DEFAULT_LE_MTU;
>                 break;
>         default:
> --
> 2.52.0
>


--=20
Luiz Augusto von Dentz
