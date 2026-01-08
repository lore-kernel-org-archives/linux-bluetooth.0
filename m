Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DF32720E
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897999; cv=none; b=jNi/fp3G6mm1TsD3gttweY88Pw+G0LwjxKHiRfbaOOm/WaRM9Os4pgLXT4hpAlRlVaIQPA2sV4EK9L/FWQuVU8RYZe4VRLfHyIXeNT3+tAdI5U00q15TYdTjWg8dp0ktlM63rW/4IBextQUNyWwuKBqQAzlkIkHLXoAi3vq5saQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897999; c=relaxed/simple;
	bh=jzBYelsovD/tAz+dW5pDPR48Mcp5jOA7xy3XyPAFPkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grn++uoCKNy6MDBYAmHvX7ejVb1glk6os0Wlv9UcfjmH6nGGuTrT4OaOx/F0WT4jp7MyeoQP9/NaOwb2NEzli247Y16ob06KyFjdv4TAkp1+W2Si85XwDeifauM5so2QUv1rGrASd43XizRqFIAckmw0czh5PF9tMJvyKJfUekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbekhihM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbekhihM"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso5738544a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897994; x=1768502794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu2UowQCQytnQtriZcRiEfMmgX8XZwkm5VBActmaST8=;
        b=PbekhihMJslSm7nn79VEE6p0bvM0sgf+PLY7acFXPXFMn82CU/RfnE6KgmpMWT2Wvq
         nlesCfmfrhTb5sfy4xxPL769FeZl8TFLkpaLaSVP4cdSKkcGaU8j2SC1yPgFq0ILT7oO
         bTmr3O3zNn990oz1IIw7XzUG0+SVZ+Q0O5yHFlyRykNJD1Pawiv4rn5UVxTtb5Q6Pj6H
         +az+kXOcJG4555TQFgOZ+KQYeLz385pEcW+172E+ho4n11PxVmqTWy7jsIV4AQsNEtpe
         OpiWyDEVmfUR1o1Kwo8XKKOLQ6ny00FvLZg4EtWJIGamvJ2JUl2oWta6kskrl8rGm0Pe
         aYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897994; x=1768502794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xu2UowQCQytnQtriZcRiEfMmgX8XZwkm5VBActmaST8=;
        b=RwwN3wCzUhNS4tgSjJ8Fb5T5Dj8xX2mi/kYQW0qRH2uwn0l7Q0K3mLhVVZ1XrAh/eM
         ayPeXn2u2vbRARAVDgsSUOQb05hySDZXQ6gBhXcEESbnveWqieTZufv3pUrXixLmsTKb
         FMgJG56Xi/49iYPLwBxbKVAHyuBSPdrzxze7UMEUj0fZGyQsP4HBQ1oZCvL8Qh5/bReD
         6OVGSO1ExCSfyIvDioFuiTSk4cEeP8Gq0F1vNqEfElfehJ6RrDMcO1UWY7KW/peWZdKk
         cyjg5cNLoX6up7zpXMINTzBjwFsnD1bOAUY8ZeGVqle2za03uxv1k6aHz+xxlCDh6+Lg
         Rn5Q==
X-Gm-Message-State: AOJu0YxMW6e6HLQtTt3sNHwZNpoWr9Wl6P/CI0oYm0szbCUVrIolXPal
	PDbHtGxlgxRxzHI3beqilmldY6G0GOunOMgezu9grHiZauxQSrKENfojRvjkklQkCsmaI4Noo7A
	TOfeN5WN8jDNd0DrNs/SmGdbfmj8QT/NgGSOp
X-Gm-Gg: AY/fxX7nzfOboH96JpXH9pxw6E3LfTNmTS+dedWlaHuhGKkfhFIPHi40BjGZOhRqedJ
	9joinoqhLjcoxn8NCdgKt3cUXzy7G+MmvUUgExn+ZXwmt6v49HB6lZTe1g6CpjgoyRy9zVSILmn
	wsIjVuYUj9NvOMlTsq7fnPwbSPKJ4K+by+qy3fE8z2B9vW0lr6CkMXLDw7ZYRO6MT2moP1VNg67
	jJ/usdIZJsJ0vTgJLtgZf8f3iPJzRaKNtpE03p0fPNfJkEUkEtr0XD2mkLbGyAGg2kYFHwvEb0a
	hHa7+Ic3ckZET+Zk6g03kC591Dof
X-Google-Smtp-Source: AGHT+IHOY1gxTpU4dDEcjpI6ROYt7wtaAiZsYjnPeSqVqPsU7mAUWXhHjdW1kWIzp1FdInPAjIJx7sC238m/8H2dhNw=
X-Received: by 2002:a05:6402:280f:b0:64b:3e03:63b with SMTP id
 4fb4d7f45d1cf-65097e8c00fmr5292414a12.31.1767897993952; Thu, 08 Jan 2026
 10:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100136.486675-1-dalegaard@gmail.com> <CABBYNZLfjWHAUorAmRvam+2NnGqRw0HF50XBoQNEXVEdzpQBjQ@mail.gmail.com>
In-Reply-To: <CABBYNZLfjWHAUorAmRvam+2NnGqRw0HF50XBoQNEXVEdzpQBjQ@mail.gmail.com>
From: Lasse Dalegaard <dalegaard@gmail.com>
Date: Thu, 8 Jan 2026 19:46:21 +0100
X-Gm-Features: AQt7F2oE0rJak8pSFCNt7LPa32Uw3Cm9J5WKhDKnk4SLOlaHVcMgf1RISWnfDDA
Message-ID: <CAJWtJbZAa+_2rR6dh9W9FiEBvvj2x7O4A5cCE2-czgPddAB7PA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gatt-client: fix use-after-free
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Jan 8, 2026 at 4:23=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Lasse,
>
> On Thu, Jan 8, 2026 at 5:56=E2=80=AFAM Lasse Dalegaard <dalegaard@gmail.c=
om> wrote:
> >
> > Clients with an acquired characteristic subscription would free the
> > client during disconnect. When notify_io_destroy then tries to remove
> > the client, it'll use-after-free.
> >
> > Add another reference when allocating the notify_io and unref it again
> > in notify_io_destroy.
>
> Please add a backtrace to the patch description.

Are you looking for backtraces on how this was discovered or something else=
?
There could be multiple paths that cause the use-after-free.

>
> > ---
> >  src/gatt-client.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > index 44ec95db0..374e67c34 100644
> > --- a/src/gatt-client.c
> > +++ b/src/gatt-client.c
> > @@ -1566,6 +1566,7 @@ static void notify_io_destroy(void *data)
> >
> >         if (queue_remove(client->chrc->notify_clients, client))
> >                 notify_client_unref(client);
> > +       notify_client_unref(client);
> >  }
> >
> >  static DBusMessage *characteristic_acquire_notify(DBusConnection *conn=
,
> > @@ -1607,7 +1608,7 @@ static DBusMessage *characteristic_acquire_notify=
(DBusConnection *conn,
> >         queue_push_tail(chrc->notify_clients, client);
> >
> >         chrc->notify_io =3D new0(struct sock_io, 1);
> > -       chrc->notify_io->data =3D client;
> > +       chrc->notify_io->data =3D notify_client_ref(client);
> >         chrc->notify_io->msg =3D dbus_message_ref(msg);
> >         chrc->notify_io->destroy =3D notify_io_destroy;
> >
> > --
> > 2.52.0
> >
> >
>
>
> --
> Luiz Augusto von Dentz

Best regards,
Lasse
