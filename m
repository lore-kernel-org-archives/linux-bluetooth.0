Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8F21770A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331743; cv=none; b=IeBwryJv/gO7IyzKH4T3EUXb11AaF3IC58eSyqq/dRslUmtbZbeMAOCMg+7W/59F75jHbWOI1xQ3QHY2VY4sf2G/uRXpmtRyPvnMd3N6segQw506RxXR5QaMQUCrLp/ICLXkTF2XlvuVUqqccMwdB7Hl986kr8R1E5bKBfT1mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331743; c=relaxed/simple;
	bh=9FEstbwQby0+LBbxVNZCiO9npszO40zdLOJQDpsmI/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzEVkUwlNEJcKXIArF5eOUM4FQE7tquxmE1G4l72yXzUwcwVd8VETq+KjbpSDARv86YgP2zMbhepeaD+gDFVdcUW9k+mw5EdgEQyLzHYJI0XHih8nKBmmE+oUzhVHlUDR4RbpQUlnq2JnDtywuJhAeXpWGN3NYiAfwUxl4Rs4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/ktgQUs; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/ktgQUs"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so80848201fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733331739; x=1733936539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beVPuTUEhV/izfyTw5je7GyFeoQuOJSXMt9ZrHJXSZk=;
        b=H/ktgQUsfGp3+qf7R7r2zRruSPx7tA2ybXnClwgaS9Z4kZ1wX1IMvVn6DQmuAqCYKv
         WzcZCZq9RaUZbpSi5NOL2z+xdUCubxAdSgk7CzTWkAl51CmPRiNUrX9+KuPzDGCln98Z
         +A9VnERBxbC82DVKSuoJOMvs9s79i8COMu8a+SZbPfHhNTm3EdacRUxTF1bgpqs9bW4l
         Z+NM+6G72+TAUYBdKbo6bL/r+PUYTzArWoswOTqIpH79zjf+vcuFzRjydIiugDVtduub
         prkESA5qO1+yD2fq1wCKiBq3B/aIzAU1DyQRPkNaoe6NubkyuQfar2M/RuA5xtUVSGv4
         fikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331739; x=1733936539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beVPuTUEhV/izfyTw5je7GyFeoQuOJSXMt9ZrHJXSZk=;
        b=AdfM9h7OVBQ7TlpmF6WD2LOlOOLz+jYSamhCEihMyYI4XNhZcZvqcDEZ5afQYMNO5y
         HFp/mfT1xwmL6TwhtfUm0yBVa+kUlIA3B66d1rVDkDDp93s60E0yuA0a6SAL/umdiq2c
         9Atfp2bsVvpFzGtSXP3Ji0ZMlih7DJwUle2yEHWUrRuyzREIrWN3GPiTBSglkmfMCFRZ
         FDa/XHdEdjrIyWt3HvmjHZUdEBoV7NMAtug7Ntpjj+4lLHrn4xAu5/oaSWgI4x2rOGNR
         3aerrB63ipcUoAYTu3cEgv89Siz1225idPUsFhQrkzgkmlZNAWblbFLRzBLoE2lW2cnI
         RZ7g==
X-Gm-Message-State: AOJu0Yw+ukPJJEQsQNZDaFrTIm+j47WlVX/s/mP62zKtD4TnqtjvEaeB
	G1VVxL5jGiDGSFzvpk4XUOOb6exmFl3j+zc9MvwshnWk475xZZE9Ccrht1gDXfwGGhznTUIVFoU
	HR6m5eb4tGsuRZ7qOaJI65Q2yx1puHg==
X-Gm-Gg: ASbGncv/x+Vhne990dOY1zFvkKA1CAJEhSpzRM2ifGxsr8GyR5MD2WAvfXLVTNGxK0E
	asiix34nFtcpK5Wo9NEzodSwEtnF3zlp1
X-Google-Smtp-Source: AGHT+IF27ZeGLarSyJimYg7Uw+4XzKzqYv2hXhnuDMDBEImseqU5fwIfMr5LD8ubNTa4h2uNncwD1sUCE5Cz0SAdTaU=
X-Received: by 2002:a05:651c:19aa:b0:2ff:8d3b:46d3 with SMTP id
 38308e7fff4ca-30009ca95f6mr45657871fa.16.1733331737329; Wed, 04 Dec 2024
 09:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204165849.392564-1-luiz.dentz@gmail.com>
In-Reply-To: <20241204165849.392564-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Dec 2024 12:02:04 -0500
Message-ID: <CABBYNZJdt-HQf_BkWKL69Nnp0mFZH41cccJu+Fs=wMZOPSWVkg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix using rcu_read_(un)lock
 while iterating
To: linux-bluetooth@vger.kernel.org
Cc: iulia-tanasescu <iulia.tanasescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:58=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The usage of rcu_read_(un)lock while inside list_for_each_entry_rcu is
> not safe since for the most part entries fetched this way shall be
> treated as rcu_dereference:
>
>         Note that the value returned by rcu_dereference() is valid
>         only within the enclosing RCU read-side critical section [1]_.
>         For example, the following is **not** legal::
>
>                 rcu_read_lock();
>                 p =3D rcu_dereference(head.next);
>                 rcu_read_unlock();
>                 x =3D p->address; /* BUG!!! */
>                 rcu_read_lock();
>                 y =3D p->data;    /* BUG!!! */
>                 rcu_read_unlock();
>
> Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple=
 BISes")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index aca121408369..0d59f2cfb9a4 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6872,38 +6872,27 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
>                 return;
>
>         hci_dev_lock(hdev);
> -       rcu_read_lock();
>
>         /* Connect all BISes that are bound to the BIG */
> -       list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
> -               if (bacmp(&conn->dst, BDADDR_ANY) ||
> -                   conn->type !=3D ISO_LINK ||
> -                   conn->iso_qos.bcast.big !=3D ev->handle)
> +       while ((conn =3D hci_conn_hash_lookup_big_state(hdev, ev->handle,
> +                                                     BT_BOUND))) {
> +               if (ev->status) {
> +                       hci_connect_cfm(conn, ev->status);
> +                       hci_conn_del(conn);
>                         continue;
> +               }
>
>                 if (hci_conn_set_handle(conn,
>                                         __le16_to_cpu(ev->bis_handle[i++]=
)))
>                         continue;
>
> -               if (!ev->status) {
> -                       conn->state =3D BT_CONNECTED;
> -                       set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
> -                       rcu_read_unlock();
> -                       hci_debugfs_create_conn(conn);
> -                       hci_conn_add_sysfs(conn);
> -                       hci_iso_setup_path(conn);
> -                       rcu_read_lock();
> -                       continue;
> -               }
> -
> -               hci_connect_cfm(conn, ev->status);
> -               rcu_read_unlock();
> -               hci_conn_del(conn);
> -               rcu_read_lock();
> +               conn->state =3D BT_CONNECTED;
> +               set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
> +               hci_debugfs_create_conn(conn);
> +               hci_conn_add_sysfs(conn);
> +               hci_iso_setup_path(conn);
>         }
>
> -       rcu_read_unlock();
> -
>         if (!ev->status && !i)
>                 /* If no BISes have been connected for the BIG,
>                  * terminate. This is in case all bound connections
> --
> 2.47.1
>


--=20
Luiz Augusto von Dentz
