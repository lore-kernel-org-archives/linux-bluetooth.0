Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6021D173A
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896812; cv=none; b=AWl7vcl1cNJCHvYzUuXIAAjfYRjtgW9k6jbjFiG29FKj5EREQn8jtGW1AO/G3nl2hV2IZkUWv6+ntB5TW3fM5incKfRm2fPERRbmRbPivD0MlFLgD+py2ObAixR6PpK5+erXjwPqEYYPHT6knvvgg4IE9I7/OZDk4hi11dR/Nzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896812; c=relaxed/simple;
	bh=rX8joWNGRpMwuBaI/jPf0b0s0uuMxpWyNa0UgejN3F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzVv/LDfviFEJ+gmXWJqs9TCRH6LJXxRMrkXrot/rA9kx4ISjR+s1wDF+yIdVWfThansByWj895V+nF1z6HNzm7aoRAxmhOz2B5tGyWKqHDFIUMgdd06WAZ7ZmRFQg2Sbw6OB+rOOPRaIDUXkwwfpdGtdZuw2GTZnmHE/j1V17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdJT3DWU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdJT3DWU"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so1455751fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727896808; x=1728501608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4YHOCdxSVOyyECyFoB6dwiFWiEGqVUTCl981zKGkkw=;
        b=QdJT3DWUqxWdyAbvQs9ydud6ySZrDmpCcIC7Ly4Gy3Nd/G+UMNT1+s80gpuEohkYYn
         qKNRh/dnclO26YyCNdzxmu62GpSfzpQ0TotlEtA/qVJk7B/osrV660lYfV9no4NTOqm6
         x1MSuiVRTlxn/36BP9bLsn12CHOvh3jtPgFOwifAiPaPjLKxAzCEo6pZ82g7CFfPRZtj
         BJf2vaWL6aQRujER5BsAdRKhp6gSXJE0JCxFwvad54+EzFc7SuPn1Vy7jtXpfjsmxXgB
         c+9VMbD8XUM/Y7o3kpDojx2LFI4sgepC3wmdEeDorgH6No4UuKqodqcorwsDHRUlI6BV
         jasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896808; x=1728501608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4YHOCdxSVOyyECyFoB6dwiFWiEGqVUTCl981zKGkkw=;
        b=OPaITf9kNDAsEwMB3k7+4SvgSBbvBfo4XoDGS/CdI9nXK5yamXl6N+MSzYNaBpmI1E
         BLFdmv0GVQlsaVkAn2qb/Neb0LCi29hZO8hr2cpMkCdkkhkwoMbLc6ll0FRPjwepoFQc
         +XyISQLaBLVM0gFBF3x6b71MIiIhILAKSax7w9nezMuOcX4q+qmze8y0RYZ9TkFLbFnG
         zn2ShkcOWf4tJAvYf0KpDRWi8pe6pChFyjQRI3wa+B6F2Go/AhFfOPU+2oBQpqDse0Bs
         3BiW+DRjn9bXtHd/0TEN/hcFGNwU89LNd0Px+KXON/tktramvtflZQNB6sfX66b4jPjG
         fk4w==
X-Gm-Message-State: AOJu0YzJF4t5yTDjRtwxFMoh2G99OTnsglQIGKrcwF6GxzW7Yoqbzo+8
	h2KynwjOl7j3GdLPSsdWY9+a11xvdjJBqcO/n0GilsGbM3ni9iBf7LXFtTcqtAtzA9Tq41Wmrx5
	iGARXZ666sbzO0w51JcYypg/XMBc52Q==
X-Google-Smtp-Source: AGHT+IE0sLUJcw60UIalr64ORmfBMG+FGie2JoPbuNNGfc32jEbO1ZcRd/fiqsUNOm+8kWihPpz9romy+CwF7dEEUPw=
X-Received: by 2002:a2e:a548:0:b0:2fa:cd30:8dfa with SMTP id
 38308e7fff4ca-2fae10b4b01mr29239731fa.44.1727896807974; Wed, 02 Oct 2024
 12:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002190452.3405592-1-luiz.dentz@gmail.com>
In-Reply-To: <20241002190452.3405592-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Oct 2024 15:19:55 -0400
Message-ID: <CABBYNZKqrja__qdidRwqXh9wcJJ6YdGqdh4bejU5HsL02qcFpw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> In addition to it remove call to sco_sock_set_timer on __sco_sock_close
> since at that point it is useless to set a timer as the sk will be freed
> there is nothing to be done in sco_sock_timeout.
>
> Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work"=
)
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/sco.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index a5ac160c592e..2b1e66976068 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int e=
rr)
>         }
>
>         /* Ensure no more work items will run before freeing conn. */
> -       cancel_delayed_work_sync(&conn->timeout_work);
> +       disable_delayed_work_sync(&conn->timeout_work);
>
>         hcon->sco_data =3D NULL;
>         kfree(conn);
> @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
>
>         case BT_CONNECTED:
>         case BT_CONFIG:
> -               if (sco_pi(sk)->conn->hcon) {
> -                       sk->sk_state =3D BT_DISCONN;
> -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> -                       sco_conn_lock(sco_pi(sk)->conn);
> -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> -                       sco_pi(sk)->conn->hcon =3D NULL;
> -                       sco_conn_unlock(sco_pi(sk)->conn);
> -               } else
> -                       sco_chan_del(sk, ECONNRESET);
> -               break;
> -
>         case BT_CONNECT2:
>         case BT_CONNECT:
>         case BT_DISCONN:
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz
