Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E1366568
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480828; cv=none; b=F/jJIveSkWIRZaDIggVIvREUn5jSQhp7Kia//uiL0o+ZxLSjhf29LAz2i+Oy6htgczaAhl2SurOgXEiA83Qy2/YgNFLwU62sEv6KMfsuY9ZukpUsrW4pBEzJolTN7CU8OfQNTJSZKPrXT1cWSqZ9p5xQuA7oBL8UJ2wnLCzIteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480828; c=relaxed/simple;
	bh=H3d7NTCk7vqMaKv70F0Nxm12SAXLyDbLP55808e3AzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvQFtyLRt04G55DpkcvxzXHc5YLNAW2C3iIFoBOUfTrCwJ9bxpbXfeISclMuK4WV6tjs03iVGAf8MSJQWMy5QcGuHma4jqjLnyDuA4MgzkcjFf6czoKb7lWcymlVLa6YurvPiajYnrzVin1GaEKYXvs3GOqqsp5MOrHHYxavWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYhmC/9m; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYhmC/9m"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a5ab1e81fso47665701fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 07:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480822; x=1764085622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlXkEwZFuaLdo4FW6uLunpTk20dTmowyZkZQTUhsU6w=;
        b=BYhmC/9mvRdl8kScpupDGIhuXbK6QHws8fV3F/RV3GDTJzVyMO4AJvxYFFo/FMBtmJ
         pshtv4uggBvRgT2m8p2QwI5BNc/cY2vWtZMHVIdUd5W3hGRy5tbGdidhTZc8AT0j2vNC
         FpxT5XHgoyKlfsHt7mxmDdCABIEV6/w1EymFRJMJ/dQuKepSvr9waYg6/JugSlVDsBKo
         kuKQJ/1qOp/Q+Fh47xyMU9/2lvoVIrHXr4A1PVdwUgzmOlY1jelbcLyP1NJuOMPdhZuj
         QheT2V7JtI37JRXQo9ZwMHGZU591uw6yVDP+ZF6GLI8sfBbN1Yr5Q3NwjI1gro/A7UcU
         uMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480822; x=1764085622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlXkEwZFuaLdo4FW6uLunpTk20dTmowyZkZQTUhsU6w=;
        b=B5n/DrUgeE73s3Qa3qyEALk/Yx6c1wRjulPTZeHke5GxR95wL1vz/URI3O8PULDqGC
         Tq0ECeTV43+gBM7oyMyaBTeNJnj1giwUu5gnXJhsAGgZWpnTQN+hPgkeXrL5LKOPt38z
         JUjYrRyNXcQAd6vebGhqUz28yLi8UX7lHk9aftXG0xDete1KJfKweCg6+VNinmQwr3QA
         P32Of4iiGcDqF+DB3zqAikEXBDqHjV57FRIpx/wYUMBAh+PGBx3gGkMAiGXL+x+ODQlH
         6L9VtLNZK6lBgihnGwbqA4kmsUYhEpcPhoz9t03Vj83ooi1qs31owIxa9vQ8bDAX2/hY
         DcnQ==
X-Gm-Message-State: AOJu0Yw/wI7Ayjwoq8jJJu58l4o1wpu93tmJF2D/HWEO1+DWXx/8tDb0
	SI44CT4ykhWUdPqU3SRgZZiCap4VbnzS72SQnTUlNDQQ9+AjAfUDd+pYxtp5ijl6IGjOli2/J9v
	6ux5HZRYRxjHJKS1SYMMTnfIt/NrYdjHHe+3O
X-Gm-Gg: ASbGncsTu7jfCTQwG66E9r6oHH0gVrDlC6eu20O5ftkErlUqfflWJ9ClEgTTFvSe8ID
	84NFKVBs0BbIyQaTRNfQ/k7kKZHBjnMefH5kEAxcHJHMpjfm14PfnvrgXl6D2eMyakfTeIFdMAz
	PJFLQ2D9RgoOer29l5tkfLeFsz4zzUxdL1HVfwphuUc37JqYaabsANh+nffzXJs4gh2lU0sspfg
	/Se+/1IiWQZZ4/sVxUBvowv9dHN6BWZcPovNFGyMvyiaM4tzo1LkqlmJfXLMBsdls5H6oj+jGv5
	yZc2
X-Google-Smtp-Source: AGHT+IGVUudCYxXMSLBnI5lzfo8CKl5uPlpOpkY+2gitkXINB8RXrHvh/YakS3BGS2iEbnCqZVoi7sh6ILrz1fGpd7A=
X-Received: by 2002:a2e:95d8:0:b0:375:ffc2:1b40 with SMTP id
 38308e7fff4ca-37babd73a75mr35768071fa.35.1763480821330; Tue, 18 Nov 2025
 07:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117190232.3918619-1-luiz.dentz@gmail.com>
In-Reply-To: <20251117190232.3918619-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Nov 2025 10:46:47 -0500
X-Gm-Features: AWmQ_blzO93zF4hVX_dSuhXUQCOjAsWyE9KvTPlDsOER0_L_1gMGom0CW_AqpVA
Message-ID: <CABBYNZLbYqBE8Ah7iGHSXxu2FCHUphxPqVJZJxN7H8Da2qGTqw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: SMP: Fix not generating mackey and ltk when repairing
To: linux-bluetooth@vger.kernel.org
Cc: Yun-hao Chung <howardchung@google.com>, Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Howard, Sonny,

On Mon, Nov 17, 2025 at 2:02=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The change eed467b517e8 ("Bluetooth: fix passkey uninitialized when used"=
)
> introduced a goto that bypasses the creation of temporary mackey and ltk
> which are later used by the likes of DHKey Check step.
>
> Later ffee202a78c2 ("Bluetooth: Always request for user confirmation for
> Just Works (LE SC)") which means confirm_hint is always set in case
> JUST_WORKS so the branch checking for an existing LTK becomes pointless
> as confirm_hint will always be set, so this just merge both cases of
> malicius or legimate devices to be confirmed before continuing with the
> pairing procedure.

Not sure if you guys still have any setup where to check if the
following changes make sense.

> Link: github.com/bluez/bluez/issues/1622
> Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/smp.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 45512b2ba951..08461ca06cde 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2136,7 +2136,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn =
*conn, struct sk_buff *skb)
>         struct smp_chan *smp =3D chan->data;
>         struct hci_conn *hcon =3D conn->hcon;
>         u8 *pkax, *pkbx, *na, *nb, confirm_hint;
> -       u32 passkey;
> +       u32 passkey =3D 0;
>         int err;
>
>         bt_dev_dbg(hcon->hdev, "conn %p", conn);
> @@ -2188,24 +2188,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn=
 *conn, struct sk_buff *skb)
>                 smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->pr=
nd),
>                              smp->prnd);
>                 SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
> -
> -               /* Only Just-Works pairing requires extra checks */
> -               if (smp->method !=3D JUST_WORKS)
> -                       goto mackey_and_ltk;
> -
> -               /* If there already exists long term key in local host, l=
eave
> -                * the decision to user space since the remote device cou=
ld
> -                * be legitimate or malicious.
> -                */
> -               if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
> -                                hcon->role)) {
> -                       /* Set passkey to 0. The value can be any number =
since
> -                        * it'll be ignored anyway.
> -                        */
> -                       passkey =3D 0;
> -                       confirm_hint =3D 1;
> -                       goto confirm;
> -               }
>         }
>
>  mackey_and_ltk:
> @@ -2226,11 +2208,15 @@ static u8 smp_cmd_pairing_random(struct l2cap_con=
n *conn, struct sk_buff *skb)
>         if (err)
>                 return SMP_UNSPECIFIED;
>
> -       confirm_hint =3D 0;
> -
> -confirm:
> +       /* Always require user confirmation for Just-Works pairing to pre=
vent
> +        * impersonation attacks, or in case of a legitimate device that =
is
> +        * repairing use the confimation to as and indication to proceed =
with
> +        * the creation of new keys.
> +        */
>         if (smp->method =3D=3D JUST_WORKS)
>                 confirm_hint =3D 1;
> +       else
> +               confirm_hint =3D 0;
>
>         err =3D mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->t=
ype,
>                                         hcon->dst_type, passkey, confirm_=
hint);
> --
> 2.51.1
>


--=20
Luiz Augusto von Dentz
