Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53614D2B7
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088253; cv=none; b=vBqRWM9DxeeNaLoOXTufddbNfpBouzksueI9q5I9weL1SNdw6eF5kiRKD7ARXqG+t+OeT5mmtBQx4PRtamrgtLd767OAwYnfvoOhGkkmLp79AVmk4DGpIqbWbUGN57rHR+Lng5KjdmzM/a1XaTQVK1wehKKGMLmBQkfRj1Fk6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088253; c=relaxed/simple;
	bh=8N9Vr0I0NG4tAkR6zT/imQALB5AwU9Zo2GYNGPc1Fc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SohHtM0edjaNeFYQZRrIRuq2jB0PU4UGF72WZPBPDHQJ+dHWl4fNTnJ9QOfcWATMDmU4VbxjP/NkjXuZiz0B+DY83wyK+5fe8ouUzvpAD2yLATSuOmX6x6XttlirbtMyg993f+jP8zyNulE9Mdn0trlWHYeTAqFP9FCn5oQaVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWHy4m0s; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWHy4m0s"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c461a45f8so11702571fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743088249; x=1743693049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2XX2TmhdtFAt65JW17RwWTrccflrFfO98c5ePW1B0w=;
        b=fWHy4m0sLewecMvbaVNMcTBNDqf1U0zNsZZiXmQpm+jHVQTvlkknEYsj0bBUrhCWnE
         g7xMslKg/RmQs+drBzdMr3tENUCMBpLND9OkFWLpjLooOcYxNVGhb6uAiG0kSZtEssIT
         OODYdkHEj7095lG5Mxw2ucMKoWa8MbF6mtKevnqa6U2eyhayWxz5SXHa5lAKPcOm2OI4
         ggdyRwmaqAJRb4zZ0u2gkyGj2XIAM1CXZLzE5V9JBSTXUype5t9Dka+dEtHb9n6SWVDg
         EqiO909RD67+VD7tZRvBMoYaibql3nesuXCIrJTz+aF/X95Lz8fAGWVMO116dTtEWeVC
         rang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743088249; x=1743693049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2XX2TmhdtFAt65JW17RwWTrccflrFfO98c5ePW1B0w=;
        b=RKb2kndNTaM//H2AzzzHTwZfkDp4i2FGOK3bU23fK7lsH3RT45RHzo2YvPYLTCao1v
         Kpxh66UXmD/S9jbD964QBo1645mWWa0LPBEAN/jzuoImsqenf9azPEJc1mpLYUhWzhgC
         Qwzp7QTOsaQPh6/AkUwEsSXKC3EFqHJwA2IcwNAQUaYHQOLtxQ0dkwvIoysu/OpK/4Kq
         NThbk/IVVIWSRBfohN4rBiYItoYpmqpj5DU0z1A7IfUemK1nPncTB8FBvyKmeO3erw5v
         O/ymfldjbsKJJbsem81NAIhLjSeGZkXeW3cuRMDJZfCscBSNoma3i/InnDtNYqmF+i7+
         ef3Q==
X-Gm-Message-State: AOJu0YyN8VXVPoXAUNG0XDj3PlNGiarb1b06O4lxDYpKVwzGWqBF+K9l
	D0/XuIUk3jJm2WZMvGNnXs27RvF9GXf7Dupl8LT7JJ0w1xkqR/V3TeGcqQuA3zOKfPqfjkHuTjP
	mpvPPW14piagv7Dl9wnalWbMrln8=
X-Gm-Gg: ASbGnctxAruLn+LQmWNoJVQG/nWd5DGkgLEP1V+eza/tL9ho5mV3vSk/nUlm4u76Uv/
	sPUKScUg7FFYoC+BbP/CA5fai0yzD8LS4Kc7lZvtGD+yNritlTOJhu3v/2/2sAwRhXOnanyl5lC
	ftCJ3CgnzrX+cysNsNLJ+dSpSI
X-Google-Smtp-Source: AGHT+IEczlA5y6mu7OQjZ8yDIsqHKOL9Y1KYDEp58rPS8CoraedCS4TILypMN3iZbcuCqCqgQaG8ee2BFQg4YGgJt0o=
X-Received: by 2002:a2e:98d2:0:b0:30b:cd41:89c7 with SMTP id
 38308e7fff4ca-30dc5e5d9a2mr13911961fa.22.1743088248281; Thu, 27 Mar 2025
 08:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327084128.3315736-1-quic_shuaz@quicinc.com> <CABBYNZLkwH=8TztnGnuzGy7FJ+iugp3sKT_cS0dsRoo1aV_hrw@mail.gmail.com>
In-Reply-To: <CABBYNZLkwH=8TztnGnuzGy7FJ+iugp3sKT_cS0dsRoo1aV_hrw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Mar 2025 11:10:35 -0400
X-Gm-Features: AQ5f1JpqpHsvjHHfx-j9B012hXm0nb1XavPqnovuWh6Fh9M6D2bwhQlscTGFUKs
Message-ID: <CABBYNZLZfuEXS7YzANUrkuD59oWWyctLU9wPWsyOLO6LNG7oxA@mail.gmail.com>
Subject: Re: [PATCH v1] dbus: Fix add invalid memory during interface removal
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com, 
	quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com, quic_zijuhu@quicinc.com, 
	quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Thu, Mar 27, 2025 at 10:58=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Shuai,
>
> On Thu, Mar 27, 2025 at 4:41=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.c=
om> wrote:
> >
> > test setp
> > register_service <uuid>
> > register_application <uuid>
> > unregister_service <uuid>
> > unregister_application
> > register_service <uuid>
> > register_application <uuid>
> > core dump
>
> Ok, what exactly are you talking about above, you are not referring to
> D-Bus api it seems, are these bluetoothctl commands?

Tried this with bluetoothctl, doesn't seem to trigger any errors:

https://gist.github.com/Vudentz/7b20ff8b59e3122606a2239e1b63aa8a

>
> > invalidate_parent_data is called to add the service to the application'=
s
> > glist when unregister_service. However, this service has already been
> > added to the glist of root object in register_service. This results in
> > services existing in both queues,but only the services in the
> > application's glist are freed upon removal. A null address is stored
> > in root object's glist, a crash dump will occur when get_object is call=
ed.
> >
> > Add a check for the parent pointer to avoid adding the service again.
> >
> > 0  0x0000007ff7df6058 in dbus_message_iter_append_basic ()
> >    from /usr/lib/libdbus-1.so.3
> > 1  0x00000055555a3780 in append_object (data=3D0x31306666,
> >   user_data=3D0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.=
c:1117
> > 2  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.s=
o.0
> > 3  0x00000055555a37ac in append_object (data=3D0x5555642cf0,
> >   user_data=3D0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.=
c:1122
> > 4  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.s=
o.0
> > 5  0x00000055555a3630 in get_objects (connection=3D<optimized out>,
> >     message=3D<optimized out>, user_data=3D0x555563b390)
> >     at /usr/src/debug/bluez5/5.72/gdbus/object.c:1154
> > 6  0x00000055555a51d0 in process_message (
> >     connection=3Dconnection@entry=3D0x5555639310,
> >     message=3Dmessage@entry=3D0x5555649ac0,
> >     method=3Dmethod@entry=3D0x55555facf8 <manager_methods>,
> >     iface_user_data=3D<optimized out>)
> >     at /usr/src/debug/bluez5/5.72/gdbus/object.c:246
> > 7  0x00000055555a575c in generic_message (connection=3D0x5555639310,
> >     message=3D0x5555649ac0, user_data=3D<optimized out>)
> >
> > Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> > ---
> >  gdbus/object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/gdbus/object.c b/gdbus/object.c
> > index 7b0476f1a..d87a81160 100644
> > --- a/gdbus/object.c
> > +++ b/gdbus/object.c
> > @@ -809,7 +809,8 @@ static struct generic_data *invalidate_parent_data(=
DBusConnection *conn,
> >
> >         if (child =3D=3D NULL || g_slist_find(data->objects, child) !=
=3D NULL)
> >                 goto done;
> > -
> > +       if(g_slist_find(parent->objects, child) !=3D NULL)
> > +               goto done;
>
> Use empty lines after if statements, and keep the one you are removing.
>
>
> >         data->objects =3D g_slist_prepend(data->objects, child);
> >         child->parent =3D data;
> >
> > --
> > 2.34.1
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
