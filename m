Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85F78C6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633272; cv=none; b=TrxfskpnyhoUQ1LJTepSdSpLXF7tXz93w8ErA/Rmkq08Ic6VR4V9CXdEYs7SpwICUapqkhOZWAYr0jg+eAu/vwuNLoyfA4rEGDNsE/cN1tXmTHMXn2qzc7s8FqoBwifpM2/wkoY/RNIU0PquQ1bgPKwsJCfVQqONFcGInUeY0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633272; c=relaxed/simple;
	bh=1hGQDYtpzb2pItcH8g2Fv2u5rxGjQaN18Z/22Ib+FzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkIMJEp++02UJH1t+A7oT+1CTeDNfdjwb7Hp5DCSCkx6u2u9oy6R1lsHsw/Z2yIa9gHPA02AkZvaJ+sBTaRmTnp2ETi6m8Kb612u0goOtEN/BsJHH2AZX64KA5AYEvKea0VJv7h2L3TmS/kfAJ3KWNJphiFun0ubhYQlpU2WEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByrZ/5dp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByrZ/5dp"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de84e4005so1540490e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 07:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732633269; x=1733238069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGqO00ImZwvdwrcUB5czYtdu9jeqaTyqapY9WmuoxP0=;
        b=ByrZ/5dpdmJsT1zN2cWLZkg74DmP3pYmJWtOQpIBguswnWxYUX/clZiAZSvZVCZ6Qv
         ezf/DbHR2jAhUS0ud0NBKRS9TkccG3CKz/413OSOp2jNEpgyWV3m34tTmQGJo2xux/Np
         +oqZUhIg2ZtdH42AB8QP3ScmWWtO8s0WbqwM/sn/f+z892J2MTjvlFVfbTvNhe401ESW
         f9Ni07PtqpQggyXpKcCn3j5j8tSdW8fri+vE9nYhNYR7DHtah/Fsix91BBAp2h1wFAXY
         mgm+dVLyFcWUzUEVxWRfIawiIeBAfQa8Wj2aBbGn1O14I1lHTb4bcOmANTid0evNT2wC
         PD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633269; x=1733238069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGqO00ImZwvdwrcUB5czYtdu9jeqaTyqapY9WmuoxP0=;
        b=Wib1ghso8nfIxqdYVuqHPCojntYjhyeIah671MdpcZhnsuwJAiHE9Mq3iP/dwbaQma
         cqV9pFNgisxUI/sJSuDwcUMbODs5ykqa6paUPL0qsmja+nrkuX8EJW+kbFF1SQ3H84dU
         kiEUYV3gNtJzAd7JAiAAR8caYux6+i19KXuXe4ChXYYCEkAnee7rhuFxetN3mdCGea6a
         LuhQP4NsUUsGvArqyB4iqSC7FSiKxwVKCk5gVdVzOCll5Y324wq4bjIbnZQfZTP1Z2YJ
         fl7aZt00PaVVcGG1cRk7WAU75WUVeBZgTeXKPIfcahasjHj5fgqc7UF7LLwVwcKwswha
         dNNA==
X-Gm-Message-State: AOJu0YxtN9apfibS5wDZ2zaMvsc6+EadSdOUr5A0LyBkCdi6nHIVwH2v
	fL75NvLWHGNvc3YCy71x9eP5JFumz2wdfEGeTjWFvh3RXLKA2NMIDu0gL/pkpTNf0H8iFleikLi
	DkLz5yoeqmd2ZvhsFliHHkaMS+MQ=
X-Gm-Gg: ASbGncvaQBpaaZfdVQVdJdfo/jWrGBUtkf1LZzRoUyHIGTME8Xwd+S6hIUL3SKnToHW
	ie4MO1/IUoaQLY1IvOrR14tcCHN80TlMI
X-Google-Smtp-Source: AGHT+IF8nxQV+II2j+Tfp8/Q8uLGrtKLsaYouU3XIw/fi12UJU9mRxLRhh+XRzng3enMsrbj6fpED/tNvszx5J6bE7Q=
X-Received: by 2002:a05:6512:b11:b0:539:fb6f:cb8d with SMTP id
 2adb3069b0e04-53dd389cc7bmr7307115e87.27.1732633267240; Tue, 26 Nov 2024
 07:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126082003.2178783-1-quic_shuaz@quicinc.com>
In-Reply-To: <20241126082003.2178783-1-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Nov 2024 10:00:54 -0500
Message-ID: <CABBYNZKHSj3kVFz3QUnuM_0nmnkohR7aRk=7yPCra1agB8T=gw@mail.gmail.com>
Subject: Re: [PATCH v1] BNEP: Fix the BNEP Unknown Control Message in PTS testing
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com, 
	quic_jiaymao@quicinc.com, quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Tue, Nov 26, 2024 at 3:20=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com=
> wrote:
>
> This change is required for passing below PTS testcase:
> 1. BNEP/CTRL/BV-01-C
>
> PTS sends an Unknown Control Message with only two bytes,
> which is considered incorrect data. Therefore, the handling of
> the Unknown Control Message is added before validating the data.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  profiles/network/server.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index 96738f26c..c1d96cd1c 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -325,6 +325,32 @@ static gboolean bnep_setup(GIOChannel *chan,
>                 return FALSE;
>         }
>
> +       /*
> +        * When benp_control_type is between 0x07 and 0xFF,
> +        * a reply is also required.
> +        * However, since the command size is only 2 bytes,
> +        * it needs to be processed before determining
> +        * if it is a valid command.
> +        */
> +       if (req->type =3D=3D BNEP_CONTROL &&
> +               req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
> +               error("bnep: cmd not understood");
> +               int err;
> +               struct bnep_ctrl_cmd_not_understood_cmd rsp;

Id probably memset the rsp to 0 to be safe that we don't respond with
uninitialized fields.

> +               rsp.type =3D BNEP_CONTROL;
> +               rsp.ctrl =3D BNEP_CMD_NOT_UNDERSTOOD;
> +               rsp.unkn_ctrl =3D (uint8_t) req->ctrl;
> +
> +               err =3D send(sk, &rsp, sizeof(rsp), 0);
> +
> +               if (err < 0)
> +                       error("send not understood ctrl rsp error: %s (%d=
)",
> +                                 strerror(errno), errno);
> +
> +               return FALSE;

Move this code to its own function so it is easier to reuse.

> +       }
> +
>         /*
>          * Initial received data packet is BNEP_SETUP_CONNECTION_REQUEST_=
MSG
>          * minimal size of this frame is 3 octets: 1 byte of BNEP Type +
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
