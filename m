Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D041519BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245639; cv=none; b=XbCopjAawdc2nGWaR+l0S7vUSpnVbJCBZ0xTg6Relv+uJRcxXs8EEuE3tzB8KxsXIcoXNpmlM5oaKFj9OuCGGQNO6k7rC6TDuHWqacPpc0E66UlyD284nS9MynghxRWkviae+xyirVsOVBL9R4X7hT5e/VhKiMO3KhO4kvinfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245639; c=relaxed/simple;
	bh=kD29/uoB/2r7VHQiS8AIMvODaCfnHX23tosO3xqUH44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNwiRYv7nOxcU6lTZZ+C3xNGGkHOqE2ScZyG0nVcgVHqnIaQ9xu9UbXyyNjb3+Q82TvuJgeft88nvI4byuGIxxmuTIaODNWl+DU31AuOsJIQF+ektcRzkEC9ULi3zy8AJFF78ys92yncOU+kHFizUoAHk2teJ7BCR1LSI8puyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcf2De4G; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcf2De4G"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so36180721fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745245636; x=1745850436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n5S3vTjGg8VrXKt5Pr6zzI5aFfpqwnp53LQh+hV9CE=;
        b=Zcf2De4GeKH0wSR7zFa7k2g7dYYiyUAutMAyrm8oITmmsvqwG6F9KrIDqV5R9U9VGe
         AvBFAHHNKtU6Cau+l23iJv6Xt0lhRbX8G5+E45DWWQfKqUpp0zR9lbyJpX4ndzUtmEVi
         7lQCnl9EfvJ0lVENRVi0KtFB90eG7wxaFouQDPsb4LDmf3mIlOOzXztIsKyKun6Yahjp
         lvXEeQX31wuZ6mK0vOSL4jREtSRVAoC8uTOjH9DIhW9XGJ+/aJZPvB6i88r+LyloPpO2
         jDxchVxTTxxOBBjk3Kn4ZGJOrm3N4x1Zy+9Qk4IoQrHqAsN+ngx2S1+UM4OuQPJAWCQ4
         GLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745245636; x=1745850436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n5S3vTjGg8VrXKt5Pr6zzI5aFfpqwnp53LQh+hV9CE=;
        b=Xky/ujZ/4Q7EHAjFBAJxusYy+pzNJrlRPWsa2WdXJmsrDJWH3uaVHb0LThrK0kzLJH
         eNxSdW3HYqxITe7kj9x54Bg9UFUj+DuvKt5cQvWVzDiNg0VnFAYHqfi+jT1DphH7U98t
         tBGHBxHvUc4xNmoQH6NwOpXtTcMsSEb0yG/dPvSPqznaYQ+dbO3ul2Kj1WJL0oOQ4fdA
         KQ0JexoxTwQReVtlnIcgmRjW0BegNrKpl+asv4DavINDdUZg6Xk8fnN3S+WJdj9YTkyB
         7g8Q+GVkw84LyJBkB1arYUzEBFOW+4wu+131HTbfo1nsuiqL2szpsjoFzEoS7j0in65S
         1kQQ==
X-Gm-Message-State: AOJu0YwxHFzXtMBH93YH21KeHBUe/LMrPK9ExDgOjUdWdukB12kzyy9O
	ohzS5GViFQtOK49RT2x42y5ZrDdyPdnROzs85deaOOVZNsrHaPW+p8HSRkn6R2XtT0n52KglvBH
	qbB3Mc1gWkvWmAH9OmhGNCoXP2+awGpR0ETQ=
X-Gm-Gg: ASbGncvlG3S6F/m69TbCqYTPlDPm+VZYX4Rs4P/inwApiL6fPwDVr+90ZSaoCMJb9Y4
	U4ozKSpEKE7soGSw7z58Tq5jF1lsHFo/ytsySjpI02aF3gcVYKMLxvqXHte3UK6wYeIRV/r9EhK
	60tlNSJDxo9d+qEnN1ugK+
X-Google-Smtp-Source: AGHT+IEIF+ees4e1zG955V9h4ZKArjOyI0bWmQqSa6gXGuiGdCgiyvBQ2i9CYPSBgtsIY/ATxBF5rhSwXYApGmSFJjw=
X-Received: by 2002:a05:651c:3225:b0:30d:e104:cb74 with SMTP id
 38308e7fff4ca-310905a3a25mr29341271fa.41.1745245635741; Mon, 21 Apr 2025
 07:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421055814.96955-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250421055814.96955-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 10:27:02 -0400
X-Gm-Features: ATxdqUGwgFPRkIXw68nv3BSEyFm_LXtrtY_n-4jnWWCCCNlebB0vpOzWRZ-AiLQ
Message-ID: <CABBYNZ+umV4SZqVdtFq_ThD9PDpYA41+rZ=EF=xVxgOUXXQwsw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] obex: Send response to client for Abort request
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Mon, Apr 21, 2025 at 1:58=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> Incase of ongoing transfer, If the client sends Abort request, Server is =
not
> sending any response back.
>
> Ideally it should send OK or Success reponse code for the abort command.
>
> This is required in PTS testing for passing below testcases -
> 1) OPP/SR/OPH/BV-27-I
> To verify that a server can respond to an ABORT from the client during an=
 OBEX operation.
> 2)FTP/SR/OTR/BV-02-C
> To verify that the pushed file is aborted normally.
> 3)PBAP/PSE/PDF/BV-06-I
> Verify that the PCE can abort a Phone Book object download from the PSE.
> 4)PBAP/PSE/PBF/BV-03-I
> Verify that the PCE can abort a vCard-listing object download from the PS=
E.
>
> ---
>  obexd/src/obex.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 370bfac9e..0330d5a7c 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -389,6 +389,8 @@ static void transfer_complete(GObex *obex, GError *er=
r, gpointer user_data)
>
>         if (err !=3D NULL) {
>                 error("transfer failed: %s\n", err->message);
> +               if (strcmp(err->message, "Request was aborted") =3D=3D 0)
> +                       os_set_response(os, 0);

We shouldn't be checking the error message but rather check the error
code G_OBEX_ERROR_CANCELLED, that said I wonder why this is not being
handled directly in the likes of
gobex/gobex-transfer.c:transfer_abort_req, but it looks like it
responding already:

    rsp =3D g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID)=
;
    g_obex_send(obex, rsp, NULL);

>                 goto reset;
>         }
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
