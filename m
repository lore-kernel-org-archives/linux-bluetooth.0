Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4F395DB4
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901233; cv=pass; b=nQ9jjTo6xcbiZvuLW0D1zlZPzl6e+Jt3O3U8fHuF7smaR9ZKT8EbTvy00V0xmCWG0coD6qBKZ3KmO5tmVtohZkXtgeDETPoRSZFnTL4diCvmS8rknc8NU7CpdeIDpFTKQP9ZkE+jDEQecVwA4JZ2+Z/YYcGZ05DjpQ57q9clXT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901233; c=relaxed/simple;
	bh=XhCUIJIIyi5yadFeGB2KrUn642zUYBdNPYf8xkB063I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhBHBQs/+cfho6dCdMeJaMCoTx+2iF9+0Fnef+SxRts9pEXwdUI/ByydzBtfDh3hROG3ZPTYwdvWKXFguPk3S+7wlZBLLgyfR+TqBZdVXqV4ZDx2T1LOYMTfIl80CdlP3FSwf3GrEfapX0FezjO9hY1+2aLfng8GdciS2w73fZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtTnJc68; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtTnJc68"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501c0399c4so2616120d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 13:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774901230; cv=none;
        d=google.com; s=arc-20240605;
        b=bPCJRnBt6wg8RkNLXFTlPZa/Bm8UnCSBvGdk2EHDU2sc/K2iXgDj+ZFGXwCAwF7/q0
         7w6eZlyTkorxC10OE08Os9nNFKrU989aiOmjmW19ZLSYW3jfG0Afs8Y7IbjJGkMiYMc6
         7Iz90Bpc3q5XiNrlhfONELpWUFow0iMquVehamBUAdf3QWOdIigwHdCWW8P1Ka3pahPb
         N7BuZouXlETBB4iaBkBHYtzyquckc9byzLZs1GQL5aJwegmJiEHuxPP435G0P9LwbTQ5
         GhNuflE9MkplfyCMLuONXcrwbCpu9zkoEHd7uvW4btE5Jh+gslRRmZMzup79t9bCINPr
         sVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKr4CbnJYWBCmmifHbM8+UnuBnJ6icBvzVYjOI+lMG4=;
        fh=NYwlcEMjBzyalpyF5mHm3vy0MUk50HCsHp35QIIJVFI=;
        b=FjQacFMUMi+2a1+BmKikC54XZMZp2zxiNEFdVrvjPHj7U3z1eE05wbLrKErrlwHAYL
         BpHQNkfNB6VWbt4AyGZxI0YspvrxR6Dx6hwNOxA96I2f5UXywRK3560fUc39DMBVFZZ0
         K5d8M7aUYVBBrG/RagqVT0MsctH1URRonZHRedyHAzHoZnJuTAC9DVgsAPN+dKGaz4rq
         lhCMUiKUu6GuRyL2cV90AomGGHB5T2XLCPQHPmgGBGDBTY7zShDuYT1L3imTW95oPM+o
         vYrR+zVQnQNY2fGs2Z9v9XD63zySchpH8zdkb9gaojfBfhCrR88fkxO+q5ewIV9GwBLR
         O61Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774901230; x=1775506030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKr4CbnJYWBCmmifHbM8+UnuBnJ6icBvzVYjOI+lMG4=;
        b=XtTnJc68c4hJ3tCr84H+KeZx9hFu3O49YRuWo404e2R7vnLkLvRp/7pphifJQ5k7Fh
         yrkiatA65cY6oaPS2cFjTj8XloeAcOw7WpA2+J625j6CclEyGJ9fZNVBnZxtiYlM+oE0
         lI1+xV5wDGy0pGINtHhW2u/Rbq2jZ9JpfXV4GCCGbwU1beOAW2snApoiEACrhVkC4yqs
         u+4zKohVVRmfRNuCjXGqienLE6qXdce9E9Tkfj9luIhWUZKa/IbFbDwJHb0ByY/rVxgE
         C2B0CKshxzf40qcfDpD6UGLRMlUfBDBI4i5OYxgegqdosD0Cgao10MWPJkf5m8yBkRCt
         UXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774901230; x=1775506030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dKr4CbnJYWBCmmifHbM8+UnuBnJ6icBvzVYjOI+lMG4=;
        b=DfT9m0tEHaxbXwagPiThk882I7ZgmSKrjp5rgQysKT2oK+h7LoZ+SGrHT8q2mgqQzS
         VrIfCJAz8KiSicN4BJyqXm7Q+4iiaYkrnySioxHM0YkqTeQURA9lLqpoXVmjhUpYhKFS
         cWWajCwjW455xTPNLl511OzyNfBXENJ5MttH9y46Cwj3sSPhurPhzrBNRdW5pGztSZ9k
         hVVo29J8YKtgmRMbtCiSfhBbbcg456npkyZtVYHdjOfEosJcZXC7sEcMnV8tl11ZH4kr
         05a4/73t7Afs8IbsXYKX48dMmsCyxkc8Fg8MIocLGuxn3eyl0j8Y6Hl1I4QEdy13QaMG
         m2/g==
X-Gm-Message-State: AOJu0Yx6q6Ngkcl8r/A2nvOwbWq8PnmmLs1E/wWY8dJOgIMIlc0bJOhH
	9UyRGqPNHJvzTKzqRhCfsozlSErI3f028qkNMfWmNDjL8xTAuceiQd9FZriprrXN2n/X1lYbVqA
	aWKjOiM11qXvKZ1P5gkhovcrys2q6HbTDiNi4DOc=
X-Gm-Gg: ATEYQzxjppmekXdJCA4AEKeDvkNE5IFckThWx8J9ITQd6zWo9rl3HKOABeoGL4QhVHH
	TARDJ2xKMFGz6V5wiHyHzMu48xQUlq3xyVP1s1NWhLcR6CcBrj7JICqJazh/TWZeINFcv7jQ/UB
	A5uhcq/uc+/NF3HWsaOQjXKBLJ2zUGtecBwd6W2tqqqIonZgYlfabVtwkIp43hq1edvONiVLCK5
	5szYbHgjzEfI106tAV4KntEBn0j0L19UL/Q+An58s1JUcdKiQi+PhC7mB5y+b1523tlGdUehdeE
	No/S8tafbErVzZXf/Wn7vFA1sXfJwVT2sdYMBDn7xm3TCHSU1m5HiUVQYiQOkMMhyzE=
X-Received: by 2002:a05:690e:1187:b0:650:1102:64d7 with SMTP id
 956f58d0204a3-6501102668cmr7864038d50.10.1774901229894; Mon, 30 Mar 2026
 13:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328084648.51158-1-keenanat2000@gmail.com> <20260328084648.51158-2-keenanat2000@gmail.com>
In-Reply-To: <20260328084648.51158-2-keenanat2000@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 16:06:56 -0400
X-Gm-Features: AQROBzBBOo-xmbp0C3gbI8pnMN_yqGCLBhI4xxwhqBqEgrjG-r6TZoLehMRKrhA
Message-ID: <CABBYNZKEWUtkZX9jB9nrTzLUwQh0MCVVaN0x6W1bNM1A5LXKRg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: require exact mesh send payload length
To: Keenan Dong <keenanat2000@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Keenan,

On Sat, Mar 28, 2026 at 4:47=E2=80=AFAM Keenan Dong <keenanat2000@gmail.com=
> wrote:
>
> mesh_send() only checks that the total command length falls within a
> broad range. A malformed MGMT_OP_MESH_SEND request can therefore claim
> a larger adv_data_len than the bytes actually present, and the async
> mesh send path later copies past the end of the stored command buffer.
>
> Require the command length to exactly match the variable advertising
> payload size before queueing the request.
>
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
> ---
>  net/bluetooth/mgmt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index e5f9287fb..aad0da033 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2478,6 +2478,7 @@ static int mesh_send(struct sock *sk, struct hci_de=
v *hdev, void *data, u16 len)
>         struct mgmt_mesh_tx *mesh_tx;
>         struct mgmt_cp_mesh_send *send =3D data;
>         struct mgmt_rp_mesh_read_features rp;
> +       u16 expected_len;
>         bool sending;
>         int err =3D 0;
>
> @@ -2491,6 +2492,11 @@ static int mesh_send(struct sock *sk, struct hci_d=
ev *hdev, void *data, u16 len)
>                 return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
>                                        MGMT_STATUS_REJECTED);
>
> +       expected_len =3D struct_size(send, adv_data, send->adv_data_len);
> +       if (expected_len !=3D len)
> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> +                                      MGMT_STATUS_INVALID_PARAMS);

Ok, I guess you are saying the following is not actually correct:

    if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
        len <=3D MGMT_MESH_SEND_SIZE ||
        len > (MGMT_MESH_SEND_SIZE + 31))

So is MGMT_MESH_SEND_SIZE is not the size of mgmt_cp_mesh_send? Anyway
your check can probably replace these checks above, it would be great
to have these conditions covered by the likes of mesh-tester:

https://github.com/bluez/bluez/blob/master/tools/mesh-tester.c

>         hci_dev_lock(hdev);
>
>         memset(&rp, 0, sizeof(rp));
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
