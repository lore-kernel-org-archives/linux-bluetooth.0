Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC733126C2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428954; cv=pass; b=LtNkrDZEsUMdv/j36gboCYzOJq7uqf+5EFOLxeYqAKKWic02xsAUvkWge5/4cdqTkG7QCGshtUFLLuNaRWKhqaBt85EFL7FG0Xeb0y1Gcgo9qzmDtzjfOQ9tkAth5kjeiA2BNQ62bD97FIh50Plx/iwMC4m7KQ4V1N1poxJV8XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428954; c=relaxed/simple;
	bh=D23/FmuDoKYs5gffP8VyKoH5X45LKgn8rEI/PzvwSpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I71qY++Y9YS2IJdqq+YJUs5OmHV2hi2eIgqjnP3Nyd0CQKSpqFUNSIF37nr0JljhisctlxQznSRBYB/VU8bVpIAANyPVsglPUka9IFqHXPSKjGQRxbiY99W+zteelX6bj0Sy8oCVycbIdvKquRjnX9LGGDowiSWvt2GKiHY1l+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl7p8m8a; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl7p8m8a"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66077e90382so2836361d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 12:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780428952; cv=none;
        d=google.com; s=arc-20240605;
        b=LdNcRs6gZiZG0psAAWUGlXJl4K4JFzW05meTol4rCr/AmQC881f1oRAphez8mHTVdm
         IAGHHcN1dymKmE1ZZULn1hZYjQ17pfZOcG6A4mfPHXFy5mt1gJ5pnHaQdY3QBuvO/KHP
         iKXiaKHue2zw6u8wO8asDUqXoWefy039JuOgFItbJywkLz4WbUX3zbAkEFEtnY5USbYB
         X8phRONm6+fo8Nnnia597QTSx/oTByRiRi5ydFWrk8q+JdeOsnwhfVOUeZV9ycAszuwW
         jKXnzjMhcQlGVL9FudaaI4gltG0AKVQCfMSRTf7BciV2+IRO7TxjDKkBg3mpgBfeJ2R/
         fe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXIj7Lo4DPufs7eYOAjmrhEeX3Nf6BhsRLkHnQ1p/fg=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=PME4bIQtZAsx7GgmuCzPyKv65AfqXhKNHI4vKDQXdjxw5cZKw33tvu4rgcAPXjQctf
         gEAiUbaUJV8XyQfjE8ztLrPAR7BgZrG+/eEz+uHKJ88pSeKUiFlc+sJo0T+Ko8Y0ZmWj
         6sIWIhMsuEQc/WrejR8oef5R7va4u2VLWTB5EfZWETFuWCEEBg/PeZQytvXWSno3CGom
         HyVRSOex4fdi4ayoDnMsTuK6XyTOtOvRRMIEzL8V1uJvBeOzoWj51QNmay8xlqUF9rTa
         vGGhOjmKH6aS+xGFpfkjqSYBwts4HF48pUo82Jdf2IjcciIyqvl8fmgE1oRNJHK3uBte
         4ALg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780428952; x=1781033752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXIj7Lo4DPufs7eYOAjmrhEeX3Nf6BhsRLkHnQ1p/fg=;
        b=Gl7p8m8aRYHScZCDZMLYcvXkYqW2LvPHRqc8yCuayN3jDgtX7077l+PyJQh3VwD6lv
         wDa1uwaR/vyFL1h/KPJ90sLdvApw5mU3u81lmlx4M3KFvwaZ9vDu+efflv8CvoBzgCTS
         KuQefxiTnkHpeICZfi/DUtrgPIziZYtnW8+0hGZGnp3UTt732mJW5vJcXEKtbaKmbQCo
         PMYVSwZiKaDrliUz3ZUSojTfPt20eJ2/tWChheRVVUUjXFPSUqgE9mAK+FTq2iJpOAIY
         1nGsHbaAnmlACa8JdiQwqAbtTxDI3TU5USdz/yI8k/hiDDogskpvXhNfcnmeoJ6wiXld
         upqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780428952; x=1781033752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXIj7Lo4DPufs7eYOAjmrhEeX3Nf6BhsRLkHnQ1p/fg=;
        b=XHIMZYLdoZJWqWI6+TRxIOVBSBnemXKPFFPr0OpFo0XlV9J6G8rcVogzo32Do/Lig/
         ZAgrsrTNJbHmfYlIUmYbDA7qUtnuzBSVEIZnDlKIls5vBKI7T9JpogRtWv2H6oyb+p5W
         Hh5Ue1QzgwjYAysHzHJchtLsDi0jpxbG0tjxZ7Grb4VdJ54Y3Tkk5ZR43LazyOy/2eWH
         Ujc+FdvC6AgLZVXZMiajwVDkUiUdl1r3719wqgi8dIFwOl4UXXquavc47K4J9LXHm7P9
         lBxDa/zRNGmi88YoqYK7xHNnwMOX+zcD0wf5Fl+hssD9uN3lyNXHCy42mHt3X2lWMv2q
         +8zw==
X-Gm-Message-State: AOJu0YzMmlc9RqZuU63IPbgG1e+ZIs97yvWySGsWnRHu0UtzkPAajOrg
	1NwFCZWmogAQq6khRx5rvN3XGoRz/6jge1DR02yINIGp9zg+EyM/jFRfLj6qu2+LrFcVh+EzsOm
	hGAXiLy/9zLrQlwjha0sgjxRef5Dqy5RUXpALx4tDTQ==
X-Gm-Gg: Acq92OGD1gDYH9yunT2TYi6n5tdTmvuHsC7lDbQ2eCXTra2PjAPD77zZQ97tgy4UzPM
	9fsrQGieVBgYgBziAbCW960yR3wIOM2JYtE4dk/dC6NtPYhL5RdZKcy+RUXAJwA+OxgiPjxJEl4
	En4mgX9tX2sRQOSIzvf9xMtBiohDddg1pSs7kLoRO80X4YBfELAOD69jDFmE763/mgtTNy8Rlag
	3uJvRrmOKBP88jqQDlian5NAb0fU2aHF6+ocnNwmABC1FF3fcfYNh9DNHjmBotyXt9x2xj+qPMA
	527mE72XnmbWY6ZnOpR8yuKnE/0fDeKi8yEa9m5AugQNKTS4Lng/VyUGl+DBSAjFtHUmn6rwLMm
	dU8MHYNlRxan1XSc=
X-Received: by 2002:a53:d015:0:b0:660:8fc2:cbd0 with SMTP id
 956f58d0204a3-660dbe976ffmr200286d50.31.1780428952184; Tue, 02 Jun 2026
 12:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778688966.git.pav@iki.fi> <5d818c768189b6d0a8e5a4b90eb41cc7b9932624.1778688966.git.pav@iki.fi>
In-Reply-To: <5d818c768189b6d0a8e5a4b90eb41cc7b9932624.1778688966.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 15:35:41 -0400
X-Gm-Features: AVHnY4IO4zIyYIz5Wd_VbKVjEGzQkxZpAWtCKnHqfp3kT-pE0GUxErmRZ1k3W_4
Message-ID: <CABBYNZL42S2FKP9EF33i=P5p5ggD4fg2qFkg-NaKAF4h8wD_iw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 08/16] test-runner: use virtio-serial for
 implementing -u device forwarding
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, May 13, 2026 at 12:48=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
> kernel seems to be sometimes dropping part of the sent data or insert
> spurious \0 bytes, leading to sporadic errors like:
>
>     kernel: Bluetooth: hci0: command 0x0c52 tx timeout
>     kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
>     btvirt: packet error, unknown type: 0
>
> This appears to occur most often when host system is under load, e.g.
> due to multiple test-runners running at the same time.  The problem is
> not specific to btvirt, but seems to be in the qemu serial device layer
> vs. kernel interaction.
>
> Change test-runner to use virtserialport to forward the btvirt
> connection inside the VM, as virtio-serial doesn't appear to have these
> problems.
> ---
>  tools/test-runner.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index b3e0b0cfe..0e3bfb8b7 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -306,7 +306,7 @@ static void start_qemu(void)
>                                 testargs);
>
>         argv =3D alloca(sizeof(qemu_argv) +
> -                       (sizeof(char *) * (6 + (num_devs * 4))) +
> +                       (sizeof(char *) * (8 + (num_devs * 4))) +
>                         (sizeof(char *) * (usb_dev ? 4 : 0)) +
>                         (sizeof(char *) * num_extra_opts));
>         memcpy(argv, qemu_argv, sizeof(qemu_argv));
> @@ -330,14 +330,19 @@ static void start_qemu(void)
>         argv[pos++] =3D "-append";
>         argv[pos++] =3D (char *) cmdline;
>
> +       if (num_devs) {
> +               argv[pos++] =3D "-device";
> +               argv[pos++] =3D "virtio-serial";
> +       }
> +
>         for (i =3D 0; i < num_devs; i++) {
>                 char *chrdev, *serdev;
>
>                 chrdev =3D alloca(48 + strlen(device_path));
>                 sprintf(chrdev, "socket,path=3D%s,id=3Dbt%d", device_path=
, i);
>
> -               serdev =3D alloca(48);
> -               sprintf(serdev, "pci-serial,chardev=3Dbt%d", i);
> +               serdev =3D alloca(64);
> +               sprintf(serdev, "virtconsole,chardev=3Dbt%d,name=3Dbt.%d"=
, i, i);
>
>                 argv[pos++] =3D "-chardev";
>                 argv[pos++] =3D chrdev;
> @@ -910,7 +915,7 @@ static void run_command(char *cmdname, char *home)
>         }
>
>         if (num_devs) {
> -               const char *node =3D "/dev/ttyS1";
> +               const char *node =3D "/dev/hvc0";

Im getting and error with these changes:

Attaching BR/EDR controller to /dev/hvc0
Failed to open serial port: No such file or directory

I tried adding the kernel config options but it didn't make any difference.

>                 unsigned int basic_flags, extra_flags;
>
>                 printf("Attaching BR/EDR controller to %s\n", node);
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
