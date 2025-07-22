Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219A288CA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194476; cv=none; b=bXngHaY/cQ+NLPLnGCjt/JbTpF/8xRDvn/wV+s/qVhtkJBS7cgcguI61dN8z2O4RfrOqbHQbaMwiv6IjEkLBTeFXTG66lb1pg6GRXPmu84IzjR/kYfkodPEsG20WuCCjQqIRKp6LRj6jXcW2t39C/dldvALIHv7LZ1ZzhelDbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194476; c=relaxed/simple;
	bh=5b0iMEoy9mHBGa9P0i6NfChk8T/CAZzLWaBamC/p+hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrCgn8Sj/UlZc4Xue4Rp+LwHcM3NbSW9kzLXV8w4/CGocIMyeTVyYiURJfTj4SRqwqgKGFoSELlq6R7fLZE1JAg5mmPXJPncFthuuAmw171CQ2D3XNWra305xGAuv97NjQFmPj0hRsq2PLFDTuEFIjrjJC2QANzsCsxUd9rzdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0sKcv2R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0sKcv2R"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b5226e6beso54295801fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753194472; x=1753799272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7T7xhQeQPqyAddB8VXqdad4Js/shtZOzr7Uze5cqXY=;
        b=a0sKcv2R3nMROz/23dkRBUcAk1kFN7aW+c/XKu6IWczlCv0DoxFdY2BKLNSyNAJtLA
         AZxMo+ODoHmsPh0em0S+520Uh5QNiKEtNW4fboG52brae8t3oy9YJgaDe5+gC7fqGvoP
         MFN0nRX/XyaOFaGS97GZFJ0Ofp2lzSBYhX+d6NPm6DKYUfq25q2pF+jUlXzUpk/oAgl1
         Xb1l2Iz9cGzx+nqoe12rYO2LFygU8tB2iZ1I0NDTMOQwsCh01Ka/kTIpytR/6GKDxRzD
         V/ocISD42eO8hIZvxfH6cs9yY56U9cg1+FfOWAL5DqccKY3vTnkHCxgEZKebCJv1kD4J
         uaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194472; x=1753799272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7T7xhQeQPqyAddB8VXqdad4Js/shtZOzr7Uze5cqXY=;
        b=Yajt9KpKtdBK2dkHC85RthF2PfQ4Levo7Dme1A+LpsPRJz3hyv/Kf0hCE5r23xsgza
         PIqDRSPOBM388w75YJ95hjDz44xfc2tNJDh91hOadlH8xzj+FSZTlgACPVv+s8BmwUqG
         qHKe8RLWdINLama7zJJ2ZQ+CQwsBk4PE/RogIEmKNcImksYGRTZmCDwpUNhBOo5qqMdw
         EYwcHqUPxE0owmp+YLOeq7wbBWAlwalqfHvQCNnVG69tnnlEnglzcrFc8YLuidkI95jM
         sR8pyL1yOLnILxVzqGMO7nSXJV/afXgi2DGuWOwDjHm8lW8gt2BQLwu+dPLnkuhpyzff
         X06A==
X-Gm-Message-State: AOJu0YywGwUximaP3PXr2ZXQQLmpl+NZn3pIgXp9ND9xawfDkFiK1lAR
	9h81/Avkb3gBHEZIJL6uSeGpq5CE9AjL+h0vMYt4eLMaDKA0jPrWjEm87U47tZaCFY4mXENehhr
	exaaQbb5c4IyMq5zOA5M2FwaT0uxKxoSA7Klj
X-Gm-Gg: ASbGncvqoesXEJST+fGYjHw/V3IG61EvAE3NGm8CeO+X4HAoOM+uOH1o21k3vCnFj7j
	TnTxD1L6pFVsMzoUiwz2h3VePA9HjjFOzbHN8WJe3ywQ4YzKjjxR2co6XMzKn/Hln/GwzeXbdKZ
	HCX7Xah8DHSvpPqau8Hnote29mzqLSBQ0fmy7/fPlM9TaboPATZi2GO8NSHBMewp0vSqqB7sFZU
	cSYqA==
X-Google-Smtp-Source: AGHT+IGiN3MFSZWPyUEK1w+JrnqMQP7o0j2X2j6wdQHqE+fbKewAFGVw5LijAo9MAp8/0fblUIDvhb6WJR4Fju95dwc=
X-Received: by 2002:a2e:b950:0:b0:32a:7a12:9286 with SMTP id
 38308e7fff4ca-3308f5f1a03mr46134831fa.31.1753194472184; Tue, 22 Jul 2025
 07:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-bap_crash-v1-1-35ae54484d29@amlogic.com>
In-Reply-To: <20250722-bap_crash-v1-1-35ae54484d29@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Jul 2025 10:27:39 -0400
X-Gm-Features: Ac12FXx67AphGLmNjfHspGI3hEmWGNbsY8lgSll2ZlFZSh8XmN7aJB-J5hdWpbk
Message-ID: <CABBYNZ+2hRhUkwacjJUzC1C=8qfmH++O34k4dGbrSsUSiGZ7cQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: Add NULL check for stream in iso_bcast_confirm_cb()
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 11:29=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When a BIG sync is established and then immediately terminated,
> the associated stream may have already been released.
>
> backtrace:
>   (gdb) bt
>   #0  0x006d16c0 in queue_find ()
>   #1  0x006d16cc in queue_find ()
>   #2  0x006edd14 in stream_get_io ()
>   #3  0x006f0bdc in bt_bap_stream_get_io ()
>   #4  0x0064a440 in iso_bcast_confirm_cb ()
>   #5  0x0065c36c in server_cb ()
>   #6  0xf7878c24 in g_main_context_dispatch () from /usr/lib/libglib-2.0.=
so.0
>   #7  0xf7878fb0 in ?? () from /usr/lib/libglib-2.0.so.0
>   #8  0xf78793ec in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
>   #9  0x007055d0 in mainloop_run ()
>   #10 0x00705a34 in mainloop_run_with_signal ()
>   #11 0x0061484c in main ()
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  profiles/audio/bap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index f39a40458..022b5ae28 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1370,12 +1370,17 @@ static bool stream_io_unset(const void *data, con=
st void *user_data)
>  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
>  {
>         struct bap_setup *setup =3D user_data;
> -       struct bt_bap_stream *stream =3D setup->stream;
> +       struct bt_bap_stream *stream;
>         int fd;
>         struct bap_data *bap_data =3D setup->data;
>
> +       if (!setup && !setup->stream)
> +               return;

This is indicative that io channel is not being canceled/shutdown
properly, if it was then the confirm callback shall not be called, so
this is more of a workaround so we need to figure out why that
callback is still being called if the stream is destroyed.

>         DBG("BIG Sync completed");
>
> +       stream =3D setup->stream;
> +
>         /* The order of the BIS fds notified from kernel corresponds
>          * to the order of the BISes that were enqueued before
>          * calling bt_io_bcast_accept.
>
> ---
> base-commit: 52de8da1a99cd33b517284f87d231055a0dee6bb
> change-id: 20250722-bap_crash-7ba065496958
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
