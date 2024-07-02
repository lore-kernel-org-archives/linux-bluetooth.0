Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784291BD01F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932452; cv=none; b=VxL5+QMl8KyWQk8dgMcDK4BpHQKCR2H+YD2P4ZJ8zYlIO4P1/Ox7wstfi7tQ1XAZ3dooia7MV5LY4YJDsjvZP3N8MVM2JiKkRpGz3rkI27pFum7lm8xXT+3mKNSJ3eHomPeygiN0F1xt5yybzgL7E38YZ7nsjqIxx4oTnoUwp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932452; c=relaxed/simple;
	bh=8noMJqQRClgVC7raXZGEd9F7pDYbCkehXGRaOZvUJWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW4H64eRp+q3MhsuAFLYoHeoGs4jLjwjjhWU8BfPUSU+QmgTXa4qM8XOSuPLZGOovC6dL14EmfwM6voXoTs0dn7z+SIXvJ0cVTDxhqzzRmqrq+hCd+d9eZuprSk5guGKTdjuq7kQss7lPRxuYNfr/QPkmtCdKieHTXigA8hQGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mllNuM+W; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mllNuM+W"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec59193468so33737561fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932448; x=1720537248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWntt3/Jy+qziZwKzW3U4ywIEWb5hPjBxyX9tp/aA9A=;
        b=mllNuM+WhqbU1Kf4FWRWfqO9ULs8JJGMNt0oPt4rg4TVSWcRtM+yiTZxcO+/5dsGNl
         aSn+NxRdCrY+Y4eV0LOQOPnZl7si6uKJqqUuQwDjopc55uTlq5nQwRrFmmHRSXA8Z6sG
         6jssj9CT6ni2wbEyPHTYG2Kmi0FWnevSg0lPhBbWtLtgRKpvFfB86nU2nhgJ1qRVhUou
         nXwwVD7bmMmgy+8Uaz8aHLBvczj9588ltrVxLGkG0KyR9TZwBs4rEpHv7UjzlBa+BaLY
         KtyBM2J7tMVYSFSp9pl9ZmQNE94qidqx5uKXP/MVDgJg4/bVFOHN1a0DrFS4Aq+HHwI0
         KtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932448; x=1720537248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWntt3/Jy+qziZwKzW3U4ywIEWb5hPjBxyX9tp/aA9A=;
        b=UmoBeaYVj5cLugQXkXLMRbnku3HLMyKRhqTOSOj2uPKNO6j3i+eLx/vcLjvPl6huok
         V+ZaY/3O2zNiDhlbifGbnMojBzL+GOmX8IEfK0EFt8m+jiO1wiBiRxTO5Gl6J0yF08hJ
         NZjA3xJOrbBt/sdLMDL0rpv/Of6k9uo5xlvl+qEFGhV/aXSJdnS37oWYBuOxXlKTAf19
         36FzBoaF7/aOqFZXeHTVXcSNEZoogpuq091LxEv7L4R5BHGdt+1Yo3kNb9vLLgk2NnPC
         mlCFgZKAgDvUll0g9I6+tywduZP7WHH+7BZl/TVK9eO63lVWmmgTRNVjHjT8ibB9SLA1
         W3xg==
X-Gm-Message-State: AOJu0YwGlUXYgj6Hue9W9bF5AevPhNZsmBx2pRERkPioYYb5VqZF7Z7U
	1W544nYXaTXRNF9my+/tJztY177HYUImG3wDb0+Yr+SihT8DOHCwq9CDg1PtgmWA9HNBgEQIh5G
	CR2bMP4O51cwXrHTkMnTaIe+2BHeD9w==
X-Google-Smtp-Source: AGHT+IHAHuNQPDORLE9xYEZ+cr/WrcBjeJeJktpXyiquMkSUHZKtCkZWPsecqp6uWdeW4AUYENfGEEIMjsvDmnfzVOI=
X-Received: by 2002:a2e:b173:0:b0:2ec:5156:e8c2 with SMTP id
 38308e7fff4ca-2ee53c5850amr35108231fa.18.1719932448242; Tue, 02 Jul 2024
 08:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702134106.102024-1-r.smirnov@omp.ru>
In-Reply-To: <20240702134106.102024-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jul 2024 11:00:35 -0400
Message-ID: <CABBYNZLZ1D5ujf938c00mNqNPdG+RXBScQnAZw9FYB3zrLTr7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to sock_io_send()
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Tue, Jul 2, 2024 at 9:41=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> wro=
te:
>
> It is necessary to add a return value check.
>
> Found with the SVACE static analysis tool.
> ---
>  src/gatt-database.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 5756eb9d1..99aa6b63a 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2625,6 +2625,7 @@ static int sock_io_send(struct io *io, const void *=
data, size_t len)
>  {
>         struct msghdr msg;
>         struct iovec iov;
> +       int fd;
>
>         iov.iov_base =3D (void *) data;
>         iov.iov_len =3D len;
> @@ -2633,7 +2634,13 @@ static int sock_io_send(struct io *io, const void =
*data, size_t len)
>         msg.msg_iov =3D &iov;
>         msg.msg_iovlen =3D 1;
>
> -       return sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
> +       fd =3D io_get_fd(io);
> +       if (fd < 0) {
> +               error("io_get_fd() returned %d\n", fd);
> +               return fd;
> +       }
> +
> +       return sendmsg(fd, &msg, MSG_NOSIGNAL);
>  }

So static analyzers are complaining that we pass a negative fd to the
likes of sendmsg? I assume that it was safe to pass it this way since
the sendmsg would check that fd is valid and return an error, anyway
it is valid point that if we catch it earlier than we can print a
specific error rather then depend on sendmsg return, just wondering
what is the static analyzer trying to do with respect to checking the
values passed to syscalls.

>  static void att_disconnect_cb(int err, void *user_data)
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
