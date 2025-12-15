Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E92D73B2
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813598; cv=none; b=G/B1+5io7yjV5n3MBoTPc/eqZE8UEisEW83zFNHfMHN8RGZrPPx2KzIPT1mALXRht5y5t1OHUW+VlwMyLfFgeLfNPKy7q4/r3DuUmU7IEHzj57VDsQMePzV7PYy6+tu2eiywX6nghRl0ZbkaEAVUeyi3AsMOqnXugJvok/GD0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813598; c=relaxed/simple;
	bh=xARBVQ8DdEC8F1ONmGPvA/lzUfaTn7/VMbcYrfzQpLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMJwvcXQ+LQI6qPiQkl0EXfnLdAxhVPMbrA+v4lN9gU1JnwLotOq/xsYBcFBcIKFgslstk/RfZsuQ35kihbp3tF7ZgqB6GSz+KUkVc9nvskZbvYSxmBIt4eVatDmSO+h2MrlTAlI8MQ8C2btsRdyIhg+EJR+zOBLFbZaUPmDVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbAP7xII; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbAP7xII"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso32031371fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 07:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765813594; x=1766418394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMvvVGERd3mt1B4otJOteb3OqAwxA2BKhC4KiqGzfY8=;
        b=MbAP7xIIuoOOzDgRL20GQM2cffYaTzidS4SEirLrIZyGjtKGisyvIGxDlliF4TCr9Q
         QSmQPqHxPh8uhBT3lVqIeQydrUOwsCM7CucBEGvjQCa2Ca/Yt8paY04Q+MV5tDFeTxne
         Obeekt7BYvoAFzMTnHfP/0n9NpEKSrp8lvtPp/cXn6cAoBrALRfGBW9/k+wrl/iEZHyG
         vLoLgoi0k6IgJr0jhf2ltCGkD8516rfkR2Sn/3N8Bo8XvkmEaFOb1jimC86C8iyRKB3z
         +4WV6+psgh/YwFVpPpE0FThiKZ2tfB7nFp7WwCVyH/mZ0YkFd+vsgZWKOdR2QtGsD+Fj
         h4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813594; x=1766418394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMvvVGERd3mt1B4otJOteb3OqAwxA2BKhC4KiqGzfY8=;
        b=TBNRW8VQ+5ozn3B+MajtHqENYIlv3jrlymx/GqsKzwmHECo5BVSJ204K+/Y5bsUhBp
         zrc3kvZtobqcjAP3b7g1uLFvoXS5XLxiG4zVcuw/cUb9RdtlyLQAl6MNxIMNd369fil/
         DtC8BglA/QjdAFXzNQFpsdIuKToFUCNFrAqZyGGR3byOXMMTa9XCu8t/4YEoFWy25ssq
         2wsaigv9DiehbD0i0YZIdVjkdqlmPOv0wgiX40+hurHVe5GVVrP26z0hDlNNBHXZAsSO
         PzKCyqGgTjVVQtr/SQVK9CnZoo1JI71zkXUCwhnwNulMKaeKtYYlKmc9MTsJ+urhyRHj
         Nwug==
X-Gm-Message-State: AOJu0YyX2JSGmLtSBsSk/Yi4AWMsCsNw9jXpTNSoP3iZNVJLBghlUhPh
	VmrYq95rbyx3b6WylxCw63avJyHD1PDqYCxF+QPeUQr+ZkXAREYpRcSHluSAUP16QlxPjHJ0b2m
	j/vIJdV0stBxuX0m+xTQnR2ziAOC80f8=
X-Gm-Gg: AY/fxX4R99ReZem0bMPB2c4TBGJzcTdqY+AzkIXUqb9uNzpG0LbtgM/Xab6dVUKBJl2
	8cEgKc5etAx3YBZOp+nvxbMN1ORQW4pHNs6YEY5FzYe11OYm7d3drCIQFWCgjbGV5wqFqqnSMdA
	vVFaPyXGAqPxsgIzhOonVdPweRWLJPi5e35+QQyIPI7lrTzYSyMuNYNBlZOcu6RpCMLAkaK8ZXh
	lW0aIatH6PIJgDey+R5qJlSPNJ5mnDsdlS6K0vR0NV+b73R93jkZY3BAAI5f9g8X4A7Rw==
X-Google-Smtp-Source: AGHT+IHneG1rZ2MwhYZ0u2YxLT6UH/z5TKZYZ9/dEAf9S+15E8j9p/hAl/fdsirSTgMcNSUFElhetehKeQTXJGitb0I=
X-Received: by 2002:a2e:9a12:0:b0:37a:95c9:4745 with SMTP id
 38308e7fff4ca-37fd08c7a93mr34442571fa.40.1765813593980; Mon, 15 Dec 2025
 07:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZ+bgaa4znWcjW_n_3n3_oKbPsptg0K80eZU8iQwR81kVA@mail.gmail.com> <CAGFh0265yqFi=Jm2VOSxG4pdy+FKxvnFr5F_+wesB1dwW1nDLA@mail.gmail.com>
In-Reply-To: <CAGFh0265yqFi=Jm2VOSxG4pdy+FKxvnFr5F_+wesB1dwW1nDLA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Dec 2025 10:46:21 -0500
X-Gm-Features: AQt7F2otUwxJwQ7XIwVNIT8gfOXVfkQK1Qp3qbMcB9HO2iJLaNVon6VA-vAMrGQ
Message-ID: <CABBYNZ+jcFPxigPq9yUbiRstaT2zyO68527z_0xDexLr3aJ6pQ@mail.gmail.com>
Subject: Re: [PATCH] client/player: Refcount registered endpoints
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Dec 15, 2025 at 10:33=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Do you have a backtrace or something? We don't reference struct
> > endpoint across different adapters afaik so this might be a different
> > bug or something.
>
> > [bluetoothctl]> endpoint.register 0000110a-0000-1000-8000-00805f9b34fb =
0x00 '0xFF 0xFF 0x02 0x40'
> > [/local/endpoint/ep0] Enter Metadata (value/no): no
> > [/local/endpoint/ep0] Auto Accept (yes/no): no
> > [/local/endpoint/ep0] Max Transports (auto/value): auto
> > [/local/endpoint/ep0] Locations: 0
> > [/local/endpoint/ep0] Supported Context (value): 0
> > [/local/endpoint/ep0] Context (value): 0
> > [/local/endpoint/ep0] CIG (auto/value): auto
> > [/local/endpoint/ep0] CIS (auto/value): auto
> > Capabilities:
> >   ff ff 02 40                                      ...@
> > Capabilities:
> >   ff ff 02 40                                      ...@
> > Endpoint /local/endpoint/ep0 registered
> > Endpoint /local/endpoint/ep0 registered
> > [bluetoothctl]> endpoint.unregister /local/endpoint/ep0
> > Endpoint /local/endpoint/ep0 unregistered
> > [bluetoothctl]>
> > Program received signal SIGSEGV, Segmentation fault.
> > Download failed: Invalid argument.  Continuing without source file ./st=
ring/../sysdeps/x86_64/multiarch/strlen-avx2.S.
> > __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:76
> > warning: 76     ../sysdeps/x86_64/multiarch/strlen-avx2.S: No such file=
 or directory
> > (gdb) bt
> > #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:76
> > #1  0x00007ffff7a6f980 in __printf_buffer (buf=3Dbuf@entry=3D0x7fffffff=
c7a0, format=3Dformat@entry=3D0x5555555afbd3 "Endpoint %s unregistered\n", =
ap=3Dap@entry=3D0x7fffffffc8b0, mode_f
> >     at ./stdio-common/vfprintf-process-arg.c:443
> > #2  0x00007ffff7a70788 in __vfprintf_internal (s=3D0x7ffff7c355c0 <_IO_=
2_1_stdout_>, format=3Dformat@entry=3D0x5555555afbd3 "Endpoint %s unregiste=
red\n", ap=3Dap@entry=3D0x7fffffffc8
> >     at ./stdio-common/vfprintf-internal.c:1543
> > #3  0x00007ffff7b45489 in ___vfprintf_chk (fp=3D<optimized out>, flag=
=3Dflag@entry=3D2, format=3Dformat@entry=3D0x5555555afbd3 "Endpoint %s unre=
gistered\n", ap=3Dap@entry=3D0x7fffffffc8b
> > #4  0x00005555555a90bf in vprintf (__fmt=3D0x5555555afbd3 "Endpoint %s =
unregistered\n", __ap=3D0x7fffffffc8b0) at /usr/include/x86_64-linux-gnu/bi=
ts/stdio2.h:156
> > #5  bt_shell_printf (fmt=3Dfmt@entry=3D0x5555555afbd3 "Endpoint %s unre=
gistered\n") at ../src/shared/shell.c:741
> > #6  0x0000555555587739 in unregister_endpoint_reply (message=3D0x555556=
2c2990, user_data=3D0x5555562b9c00) at ../client/player.c:3738
> > #7  unregister_endpoint_reply (message=3D0x5555562c2990, user_data=3D0x=
5555562b9c00) at ../client/player.c:3724
> > #8  0x00005555555a1516 in method_call_reply (call=3D<optimized out>, us=
er_data=3D0x5555562c2270) at ../gdbus/client.c:1075
> > #9  0x00007ffff7e037c2 in ?? () from /lib/x86_64-linux-gnu/libdbus-1.so=
.3
> > #10 0x00007ffff7e07dfe in dbus_connection_dispatch () from /lib/x86_64-=
linux-gnu/libdbus-1.so.3
> > #11 0x000055555559c828 in message_dispatch (data=3D0x5555562a8890) at .=
./gdbus/mainloop.c:59
> > #12 0x00007ffff7e9fbfb in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.=
so.0
> > #13 0x00007ffff7ea1237 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.=
so.0
> > #14 0x00007ffff7ea15d7 in g_main_loop_run () from /lib/x86_64-linux-gnu=
/libglib-2.0.so.0
> > #15 0x00005555555ab7f9 in mainloop_run () at ../src/shared/mainloop-gli=
b.c:65
> > #16 0x00005555555abbfa in mainloop_run_with_signal (func=3Dfunc@entry=
=3D0x5555555a8880 <signal_callback>, user_data=3Duser_data@entry=3D0x0) at =
../src/shared/mainloop-notify.c:196
> > #17 0x00005555555aa655 in bt_shell_run () at ../src/shared/shell.c:1476
> > #18 0x000055555556f418 in main (argc=3D<optimized out>, argv=3D0x7fffff=
ffcef8) at ../client/main.c:3960

Oh, this is bluetoothctl bug, sorry I was looking into bluetoothd not
bluetoothctl, endpoint_register does indeed make a reference to the
same object.

> The bug is caused by freeing the endpoint on the first reply from
> deregistration. When the second one (or another if you have 3, 4, 5..
> etc. adapters) arrieves you have access after free. Simple refcount
> should fix that, but of course there might be other approaches.



--=20
Luiz Augusto von Dentz
