Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39C192B89
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769422; cv=none; b=jIZqAlSyhvd5NLIy7G5VVuM7g44qzhYxEBitCnyn6O0pYhTRgcZx97Bgw1qEcmRDfqWViu0xGD+8JR7Bxo/L9Ij73fOrDIkAFtsaOPJZSzRpB1dEH1yj4RGO4g3hrnXeHWESci+s2MOOPNHeKrsfode59U7d8FrWf5e6OsyJwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769422; c=relaxed/simple;
	bh=RAoVCnck13wNRxCUBR1n3o0UHvyMIr+KGNQpswwt2Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5NR9jNjuiSOutJVX2+XOxrdPymNHjX5+sJRLE9PHXOPcnXaJtxSC6VYy2SKqzFh5A8AOpSI+rs6Q/Obo7ZOmQGd0SdmRSywa21O6zEk5zSpdaMcEPKMBciZAdSwFZ+Chui6DP2zvVtPw5lTO4zsONldN/2OmNnRlZVQ9GMkCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2MTtAw4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2MTtAw4"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eae5b2ddd8so5034261fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2024 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717769419; x=1718374219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caoUsootu3rWgNEsCqU6FRoOeBMbvh/V/ZbUv2vILsM=;
        b=e2MTtAw47C5PaHCDvLgV32VrZ4HIacLZDYtAjwBo+uOlYvlJ3FGpPM8SoirAF7MYMT
         Ma3IpDerQaDkbkY6FRhjUr4aeVbLLB4wz0PHT1Ef2LWLZJ/tSGe8EHnxZ2Wf4ukA4l3m
         5la+YXq+dM/vEQeYKJx9DfIL0WQTM17x12wuY+HpNECMpXrYfDurFC65ixPjOxO2z2BG
         pAjja6La28/sVYD36ryS3krDKpr4oecq3tHbrft18Cx2kuhLIBr1DhRMk7HBR9QXxoWR
         eo4vfzvrT/A1/2EYidEwP76hoBQqvqFPh4JXCMHdftkTkPi+Jl30mwqVXKwGrj9cwoGK
         2i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769419; x=1718374219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caoUsootu3rWgNEsCqU6FRoOeBMbvh/V/ZbUv2vILsM=;
        b=On14U4//MagU46+16ChetVNYD/BsLNYkbhegdgj9KV0mzoK8yigOa0/ssAr9K6LY17
         5Cu4OyVbWcHUhL2yfEDxfudh3ec1VLe7ibrQiQrDVJz5lrQiJOx55tLsz1s5VWAVD9Av
         wNeH5beciXmLekuNmS0OGtU2xc7rwO8/OSF0+IUrw4wD7fV5aiLllPDk5l6ccsXC6omC
         kv5QNmXj4MYub84N3ZpBYZhxcGFEOnhG4QQlctPAvbg9nwyI+FZCo/tDcg47+EUe3V0k
         lV9Vt67UmynHdAfpLOgjwqiHdIXKF0BfJ759jMwWzyHR6kYynZZFYkDZUabnQW8/w288
         KQcQ==
X-Gm-Message-State: AOJu0YzG8z/ejBQOhzDXHLIqOqK2f5TfOj7AAkp+o+CJg1+XwWVXgF8m
	ZaOXMVIrMdY72GIk2oAa1kVc8dYEtAxx4oeAMA4CZ0vSZjeSHvQ/h9qvE8gxWESXvGH9DpnstA0
	4w6cJbFFUUqtY+SgEg6egPon3NTYllrAR
X-Google-Smtp-Source: AGHT+IE2uCXOzs4HdltjwWRd+uOccwa5RWeUfTEXa/I9LcmDCSQDyJBDEUIGBwxi/VJhq1L1jedL3ulh9mAF9j1Mdik=
X-Received: by 2002:a05:651c:2220:b0:2de:d4df:5685 with SMTP id
 38308e7fff4ca-2eadcb85c30mr10137311fa.0.1717769418677; Fri, 07 Jun 2024
 07:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec4a4adbfee94a699ebd635abc51f01c@quicinc.com> <3ffea594e86647208806e321275df2c6@quicinc.com>
 <6a7a26622a3f47aaa7b531773ce35f48@quicinc.com>
In-Reply-To: <6a7a26622a3f47aaa7b531773ce35f48@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Jun 2024 10:10:06 -0400
Message-ID: <CABBYNZKoNvL3SxgNDgXN=QwCALxRM2xbeNXfoxs=NVVq+ChKRg@mail.gmail.com>
Subject: Re: MAP server crash during connection
To: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Fri, Jun 7, 2024 at 3:00=E2=80=AFAM Amisha Jain (QUIC)
<quic_amisjain@quicinc.com> wrote:
>
> Hi,
> To resolve the MAP crash issue, We have added the below fix -
>
>
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 3a68fd6..7c95075 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -716,7 +716,7 @@ int obex_put_stream_start(struct obex_session *os, co=
nst char *filename)
>                 return err;
>         }
>
> -       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE=
_UNKNOWN)
> +       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE=
_UNKNOWN && strcmp(os->service->name, "Message Access server") !=3D 0)
>                 manager_emit_transfer_property(os->service_data, "Size");

It has been a while I don't look into MAP implementation but the
impression I have is that Size is not being set properly for MAP which
then causes the problem, so this is more like a workaround it seems,
and if MAP don't really want to track the object size then it shall
set OBJECT_SIZE_UNKNOWN.

>         os->path =3D g_strdup(filename);
> --
>
> Please review the above fix and let us know if we can go ahead with this =
change.
>
> Thanks,
> Amisha
>
> > -----Original Message-----
> > From: Amisha Jain (QUIC)
> > Sent: Tuesday, June 4, 2024 11:43 AM
> > To: 'linux-bluetooth@vger.kernel.org' <linux-bluetooth@vger.kernel.org>
> > Subject: RE: MAP server crash during connection
> >
> > Hi,
> > Please help with the below issue.
> >
> > > -----Original Message-----
> > > From: Amisha Jain (QUIC)
> > > Sent: Friday, May 31, 2024 12:34 PM
> > > To: 'linux-bluetooth@vger.kernel.org'
> > > <linux-bluetooth@vger.kernel.org>
> > > Subject: MAP server crash during connection
> > >
> > > Hi bluez team,
> > > I have been trying to verify MAP Server obex profile on bluez 5.65.
> > > While trying connection, I have noticed the crash on the server side
> > > (connection initiated from client side) and hence connection is faili=
ng.
> > > Please find the backtrace of the crash -
> > >
> > >   assertion failed "i =3D=3D len" file "../../dbus-1.14.8/dbus/dbus-o=
bject-tree.c"
> > > line 1321 function _dbus_decompose_path
> > >   /usr/lib/libdbus-1.so.3(_dbus_print_backtrace+0x28) [0xfffff7f4cc9c=
]
> > >   /usr/lib/libdbus-1.so.3(_dbus_abort+0x14) [0xfffff7f4fe3c]
> > >   /usr/lib/libdbus-1.so.3(+0x4a9cc) [0xfffff7f3a9cc]
> > >   /usr/lib/libdbus-1.so.3(+0x36c5c) [0xfffff7f26c5c]
> > >   /usr/lib/libdbus-1.so.3(dbus_connection_get_object_path_data+0xc4)
> > > [0xfffff7f0f818]
> > >   /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed_full+0x30=
)
> > > [0x450dc4]
> > >   /usr/libexec/bluetooth/obexd(g_dbus_emit_property_changed+0x14)
> > > [0x450ec0]
> > >   /usr/libexec/bluetooth/obexd(manager_emit_transfer_property+0x34)
> > > [0x429408]
> > >   /usr/libexec/bluetooth/obexd(obex_put_stream_start+0xc8) [0x42b314]
> > >   /usr/libexec/bluetooth/obexd() [0x425f58]
> > >   /usr/libexec/bluetooth/obexd() [0x42adcc]
> > >   /usr/libexec/bluetooth/obexd() [0x4171dc]
> > >   /usr/libexec/bluetooth/obexd() [0x418078]
> > >   /usr/lib/libglib-2.0.so.0(+0xb20cc) [0xfffff7e420cc]
> > >   /usr/lib/libglib-2.0.so.0(+0x54a30) [0xfffff7de4a30]
> > >   /usr/lib/libglib-2.0.so.0(g_main_context_dispatch+0x44)
> > > [0xfffff7de850c]
> > >   /usr/lib/libglib-2.0.so.0(+0x5868c) [0xfffff7de868c]
> > >   /usr/lib/libglib-2.0.so.0(g_main_loop_run+0x1ac) [0xfffff7de8b08]
> > >   /usr/libexec/bluetooth/obexd(main+0x128) [0x427d6c]
> > >   /lib/libc.so.6(+0x2affc) [0xfffff7c0affc]
> > >   /lib/libc.so.6(__libc_start_main+0x90) [0xfffff7c0b0c4]
> > >   /usr/libexec/bluetooth/obexd(_start+0x30) [0x4101b0]
> > >
> > >   Program received signal SIGABRT, Aborted.
> > >
> > >  __pthread_kill_implementation (threadid=3D<optimized out>,
> > > signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c=
:4
> > >
> > > Please help support the issue.
> > >
> > > Thanks,
> > > Amisha
>


--=20
Luiz Augusto von Dentz
