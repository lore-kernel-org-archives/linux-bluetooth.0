Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA2F25F5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431057; cv=pass; b=j9Idte6FBrwLEQG35PJeGdQ1GzX7VpXB61Dwikqu18YFfhbqCokQQ13EIny9AP5u+J74/UnNeLl5n7HlypPqWuWUlhmrUI0/T8bPkHI1AQG4a5+tbeExllcQDb1d+fVXLCVYbCQUTOfKAh8i160Rxn8wbJZFogKqe9/Zds8S+5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431057; c=relaxed/simple;
	bh=hdyiNP6ePbv4KxYi3k63kYpQyZn2u7yFIsPQybbCCOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPUjjDuTyDTIyTwVtNalCsVc30qwHp3yKgidhyxZBElfdrVuRfYqK97lFH8mcDsMTlptHVZQ9k0ecQiw4MKJutE88OBb4jIk9Icch4ao7rd2R8LCx7WwHIXWIQ7JqbjxdRAGdulS7oaMxIrgoMMD6xZBCNgVzFG1jHYyMwD6xrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPMQpvzH; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPMQpvzH"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66067da0638so1864989d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 13:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780431055; cv=none;
        d=google.com; s=arc-20240605;
        b=ef+RA/olzSVB+fADsGt+MiXiyQuZUuFHtZx8JRzk62h7ZeTnYQmeFJTsbo8xQLzfGu
         DTpo1juCUcdp9LpT38tV4peFT/khxzEKpcdtyjTK2eFo8b+jZEmc9VlihcBu4dwpgOZB
         gp5+xo9AKHYpfUXGpR/BB2caijb2AIvZC4Hh3r6kQcRs93UjF98hIdaVlqmsEaL1pTtA
         Yn+guvEkfPn2XbifTX17MFPUKkRVpMTHEf0M9MzMe6P6WY6mxFzRBT3RfG5PdkXVd/MS
         N49yLPM5sg3mQRkMGKXydzRvKls+txVioFfOFMyZYnXbSRzNOG1KewgWTV2Ojy4tjG3B
         YrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zIhH4zgnsVoHBakbzvLozVuowD/cGyIQOOJW1J2XlYw=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=l3Jnjtu8N3dPSaTGO0C6dFv3NX/SOB6W7e9W8C1gnc+0pWh5TkY9/d3IRxfoHOUeac
         5vpiI+iAxPlvtrOSmOLFlszacBbiP1agvn0WgWpBbADMQGSOsmTV6mGjfBGGbbY99toG
         UuG2lJDZqfNHf2EWW/NAc/WRtP/HMvghj/WeGp6FBdAxux5fw9eUFsOCuZDOWnoHHWdW
         1W6tckbFuRMGMPGiboNLVddtOU/cksnlvg7IXI7UCwryFtAvK0ncUAtuxWXKMK8UEC1k
         9VFA8XKM94MS9e4Y1aB0MJdO9EpcjBjxSPXHpSImVJk5s1iGzrYW9WRWqQXXX6UaVPpz
         DifQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780431055; x=1781035855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIhH4zgnsVoHBakbzvLozVuowD/cGyIQOOJW1J2XlYw=;
        b=OPMQpvzHvLW+TqGwzLE4W4MatZQOgnnl5vmrevi+le2Nzlh/GdktdwBRrcJqTAzDAv
         AGfexxBmBEzKy5BohVkHqJ06YJnFu1JtlCo8AIzLh91hkXMtxo66U1W5VRTrMaUfYQY/
         4cPboxM4ptQXbONWfyq97RkHCIheLW5tlJrdpmQVsWxFcw6l17JEQCfdzmPeop2KyupM
         Mphuxkx4nFlWgUdGjr36Y92bE6Jf5aXJwD3l25T7+LJV58OwSfENUDJ4PLi3TViT3ehl
         k4zoyzGX+5O2PO4FBWGEq5zq7NPJDI01KgpnOh0Wo6en2G7b3RGGhJfF5fws7djRSxmM
         ESMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431055; x=1781035855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIhH4zgnsVoHBakbzvLozVuowD/cGyIQOOJW1J2XlYw=;
        b=Ohcy3VHU59M+1ZLWFEdKy7sTM8JcCojfKT47R+PWZeoPhCS12ZBJetu+mvjLDYuzMn
         lA0n+RCh2/OIGA70qXB4W93E6myvJxI+gCkVynhCwLQiuFQf0pVp/NF7iSsnpkLkIcN0
         Qak5INr7WKZgp04z8Qgw8eDGmCORmKLQY32FPOwRVHD8tUARHlHwm/sEEmHQZb31u6wb
         e6cUE7Mh05RN/+X+hIN5FYdGd6KU74u00mKWvFyPi+ioFJ+nITkClp3yQ3sqLUzFlB/I
         rhc+uKgBnXHanq+z43BKCSIeWj+Ysc50dUV8kyy2ko8FXDuE/eIwo6yQndIpGEr7E4SF
         vaXw==
X-Gm-Message-State: AOJu0YwJPp1VBJD+AvC3ISeV2lgcn9YF03VMPEaFRE1p1cmkidV1fTaJ
	EL5nxKVvX+nFkSYkHZGG1LlgV3Kw8YlYPOfgd6R/sMEwpLF4Et/ry7dghJpkSvmN6whkNrhmgU+
	HAyfDRzX88DNSa7ewOaK/iGcGjnCHcH4=
X-Gm-Gg: Acq92OEYl4yp00bkFwxtCTDvne9ZSCOBVld4NGv3tpZiD6E+WhWOeVl4ZAXwO6NCXLx
	s0h7KzojUZN3TK/SeK+vNKY+7d2CEJKBhoqEiX3L7V/pxypHmf4+wE5bXwPObfyuQS7lmcTkIME
	U7ON9l5gLItMWsbtTZdhr0a4btimSEF1fhS7uZDDRljmExdO337+6aYdxhKam4uhZROVNXneS4h
	v4+qDGpENMK4I2/qyCWgOdHgE8/2vKa7KucMxgBKwPzjQeRUgN982dbQfTs1YJOIo41cWUsp7yS
	oSRYduOBbXnwOrM9NeyLpJsG7i9tL02ptl3VvPzDYjbhVB4gVPabUdp0SeMe1YghC8NmA/Q9mZt
	6SARk
X-Received: by 2002:a05:690e:1289:b0:660:7b47:24cc with SMTP id
 956f58d0204a3-660dbe20f2emr355311d50.1.1780431055397; Tue, 02 Jun 2026
 13:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778688966.git.pav@iki.fi> <5d818c768189b6d0a8e5a4b90eb41cc7b9932624.1778688966.git.pav@iki.fi>
 <CABBYNZL42S2FKP9EF33i=P5p5ggD4fg2qFkg-NaKAF4h8wD_iw@mail.gmail.com>
 <132073b9a61db8dcd9c85f0b5787200a63a50604.camel@iki.fi> <81837f88d2bc467cb3b188fbcebda0b395f5b689.camel@iki.fi>
In-Reply-To: <81837f88d2bc467cb3b188fbcebda0b395f5b689.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 16:10:43 -0400
X-Gm-Features: AVHnY4Klx5fNX_6o3m1bbnkX80HdP03h9uPSQuY43xsrjpjPVcO7SzsToTSSYBk
Message-ID: <CABBYNZJHmpBqY9Z=FUtcFz-EqCdmctMQPi6BoFedW3cQUKEr5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 08/16] test-runner: use virtio-serial for
 implementing -u device forwarding
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Jun 2, 2026 at 4:03=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ti, 2026-06-02 kello 19:51 +0000, Pauli Virtanen kirjoitti:
> > Hi Luiz,
> >
> > ti, 2026-06-02 kello 15:35 -0400, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > >
> > > On Wed, May 13, 2026 at 12:48=E2=80=AFPM Pauli Virtanen <pav@iki.fi> =
wrote:
> > > >
> > > > Using pci-serial to forward eg. btvirt sockets is unreliable, as
> > > > qemu or
> > > > kernel seems to be sometimes dropping part of the sent data or
> > > > insert
> > > > spurious \0 bytes, leading to sporadic errors like:
> > > >
> > > >     kernel: Bluetooth: hci0: command 0x0c52 tx timeout
> > > >     kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
> > > >     btvirt: packet error, unknown type: 0
> > > >
> > > > This appears to occur most often when host system is under load,
> > > > e.g.
> > > > due to multiple test-runners running at the same time.  The
> > > > problem
> > > > is
> > > > not specific to btvirt, but seems to be in the qemu serial device
> > > > layer
> > > > vs. kernel interaction.
> > > >
> > > > Change test-runner to use virtserialport to forward the btvirt
> > > > connection inside the VM, as virtio-serial doesn't appear to have
> > > > these
> > > > problems.
> > > > ---
> > > >  tools/test-runner.c | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/test-runner.c b/tools/test-runner.c
> > > > index b3e0b0cfe..0e3bfb8b7 100644
> > > > --- a/tools/test-runner.c
> > > > +++ b/tools/test-runner.c
> > > > @@ -306,7 +306,7 @@ static void start_qemu(void)
> > > >                                 testargs);
> > > >
> > > >         argv =3D alloca(sizeof(qemu_argv) +
> > > > -                       (sizeof(char *) * (6 + (num_devs * 4))) +
> > > > +                       (sizeof(char *) * (8 + (num_devs * 4))) +
> > > >                         (sizeof(char *) * (usb_dev ? 4 : 0)) +
> > > >                         (sizeof(char *) * num_extra_opts));
> > > >         memcpy(argv, qemu_argv, sizeof(qemu_argv));
> > > > @@ -330,14 +330,19 @@ static void start_qemu(void)
> > > >         argv[pos++] =3D "-append";
> > > >         argv[pos++] =3D (char *) cmdline;
> > > >
> > > > +       if (num_devs) {
> > > > +               argv[pos++] =3D "-device";
> > > > +               argv[pos++] =3D "virtio-serial";
> > > > +       }
> > > > +
> > > >         for (i =3D 0; i < num_devs; i++) {
> > > >                 char *chrdev, *serdev;
> > > >
> > > >                 chrdev =3D alloca(48 + strlen(device_path));
> > > >                 sprintf(chrdev, "socket,path=3D%s,id=3Dbt%d",
> > > > device_path, i);
> > > >
> > > > -               serdev =3D alloca(48);
> > > > -               sprintf(serdev, "pci-serial,chardev=3Dbt%d", i);
> > > > +               serdev =3D alloca(64);
> > > > +               sprintf(serdev,
> > > > "virtconsole,chardev=3Dbt%d,name=3Dbt.%d", i, i);
> > > >
> > > >                 argv[pos++] =3D "-chardev";
> > > >                 argv[pos++] =3D chrdev;
> > > > @@ -910,7 +915,7 @@ static void run_command(char *cmdname, char
> > > > *home)
> > > >         }
> > > >
> > > >         if (num_devs) {
> > > > -               const char *node =3D "/dev/ttyS1";
> > > > +               const char *node =3D "/dev/hvc0";
> > >
> > > Im getting and error with these changes:
> > >
> > > Attaching BR/EDR controller to /dev/hvc0
> > > Failed to open serial port: No such file or directory
> > >
> > > I tried adding the kernel config options but it didn't make any
> > > difference.
> >
> > We have test-runner with this patch in Pipewire CI, and it is working
> >
> > https://gitlab.freedesktop.org/pipewire/pipewire/-/jobs/101256448
> >
> > on Fedora 44 + Qemu 10.2.2. Kernel configuration is here:
> >
> > https://github.com/pv/bluez-test-functional-kernel/blob/main/tester.con=
fig
> >
> > I've also used with this for USB redirection.
>
> Also, the exact kernel image we are using built from that config is
> here:
>
> https://github.com/pv/bluez-test-functional-kernel/releases/tag/2026-05-0=
8.1
>
> at bluez 07b6fc156348bb515ac0a876d49644312c9476d6 I can then do
>
> $ ./emulator/btvirt -s &
> $ ./tools/test-runner -u/tmp/bt-server-bredrle -k bzImage -- bash
> ...
> Attachment of devices requested
> Attaching BR/EDR controller to /dev/hvc0
> Switched line discipline from 0 to 15
> Device index 0 attached
> Running command bash

Seem that CONFIG_VIRTIO_CONSOLE was not enabled for some reason, once
I enabled it works as intended.

> >
> > Not sure what is different for you, do you get any virtio serial
> > devices from the virtconsole?
> >
> > >
> > > >                 unsigned int basic_flags, extra_flags;
> > > >
> > > >                 printf("Attaching BR/EDR controller to %s\n",
> > > > node);
> > > > --
> > > > 2.54.0
> > > >
> > > >
> > >


--
Luiz Augusto von Dentz
